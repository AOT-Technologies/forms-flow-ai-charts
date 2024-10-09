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
helm install forms-flow-bpm forms-flow-bpm  --set ingress.ingressClassName=INGRESS_CLASS --set camunda.websocket.securityOrigin=FORMS_FLOW_WEB_URL --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS`, `FORMS_FLOW_WEB_URL` and `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `INGRESS_CLASS=nginx`

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

| Parameter                        | Description                                                                                          | Default Value               |
|----------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `replicaCount`                   | Number of replicas for the deployment                                                                 | `1`                         |
| `existingSecret`                 | Existing secret containing password, username, dbname                                                | `""`                        |
| `image.registry`                 | Container image registry                                                                               | `docker.io`                 |
| `image.repository`               | Container image repository                                                                             | `formsflow/forms-flow-bpm`  |
| `image.pullPolicy`               | Image pull policy                                                                                     | `IfNotPresent`              |
| `image.tag`                      | Image tag                                                                                            | `v7.0.0-alpha`              |
| `image.pullSecrets`              | Pull secrets for the image                                                                           | `forms-flow-ai-auth`        |
| `nameOverride`                   | Override for common names                                                                              | `""`                        |
| `fullnameOverride`               | Full override for common names                                                                         | `""`                        |
| `commonLabels`                   | Labels to add to all deployed objects                                                                  | `{}`                        |
| `dnsPolicy`                      | DNS Policy for pod                                                                                    | `ClusterFirst`              |
| `commonAnnotations`              | Annotations to add to all deployed objects                                                            | `{}`                        |
| `tolerations`                    | Tolerations for pod assignment                                                                         | `[]`                        |
| `nodeSelector`                   | Node labels for pod assignment                                                                         | `{}`                        |
| `affinity`                       | Node affinity rules                                                                                   | `{}`                        |
| `priorityClassName`              | Priority class for the pod                                                                             | `""`                        |
| `schedulerName`                  | Name of the scheduler                                                                                 | `default-scheduler`         |
| `terminationGracePeriodSeconds`  | Grace period for pod termination                                                                       | `30`                        |
| `topologySpreadConstraints`      | Constraints for pod topology spread                                                                    | `[]`                        |
| `diagnosticMode.enabled`         | Enable diagnostic mode                                                                                | `false`                     |
| `diagnosticMode.command`         | Command to override all containers                                                                     | `["sleep"]`                 |
| `diagnosticMode.args`            | Arguments to override all containers                                                                   | `["infinity"]`              |
| `hostAliases`                    | Deployment host aliases                                                                                | `[]`                        |
| `serviceAccount.create`         | Specifies whether a service account should be created                                                 | `true`                      |
| `serviceAccount.annotations`     | Annotations to add to the service account                                                              | `{}`                        |
| `serviceAccount.name`            | Name of the service account to use (if not set and create is true, a name is generated)              | `""`                        |
| `serviceAccount.automountServiceAccountToken` | Mount Service Account token in pod                                                        | `false`                     |
| `podManagementPolicy`            | Policy for managing pods                                                                               | `OrderedReady`              |
| `podAnnotations`                 | Annotations for the pod                                                                                | `{}`                        |
| `podLabels`                      | Labels for the pod                                                                                   | `{}`                        |
| `podSecurityContext.enabled`     | Enable pod security context                                                                            | `true`                      |
| `podSecurityContext.fsGroupChangePolicy` | File system group change policy                                                                | `Always`                    |
| `podSecurityContext.fsGroup`     | File system group for the pod                                                                         | `1001`                      |
| `containerSecurityContext.enabled` | Enable container security context                                                                    | `true`                      |
| `containerSecurityContext.runAsUser` | User ID for running the container                                                                | `1001`                      |
| `containerSecurityContext.runAsGroup` | Group ID for running the container                                                              | `1001`                      |
| `containerSecurityContext.runAsNonRoot` | Run as non-root user                                                                          | `false`                     |
| `containerSecurityContext.privileged` | Privileged mode for the container                                                                | `false`                     |
| `containerSecurityContext.readOnlyRootFilesystem` | Read-only root filesystem                                                          | `false`                     |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation                                                    | `false`                     |
| `containerSecurityContext.capabilities.drop` | Capabilities to drop for the container                                              | `["ALL"]`                  |
| `containerSecurityContext.seccompProfile.type` | Seccomp profile type                                                               | `RuntimeDefault`            |
| `command`                        | Override default container command (useful for custom images)                                       | `[]`                        |
| `args`                           | Override default container args (useful for custom images)                                          | `[]`                        |
| `lifecycleHooks`                 | Lifecycle hooks for the forms-flow-bpm container(s)                                                 | `{}`                        |
| `updateStrategy.type`            | Update strategy type                                                                                 | `RollingUpdate`             |
| `updateStrategy.rollingUpdate.maxSurge` | Maximum surge during updates                                                                | `25%`                       |
| `updateStrategy.rollingUpdate.maxUnavailable` | Maximum unavailable during updates                                                      | `25%`                       |
| `minReadySeconds`                | How many seconds a pod needs to be ready before killing the next, during update                    | `0`                         |
| `extraEnvVars`       | Additional environment variables for the container            | See below                            |
| `extraEnvVarsCM`     | Name of existing ConfigMap containing extra env vars         | `""`                                 |
| `extraVolumes`       | Additional volumes for the pod                               | `{}`                                 |
| `extraVolumeMounts`  | Additional volume mounts for the pod                         | `{}`                                 |
| `existingSecret`     | Existing secret containing password, username, dbname       | `""`                                 |
| `rbac.create`                             | Create RBAC resources                                                                         | `false`                     |
| `rbac.rules`                              | Custom RBAC rules                                                                             | `[]`                        |
| `pdb.create`                              | Create Pod Disruption Budget                                                                   | `true`                      |
| `pdb.minAvailable`                        | Minimum available pods                                                                        | `""`                        |
| `pdb.maxUnavailable`                      | Maximum unavailable pods                                                                      | `""`                        |
| `livenessProbe.enabled`                   | Enable liveness probe                                                                         | `true`                      |
| `livenessProbe.failureThreshold`           | Liveness probe failure threshold                                                               | `5`                         |
| `livenessProbe.initialDelaySeconds`       | Initial delay before liveness probe                                                          | `120`                       |
| `livenessProbe.periodSeconds`             | How often to perform the liveness probe                                                       | `60`                        |
| `livenessProbe.successThreshold`          | Minimum consecutive successes for the probe to be considered successful                       | `1`                         |
| `livenessProbe.timeoutSeconds`            | Timeout for the liveness probe                                                                | `3`                         |
| `readinessProbe.enabled`                  | Enable readiness probe                                                                        | `true`                      |
| `readinessProbe.failureThreshold`         | Readiness probe failure threshold                                                              | `5`                         |
| `readinessProbe.initialDelaySeconds`     | Initial delay before readiness probe                                                          | `120`                       |
| `readinessProbe.periodSeconds`            | How often to perform the readiness probe                                                      | `60`                        |
| `readinessProbe.successThreshold`         | Minimum consecutive successes for the readiness probe                                          | `1`                         |
| `readinessProbe.timeoutSeconds`           | Timeout for the readiness probe                                                                | `3`                         |
| `autoscaling.enabled`                     | Enable autoscaling                                                                           | `false`                     |
| `autoscaling.minReplicas`                | Minimum number of replicas for autoscaling                                                  | `1`                         |
| `autoscaling.maxReplicas`                | Maximum number of replicas for autoscaling                                                  | `11`                        |
| `autoscaling.targetCPU`                  | Target CPU utilization for autoscaling                                                       | `""`                        |
| `autoscaling.targetMemory`               | Target memory utilization for autoscaling                                                    | `""`                        |
| `autoscaling.behavior.scaleUp`           | Configuration for scale-up behavior                                                           | See values below            |
| `autoscaling.behavior.scaleDown`         | Configuration for scale-down behavior                                                         | See values below            |
| `autoscaling.behavior.scaleUp.stabilizationWindowSeconds` | Time window to stabilize scale-up events                                                  | `120`                       |
| `autoscaling.behavior.scaleUp.selectPolicy`             | Policy for selecting scale-up behavior                                                    | `Max`                       |
| `autoscaling.behavior.scaleUp.policies`                 | Policies for scaling up                                                                    | `[]`                        |
| `autoscaling.behavior.scaleDown.stabilizationWindowSeconds` | Time window to stabilize scale-down events                                                | `300`                       |
| `autoscaling.behavior.scaleDown.selectPolicy`           | Policy for selecting scale-down behavior                                                  | `Max`                       |
| `autoscaling.behavior.scaleDown.policies`                | Policies for scaling down                                                                  | `[{ "type": "Pods", "value": 1, "periodSeconds": 300 }]` |
| `camunda.analytics.database`               | Camunda analytics database name                                                                | `forms-flow-analytics`      |
| `camunda.auth.enabled`                    | Enable authentication for Camunda                                                              | `true`                      |
| `camunda.database.name`                   | Name of the Camunda database                                                                    | `forms-flow-bpm`            |
| `camunda.database.port`                   | Port for the Camunda database                                                                   | `5432`                      |
| `camunda.historyLevel`                    | History level setting for Camunda                                                               | `auto`                      |
| `camunda.securityOrigin`                  | Allowed security origin for the application                                                     | `'*'`                       |
| `camunda.logLevel`                        | Logging level for Camunda                                                                      | `INFO`                      |
| `mail.protocol`                  | The protocol used for mail configuration.                                                           | `smtp`                      |
| `mail.from`                      | The sender's email address.                                                                          | `<DEFINE_ME>`               |
| `mail.password`                  | Password for the email account.                                                                      | `<DEFINE_ME>`               |
| `mail.user`                      | Username for the email account.                                                                       | `<DEFINE_ME>`               |
| `mail.alias`                     | Alias used for sending emails.                                                                       | `DoNotReply`                |
| `mail.folder`                    | Default folder for incoming emails.                                                                  | `INBOX`                     |
| `mail.smtp.auth`                 | Specifies if SMTP authentication is required.                                                       | `true`                      |
| `mail.smtp.port`                 | Port number for SMTP server connection.                                                              | `5432`                      |
| `mail.smtp.server`               | SMTP server address.                                                                                 | `<DEFINE_ME>`               |
| `mail.smtp.socketFactory.port`   | Port for the SSL socket factory.                                                                     | `465`                       |
| `mail.smtp.socketFactory.class`  | Class used for the SSL socket factory.                                                               | `javax.net.ssl.SSLSocketFactory` |
| `mail.smtp.ssl.enable`           | Specifies if SSL is enabled for the SMTP connection.                                                | `false`                     |
| `mail.store.protocol`            | Protocol used for mail storage.                                                                      | `imaps`                     |
| `mail.imaps.host`                | Hostname of the IMAP server.                                                                         | `imap.gmail.com`           |
| `mail.imaps.port`                | Port number for the IMAP server connection.                                                          | `993`                       |
| `mail.imaps.timeout`             | Timeout duration for the IMAP connection in milliseconds.                                            | `1000`                      |
| `mail.attachment.download`       | Specifies if attachments should be downloaded.                                                       | `true`                      |
| `mail.attachment.path`           | Path where attachments will be saved.                                                                | `attachments`               |
| `formsflow.configmap`           | Name of the FormsFlow configuration map.                                                             | `forms-flow-ai`             |
| `formsflow.secret`               | Name of the FormsFlow secret.                                                                        | `forms-flow-ai`             |
| `waitFor`                        | Service and port to wait for before starting.                                                       | `${CAMUNDA_DATABASE_SERVICE_NAME}:${CAMUNDA_DATABASE_PORT}` |

