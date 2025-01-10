# Formsflow.ai API

formsflow.ai has built this adaptive tier for correlating form management, BPM and analytics together.

The goal of the REST API is to provide access to all relevant interfaces of the system.


## Introduction

This chart bootstraps a forms-flow-api deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-api`:

```console
helm install forms-flow-api forms-flow-api
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


```console
helm install forms-flow-api forms-flow-api  --set ingress.ingressClassName=INGRESS_CLASS  --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS` and `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `INGRESS_CLASS=nginx`. Use  `--set image.repository=formsflow/forms-flow-webapi-ee` for deploy the enterprise version

These commands deploy Forms-flow-api on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-api charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 300m
    memory: 1Gi
  requests:
    cpu: 200m
    memory: 512Mi
```

### Change Forms-flow-api version

To modify the Forms-flow-api version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-webapi) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

#### Using the OpenSource Version
By default, the chart uses the OpenSource version of the `Forms-flow API`. You can change the image tag to any valid version of the OpenSource image, as shown below:

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-webapi
  tag: X.Y.Z # Replace with the desired OpenSource version
```
#### Using the Enterprise Version
If you're using the enterprise version of Forms-flow API, you can switch the image repository to `formsflow/forms-flow-webapi-ee`. The enterprise version includes additional features and support designed for larger-scale or production environments. To use the enterprise version, update the repository field as shown below:

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-webapi-ee
  tag: X.Y.Z  # Replace with the desired enterprise version
```
Make sure to replace X.Y.Z with the specific version number you wish to use for either the OpenSource or enterprise version.

