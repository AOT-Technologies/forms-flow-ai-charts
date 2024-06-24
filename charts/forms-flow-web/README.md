# Formsflow.ai Web Application

formsflow.ai delivers progressive web application with React version 17.0.2 and create-react-app. Also currently uses form.io version 3.2.0.

## Introduction

This chart bootstraps a forms-flow-web deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-web`:

```console
helm install forms-flow-web forms-flow-web
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


```console
helm install forms-flow-web forms-flow-web --set Domain=DOMAIN_NAME --set ingress.ingressClassName=INGRESS_CLASS
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-web on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-web charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 200m
    memory: 1Gi
  requests:
    cpu: 100m
    memory: 512Mi
```

### Change Forms-flow-web version

To modify the Forms-flow-web version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-web) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-web
  tag: X.Y.Z 
```

## Parameters

| Parameter                                 | Description                                                           | Default                                                          |
|-------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                  | The domain for the application                                        | `""`                                                             |
| `replicas`                                | Number of replicas for the deployment                                 | `1`                                                              |
| `analytics.configmap`                     | Name of the formsflow analytics ConfigMap                             | `forms-flow-analytics`                                           |
| `analytics.secret`                        | Name of the formsflow analytics Secret                                | `forms-flow-analytics`                                           |
| `formsflow.configmap`                     | Name of the formsflow.ai ConfigMap                                    | `forms-flow-ai`                                                  |
| `formsflow.secret`                        | Name of the formsflow.ai Secret                                       | `forms-flow-ai`                                                  |
| `formsflow.auth`                          | Name of the formsflow.ai auth component                               | `forms-flow-ai-auth`                                             |
| `web.base_custom_url`                     | Custom base URL for the web                                           | `""`                                                             |
| `web.custom_theme_url`                    | Custom theme URL for the web                                          | `""`                                                             |
| `ingress.ingressClassName`                | Ingress class name                                                    | `""`                                                             |
| `ingress.annotations`                     | Annotations for the Ingress                                           | `{}`                                                             |
| `ingress.enabled`                         | Enable the creation of an Ingress                                     | `true`                                                           |
| `ingress.hostname`                        | Hostname for the Ingress                                              | `{{.Chart.Name}}-{{.Release.Namespace}}.{{tpl .Values.Domain .}}`|
| `ingress.port`                            | Port for the Ingress                                                  | `8080`                                                           |
| `ingress.tls`                             | Enable TLS for the Ingress                                            | `true`                                                           |
| `ingress.selfSigned`                      | Use self-signed TLS certificates                                      | `false`                                                          |
| `ingress.extraTls`                        | Additional TLS configuration                                          | `[]`                                                             |
| `resources.limits.cpu`                    | CPU limit for the container                                           | `200m`                                                           |
| `resources.limits.memory`                 | Memory limit for the container                                        | `1Gi`                                                            |
| `resources.requests.cpu`                  | CPU request for the container                                         | `100m`                                                           |
| `resources.requests.memory`               | Memory request for the container                                      | `512Mi`                                                          |
| `image.registry`                          | Docker registry for the image                                         | `docker.io`                                                      |
| `image.repository`                        | Repository for the image                                              | `formsflow/forms-flow-web`                                       |
| `image.tag`                               | Tag for the image                                                     | `""`                                                         |
| `config_path`                             | Path to the configuration files                                       | `/usr/share/nginx/html/config/`                                  |
| `webclient`                               | Name of the web client                                                | `{{.Chart.Name}}`                                                |
| `webname`                                 | Name of the web application                                           | `formsflow`                                                     |
| `UserAccesPermissions`                    | User access permissions                                               | `""`                                                             |