## Vault Parameters

| Name          | Value                                |
|---------------|--------------------------------------|
| `VAULT_ENABLED` | `"false"`                         |
| `VAULT_URL`     | `"http://{your-ip-address}:8200"` |
| `VAULT_TOKEN`   | `""`                               |
| `VAULT_PATH`    | `""`                               |
| `VAULT_SECRET`  | `""`                               |


## Ingress Parameters

## Ingress

| Parameter                                  | Description                                                                                   | Default Value               |
|--------------------------------------------|-----------------------------------------------------------------------------------------------|-----------------------------|
| `ingress.enabled`                          | Enable ingress record generation for forms-flow-bpm                                        | `true`                      |
| `ingress.ingressClassName`                | Ingress class name to use                                                                    | `""`                        |
| `ingress.path`                            | Ingress path                                                                                 | `"/camunda"`                |
| `ingress.servicePort`                     | Service port for ingress                                                                     | `8080`                      |
| `ingress.tls`                             | Enable TLS for ingress                                                                        | `true`                      |
| `ingress.selfSigned`                      | Use self-signed certificates for TLS                                                          | `false`                     |
| `ingress.extraHosts`                      | Additional hosts for the ingress                                                              | `[]`                        |
| `ingress.extraPaths`                      | Additional paths for the ingress                                                              | `[]`                        |
| `ingress.extraTls`                        | Additional TLS configurations                                                                  | `[]`                        |
| `ingress.secrets`                         | Secrets for TLS configuration                                                                  | `[]`                        |
| `ingress.extraRules`                      | Additional rules for ingress                                                                   | `[]`                        |

