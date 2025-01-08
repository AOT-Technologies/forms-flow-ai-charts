# Formsflow Documents API

The goal of the document API is to generate pdf with form submission data..

## Introduction

This chart bootstraps a forms-flow-documents-api deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-documents-api`:

```console
helm upgrade --install forms-flow-documents-api forms-flow-documents-api
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm upgrade --install forms-flow-documents-api forms-flow-documents-api  --set ingress.ingressClassName=INGRESS_CLASS --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS` and `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-documents-api on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-documents-api charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 300m
    memory: 1Gi
  requests:
    cpu: 200m
    memory: 512Mi
```

### Change Forms-flow-documents-api version

To modify the Forms-flow-documents-api version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-documents-api) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-documents-api
  tag: X.Y.Z 
```
## Persistence

The `forms-flow-documents-api` image stores the application logs at the `/forms-flow-documents/app/logs` path of the container.

## Sidecar Configuration

To add a sidecar to your `Forms-flow-documents-api` deployment, you can use the following configuration. In this case, the sidecar container is an Nginx container used for configuration management.

### Example Sidecar Configuration

```yaml
sidecars:
  - name: nginx
    image: nginx:latest
    ports:
      - containerPort: 80
    volumeMounts:
      - name: nginx-config-volume
        mountPath: /etc/nginx/nginx.conf
        subPath: nginx.conf
```

## Path Update
The `Forms-flow-documents-api` can now be accessed at the `/docapi` route. Ensure that all configurations and requests reference this updated path.

For example:

