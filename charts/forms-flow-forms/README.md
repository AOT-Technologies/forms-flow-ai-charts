# Form Management Platform

formsflow.ai leverages form.io to build "serverless" data management applications using a simple drag-and-drop form builder interface.

To know more about form.io, go to https://form.io.

## Introduction

This chart bootstraps a forms-flow-forms deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-forms`:

```console
helm install forms-flow-forms forms-flow-forms
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install forms-flow-forms forms-flow-forms --set Domain=DOMAIN_NAME --set ingress.ingressClassName=INGRESS_CLASS
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-forms on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-forms charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 200m
    memory: 1Gi
  requests:
    cpu: 100m
    memory: 512Mi
```

### Change Forms-flow-forms version

To modify the Forms-flow-forms version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-forms) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-forms
  tag: X.Y.Z 
```
## Persistence

The `forms-flow-forms` image stores the application logs at the `/app/logs` path of the container.

## Parameters

| Parameter                                | Description                                                           | Default                                                          |
|------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                 | The domain for the application                                        | `""`                                                             |
| `replicas`                               | Number of replicas for the deployment                                 | `1`                                                              |
| `ExternalAuth.ExistingMailAuthKey`       | Key for existing mail authentication                                  | `""`                                                             |
| `ExternalAuth.ExistingPwdAuthKey`        | Key for existing password authentication                              | `""`                                                             |
| `ExternalAuth.ExistingSecretName`        | Name of the existing secret                                           | `""`                                                             |
| `formsflow.configmap`                    | Name of the formsflow.ai ConfigMap                                    | `forms-flow-ai`                                                  |
| `formsflow.secret`                       | Name of the formsflow.ai Secret                                       | `forms-flow-ai`                                                  |
| `formsflow.auth`                         | Name of the formsflow.ai auth component                               | `forms-flow-ai-auth`                                             |
| `image.registry`                         | Docker registry for the image                                         | `docker.io`                                                      |
| `image.repository`                       | Repository for the image                                              | `formsflow/forms-flow-forms`                                     |
| `image.tag`                              | Tag for the image                                                     | `""`                                                         |
| `image.secret`                           | Secret for pulling the image                                          | `""`                                                             |
| `ingress.ingressClassName`               | Ingress class name                                                    | `""`                                                             |
| `ingress.annotations`                    | Annotations for the Ingress                                           | `{}`                                                             |
| `ingress.enabled`                        | Enable the creation of an Ingress                                     | `true`                                                           |
| `ingress.hostname`                       | Hostname for the Ingress                                              | `{{.Chart.Name}}-{{.Release.Namespace}}.{{tpl .Values.Domain .}}`|
| `ingress.port`                           | Port for the Ingress                                                  | `3001`                                                           |
| `ingress.tls`                            | Enable TLS for the Ingress                                            | `true`                                                           |
| `ingress.selfSigned`                     | Use self-signed TLS certificates                                      | `false`                                                          |
| `ingress.extraTls`                       | Additional TLS configuration                                          | `[]`                                                             |
| `resources.limits.cpu`                   | CPU limit for the container                                           | `200m`                                                           |
| `resources.limits.memory`                | Memory limit for the container                                        | `1Gi`                                                            |
| `resources.requests.cpu`                 | CPU request for the container                                         | `100m`                                                           |
| `resources.requests.memory`              | Memory request for the container                                      | `512Mi`                                                          |
| `hpa.enabled`                            | Enable Horizontal Pod Autoscaler                                      | `false`                                                          |
| `hpa.CpuAverageUtilization`              | Target average CPU utilization for the HPA                            | `70`                                                             |
| `hpa.maxReplicas`                        | Maximum number of replicas for the HPA                                | `3`                                                              |
| `elastic_search.enabled`                 | Enable Elasticsearch                                                  | `false`                                                          |
