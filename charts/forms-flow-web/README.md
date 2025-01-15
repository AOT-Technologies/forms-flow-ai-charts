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
helm install forms-flow-web forms-flow-web  --set ingress.ingressClassName=INGRESS_CLASS --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS`, `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `DOMAIN_NAME=example.com` and `INGRESS_CLASS=nginx`

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

#### Using the OpenSource Version
By default, the chart uses the OpenSource version of the `Forms-flow-WEB`. You can change the image tag to any valid version of the OpenSource image, as shown below:

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-web
  tag: X.Y.Z # Replace with the desired OpenSource version
```
#### Using the Enterprise Version
If you're using the enterprise version of Forms-flow-web, you can switch the image repository to `formsflow/forms-flow-web-ee`. The enterprise version includes additional features and support designed for larger-scale or production environments. To use the enterprise version, update the repository field as shown below:

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-web-ee
  tag: X.Y.Z  # Replace with the desired enterprise version
```
Make sure to replace X.Y.Z with the specific version number you wish to use for either the OpenSource or enterprise version.

### EE Specific Environment Variables
When deploying the Enterprise Edition (EE) for forms-flow-web, the environment variables specific to the EE deployment are already included in the `values.yaml` file of the forms-flow-web chart.

Make sure to replace `clarity_key` and `show_premium_icon` with the appropriate values provided to you.

Example: 
```yaml
ShowPremiumIcon: SHOW_PREMIUM_ICON
ClarityKey: true
```

- `CLARITY_KEY_VALUE` should be replaced with the actual clarity key provided to you.
- `SHOW_PREMIUM_ICON` should be set to "true" to display the premium icon in the EE version of the application.

These environment variables will be used to enable EE-specific features in forms-flow-web.

## Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `replicaCount`                          | Number of replicas to run for the application.                                                      | `1`                         |
| `image.registry`                        | Docker registry for the application image.                                                           | `docker.io`                 |
| `image.repository`                      | Repository name for the application image.                                                           | `formsflow/forms-flow-web`  |
| `image.pullPolicy`                     | Image pull policy for the application.                                                               | `IfNotPresent`              |
| `image.tag`                            | Tag of the image to use for the application.                                                         | `v7.0.0`              |
| `image.pullSecrets`                    | Secrets to use for pulling the application image.                                                   | `["forms-flow-ai-auth"]`    |
| `nameOverride`                          | Override for the name of the application.                                                            | `""`                        |
| `fullnameOverride`                      | Override for the full name of the application.                                                       | `""`                        |
| `commonLabels`                          | Common labels to apply to all resources.                                                             | `{}`                        |
| `commonAnnotations`                     | Common annotations to apply to all resources.                                                        | `{}`                        |
| `nodeSelector`                          | Node selector for scheduling pods.                                                                   | `{}`                        |
| `tolerations`                           | Tolerations for scheduling pods.                                                                      | `[]`                        |
| `affinity`                              | Affinity rules for scheduling pods.                                                                  | `{}`                        |
| `priorityClassName`                     | Name of the priority class for the application pods.                                                | `""`                        |
| `schedulerName`                         | Name of the scheduler to use for scheduling pods.                                                    | `""`                        |
| `terminationGracePeriodSeconds`        | Grace period for pod termination.                                                                     | `""`                        |
| `topologySpreadConstraints`             | Constraints for spreading pods across nodes.                                                        | `[]`                        |
| `diagnosticMode.enabled`                | Enable diagnostic mode for the application.                                                          | `false`                     |
| `diagnosticMode.command`                | Command to run in diagnostic mode.                                                                    | `["sleep"]`                 |
| `diagnosticMode.args`                   | Arguments for the diagnostic mode command.                                                            | `["infinity"]`              |
| `hostAliases`                           | Host aliases for the application pods.                                                               | `[]`                        |
| `serviceAccount.create`                 | Create a service account for the application.                                                        | `true`                      |
| `serviceAccount.annotations`             | Annotations for the service account.                                                                  | `{}`                        |
| `serviceAccount.name`                   | Name of the service account to use.                                                                   | `""`                        |
| `serviceAccount.automountServiceAccountToken` | Automount the service account token.                                                            | `false`                     |
| `podAnnotations`                        | Annotations for the application pods.                                                                | `{}`                        |
| `podLabels`                             | Labels for the application pods.                                                                      | `{}`                        |
| `podAffinityPreset`                     | Pod affinity preset for the application.                                                              | `""`                        |
| `podAntiAffinityPreset`                 | Pod anti-affinity preset for the application.                                                        | `soft`                      |
| `nodeAffinityPreset.type`               | Node affinity preset type for the application.                                                       | `""`                        |
| `nodeAffinityPreset.key`                | Key for node affinity preset.                                                                         | `""`                        |
| `nodeAffinityPreset.values`             | Values for node affinity preset.                                                                      | `[]`                        |
| `podSecurityContext.enabled`            | Enable pod security context.                                                                          | `false`                     |
| `podSecurityContext.fsGroupChangePolicy`| Policy for changing filesystem group.                                                                  | `Always`                    |
| `podSecurityContext.sysctls`            | Sysctl settings for the pod.                                                                         | `[]`                        |
| `podSecurityContext.supplementalGroups` | Supplemental groups for the pod.                                                                      | `[]`                        |
| `podSecurityContext.fsGroup`            | Filesystem group for the pod.                                                                         | `1001`                      |
| `containerSecurityContext.enabled`      | Enable container security context.                                                                    | `false`                     |
| `containerSecurityContext.seLinuxOptions` | SELinux options for the container.                                                                  | `{}`                        |
| `containerSecurityContext.runAsUser`    | User ID to run the container as.                                                                      | `1001`                      |
| `containerSecurityContext.runAsGroup`   | Group ID to run the container as.                                                                     | `1001`                      |
| `containerSecurityContext.runAsNonRoot` | Run the container as a non-root user.                                                               | `false`                     |
| `containerSecurityContext.privileged`   | Allow the container to run in privileged mode.                                                       | `false`                     |
| `containerSecurityContext.readOnlyRootFilesystem` | Mount the root filesystem as read-only.                                                      | `false`                     |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation.                                                                | `false`                     |
| `containerSecurityContext.capabilities.drop` | Capabilities to drop from the container.                                                        | `["ALL"]`                   |
| `containerSecurityContext.seccompProfile.type` | Seccomp profile type for the container.                                                        | `RuntimeDefault`            |
| `command`                               | Command to run in the container.                                                                      | `[]`                        |
| `args`                                  | Arguments to pass to the command.                                                                     | `[]`                        |
| `lifecycleHooks.postStart`             | Lifecycle hooks for the pod, such as post-start actions.                                           | `{exec: {command: ["/bin/sh", "-c", "envsubst < /tmp/{{.Chart.Name}}-config.template/config.js > {{.Values.config_path}}/config.js;"]}}` |
| `automountServiceAccountToken`          | Automount the service account token in the pod.                                                     | `true`                      |
| `extraEnvVars`                          | Extra environment variables to add to the container.                                                | `[]`                        |
| `extraEnvVarsCM`                       | ConfigMap for extra environment variables.                                                           | `""`                        |
| `extraVolumes`                          | Extra volumes to add to the pod.                                                                      | `{}`                        |
| `extraVolumeMounts`                     | Extra volume mounts for the pod.                                                                      | `{}`                        |
| `existingSecret`                        | Existing secret containing username, password, and database name.                                    | `""`                        |
| `updateStrategy.type`                   | Update strategy for the deployment (e.g., `RollingUpdate`).                                         | `RollingUpdate`             |
| `updateStrategy.rollingUpdate.maxSurge` | Maximum number of pods that can be created above the desired number of pods during an update.      | `25%`                       |
| `updateStrategy.rollingUpdate.maxUnavailable` | Maximum number of pods that can be unavailable during an update.                               | `25%`                       |
| `pdb.create`                           | Create a Pod Disruption Budget for the application.                                                | `true`                      |
| `pdb.minAvailable`                     | Minimum number of available pods during disruptions.                                                | `""`                        |
| `pdb.maxUnavailable`                   | Maximum number of unavailable pods during disruptions.                                              | `""`                        |
| `customStartupProbe`                   | Custom startup probe configuration for the application.                                              | `{}`                        |
| `customLivenessProbe`                  | Custom liveness probe configuration for the application.                                             | `{}`                        |
| `customReadinessProbe`                 | Custom readiness probe configuration for the application.                                            | `{}`                        |
| `formsflow.configmap`                  | Name of the FormsFlow configmap for integration environment variables.                               | `forms-flow-ai`             |
| `formsflow.secret`                     | Name of the FormsFlow secret for integration environment variables.                                   | `forms-flow-ai`             |
| `analytics.configmap`                  | Name of the FormsFlow analytics configmap for integration.                                          | `forms-flow-analytics`      |
| `analytics.secret`                     | Name of the FormsFlow analytics secret for integration.                                             | `forms-flow-analytics`      |
| `web.base_custom_url`                  | Base URL for the web application.                                                                    | `""`                        |
| `web.custom_theme_url`                 | Custom theme URL for the web application.                                                            | `""`                        |
| `config_path`                          | Path for configuration files.                                                                         | `/usr/share/nginx/html/config/` |
| `webclient`                            | Name of the web client application.                                                                   | `"{{.Chart.Name}}"`         |
| `webname`                              | Name of the web application.                                                                          | `formsflow`                 |
| `UserAccesPermissions`                 | User access permissions for the application.                                                         | `""`                        |
| `autoscaling.enabled`                  | Enable or disable autoscaling for the application.                                                 | `false`                     |
| `autoscaling.minReplicas`              | Minimum number of replicas for autoscaling.                                                         | `1`                         |
| `autoscaling.maxReplicas`              | Maximum number of replicas for autoscaling.                                                         | `11`                        |
| `autoscaling.targetCPU`                | Target CPU utilization percentage for autoscaling.                                                 | `""`                        |
| `autoscaling.targetMemory`             | Target memory utilization percentage for autoscaling.                                              | `""`                        |
| `autoscaling.behavior.scaleUp`         | Scaling behavior when scaling up.                                                                    | `{ stabilizationWindowSeconds: 120, selectPolicy: Max, policies: [] }` |
| `autoscaling.behavior.scaleDown`       | Scaling behavior when scaling down.                                                                  | `{ stabilizationWindowSeconds: 300, selectPolicy: Max, policies: [{ type: Pods, value: 1, periodSeconds: 300 }] }` |
|  `enable_forms_module`                 | Enable or disable tasks module                                                                       | `true`   |         
|  `enable_tasks_module`                 | Enable or disable tasks module      |     `true` |
|  `enable_dashboards_module`              | Enable or disable dashboards module | `true` |
|  `enable_processes_module`      | Enable or disable process module |  `true`  |
|  `enable_applications_module`   | Enable or disable application module | `true` |
|  `public_workflow_enabled`  | Enable or disable workflow - public  |  `false` | 
|  `opentelemetry_service`    | Enable or disable opentelemetry service | `false` |