```
https://<HOSTNAME>/docapi
```
## Parameters

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `replicaCount`                           | Number of replicas for the deployment.                                                               | `1`                         |
| `image.registry`                         | Container image registry.                                                                             | `docker.io`                 |
| `image.repository`                       | Repository for the container image.                                                                   | `formsflow/forms-flow-documents-api` |
| `image.pullPolicy`                       | Image pull policy.                                                                                   | `IfNotPresent`              |
| `image.tag`                              | Tag for the container image.                                                                         | `v7.0.0-alpha`             |
| `image.pullSecrets`                     | Array of image pull secrets.                                                                         | `["forms-flow-ai-auth"]`    |
| `nameOverride`                           | Override for the name of the deployment.                                                             | `""`                        |
| `fullnameOverride`                       | Override for the full name of the deployment.                                                        | `""`                        |
| `commonLabels`                           | Common labels to apply to all resources.                                                             | `{}`                        |
| `commonAnnotations`                      | Common annotations to apply to all resources.                                                        | `{}`                        |
| `nodeSelector`                           | Node selector for scheduling pods.                                                                    | `{}`                        |
| `tolerations`                            | Tolerations for scheduling pods.                                                                      | `[]`                        |
| `affinity`                               | Affinity rules for scheduling pods.                                                                   | `{}`                        |
| `priorityClassName`                      | Name of the priority class for the pods.                                                              | `""`                        |
| `schedulerName`                          | Name of the scheduler to use for the pods.                                                           | `""`                        |
| `terminationGracePeriodSeconds`          | Grace period for pod termination.                                                                     | `""`                        |
| `topologySpreadConstraints`              | Constraints for spreading pods across topology domains.                                              | `[]`                        |
| `diagnosticMode.enabled`                | Enable or disable diagnostic mode.                                                                   | `false`                     |
| `diagnosticMode.command`                | Command to override all containers in the deployment.                                                | `["sleep"]`                 |
| `diagnosticMode.args`                   | Arguments to override all containers in the deployment.                                              | `["infinity"]`              |
| `serviceAccount.create`                  | Specifies whether a service account should be created.                                              | `true`                      |
| `serviceAccount.annotations`              | Annotations to add to the service account.                                                           | `{}`                        |
| `serviceAccount.name`                    | The name of the service account to use.                                                              | `""`                        |
| `serviceAccount.automountServiceAccountToken` | Whether to automount the service account token.                                                  | `false`                     |
| `podAnnotations`                         | Annotations to add to the pod.                                                                       | `{}`                        |
| `podLabels`                             | Labels to add to the pod.                                                                            | `{}`                        |
| `podAffinityPreset`                     | Preset for pod affinity rules.                                                                        | `""`                        |
| `podAntiAffinityPreset`                 | Preset for pod anti-affinity rules.                                                                   | `soft`                      |
| `nodeAffinityPreset.type`               | Type of node affinity preset.                                                                         | `""`                        |
| `nodeAffinityPreset.key`                | Key for node affinity preset.                                                                         | `""`                        |
| `nodeAffinityPreset.values`             | Values for node affinity preset.                                                                      | `[]`                        |
| `podSecurityContext.enabled`            | Enable pod security context.                                                                          | `true`                      |
| `podSecurityContext.fsGroupChangePolicy`| Policy for changing the fsGroup.                                                                      | `Always`                    |
| `podSecurityContext.sysctls`            | Sysctl settings for the pod.                                                                          | `[]`                        |
| `podSecurityContext.supplementalGroups` | Supplemental groups for the pod.                                                                      | `[]`                        |
| `podSecurityContext.fsGroup`            | fsGroup for the pod.                                                                                 | `1001`                      |
| `containerSecurityContext.enabled`      | Enable container security context.                                                                    | `true`                      |
| `containerSecurityContext.seLinuxOptions` | SELinux options for the container.                                                                  | `{}`                        |
| `containerSecurityContext.runAsUser`    | User ID to run the container as.                                                                     | `1001`                      |
| `containerSecurityContext.runAsGroup`   | Group ID to run the container as.                                                                    | `1001`                      |
| `containerSecurityContext.runAsNonRoot` | Whether to run the container as a non-root user.                                                   | `false`                     |
| `containerSecurityContext.privileged`   | Whether to run the container in privileged mode.                                                    | `false`                     |
| `containerSecurityContext.readOnlyRootFilesystem` | Whether to use a read-only root filesystem.                                              | `false`                     |
| `containerSecurityContext.allowPrivilegeEscalation` | Whether to allow privilege escalation.                                                        | `false`                     |
| `containerSecurityContext.capabilities.drop` | Capabilities to drop from the container.                                                          | `["ALL"]`                  |
| `containerSecurityContext.seccompProfile.type` | Seccomp profile type for the container.                                                           | `RuntimeDefault`           |
| `command`                                | Override default container command (useful for custom images).                                     | `[]`                        |
| `args`                                   | Override default container args (useful for custom images).                                         | `[]`                        |
| `lifecycleHooks`                         | Lifecycle hooks for the container to automate configuration before or after startup.                | `{}`                        |
| `automountServiceAccountToken`          | Whether to automount the service account token.                                                    | `true`                      |
| `extraEnvVars`                          | Additional environment variables for the container.                                                | `[]`                        |
| `extraEnvVarsCM`                        | Name of existing ConfigMap containing extra env vars.                                              | `""`                        |
| `extraVolumes`                          | Extra volumes for the container.                                                                    | `{}`                        |
| `extraVolumeMounts`                     | Extra volume mounts for the container.                                                              | `{}`                        |
| `auth.existingSecret`                   | Existing secret containing password, username, and db name.                                         | `""`                        |
| `auth.annotations`                       | Annotations for the auth section.                                                                   | `{}`                        |
| `updateStrategy.type`                   | Type of update strategy for the deployment.                                                         | `RollingUpdate`             |
| `updateStrategy.rollingUpdate.maxSurge`| Maximum surge during updates.                                                                         | `25%`                       |
| `updateStrategy.rollingUpdate.maxUnavailable` | Maximum unavailable pods during updates.                                                        | `25%`                       |
| `pdb.create`                            | Specifies whether a PodDisruptionBudget should be created.                                          | `true`                      |
| `pdb.minAvailable`                      | Minimum number of pods that must be available.                                                      | `""`                        |
| `pdb.maxUnavailable`                    | Maximum number of pods that can be unavailable.                                                     | `""`                        |
| `customStartupProbe`                    | Custom startup probe for the container.                                                              | `{}`                        |
| `customLivenessProbe`                   | Custom liveness probe for the container.                                                             | `{}`                        |
| `customReadinessProbe`                  | Custom readiness probe for the container.                                                            | `{}`                        |
| `autoscaling.enabled`                   | Enable autoscaling for the deployment.                                                                | `false`                     |
| `autoscaling.minReplicas`               | Minimum number of replicas for autoscaling.                                                          | `1`                         |
| `autoscaling.maxReplicas`               | Maximum number of replicas for autoscaling.                                                          | `11`                        |
| `autoscaling.targetCPU`                 | Target CPU utilization for autoscaling.                                                              | `""`                        |
| `autoscaling.targetMemory`              | Target memory utilization for autoscaling.                                                           | `""`                        |
| `autoscaling.behavior.scaleUp`          | Autoscaling behavior for scale up operations.                                                        | `{ stabilizationWindowSeconds: 120, selectPolicy: "Max", policies: [] }` |
| `autoscaling.behavior.scaleDown`        | Autoscaling behavior for scale down operations.                                                      | `{ stabilizationWindowSeconds: 300, selectPolicy: "Max", policies: [{type: "Pods", value: 1, periodSeconds: 300}] }` |
| `formsflow.configmap`                   | Name of the FormsFlow configuration map.                                                             | `forms-flow-ai`            |
| `formsflow.secret`                      | Name of the FormsFlow secret.                                                                        | `forms-flow-ai`            |


