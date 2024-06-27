# Formsflow Admin API

Formsflow Admin API is a Python REST API to provision tenants in a multi tenanted environment.


## Introduction

This chart bootstraps a forms-flow-admin deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-admin`:

```console
helm install forms-flow-admin forms-flow-admin 
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install forms-flow-admin forms-flow-admin --set Domain=DOMAIN_NAME --set ingress.ingressClassName=INGRESS_CLASS 
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-admin on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-admin charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 500m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 512Mi
```

### Change Forms-flow-admin version

To modify the Forms-flow-admin version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-ai-admin) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-ai-admin
  tag: X.Y.Z 
```

## Persistence

The `formsflow-admin` image stores the application logs at the `/opt/app-root/logs` path of the container.


## Parameters

| Parameter                                      | Description                                                   | Default                                                          |
|------------------------------------------------|---------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                       | The domain for the application                                | `""`                                                             |
| `replicas`                                     | Number of replicas for the deployment                         | `1`                                                              |
| `postgresql.url`                               | URL for connecting to PostgreSQL                              | `""` |
| `externalDatabase.existingDatabaseUrlKey`      | Key for existing database URL                                 | `""`                                                             |
| `externalDatabase.existingSecretName`          | Name of the existing secret for database credentials          | `""`                                                             |
| `resources.limits.cpu`                         | CPU limit for the container                                   | `500m`                                                           |
| `resources.limits.memory`                      | Memory limit for the container                                | `1Gi`                                                            |
| `resources.requests.cpu`                       | CPU request for the container                                 | `250m`                                                           |
| `resources.requests.memory`                    | Memory request for the container                              | `512Mi`                                                          |
| `formsflow.configmap`                          | Name of the formsflow.ai ConfigMap                            | `forms-flow-ai`                                                  |
| `formsflow.secret`                             | Name of the formsflow.ai Secret                               | `forms-flow-ai`                                                  |
| `formsflow.analytics`                          | Name of the formsflow analytics component                     | `forms-flow-analytics`                                           |
| `formsflow.auth`                               | Name of the formsflow.ai auth component                       | `forms-flow-ai-auth`                                             |
| `ingress.ingressClassName`                     | Ingress class name                                            | `""`                                                             |
| `ingress.annotations`                          | Annotations for the Ingress                                   | `{}`                                                             |
| `ingress.enabled`                              | Enable the creation of an Ingress                             | `true`                                                           |
| `ingress.hostname`                             | Hostname for the Ingress                                      | `""`|
| `ingress.port`                                 | Port for the Ingress                                          | `5000`                                                           |
| `ingress.tls`                                  | Enable TLS for the Ingress                                    | `true`                                                           |
| `ingress.selfSigned`                           | Use self-signed TLS certificates                              | `false`                                                          |
| `ingress.extraTls`                             | Additional TLS configuration                                  | `[]`                                                             |
| `ingress.path`                                 | Path for the Ingress                                          | `/`                                                              |
| `image.registry`                               | Docker registry for the image                                 | `docker.io`                                                      |
| `image.repository`                             | Repository for the image                                      | `formsflow/forms-flow-ai-admin`                                  |
| `image.tag`                                    | Tag for the image                                             | `""`                                                         |
| `elastic_search.enabled`                       | Enable Elasticsearch                                          | `false`                                                          |