## Ingress Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `ingress.enabled`                       | Enable or disable ingress for the application.                                                      | `true`                      |
| `ingress.ingressClassName`              | Class name for the ingress resource.                                                                  | `""`                        |
| `ingress.pathType`                      | Type of path matching for the ingress.                                                                | `ImplementationSpecific`    |
| `ingress.apiVersion`                    | API version of the ingress resource.                                                                   | `""`                        |
| `ingress.controller`                    | Ingress controller to use.                                                                            | `default`                   |
| `ingress.hostname`                      | Hostname for the ingress resource.                                                                     | `forms-flow-web.local`     |
| `ingress.path`                          | Path for the ingress resource.                                                                        | `/`                         |
| `ingress.servicePort`                   | Service port to route traffic to.                                                                     | `8080`                      |
| `ingress.annotations`                   | Annotations for the ingress resource.                                                                | `{}`                        |
| `ingress.labels`                        | Labels for the ingress resource.                                                                      | `{}`                        |
| `ingress.tls`                           | Enable TLS for the ingress.                                                                           | `true`                      |
| `ingress.selfSigned`                    | Whether to use self-signed certificates.                                                              | `false`                     |
| `ingress.extraHosts`                    | Additional hosts for the ingress.                                                                    | `[]`                        |
| `ingress.extraPaths`                    | Additional paths for the ingress.                                                                     | `[]`                        |
| `ingress.extraTls`                      | Additional TLS settings for the ingress.                                                              | `[]`                        |
| `ingress.secrets`                       | Secrets for TLS configuration.                                                                        | `[]`                        |
| `ingress.extraRules`                    | Additional rules for the ingress.                                                                     | `[]`                        |

## Resource Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `resourcesPreset`                       | Resource preset for the application.                                                                  | `small`                     |
| `resources.limits.cpu`                 | Maximum CPU resource limit for the application.                                                      | `200m`                      |
| `resources.limits.memory`              | Maximum memory resource limit for the application.                                                   | `1Gi`                       |
| `resources.requests.cpu`               | Minimum CPU resource request for the application.                                                    | `100m`                      |
| `resources.requests.memory`            | Minimum memory resource request for the application.                                                 | `512Mi`                     |

## Service Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `service.type`                          | Type of the service (e.g., `ClusterIP`, `NodePort`, `LoadBalancer`).                               | `ClusterIP`                 |
| `service.ports`                        | Ports for the service.                                                                                | `[{ name: http, port: 8080, targetPort: http, protocol: TCP }]` |
| `service.loadBalancerIP`                | LoadBalancer IP for the service (if applicable).                                                    | `""`                        |
| `service.loadBalancerSourceRanges`      | Allowed IP ranges for LoadBalancer source.                                                          | `[]`                        |
| `service.externalTrafficPolicy`         | External traffic policy for the service.                                                             | `""`                        |
| `service.clusterIP`                     | Static ClusterIP for the service.                                                                    | `""`                        |
| `service.annotations`                   | Annotations for the service.                                                                         | `{}`                        |
| `service.sessionAffinity`               | Session affinity settings for the service (e.g., `None` or `ClientIP`).                           | `None`                      |
| `service.sessionAffinityConfig`         | Additional settings for session affinity.                                                            | `{}`                        |
| `service.headless.annotations`          | Annotations for the headless service.                                                                | `{}`                        |