### EE Specific Environment Variables
When deploying the Enterprise Edition (EE) for `forms-flow-api`, the environment variables specific to the EE deployment are already included in the values.yaml file of [forms-flow-ai](../forms-flow-ai/values.yaml#L223) chart.
Make sure to replace `ipaas.embedded_api_key` and `ipaas.jwt_private_key` with the actual keys provided to you.

Example:
```yaml
ipaas:
  embedded_api_key: IPAAS_EMBEDDED_API_KEY
  jwt_private_key: IPAAS_JWT_PRIVATE_KEY
```

## Persistence

The `forms-flow-api` image stores the application logs at the `/forms-flow-api/app/logs` path of the container.

## Sidecar Configuration

To add a sidecar to your `Forms-flow-api` deployment, you can use the following configuration. In this case, the sidecar container is an Nginx container used for configuration management.

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

## API Path Update
The `Forms-flow-api` can now be accessed at the `/api` route. Ensure that all configurations and requests reference this updated path.

For example:

```
https://<HOSTNAME>/api
```
## Parameters

| Parameter                                             | Description                                         | Default Value               |
|-------------------------------------------------------|-----------------------------------------------------|-----------------------------|
| `replicaCount`                                       | Number of replicas for the deployment                | `1`                         |
| `image.registry`                                     | Docker registry for the image                        | `docker.io`                 |
| `image.repository`                                   | Repository for the image                            | `formsflow/forms-flow-webapi` |
| `image.pullSecrets`                                  | Secrets for pulling images from private registries  | `[]`                        |
| `nameOverride`                                       | Override name for the deployment                     | `""`                        |
| `fullnameOverride`                                   | Override full name for the deployment                | `""`                        |
| `commonLabels`                                       | Common labels for all resources                      | `{}`                        |
| `commonAnnotations`                                   | Common annotations for all resources                 | `{}`                        |
| `nodeSelector`                                       | Node selector for pod scheduling                     | `{}`                        |
| `tolerations`                                        | Tolerations for scheduling                           | `[]`                        |
| `affinity`                                           | Affinity rules for pod scheduling                    | `{}`                        |
| `priorityClassName`                                  | Priority class for scheduling                        | `""`                        |
| `schedulerName`                                      | Scheduler to use for the deployment                  | `""`                        |
| `terminationGracePeriodSeconds`                      | Grace period for termination                         | `""`                        |
| `topologySpreadConstraints`                           | Constraints for spreading pods across zones         | `[]`                        |
| `diagnosticMode.enabled`                             | Enable diagnostic mode                              | `false`                    |
| `diagnosticMode.command`                             | Command to run in diagnostic mode                    | `["sleep"]`                |
| `diagnosticMode.args`                                | Arguments for the command in diagnostic mode         | `["infinity"]`             |
| `hostAliases`                                        | Host aliases for the pods                           | `[]`                        |
| `serviceAccount.create`                              | Create a service account                            | `true`                      |
| `serviceAccount.annotations`                          | Annotations for the service account                 | `{}`                        |
| `serviceAccount.name`                                | Name of the service account                          | `""`                        |
| `serviceAccount.automountServiceAccountToken`        | Automount service account token                      | `false`                     |
| `podAnnotations`                                     | Annotations for the pods                            | `{}`                        |
| `podLabels`                                          | Labels for the pods                                 | `{}`                        |
| `podAffinityPreset`                                  | Preset for pod affinity                             | `""`                        |
| `podAntiAffinityPreset`                               | Preset for pod anti-affinity                        | `soft`                      |
| `nodeAffinityPreset.type`                            | Type for node affinity                              | `""`                        |
| `nodeAffinityPreset.key`                             | Key for node affinity                               | `""`                        |
| `nodeAffinityPreset.values`                          | Values for node affinity                            | `[]`                        |
| `podSecurityContext.enabled`                         | Enable pod security context                         | `true`                      |
| `podSecurityContext.fsGroupChangePolicy`             | Policy for changing the fsGroup                     | `Always`                   |
| `podSecurityContext.sysctls`                         | Sysctl settings for the pods                        | `[]`                        |
| `podSecurityContext.supplementalGroups`              | Supplemental groups for the pods                    | `[]`                        |
| `podSecurityContext.fsGroup`                         | fsGroup for the pods                                | `1001`                     |
| `containerSecurityContext.enabled`                   | Enable container security context                   | `true`                      |
| `containerSecurityContext.seLinuxOptions`            | SELinux options for the container                   | `{}`                        |
| `containerSecurityContext.runAsUser`                 | User ID for running the container                   | `1001`                     |
| `containerSecurityContext.runAsGroup`                | Group ID for running the container                  | `1001`                     |
| `containerSecurityContext.runAsNonRoot`              | Run the container as a non-root user                | `false`                     |
| `containerSecurityContext.privileged`                | Enable privileged mode for the container            | `false`                     |
| `containerSecurityContext.readOnlyRootFilesystem`    | Set root filesystem as read-only                    | `false`                     |
| `containerSecurityContext.allowPrivilegeEscalation`  | Allow privilege escalation                           | `false`                     |
| `containerSecurityContext.capabilities.drop`         | Capabilities to drop from the container             | `["ALL"]`                  |
| `containerSecurityContext.seccompProfile.type`       | Seccomp profile type                                 | `RuntimeDefault`           |
| `command`                                            | Command for the container                            | `[]`                        |
| `args`                                               | Arguments for the command                            | `[]`                        |
| `lifecycleHooks`                                      | Lifecycle hooks for the container                   | `{}`                        |
| `automountServiceAccountToken`                        | Automount service account token                      | `true`                      |
| `extraEnvVars`                                       | Extra environment variables                          | `[]`                        |
| `extraEnvVarsCM`                                     | ConfigMap for extra environment variables            | `""`                        |
| `extraVolumes`                                        | Extra volumes for the pods                           | `{}`                        |
| `extraVolumeMounts`                                   | Extra volume mounts for the pods                     | `{}`                        |
| `existingSecret`                                      | Name of an existing secret                           | `""`                        |
| `updateStrategy.type`                                 | Update strategy type for the deployment              | `RollingUpdate`            |
| `updateStrategy.rollingUpdate.maxSurge`              | Maximum surge for the rolling update                 | `25%`                      |
| `updateStrategy.rollingUpdate.maxUnavailable`        | Maximum unavailable for the rolling update           | `25%`                      |
| `pdb.create`                    | Create a pod disruption budget for pods                                                              | `true`                      |
| `pdb.minAvailable`              | Minimum number/percentage of pods that should remain scheduled                                       | `""`                        |
| `pdb.maxUnavailable`            | Maximum number/percentage of pods that may be made unavailable                                       | `""`                        |
| `autoscaling.enabled`           | Enable autoscaling for forms-flow-api                                                                | `false`                     |
| `autoscaling.minReplicas`       | Minimum number of forms-flow-api replicas                                                            | `1`                         |
| `autoscaling.maxReplicas`       | Maximum number of forms-flow-api replicas                                                            | `11`                        |
| `autoscaling.targetCPU`         | Target CPU utilization percentage                                                                     | `""`                        |
| `autoscaling.targetMemory`      | Target Memory utilization percentage                                                                   | `""`                        |
| `autoscaling.behavior.scaleUp.stabilizationWindowSeconds` | Seconds for which past recommendations are considered while scaling up                       | `120`                       |
| `autoscaling.behavior.scaleUp.selectPolicy` | Priority of policies applied when scaling up                                                 | `Max`                       |
| `autoscaling.behavior.scaleUp.policies` | HPA scaling policies when scaling up                                                              | `[]`                        |
| `autoscaling.behavior.scaleDown.stabilizationWindowSeconds` | Seconds for which past recommendations are considered while scaling down                 | `300`                       |
| `autoscaling.behavior.scaleDown.selectPolicy` | Priority of policies applied when scaling down                                               | `Max`                       |
| `autoscaling.behavior.scaleDown.policies` | HPA scaling policies when scaling down                                                           | `[ { type: Pods, value: 1, periodSeconds: 300 } ]` |
| `formsflow.configmap`           | Name of formsflow.ai configmap                                                                       | `forms-flow-ai`             |
| `formsflow.secret`              | Name of formsflow.ai secret                                                                          | `forms-flow-ai`             |


## Ingress Parameters

| Parameter                       | Description                                                                                          | Default Value               |
|---------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `ingress.enabled`              | Enable ingress for the service                                                                       | `true`                      |
| `ingress.ingressClassName`     | Ingress class to be used for the ingress                                                             | `""`                        |
| `ingress.pathType`             | Ingress path type                                                                                    | `ImplementationSpecific`    |
| `ingress.apiVersion`           | API version for the ingress (automatically detected if not set)                                     | `""`                        |
| `ingress.controller`           | Ingress controller type. Options: `default`, `gce`                                                  | `default`                   |
| `ingress.hostname`             | Default host for the ingress record                                                                  | `forms-flow-api.local`     |
| `ingress.path`                 | Default path for the ingress record                                                                   | `"/api"`                       |
| `ingress.servicePort`          | Backend service port to use (default is http)                                                       | `5000`                      |
| `ingress.annotations`          | Additional annotations for the Ingress resource                                                      | `{}`                        |
| `ingress.labels`               | Additional labels for the Ingress resource                                                           | `{}`                        |
| `ingress.tls`                  | Enable TLS configuration for the ingress hostname                                                    | `true`                      |
| `ingress.selfSigned`           | Create a TLS secret using self-signed certificates                                                  | `false`                     |
| `ingress.extraHosts`           | Additional hostname(s) for the ingress                                                                | `[]`                        |
| `ingress.extraPaths`           | Additional arbitrary paths to add under the main host                                               | `[]`                        |
| `ingress.extraTls`             | TLS configuration for additional hostnames                                                           | `[]`                        |
| `ingress.secrets`              | Custom certificates as secrets (key and certificate must start with appropriate headers)             | `[]`                        |
| `ingress.extraRules`           | Additional rules for the ingress                                                                      | `[]`                        |


## Resource Parameters

| Parameter                        | Description                                                                                          | Default Value               |
|----------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `resourcesPreset`               | Set container resources according to a common preset (none, nano, micro, small, medium, large)      | `small`                     |
| `resources.limits.cpu`          | Maximum CPU limit for the container                                                                    | `300m`                      |
| `resources.limits.memory`       | Maximum memory limit for the container                                                                 | `1Gi`                       |
| `resources.requests.cpu`        | Minimum CPU request for the container                                                                  | `200m`                      |
| `resources.requests.memory`     | Minimum memory request for the container                                                               | `512Mi`                     |
| `customStartupProbe`            | Custom startup probe for the component                                                                 | `{}`                        |
| `customLivenessProbe`           | Custom liveness probe for the component                                                                | `{}`                        |
| `customReadinessProbe`          | Custom readiness probe for the component                                                               | `{}`                        |


## Service Parameters

| Parameter                        | Description                                                                                          | Default Value               |
|----------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `service.type`                  | Kubernetes service type (`ClusterIP`, `NodePort`, or `LoadBalancer`)                               | `ClusterIP`                 |
| `service.ports`                 | Ports for the forms-flow-api service                                                                  | `[ { name: http, port: 5000, targetPort: http, protocol: TCP } ]` |
| `service.loadBalancerIP`        | LoadBalancer IP if service type is `LoadBalancer`                                                  | `""`                        |
| `service.loadBalancerSourceRanges` | Allowed addresses when service is LoadBalancer                                                      | `[]`                        |
| `service.externalTrafficPolicy` | External traffic policy to preserve client source IP                                                 | `""`                        |
| `service.clusterIP`             | Static clusterIP or None for headless services                                                       | `""`                        |
| `service.annotations`            | Annotations for the forms-flow-api service                                                           | `{}`                        |
| `service.sessionAffinity`        | Session Affinity for the service, can be "None" or "ClientIP"                                      | `None`                      |
| `service.sessionAffinityConfig`  | Additional settings for sessionAffinity                                                               | `{}`                        |
| `service.headless.annotations`   | Annotations for the headless service                                                                  | `{}`                        |
| `configuration`                  | Additional configuration options                                                                        | `[]`                        |
| `containerPorts.http`            | HTTP port for the container                                                                           | `5000`                      |


## Database Parameters

| Parameter                        | Description                                                                                          | Default Value               |
|----------------------------------|------------------------------------------------------------------------------------------------------|-----------------------------|
| `database.username`             | Database username                                                                                   | `postgres`                  |
| `database.password`             | Database password                                                                                   | `postgres`                  |
| `database.dbName`               | Name of the database                                                                                 | `forms-flow-api`           |
| `database.host`                 | Host for the database                                                                                 | `forms-flow-ai-postgresql-ha-pgpool` |
| `database.port`                 | Port for the database                                                                                 | `5432`                      |