## Resource Parameters

| Parameter                                  | Description                                                                                   | Default Value               |
|--------------------------------------------|-----------------------------------------------------------------------------------------------|-----------------------------|
| `resourcesPreset`                         | Resource preset (e.g., small, medium, large)                                                | `"small"`                   |
| `resources.limits.cpu`                    | CPU limit                                                                                     | `600m`                      |
| `resources.limits.memory`                 | Memory limit                                                                                  | `1Gi`                       |
| `resources.requests.cpu`                  | CPU request                                                                                   | `500m`                      |
| `resources.requests.memory`               | Memory request                                                                                | `512Mi`                     |

## Service Parameters

| Parameter                                  | Description                                                                                   | Default Value               |
|--------------------------------------------|-----------------------------------------------------------------------------------------------|-----------------------------|
| `service.type`                            | Kubernetes service type (`ClusterIP`, `NodePort`, or `LoadBalancer`)                        | `ClusterIP`                 |
| `service.ports`                          | Array of ports for the service                                                                 | `[{"name": "http", "port": 8080, "targetPort": "http", "protocol": "TCP"}]` |
| `service.loadBalancerIP`                  | LoadBalancer IP if service type is `LoadBalancer`                                            | `""`                        |
| `service.loadBalancerSourceRanges`        | Allowed addresses for LoadBalancer                                                             | `[]`                        |
| `service.externalTrafficPolicy`           | External traffic policy to preserve client source IP                                          | `""`                        |
| `service.clusterIP`                       | Static clusterIP or None for headless services                                                | `""`                        |
| `service.annotations`                      | Annotations for the service                                                                   | `{}`                        |
| `service.sessionAffinity`                 | Session affinity for the service (None or ClientIP)                                          | `None`                      |
| `service.sessionAffinityConfig`           | Additional settings for session affinity                                                       | `{}`                        |
| `service.headless.annotations`            | Annotations for the headless service                                                           | `{}`                        |

## Sidecars and Configuration

| Parameter                                  | Description                                                                                   | Default Value               |
|--------------------------------------------|-----------------------------------------------------------------------------------------------|-----------------------------|
| `sidecars`                                | Additional sidecar containers for the pod                                                     | `[]`                        |
| `configuration`                           | Custom configuration for the application                                                       | `""`                        |
| `existingConfigmap`                       | Existing ConfigMap to use                                                                      | `""`                        |
