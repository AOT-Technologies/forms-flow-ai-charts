# Formsflow.ai Sentiment Analysis Component

Sentiment Analysisis used to understand the sentiments of the customer for products, movies, and other such things, whether they feel positive, negative, or neutral about it. BERT is a very good pre-trained language model which helps machines learn excellent representations of text with respect to context in many natural language tasks.


## Introduction

This chart bootstraps a forms-flow-data-analysis-api deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-data-analysis-api`:

```console
helm install forms-flow-data-analysis-api forms-flow-data-analysis-api
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


```console
helm install forms-flow-data-analysis forms-flow-data-analysis --set Domain=DOMAIN_NAME  --set ingress.ingressClassName=INGRESS_CLASS
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-data-analysis-api on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-data-analysis-api charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 500m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 512Mi
```

### Change Forms-flow-data-analysis-api version

To modify the Forms-flow-data-analysis-api version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-data-analysis-api) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-data-analysis-api
  tag: X.Y.Z 
```

## Persistence

The `forms-flow-data-analysis` image stores the application logs at the `/forms-flow-data-analysis/app/logs` path of the container.

## Parameters

| Parameter                                 | Description                                                           | Default                                                          |
|-------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                  | The domain for the application                                        | `#<DEFINE_ME>`                                                   |
| `replicas`                                | Number of replicas for the deployment                                 | `1`                                                              |
| `resources.limits.cpu`                    | CPU limit for the container                                           | `500m`                                                           |
| `resources.limits.memory`                 | Memory limit for the container                                        | `1Gi`                                                            |
| `resources.requests.cpu`                  | CPU request for the container                                         | `250m`                                                           |
| `resources.requests.memory`               | Memory request for the container                                      | `512Mi`                                                          |
| `formsflow.configmap`                     | Name of the formsflow.ai ConfigMap                                    | `forms-flow-ai`                                                  |
| `formsflow.secret`                        | Name of the formsflow.ai Secret                                       | `forms-flow-ai`                                                  |
| `formsflow.auth`                          | Name of the formsflow.ai auth component                               | `forms-flow-ai-auth`                                             |
| `ingress.ingressClassName`                | Ingress class name                                                    | `""`                                                             |
| `ingress.annotations`                     | Annotations for the Ingress                                           | `{}`                                                             |
| `ingress.enabled`                         | Enable the creation of an Ingress                                     | `true`                                                           |
| `ingress.hostname`                        | Hostname for the Ingress                                              | `{{.Chart.Name}}-{{.Release.Namespace}}.{{tpl .Values.Domain .}}`|
| `ingress.port`                            | Port for the Ingress                                                  | `5000`                                                           |
| `ingress.tls`                             | Enable TLS for the Ingress                                            | `true`                                                           |
| `ingress.selfSigned`                      | Use self-signed TLS certificates                                      | `false`                                                          |
| `ingress.extraTls`                        | Additional TLS configuration                                          | `[]`                                                             |
| `image.registry`                          | Docker registry for the image                                         | `docker.io`                                                      |
| `image.repository`                        | Repository for the image                                              | `formsflow/forms-flow-data-analysis-api`                         |
| `image.tag`                               | Tag for the image                                                     | `""`                                                         |
| `openApiKey`                              | API key for open API                                                  | `""`                                                             |
| `chatbotModelId`                          | Model ID for the chatbot                                              | `gpt-3.5-turbo`                                                  |
| `hpa.enabled`                             | Enable Horizontal Pod Autoscaler                                      | `false`                                                          |
| `hpa.CpuAverageUtilization`               | CPU utilization threshold for HPA                                     | `80`                                                             |
| `hpa.maxReplicas`                         | Maximum number of replicas for HPA                                    | `3`                                                              |
| `elastic_search.enabled`                  | Enable ElasticSearch integration                                      | `false`                                                          |
