# Formsflow.ai API

formsflow.ai has built this adaptive tier for correlating form management, BPM and analytics together.

The goal of the REST API is to provide access to all relevant interfaces of the system.


## Introduction

This chart bootstraps a forms-flow-api deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-api`:

```console
helm install forms-flow-api forms-flow-api
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


```console
helm install forms-flow-api forms-flow-api --set Domain=DOMAIN_NAME  --set ingress.ingressClassName=INGRESS_CLASS  
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-api on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-api charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 300m
    memory: 1Gi
  requests:
    cpu: 200m
    memory: 512Mi
```

### Change Forms-flow-api version

To modify the Forms-flow-api version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-webapi) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-webapi
  tag: X.Y.Z 
```

## Persistence

The `forms-flow-api` image stores the application logs at the `/forms-flow-api/app/logs` path of the container.

## Parameters

| Parameter                                 | Description                                                           | Default                                                          |
|-------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                  | The domain for the application                                        | `""`                                                             |
| `replicas`                                | Number of replicas for the deployment                                 | `1`                                                              |
| `database.url`                            | URL for connecting to PostgreSQL                                      | `DATABASE_URL` |
| `externalDatabase.existingDatabaseUrlKey` | Key for existing database URL                                         | `""`                                                             |
| `externalDatabase.existingSecretName`     | Name of the existing secret for database credentials                  | `""`                                                             |
| `resources.limits.cpu`                    | CPU limit for the container                                           | `300m`                                                           |
| `resources.limits.memory`                 | Memory limit for the container                                        | `1Gi`                                                            |
| `resources.requests.cpu`                  | CPU request for the container                                         | `200m`                                                           |
| `resources.requests.memory`               | Memory request for the container                                      | `512Mi`                                                          |
| `formsflow.configmap`                     | Name of the formsflow.ai ConfigMap                                    | `forms-flow-ai`                                                  |
| `formsflow.secret`                        | Name of the formsflow.ai Secret                                       | `forms-flow-ai`                                                  |
| `formsflow.auth`                          | Name of the formsflow.ai auth component                               | `forms-flow-ai-auth`                                             |
| `ingress.ingressClassName`                | Ingress class name                                                    | `""`                                                             |
| `ingress.annotations`                     | Annotations for the Ingress                                           | `{}`                                                             |
| `ingress.enabled`                         | Enable the creation of an Ingress                                     | `true`                                                           |
| `ingress.hostname`                        | Hostname for the Ingress                                              | `""`|
| `ingress.port`                            | Port for the Ingress                                                  | `5000`                                                           |
| `ingress.tls`                             | Enable TLS for the Ingress                                            | `true`                                                           |
| `ingress.selfSigned`                      | Use self-signed TLS certificates                                      | `false`                                                          |
| `ingress.extraTls`                        | Additional TLS configuration                                          | `[]`                                                             |
| `image.registry`                          | Docker registry for the image                                         | `docker.io`                                                      |
| `image.repository`                        | Repository for the image                                              | `formsflow/forms-flow-webapi`                                    |
| `image.tag`                               | Tag for the image                                                     | `""`                                                         |
| `hpa.enabled`                             | Enable Horizontal Pod Autoscaler                                      | `false`                                                          |
| `hpa.CpuAverageUtilization`               | Target average CPU utilization for the HPA                            | `80`                                                             |
| `hpa.maxReplicas`                         | Maximum number of replicas for the HPA                                | `3`                                                              |
| `elastic_search.enabled`                  | Enable Elasticsearch                                                  | `false`                                                          |

