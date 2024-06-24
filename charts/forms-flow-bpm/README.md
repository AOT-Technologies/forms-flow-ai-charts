# Formsflow Workflow Engine

Formsflow.ai leverages Camunda for workflow and decision automation.

To know more about Camunda, visit https://camunda.com/.


## Introduction

This chart bootstraps a forms-flow-bpm deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-bpm`:

```console
helm install forms-flow-bpm forms-flow-bpm
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install forms-flow-bpm forms-flow-bpm --set Domain=DOMAIN_NAME  --set ingress.ingressClassName=INGRESS_CLASS --set camunda.websocket.securityOrigin=FORMS_FLOW_WEB_URL
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `INGRESS_CLASS` and `FORMS_FLOW_WEB_URL` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-bpm on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-bpm charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 600m
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi
```

### Change Forms-flow-bpm version

To modify the Forms-flow-bpm version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-bpm) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-bpm
  tag: X.Y.Z 
```
## Persistence

The `forms-flow-bpm` image stores the application logs at the `/logs` path of the container.

The `forms-flow-bpm` image supports mounting a mail configuration file at the `/app/mail-config.properties` path of the container. This can be done using a ConfigMap and mounting it as a volume.

## Parameters

| Parameter                                   | Description                                                           | Default                                                          |
|---------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                    | The domain for the application                                        | `""`                                                             |
| `replicas`                                  | Number of replicas for the deployment                                 | `1`                                                              |
| `camunda.analytics.database`                | Name of the analytics database                                        | `forms-flow-analytics`                                           |
| `camunda.auth.enabled`                      | Enable Camunda authentication                                         | `true`                                                           |
| `camunda.auth.revokeCheck`                  | Revoke check method                                                   | `auto`                                                           |
| `camunda.database.name`                     | Name of the Camunda database                                          | `forms-flow-bpm`                                                 |
| `camunda.database.port`                     | Port for the Camunda database                                         | `5432`                                                           |
| `camunda.historyLevel`                      | History level setting                                                 | `auto`                                                           |
| `camunda.securityOrigin`                    | Security origin setting                                               | `'*'`                                                            |
| `camunda.logLevel`                          | Log level setting                                                     | `INFO`                                                           |
| `camunda.formBuilder.password`              | Password for the form builder pipeline                                | `demo`                                                           |
| `camunda.formBuilder.username`              | Username for the form builder pipeline                                | `demo`                                                           |
| `camunda.hikari.timeout.connection`         | Hikari connection timeout                                             | `30000`                                                          |
| `camunda.hikari.timeout.idle`               | Hikari idle timeout                                                   | `600000`                                                         |
| `camunda.hikari.timeout.valid`              | Hikari valid timeout                                                  | `5000`                                                           |
| `camunda.hikari.poolsize.max`               | Hikari max pool size                                                  | `10`                                                             |
| `camunda.jdbc.driver`                       | JDBC driver class                                                     | `org.postgresql.Driver`                                          |
| `camunda.jdbc.username`                     | JDBC username                                                         | `postgres`                                                       |
| `camunda.jdbc.password`                     | JDBC password                                                         | `postgres`                                                       |
| `camunda.jdbc.url`                          | JDBC URL for connecting to the database                               | `jdbc:postgresql://${CAMUNDA_DATABASE_SERVICE_NAME}:${CAMUNDA_DATABASE_PORT}/${CAMUNDA_DATABASE_NAME}` |
| `camunda.websocket.messageType`             | Websocket message type                                                | `TASK_EVENT`                                                     |
| `camunda.websocket.securityOrigin`          | Websocket security origin                                             | `""`                                                             |
| `camunda.externalDatabase.existingDatabaseHostKey` | Key for existing database host                                  | `""`                                                             |
| `camunda.externalDatabase.existingDatabasePortKey` | Key for existing database port                                  | `""`                                                             |
| `camunda.externalDatabase.existingDatabaseNameKey` | Key for existing database name                                  | `""`                                                             |
| `camunda.externalDatabase.existingSecretName` | Name of the existing secret for database credentials             | `""`                                                             |
| `image.registry`                            | Docker registry for the image                                         | `docker.io`                                                      |
| `image.repository`                          | Repository for the image                                              | `formsflow/forms-flow-bpm`                                       |
| `image.tag`                                 | Tag for the image                                                     | `""`                                                         |
| `formsflow.configmap`                       | Name of the formsflow.ai ConfigMap                                    | `forms-flow-ai`                                                  |
| `formsflow.secret`                          | Name of the formsflow.ai Secret                                       | `forms-flow-ai`                                                  |
| `formsflow.auth`                            | Name of the formsflow.ai auth component                               | `forms-flow-ai-auth`                                             |
| `ingress.ingressClassName`                  | Ingress class name                                                    | `""`                                                             |
| `ingress.annotations`                       | Annotations for the Ingress                                           | `{"nginx.ingress.kubernetes.io/affinity": "cookie", "nginx.ingress.kubernetes.io/session-cookie-name": "session"}` |
| `ingress.enabled`                           | Enable the creation of an Ingress                                     | `true`                                                           |
| `ingress.hostname`                          | Hostname for the Ingress                                              | `{{.Chart.Name}}-{{.Release.Namespace}}.{{tpl .Values.Domain .}}`|
| `ingress.port`                              | Port for the Ingress                                                  | `8080`                                                           |
| `ingress.tls`                               | Enable TLS for the Ingress                                            | `true`                                                           |
| `ingress.selfSigned`                        | Use self-signed TLS certificates                                      | `false`                                                          |
| `ingress.extraTls`                          | Additional TLS configuration                                          | `[]`                                                             |
| `mail.protocol`                             | Mail protocol                                                         | `smtp`                                                           |
| `mail.from`                                 | Mail from address                                                     | `""`                                                             |
| `mail.password`                             | Mail password                                                         | `""`                                                             |
| `mail.user`                                 | Mail username                                                         | `""`                                                             |
| `mail.alias`                                | Mail alias                                                            | `DoNotReply`                                                     |
| `mail.folder`                               | Mail folder                                                           | `INBOX`                                                          |
| `mail.smtp.auth`                            | SMTP authentication enabled                                           | `true`                                                           |
| `mail.smtp.port`                            | SMTP port                                                             | `5432`                                                           |
| `mail.smtp.server`                          | SMTP server                                                           | `""`                                                             |
| `mail.smtp.socketFactory.port`              | SMTP socket factory port                                              | `465`                                                            |
| `mail.smtp.socketFactory.class`             | SMTP socket factory class                                             | `javax.net.ssl.SSLSocketFactory`                                 |
| `mail.smtp.ssl.enable`                      | Enable SMTP SSL                                                       | `false`                                                          |
| `mail.store.protocol`                       | Mail store protocol                                                   | `imaps`                                                          |
| `mail.imaps.host`                           | IMAPS host                                                            | `imap.gmail.com`                                                 |
| `mail.imaps.port`                           | IMAPS port                                                            | `993`                                                            |
| `mail.imaps.timeout`                        | IMAPS timeout                                                         | `1000`                                                           |
| `mail.attachment.download`                  | Enable attachment download                                            | `true`                                                           |
| `mail.attachment.path`                      | Path for attachment downloads                                         | `attachments`                                                    |
| `resources.limits.cpu`                      | CPU limit for the container                                           | `600m`                                                           |
| `resources.limits.memory`                   | Memory limit for the container                                        | `1Gi`                                                            |
| `resources.requests.cpu`                    | CPU request for the container                                         | `500m`                                                           |
| `resources.requests.memory`                 | Memory request for the container                                      | `512Mi`                                                          |
| `hpa.enabled`                               | Enable Horizontal Pod Autoscaler                                      | `false`                                                          |
| `hpa.CpuAverageUtilization`                 | Target average CPU utilization for the HPA                            | `60`                                                             |
| `hpa.maxReplicas`                           | Maximum number of replicas for the HPA                                | `3`                                                              |
| `elastic_search.enabled`                    | Enable Elasticsearch                                                  | `false`                                                          |
| `waitFor`                                   | Wait for the database service to be available                         | `${CAMUNDA_DATABASE_SERVICE_NAME}:${CAMUNDA_DATABASE_PORT}`      |

