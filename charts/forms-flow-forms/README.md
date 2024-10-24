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
helm install forms-flow-forms forms-flow-forms --set ingress.ingressClassName=INGRESS_CLASS --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS`, `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `INGRESS_CLASS=nginx`

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

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `replicaCount`                          | Number of replicas for the deployment.                                                               | `1`                         |
| `image.registry`                        | Docker registry for the application image.                                                           | `docker.io`                 |
| `image.repository`                      | Repository for the application image.                                                                | `formsflow/forms-flow-forms` |
| `image.pullPolicy`                      | Image pull policy.                                                                                   | `IfNotPresent`              |
| `image.tag`                             | Tag of the application image.                                                                         | `v7.0.0-alpha`              |
| `image.pullSecrets`                     | Array of image pull secrets.                                                                          | `["forms-flow-ai-auth"]`    |
| `nameOverride`                          | Override for the application name.                                                                    | `""`                        |
| `fullnameOverride`                      | Override for the full application name.                                                               | `""`                        |
| `commonLabels`                          | Common labels to apply to all resources.                                                             | `{}`                        |
| `commonAnnotations`                     | Common annotations to apply to all resources.                                                        | `{}`                        |
| `nodeSelector`                          | Node selector for pod scheduling.                                                                     | `{}`                        |
| `tolerations`                           | Tolerations for pod scheduling.                                                                       | `[]`                        |
| `affinity`                              | Affinity settings for pod scheduling.                                                                 | `{}`                        |
| `priorityClassName`                     | Priority class name for the pods.                                                                     | `""`                        |
| `schedulerName`                         | Custom scheduler name for the deployment.                                                             | `""`                        |
| `terminationGracePeriodSeconds`         | Termination grace period for pods.                                                                    | `""`                        |
| `topologySpreadConstraints`             | Constraints to spread pods across topology domains.                                                   | `[]`                        |
| `diagnosticMode.enabled`                | Enable or disable diagnostic mode for the deployment.                                               | `false`                     |
| `diagnosticMode.command`                | Command to override all containers in the deployment.                                               | `["sleep"]`                 |
| `diagnosticMode.args`                   | Arguments to override all containers in the deployment.                                              | `["infinity"]`              |
| `podSecurityContext.enabled`             | Enable or disable pod security context.                                                              | `true`                      |
| `podSecurityContext.fsGroupChangePolicy` | Policy for changing the filesystem group.                                                            | `Always`                    |
| `podSecurityContext.sysctls`             | Sysctl settings for the pod.                                                                         | `[]`                        |
| `podSecurityContext.supplementalGroups`  | Supplemental groups for the pod.                                                                      | `[]`                        |
| `podSecurityContext.fsGroup`             | Filesystem group for the pod.                                                                        | `1001`                      |
| `containerSecurityContext.enabled`       | Enable or disable container security context.                                                        | `true`                      |
| `containerSecurityContext.seLinuxOptions`| SELinux options for the container.                                                                    | `{}`                        |
| `containerSecurityContext.runAsUser`     | User ID to run the container.                                                                        | `1001`                      |
| `containerSecurityContext.runAsGroup`    | Group ID to run the container.                                                                       | `1001`                      |
| `containerSecurityContext.runAsNonRoot`  | Ensure the container does not run as root.                                                           | `false`                     |
| `containerSecurityContext.privileged`    | Enable privileged mode for the container.                                                            | `false`                     |
| `containerSecurityContext.readOnlyRootFilesystem` | Enable read-only root filesystem for the container.                                           | `false`                     |
| `containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation for the container.                                               | `false`                     |
| `containerSecurityContext.capabilities.drop` | Capabilities to drop from the container.                                                      | `["ALL"]`                  |
| `containerSecurityContext.seccompProfile.type` | Seccomp profile type for the container.                                                        | `RuntimeDefault`           |
| `command`                               | Override default container command (useful when using custom images).                               | `[]`                        |
| `args`                                  | Override default container args (useful when using custom images).                                  | `[]`                        |
| `lifecycleHooks`                        | Lifecycle hooks for the container(s) to automate configuration before or after startup.            | `{}`                        |
| `automountServiceAccountToken`          | Specify whether the service account token should be automatically mounted.                         | `true`                      |
| `extraEnvVars`                          | Extra environment variables for the container.                                                      | `[]`                        |
| `extraEnvVarsCM`                       | Name of existing ConfigMap containing extra env vars.                                              | `""`                        |
| `extraVolumes`                          | Extra volumes to attach to the pod.                                                                 | `{}`                        |
| `extraVolumeMounts`                    | Extra volume mounts for the containers.                                                             | `{}`                        |
| `auth.existingSecret`                   | Existing secret containing password, username, and database name.                                   | `""`                        |
| `auth.annotations`                       | Annotations for the auth settings.                                                                   | `{}`                        |
| `updateStrategy.type`                   | Update strategy for the deployment.                                                                  | `RollingUpdate`             |
| `updateStrategy.rollingUpdate.maxSurge` | Maximum number of pods that can be created above the desired number of pods.                         | `25%`                       |
| `updateStrategy.rollingUpdate.maxUnavailable` | Maximum number of pods that can be unavailable during the update.                                 | `25%`                       |
| `rbac.create`                          | Create RBAC roles and bindings for the application.                                                | `false`                     |
| `rbac.rules`                           | RBAC rules to apply for the application.                                                            | `[]`                        |
| `pdb.create`                           | Create a Pod Disruption Budget for the application.                                                | `true`                      |
| `pdb.minAvailable`                     | Minimum number of pods that must be available during a disruption.                                  | `""`                        |
| `pdb.maxUnavailable`                   | Maximum number of pods that can be unavailable during a disruption.                                  | `""`                        |
| `livenessProbe.enabled`                 | Enable liveness probe for the application.                                                           | `true`                      |
| `livenessProbe.failureThreshold`       | Number of failures before the pod is considered unhealthy.                                          | `5`                         |
| `livenessProbe.initialDelaySeconds`    | Initial delay before starting liveness checks.                                                      | `120`                       |
| `livenessProbe.periodSeconds`           | Frequency of liveness checks.                                                                        | `60`                        |
| `livenessProbe.successThreshold`       | Minimum consecutive successes for the probe to be considered successful.                            | `1`                         |
| `livenessProbe.timeoutSeconds`         | Timeout for liveness checks.                                                                         | `3`                         |
| `readinessProbe.enabled`                | Enable readiness probe for the application.                                                          | `true`                      |
| `readinessProbe.failureThreshold`      | Number of failures before the pod is considered not ready.                                          | `5`                         |
| `readinessProbe.initialDelaySeconds`   | Initial delay before starting readiness checks.                                                      | `120`                       |
| `readinessProbe.periodSeconds`          | Frequency of readiness checks.                                                                       | `60`                        |
| `readinessProbe.successThreshold`      | Minimum consecutive successes for the probe to be considered successful.                            | `1`                         |
| `readinessProbe.timeoutSeconds`        | Timeout for readiness checks.                                                                        | `3`                         |
| `customStartupProbe`                    | Custom startup probe for the application.                                                            | `{}`                        |
| `customLivenessProbe`                   | Custom liveness probe for the application.                                                           | `{}`                        |
| `customReadinessProbe`                  | Custom readiness probe for the application.                                                          | `{}`                        |
| `ExternalAuth.ExistingMailAuthKey`     | Existing key for mail authentication.                                                               | `""`                        |
| `ExternalAuth.ExistingPwdAuthKey`      | Existing key for password authentication.                                                            | `""`                        |
| `ExternalAuth.ExistingSecretName`      | Name of the existing secret for external authentication.                                             | `""`                        |
| `formsflow.configmap`                  | Name of the Formsflow configmap for integration environment variables.                              | `forms-flow-ai`             |
| `formsflow.secret`                     | Name of the Formsflow secret for integration environment variables.                                  | `forms-flow-ai`             |
| `autoscaling.enabled`                  | Enable autoscaling for the application.                                                             | `false`                     |
| `autoscaling.minReplicas`              | Minimum number of replicas for the application.                                                     | `1`                         |
| `autoscaling.maxReplicas`              | Maximum number of replicas for the application.                                                     | `11`                        |
| `autoscaling.targetCPU`                | Target CPU utilization percentage for autoscaling.                                                  | `""`                        |
| `autoscaling.targetMemory`             | Target memory utilization percentage for autoscaling.                                               | `""`                        |
| `autoscaling.behavior.scaleUp.stabilizationWindowSeconds` | Stabilization window for scaling up.                               | `120`                       |
| `autoscaling.behavior.scaleUp.selectPolicy`           | Select policy for scaling up.                                                          | `Max`                       |
| `autoscaling.behavior.scaleUp.policies`               | HPA scaling policies when scaling up.                                                    | `[]`                        |
| `autoscaling.behavior.scaleDown.stabilizationWindowSeconds` | Stabilization window for scaling down.                                   | `300`                       |
| `autoscaling.behavior.scaleDown.selectPolicy`         | Select policy for scaling down.                                                        | `Max`                       |
| `autoscaling.behavior.scaleDown.policies`             | HPA scaling policies when scaling down.                                               | `[{type: "Pods", value: 1, periodSeconds: 300}]` |


## Ingress Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `ingress.enabled`                       | Enable ingress record generation for the application.                                               | `true`                      |
| `ingress.ingressClassName`             | Ingress class name to use for the ingress resource.                                                | `""`                        |
| `ingress.pathType`                     | Path type for the ingress resource.                                                                  | `ImplementationSpecific`     |
| `ingress.apiVersion`                   | API version for the ingress resource.                                                                | `""`                        |
| `ingress.controller`                   | Ingress controller to use.                                                                           | `default`                   |
| `ingress.hostname`                     | Hostname for the ingress resource.                                                                    | `forms-flow-forms.local`    |
| `ingress.path`                         | Path for the ingress resource.                                                                       | `/`                         |
| `ingress.servicePort`                  | Service port for the ingress resource.                                                               | `3001`                      |
| `ingress.annotations`                   | Annotations for the ingress resource.                                                                | `{}`                        |
| `ingress.labels`                       | Labels for the ingress resource.                                                                     | `{}`                        |
| `ingress.tls`                          | Enable TLS for the ingress resource.                                                                 | `true`                      |
| `ingress.selfSigned`                   | Create a self-signed TLS certificate for the ingress.                                               | `false`                     |
| `ingress.extraHosts`                   | Additional hostnames for the ingress.                                                                | `[]`                        |
| `ingress.extraPaths`                   | Additional paths for the ingress.                                                                    | `[]`                        |
| `ingress.extraTls`                     | Additional TLS settings for the ingress.                                                             | `[]`                        |
| `ingress.secrets`                      | TLS secrets for the ingress.                                                                         | `[]`                        |
| `ingress.extraRules`                   | Extra rules for the ingress resource.                                                                 | `[]`                        |

## Resource Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `resourcesPreset`                       | Preset for resource requests and limits.                                                            | `small`                     |
| `resources.limits.cpu`                 | Maximum CPU limit for the pod.                                                                       | `200m`                      |
| `resources.limits.memory`              | Maximum memory limit for the pod.                                                                    | `1Gi`                       |
| `resources.requests.cpu`               | Requested CPU for the pod.                                                                           | `100m`                      |
| `resources.requests.memory`            | Requested memory for the pod.                                                                        | `512Mi`                     |

## Service Parameters

| Parameter                               | Description                                                                                          | Default Value               |
|-----------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `service.type`                         | Kubernetes service type (e.g., `ClusterIP`, `NodePort`, `LoadBalancer`).                          | `ClusterIP`                 |
| `service.ports`                        | Array of service ports for the application.                                                         | `[{name: "http", port: 3001, targetPort: "http", protocol: "TCP"}]` |
| `service.loadBalancerIP`               | LoadBalancer IP if service type is `LoadBalancer`.                                                 | `""`                        |
| `service.loadBalancerSourceRanges`     | Allowed source ranges for LoadBalancer service.                                                    | `[]`                        |
| `service.externalTrafficPolicy`        | External traffic policy for the service.                                                            | `""`                        |
| `service.clusterIP`                    | Static clusterIP or `None` for headless services.                                                  | `""`                        |
| `service.annotations`                   | Annotations for the service.                                                                         | `{}`                        |
| `service.sessionAffinity`               | Session affinity for the service.                                                                    | `None`                      |
| `service.sessionAffinityConfig`         | Additional settings for session affinity.                                                           | `{}`                        |
| `service.headless.annotations`          | Annotations for the headless service.                                                                | `{}`                        |



