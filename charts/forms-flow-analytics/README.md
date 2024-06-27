# Formsflow.ai Analytics Engine

**formsflow.ai** leverages [Redash](https://github.com/getredash/redash) to build interactive
dashboards and gain insights. 

## Introduction

This chart bootstraps a forms-flow-analytics deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-analytics`:

```console
helm install forms-flow-analytics forms-flow-analytics
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install forms-flow-analytics forms-flow-analytics --set Domain=DOMAIN_NAME --set ingress.ingressClassName=INGRESS_CLASS 
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-analytics on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-analytics charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 200m
    memory: 2Gi
  requests:
    cpu: 180m
    memory: 1Gi
```


## Parameters

| Parameter                                 | Description                                                           | Default                                                          |
|-------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                  | The domain for the application                                        | `#<DEFINE_ME>`                                                   |
| `database.username`                       | Database username                                                     | `postgres`                                                       |
| `database.password`                       | Database password                                                     | `postgres`                                                       |
| `database.servicename`                    | Database service name                                                 | `forms-flow-ai-postgresql-ha-pgpool`                             |
| `database.port`                           | Database port                                                         | `5432`                                                           |
| `database.url`                            | Database URL                                                          | `DATABASE_URL` |
| `externalDatabase.existingDatabaseUrlKey` | Key for the existing database URL                                     | `""`                                                             |
| `externalDatabase.existingSecretName`     | Name of the existing secret                                           | `""`                                                             |
| `formsflow.auth`                          | Name of the formsflow.ai auth component                               | `forms-flow-ai-auth`                                             |
| `ingress.ingressClassName`                | Ingress class name                                                    | `""`                                                             |
| `ingress.annotations`                     | Annotations for the Ingress                                           | `{}`                                                             |
| `ingress.enabled`                         | Enable the creation of an Ingress                                     | `true`                                                           |
| `ingress.hostname`                        | Hostname for the Ingress                                              | `{{.Chart.Name}}-{{.Release.Namespace}}.{{tpl .Values.Domain .}}`|
| `ingress.port`                            | Port for the Ingress                                                  | `5000`                                                           |
| `ingress.tls`                             | Enable TLS for the Ingress                                            | `true`                                                           |
| `ingress.selfSigned`                      | Use self-signed TLS certificates                                      | `false`                                                          |
| `ingress.extraTls`                        | Additional TLS configuration                                          | `[]`                                                             |
| `redash.multiorg`                         | Enable multi-organization feature in Redash                           | `"false"`                                                        |
| `redash.image.registry`                   | Docker registry for the Redash image                                  | `docker.io`                                                      |
| `redash.image.repository`                 | Repository for the Redash image                                       | `formsflow/redash`                                               |
| `redash.image.tag`                        | Tag for the Redash image                                              | `REDASH_IMAGE_TAG`                                                         |
| `redash.database.password`                | Password for the Redash database                                      | `postgres`                                                       |
| `redash.database.url`                     | URL for the Redash database                                           | `REDASH_DATABASE_URL` |
| `resources.limits.cpu`                    | CPU limit for the container                                           | `200m`                                                           |
| `resources.limits.memory`                 | Memory limit for the container                                        | `2Gi`                                                            |
| `resources.requests.cpu`                  | CPU request for the container                                         | `180m`                                                           |
| `resources.requests.memory`               | Memory request for the container                                      | `1Gi`                                                            |
