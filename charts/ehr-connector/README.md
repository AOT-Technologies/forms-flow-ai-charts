# EHR Connector Helm Chart

The **ehr-connector** Helm chart deploys the Epic FHIR EHR integration microservice for the **formsflow.ai** platform on Kubernetes.

## Overview

The EHR Connector facilitates interoperability with Electronic Health Record (EHR) systems like Epic by supporting OAuth2 / JWKS assertion authentication, patient matching, questionnaire integration, and FHIR resource processing.

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure (e.g., `gp2` or similar StorageClass)

## Installing the Chart

To install the chart with the release name `ehr-connector` in the `immudb` namespace:

```bash
helm install ehr-connector ./charts/ehr-connector \
  --namespace immudb \
  --create-namespace
```

### Upgrading the Chart

```bash
helm upgrade ehr-connector ./charts/ehr-connector \
  --namespace immudb
```

### Uninstalling the Chart

```bash
helm uninstall ehr-connector \
  --namespace immudb
```

## Parameters

### Global and Image Parameters

| Name | Description | Default |
|------|-------------|---------|
| `replicaCount` | Number of replicas | `1` |
| `image.registry` | Image registry | `docker.io` |
| `image.repository` | Image repository | `formsflow/forms-flow-ehr-connectors` |
| `image.tag` | Image tag | `v8.1.0.20260810105148` |
| `image.pullPolicy` | Image pull policy | `Always` |
| `image.pullSecrets` | Docker registry pull secrets | `[]` |

### Epic & FHIR Configuration

| Name | Description | Default |
|------|-------------|---------|
| `epic.fhirBaseUrl` | Epic FHIR R4 base URL | `https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4` |
| `epic.tokenUrl` | Epic OAuth2 token URL | `https://fhir.epic.com/interconnect-fhir-oauth/oauth2/token` |
| `epic.clientId` | Epic client identifier | `bafc2133-f680-475f-a335-e6d28294d579` |
| `epic.kid` | Epic key identifier | `df16c8aa-5409-4fdd-b89a-73eca455db33` |
| `epic.privateKey` | RSA private key for JWT authentication | `-----BEGIN RSA PRIVATE KEY-----...` |
| `auth.existingSecret` | Existing Kubernetes secret to use for Epic credentials | `""` |

### Service & Ingress Parameters

| Name | Description | Default |
|------|-------------|---------|
| `service.type` | Kubernetes service type | `ClusterIP` |
| `service.port` | Service port | `8002` |
| `service.targetPort` | Container target port | `8002` |
| `ingress.enabled` | Enable ingress controller resource | `true` |
| `ingress.ingressClassName` | Ingress class name | `nginx` |
| `ingress.hostname` | Ingress hostname | `fhir-epic.aot-technologies.com` |
| `ingress.path` | Ingress path | `/epic/.*` |
| `ingress.pathType` | Ingress path type | `Prefix` |

### Persistence Parameters

| Name | Description | Default |
|------|-------------|---------|
| `persistence.enabled` | Enable persistence via volumeClaimTemplates | `true` |
| `persistence.mountPath` | Path to mount storage in container | `/forms-flow-ehr-connectors/app/data` |
| `persistence.storageClass` | Kubernetes StorageClass | `gp2` |
| `persistence.size` | PVC storage size | `1Gi` |
| `persistence.accessModes` | PVC access modes | `[ReadWriteOnce]` |
