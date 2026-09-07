# Forms Flow ImmuDB Helm Chart

The **forms-flow-immudb** Helm chart deploys the immutable audit logging worker service (`forms-flow-immudb`) and the backend ledger database (`immudb`) for **formsflow.ai** on Kubernetes.

## Architecture

```
forms-flow-bpm / forms-flow-api ──HTTP (port 5001)──> forms-flow-immudb (Worker) ──gRPC (port 3322)──> immudb (Ledger DB)
```

The chart packages two coordinated workloads:
1. **`immudb` (Database)**: A StatefulSet running `codenotary/immudb` with persistent storage mounted at `/var/lib/immudb`, exposing gRPC (`3322`), Web (`8080`), and Prometheus metrics (`9497`).
2. **`forms-flow-immudb` (Worker Service)**: A Deployment running `formsflow/forms-flow-immudb`, providing the RESTful audit logging endpoint (`/api/v1/audit/log`), search APIs, and an audit reporting web interface.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (e.g. `gp2` or similar StorageClass)

## Installing the Chart

To install the chart with the release name `forms-flow-immudb` into the `immudb` namespace:

```bash
helm install forms-flow-immudb ./charts/forms-flow-immudb \
  --namespace immudb \
  --create-namespace
```

### Upgrading the Chart

```bash
helm upgrade forms-flow-immudb ./charts/forms-flow-immudb \
  --namespace immudb
```

### Uninstalling the Chart

```bash
helm uninstall forms-flow-immudb \
  --namespace immudb
```

## Integrating with forms-flow-bpm

To configure `forms-flow-bpm` to stream audit logs to this service, configure the following in `charts/forms-flow-bpm/values.yaml`:

```yaml
immudbAuditPlugin:
  enabled: true
  image:
    repository: formsflow/forms-flow-immudb-plugin
    tag: v8.0.0-alpha
    pullPolicy: Always
  serviceUrl: "http://forms-flow-immudb:5001/api/v1/audit/log"
  authToken: "1Ipjwuf3k3Mj-QI97iGhZMsJx2lxXzIWT6afdg9f-l0="
```

## Key Configuration Parameters

### Worker Service Parameters (`worker.*`)

| Parameter | Description | Default |
|-----------|-------------|---------|
| `worker.enabled` | Enable worker deployment | `true` |
| `worker.replicaCount` | Number of worker replicas | `1` |
| `worker.image.repository` | Worker image repository | `formsflow/forms-flow-immudb` |
| `worker.image.tag` | Worker image tag | `v8.1.0.20260722113346` |
| `worker.service.port` | Service port | `5001` |
| `worker.auth.secretKey` | Secret key for Flask application | `change-me-in-production-use-strong-random-key` |
| `worker.auth.immudbSecretKey` | Auth token for `X-Auth-Token` validation (BPM plugin) | `1Ipjwuf3k3Mj-QI97iGhZMsJx2lxXzIWT6afdg9f-l0=` |
| `worker.auth.immudbPassword` | Password used to authenticate against ImmuDB | `immudb` |

### ImmuDB Database Parameters (`immudb.*`)

| Parameter | Description | Default |
|-----------|-------------|---------|
| `immudb.enabled` | Deploy embedded ImmuDB StatefulSet | `true` |
| `immudb.image.repository` | ImmuDB image repository | `codenotary/immudb` |
| `immudb.image.tag` | ImmuDB image tag | `latest` |
| `immudb.service.ports.grpc` | ImmuDB gRPC port | `3322` |
| `immudb.service.ports.web` | ImmuDB Web / REST port | `8080` |
| `immudb.service.ports.metrics` | ImmuDB Prometheus metrics port | `9497` |
| `immudb.persistence.enabled` | Enable persistence for immudb data | `true` |
| `immudb.persistence.storageClass` | StorageClass for persistent volume | `gp2` |
| `immudb.persistence.size` | Volume size | `5Gi` |
| `immudb.auth.adminPassword` | ImmuDB admin password | `immudb` |

### External ImmuDB (`externalImmudb.*`)

If you are running an external ImmuDB cluster:
1. Set `immudb.enabled: false`
2. Set `externalImmudb.host: "your-immudb-host:3322"`