## Ingress Parameters

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `ingress.enabled`                        | Enable ingress record generation for the application.                                               | `true`                      |
| `ingress.ingressClassName`              | Name of the ingress class to use.                                                                    | `""`                        |
| `ingress.pathType`                      | Type of path matching for the ingress.                                                               | `ImplementationSpecific`    |
| `ingress.apiVersion`                    | API version for the ingress resource.                                                                | `""`                        |
| `ingress.controller`                    | Ingress controller to use.                                                                           | `default`                   |
| `ingress.hostname`                      | Hostname for the ingress.                                                                           | `forms-flow-documents-api.local` |
| `ingress.path`                          | Path for the ingress.                                                                                | `/docapi`                         |
| `ingress.servicePort`                   | Service port for the ingress.                                                                        | `5006`                      |
| `ingress.annotations`                    | Annotations for the ingress resource.                                                                | `{}`                        |
| `ingress.labels`                         | Labels for the ingress resource.                                                                     | `{}`                        |
| `ingress.tls`                           | Enable TLS for the ingress.                                                                          | `true`                      |
| `ingress.selfSigned`                    | Create a TLS secret using self-signed certificates generated by Helm.                               | `false`                     |
| `ingress.extraHosts`                    | Additional hostnames for the ingress.                                                                | `[]`                        |
| `ingress.extraPaths`                    | Additional paths for the ingress.                                                                    | `[]`                        |
| `ingress.extraTls`                      | Additional TLS settings for the ingress.                                                             | `[]`                        |
| `ingress.secrets`                       | TLS secrets for the ingress.                                                                         | `[]`                        |
| `ingress.extraRules`                    | Additional rules for the ingress.                                                                    | `[]`                        |

## Resource Parameters

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `resourcesPreset`                       | Preset resource allocation for the deployment.                                                       | `small`                     |
| `resources.limits.cpu`                  | CPU limit for the pods.                                                                              | `200m`                      |
| `resources.limits.memory`               | Memory limit for the pods.                                                                           | `1Gi`                       |
| `resources.requests.cpu`                | CPU request for the pods.                                                                            | `100m`                      |
| `resources.requests.memory`             | Memory request for the pods.                                                                         | `512Mi`                     |

## Service Parameters

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `service.type`                          | Service type for the application.                                                                    | `ClusterIP`                 |
| `service.ports`                         | Ports configuration for the service.                                                                 | `[{name: "http", port: 5006, targetPort: "http", protocol: "TCP"}]` |
| `service.loadBalancerIP`                | Load balancer IP for the service.                                                                    | `""`                        |
| `service.loadBalancerSourceRanges`      | Source ranges for load balancer.                                                                     | `[]`                        |
| `service.externalTrafficPolicy`         | External traffic policy for the service.                                                             | `""`                        |
| `service.clusterIP`                     | Cluster IP for the service.                                                                          | `""`                        |
| `service.annotations`                    | Annotations for the service.                                                                         | `{}`                        |
| `service.sessionAffinity`                | Session affinity for the service.                                                                    | `None`                      |
| `service.sessionAffinityConfig`         | Configuration for session affinity.                                                                  | `{}`                        |
| `service.headless.annotations`          | Annotations for the headless service.                                                                | `{}`                        |

