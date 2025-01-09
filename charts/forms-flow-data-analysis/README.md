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
helm install forms-flow-data-analysis forms-flow-data-analysis --set ingress.ingressClassName=INGRESS_CLASS --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS` and `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `INGRESS_CLASS=nginx`

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

#### Using the OpenSource Version
By default, the chart uses the OpenSource version of the `Forms-flow-data-analysis-api`. You can change the image tag to any valid version of the OpenSource image, as shown below:

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-data-analysis-api
  tag: X.Y.Z # Replace with the desired OpenSource version
```
#### Using the Enterprise Version
If you're using the enterprise version of Forms-flow-data-analysis-api, you can switch the image repository to `formsflow/forms-flow-data-analysis-api-ee`. The enterprise version includes additional features and support designed for larger-scale or production environments. To use the enterprise version, update the repository field as shown below:

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-data-analysis-api-ee
  tag: X.Y.Z  # Replace with the desired enterprise version
```
Make sure to replace X.Y.Z with the specific version number you wish to use for either the OpenSource or enterprise version.

### EE Specific Environment Variables
When deploying the Enterprise Edition (EE) for `forms-flow-data-analysis`, the environment variables specific to the EE deployment are already included in the [values.yaml](values.yaml#L509). 
Make sure to replace `openApiKey` with the actual keys provided to you.

Example:
```yaml
openApiKey: "OPENAI_API_KEY"
```

## Persistence

The `forms-flow-data-analysis` image stores the application logs at the `/forms-flow-data-analysis/app/logs` path of the container.

## Sidecar Configuration

To add a sidecar to your `Forms-flow-data-analysis` deployment, you can use the following configuration. In this case, the sidecar container is an Nginx container used for configuration management.

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
The `Forms-flow-data-analysis` can now be accessed at the `/analysis` route. Ensure that all configurations and requests reference this updated path.

For example:

```
https://<HOSTNAME>/analysis
```
## Parameters

| Parameter                          | Description                                                                                          | Default Value               |
|------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `replicaCount`                     | Number of replicas for the deployment.                                                               | `1`                         |
| `image.registry`                   | Docker registry for the image.                                                                       | `docker.io`                 |
| `image.repository`                 | Repository for the image.                                                                             | `formsflow/forms-flow-data-analysis-api` |
| `image.pullPolicy`                 | Image pull policy.                                                                                    | `IfNotPresent`              |
| `image.tag`                        | Tag of the image to use.                                                                             | `latest`             |
| `image.pullSecrets`                | Array of image pull secrets.                                                                          | `forms-flow-ai-auth`       |
| `nameOverride`                     | Override the name of the deployment.                                                                  | `""`                        |
| `fullnameOverride`                 | Override the full name of the deployment.                                                            | `""`                        |
| `commonLabels`                     | Common labels to apply to all resources.                                                             | `{}`                        |
| `commonAnnotations`                | Common annotations to apply to all resources.                                                        | `{}`                        |
| `nodeSelector`                     | Node selector for pod scheduling.                                                                     | `{}`                        |
| `tolerations`                      | Tolerations for scheduling pods.                                                                      | `[]`                        |
| `affinity`                         | Affinity rules for pod scheduling.                                                                    | `{}`                        |
| `priorityClassName`                | Priority class name for scheduling.                                                                   | `""`                        |
| `schedulerName`                    | Name of the scheduler to use for scheduling pods.                                                    | `""`                        |
| `terminationGracePeriodSeconds`    | Grace period for pod termination.                                                                     | `""`                        |
| `topologySpreadConstraints`        | Constraints for spreading pods across nodes.                                                         | `[]`                        |
| `diagnosticMode.enabled`           | Enables diagnostic mode for the deployment.                                                          | `false`                     |
| `diagnosticMode.command`           | Command to run for diagnostic mode.                                                                   | `["sleep"]`                |
| `diagnosticMode.args`              | Arguments for the diagnostic command.                                                                 | `["infinity"]`             |
| `hostAliases`                      | Host aliases for the pods.                                                                           | `[]`                        |
| `serviceAccount.create`            | Specifies whether a service account should be created.                                               | `true`                      |
| `serviceAccount.annotations`        | Annotations to add to the service account.                                                           | `{}`                        |
| `serviceAccount.name`              | Name of the service account to use.                                                                    | `""`                        |
| `serviceAccount.automountServiceAccountToken` | Specifies if the service account token should be automatically mounted.                | `false`                     |
| `podAnnotations`                   | Annotations to apply to the pods.                                                                     | `{}`                        |
| `podLabels`                        | Labels to apply to the pods.                                                                          | `{}`                        |
| `podAffinityPreset`                | Pod affinity preset to use.                                                                           | `""`                        |
| `podAntiAffinityPreset`            | Pod anti-affinity preset to use.                                                                      | `soft`                      |
| `nodeAffinityPreset`               | Node affinity preset to use.                                                                          | `{}`                        |
| `podSecurityContext.enabled`       | Specifies if the pod security context is enabled.                                                    | `true`                      |
| `podSecurityContext.fsGroup`       | FS group for the pods.                                                                                | `1001`                      |
| `containerSecurityContext.enabled` | Specifies if the container security context is enabled.                                              | `true`                      |
| `containerSecurityContext.runAsUser` | User ID to run the container.                                                                       | `1001`                      |
| `containerSecurityContext.runAsGroup` | Group ID to run the container.                                                                     | `1001`                      |
| `containerSecurityContext.runAsNonRoot` | Specifies if the container should run as a non-root user.                                      | `false`                     |
| `containerSecurityContext.privileged` | Specifies if the container should run in privileged mode.                                         | `false`                     |
| `containerSecurityContext.readOnlyRootFilesystem` | Specifies if the root filesystem should be read-only.                                      | `false`                     |
| `containerSecurityContext.allowPrivilegeEscalation` | Specifies if privilege escalation is allowed.                                           | `false`                     |
| `containerSecurityContext.capabilities.drop` | Capabilities to drop from the container.                                                    | `["ALL"]`                  |
| `containerSecurityContext.seccompProfile.type` | Seccomp profile type to use.                                                              | `RuntimeDefault`            |
| `command`                          | Override default container command (useful when using custom images).                               | `[]`                        |
| `args`                             | Override default container args (useful when using custom images).                                  | `[]`                        |
| `lifecycleHooks`                   | Lifecycle hooks for the container(s).                                                                | `{}`                        |
| `automountServiceAccountToken`     | Specifies if the service account token should be automatically mounted.                              | `true`                      |
| `extraEnvVars`                     | Additional environment variables to pass to the containers.                                          | `[]`                        |
| `extraEnvVarsCM`                  | Name of existing ConfigMap containing extra environment variables.                                    | `""`                        |
| `extraVolumes`                     | Additional volumes to mount to the pods.                                                             | `{}`                        |
| `extraVolumeMounts`               | Additional volume mounts for the containers.                                                          | `{}`                        |
| `existingSecret`                   | Existing secret containing password, username, and dbname.                                          | `""`                        |
| `updateStrategy.type`              | Update strategy for deployment.                                                                      | `RollingUpdate`             |
| `updateStrategy.rollingUpdate.maxSurge` | Maximum number of pods that can be created above the desired number during an update.       | `25%`                       |
| `updateStrategy.rollingUpdate.maxUnavailable` | Maximum number of pods that can be unavailable during an update.                          | `25%`                       |
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
| `openApiKey`                            | OpenAI API key for authentication.                                                                    | `""`                        |
| `chatbotModelId`                        | Model ID for the chatbot used in the application.                                                    | `gpt-3.5-turbo`            |
| `formsflow.configmap`                   | Name of the FormsFlow configuration map.                                                             | `forms-flow-ai`            |
| `formsflow.secret`                      | Name of the FormsFlow secret.                                                                        | `forms-flow-ai`            |

## Ingress Parameters

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `ingress.enabled`                        | Enable ingress record generation for forms-flow-data-analysis.                                       | `true`                      |
| `ingress.ingressClassName`              | Name of the ingress class to use.                                                                    | `""`                        |
| `ingress.pathType`                      | Type of path matching for the ingress.                                                               | `ImplementationSpecific`    |
| `ingress.apiVersion`                    | API version for the ingress resource.                                                                | `""`                        |
| `ingress.controller`                    | Ingress controller to use.                                                                           | `default`                   |
| `ingress.hostname`                      | Hostname for the ingress.                                                                           | `forms-flow-data-analysis.local` |
| `ingress.path`                          | Path for the ingress.                                                                                | `/analysis`                         |
| `ingress.servicePort`                   | Service port for the ingress.                                                                        | `5000`                      |
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
| `resources.limits.cpu`                  | CPU limit for the pods.                                                                              | `500m`                      |
| `resources.limits.memory`               | Memory limit for the pods.                                                                           | `1Gi`                       |
| `resources.requests.cpu`                | CPU request for the pods.                                                                            | `250m`                      |
| `resources.requests.memory`             | Memory request for the pods.                                                                         | `512Mi`                     |


## Service Parameters

| Parameter                                | Description                                                                                          | Default Value               |
|------------------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `service.type`                          | Service type for the application.                                                                    | `ClusterIP`                 |
| `service.ports`                         | Ports configuration for the service.                                                                 | `[{name: "http", port: 5000, targetPort: "http", protocol: "TCP"}]` |
| `service.loadBalancerIP`                | Load balancer IP for the service.                                                                    | `""`                        |
| `service.loadBalancerSourceRanges`      | Source ranges for load balancer.                                                                     | `[]`                        |
| `service.externalTrafficPolicy`         | External traffic policy for the service.                                                             | `""`                        |
| `service.clusterIP`                     | Cluster IP for the service.                                                                          | `""`                        |
| `service.annotations`                    | Annotations for the service.                                                                         | `{}`                        |
| `service.sessionAffinity`                | Session affinity for the service.                                                                    | `None`                      |
| `service.sessionAffinityConfig`         | Configuration for session affinity.                                                                  | `{}`                        |
| `service.headless.annotations`          | Annotations for the headless service.                                                                | `{}`                        |


