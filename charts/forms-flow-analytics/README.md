# Formsflow.ai Analytics

**formsflow.ai** leverages [Redash](https://github.com/getredash/redash) to build interactive
dashboards and gain insights. 

## Introduction

This chart bootstraps a forms-flow-analytics deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-analytics`:

```console
helm install forms-flow-analytics forms-flow-analytics
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm upgrade --install forms-flow-analytics forms-flow-analytics --set ingress.ingressClassName=INGRESS_CLASS --set ingress.hosts[0].host=HOSTNAME --set ingress.tls[0].secretName="SECRETNAME" --set ingress.tls[0].hosts[0]="HOSTNAME" --set ingress.hosts[0].paths[0]="/" -n NAMESPACE
```

> Note: You need to substitute the placeholders `INGRESS_CLASS`, `HOSTNAME` and `SECRETNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use `INGRESS_CLASS=nginx`

These commands deploy Forms-flow-analytics on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-analytics charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

## Server

```yaml
  resources:
    limits:
      cpu: 1500m
      memory: 2Gi
    requests:
      cpu: 900m
      memory: 1Gi
```
## Worker

```yaml
  resources:
    limits:
      cpu: 300m
      memory: 2Gi
    requests:
      cpu: 200m
      memory: 1Gi
```
## Scheduler

```yaml
  resources:
    limits:
      cpu: 300m
      memory: 2Gi
    requests:
      cpu: 200m
      memory: 1Gi
```
## Migrations

```yaml
  resources:
    limits:
      cpu: 300m
      memory: 2Gi
    requests:
      cpu: 200m
      memory: 1Gi
```
## Sidecar Configuration

To add a sidecar to your `Forms-flow-analytics` deployment, you can use the following configuration. In this case, the sidecar container is an Nginx container used for configuration management.

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
The `Forms-flow-analytics` can now be accessed at the `/redash` route. Ensure that all configurations and requests reference this updated path.

For example:

```
https://<HOSTNAME>/redash
```

## Parameters

| Parameter                        | Description                                      | Default Value          |
|----------------------------------|--------------------------------------------------|------------------------|
| `server.replicaCount`           | Number of replicas for the server                | `1`                    |
| `server.image.registry`         | Docker registry for the image                    | `docker.io`            |
| `server.image.repository`       | Repository for the image                         | `formsflow/redash`     |
| `server.image.pullPolicy`       | Image pull policy                                | `IfNotPresent`         |
| `server.image.tag`              | Tag for the image                                | `24.04.0`              |
| `server.image.pullSecrets`      | Secrets for pulling images                        | `forms-flow-ai-auth`   |
| `server.nameOverride`           | Override for the name                            | `""`                   |
| `server.fullnameOverride`       | Override for the full name                       | `""`                   |
| `server.commonLabels`           | Common labels for all deployed objects           | `{}`                   |
| `server.commonAnnotations`       | Common annotations for all deployed objects      | `{}`                   |
| `server.nodeSelector`           | Node selector for scheduling                      | `{}`                   |
| `server.tolerations`            | Tolerations for the pod                          | `[]`                   |
| `server.affinity`               | Affinity rules for the pod                       | `{}`                   |
| `server.priorityClassName`      | Priority class name for the pod                  | `""`                   |
| `server.schedulerName`          | Scheduler name for the pod                       | `""`                   |
| `server.terminationGracePeriodSeconds` | Grace period for pod termination         | `""`                   |
| `server.topologySpreadConstraints` | Constraints for topology spread              | `[]`                   |
| `server.diagnosticMode.enabled` | Enable diagnostic mode                           | `false`                |
| `server.diagnosticMode.command` | Command for diagnostic mode                      | `["sleep"]`           |
| `server.diagnosticMode.args`    | Arguments for diagnostic command                 | `["infinity"]`        |
| `server.hostAliases`            | Host aliases for the pod                         | `[]`                   |
| `server.serviceAccount.create`  | Create a service account                         | `true`                 |
| `server.serviceAccount.annotations` | Annotations for the service account          | `{}`                   |
| `server.serviceAccount.name`    | Name for the service account                     | `""`                   |
| `server.serviceAccount.automountServiceAccountToken` | Automount service account token  | `false`                |
| `server.podAnnotations`         | Annotations for the pod                          | `{}`                   |
| `server.podLabels`              | Extra labels for the pod                         | `{}`                   |
| `server.podAffinityPreset`      | Pod affinity preset                               | `""`                   |
| `server.podAntiAffinityPreset`  | Pod anti-affinity preset                         | `soft`                 |
| `server.podSecurityContext.enabled` | Enable pod security context                  | `false`                |
| `server.podSecurityContext.fsGroupChangePolicy` | File system group change policy      | `Always`               |
| `server.podSecurityContext.fsGroup` | File system group ID                         | `1001`                 |
| `server.containerSecurityContext.enabled` | Enable container security context       | `false`                |
| `server.containerSecurityContext.runAsUser` | Run as user ID                        | `1001`                 |
| `server.containerSecurityContext.runAsGroup` | Run as group ID                      | `1001`                 |
| `server.containerSecurityContext.runAsNonRoot` | Run as non-root user               | `false`                |
| `server.containerSecurityContext.privileged` | Privileged mode                     | `false`                |
| `server.containerSecurityContext.readOnlyRootFilesystem` | Read-only root filesystem    | `false`                |
| `server.containerSecurityContext.allowPrivilegeEscalation` | Allow privilege escalation | `false`                |
| `server.containerSecurityContext.capabilities.drop` | Capabilities to drop            | `["ALL"]`              |
| `server.containerSecurityContext.seccompProfile.type` | Seccomp profile type            | `RuntimeDefault`       |
| `server.command`                | Command to run in the container                 | `[]`                   |
| `server.args`                   | Arguments for the command                        | `["server"]`          |
| `server.lifecycleHooks.postStart` | Post-start lifecycle hooks                   | `{"exec": {"command": ["/bin/sh", "-c", "python -v ./manage.py database create_tables"]}}` |
| `server.livenessProbe.enabled`  | Enable liveness probe                            | `true`                 |
| `server.livenessProbe.initialDelaySeconds` | Initial delay for liveness probe   | `90`                   |
| `server.livenessProbe.timeoutSeconds` | Timeout for liveness probe                | `1`                    |
| `server.livenessProbe.periodSeconds` | Period for liveness probe                 | `10`                   |
| `server.livenessProbe.successThreshold` | Success threshold for liveness probe | `1`                    |
| `server.livenessProbe.failureThreshold` | Failure threshold for liveness probe | `10`                   |
| `server.readinessProbe.enabled` | Enable readiness probe                           | `false`                |
| `server.readinessProbe.initialDelaySeconds` | Initial delay for readiness probe | `10`                   |
| `server.readinessProbe.timeoutSeconds` | Timeout for readiness probe             | `1`                    |
| `server.readinessProbe.periodSeconds` | Period for readiness probe               | `10`                   |
| `server.readinessProbe.successThreshold` | Success threshold for readiness probe | `1`                    |
| `server.readinessProbe.failureThreshold` | Failure threshold for readiness probe | `3`                    |
| `server.automountServiceAccountToken` | Automount service account token         | `true`                 |
| `server.extraEnvVars`           | Extra environment variables                     | `[]`                   |
| `server.extraEnvVarsCM`         | Name of existing ConfigMap for extra env vars  | `""`                   |
| `server.extraEnvVarsSecret`     | Name of existing Secret for extra env vars      | `""`                   |
| `server.extraVolumes`           | Extra volumes for the pod                       | `[]`                   |
| `server.extraVolumeMounts`      | Extra volume mounts for the pod                 | `[]`                   |
| `server.existingSecret`         | Existing secret for database credentials         | `""`                   |
| `server.updateStrategy.type`    | Update strategy type                            | `RollingUpdate`        |
| `server.updateStrategy.rollingUpdate.maxSurge` | Max surge during update        | `25%`                  |
| `server.updateStrategy.rollingUpdate.maxUnavailable` | Max unavailable during update | `25%`                  |
| `server.rbac.create`            | Create RBAC resources                           | `false`                |
| `server.rbac.rules`             | RBAC rules for the application                  | `[]`                   |
| `server.pdb.create`             | Create pod disruption budget                    | `true`                 |
| `server.pdb.minAvailable`       | Minimum available pods for disruption budget    | `""`                   |
| `server.pdb.maxUnavailable`     | Maximum unavailable pods for disruption budget  | `""`                   |
| `server.resourcesPreset`         | Resource preset for the server                  | `small`                |
| `server.resources.limits.cpu`    | CPU limit for the server                        | `1500m`                |
| `server.resources.limits.memory` | Memory limit for the server                     | `2Gi`                  |
| `server.resources.requests.cpu`   | CPU request for the server                     | `1000m`                |
| `server.resources.requests.memory`| Memory request for the server                  | `1Gi`                  |
| `server.customStartupProbe`      | Custom startup probe configuration              | `{}`                   |
| `server.customLivenessProbe`     | Custom liveness probe configuration             | `{}`                   |
| `server.customReadinessProbe`    | Custom readiness probe configuration            | `{}`                   |
| `server.containerPorts.http`     | HTTP port for the server                        | `5000`                 |
| `server.sidecars`                | Sidecar containers for the server               | `[]`                   |
| `server.configuration`           | Custom configuration for the server             | `[]`                   |
| `server.autoscaling.enabled`     | Enable autoscaling                              | `false`                |
| `server.autoscaling.minReplicas` | Minimum replicas for autoscaling               | `1`                    |
| `server.autoscaling.maxReplicas` | Maximum replicas for autoscaling               | `11`                   |
| `server.autoscaling.targetCPU`   | Target CPU utilization for autoscaling         | `""`                   |
| `server.autoscaling.targetMemory`| Target memory utilization for autoscaling      | `""`                   |
| `server.autoscaling.behavior.scaleUp.stabilizationWindowSeconds` | Stabilization window for scale up | `120`         |
| `server.autoscaling.behavior.scaleUp.selectPolicy` | Select policy for scale up | `Max`                  |
| `server.autoscaling.behavior.scaleUp.policies` | Scale up policies | `[]`                  |
| `server.autoscaling.behavior.scaleDown.stabilizationWindowSeconds` | Stabilization window for scale down | `300`        |
| `server.autoscaling.behavior.scaleDown.selectPolicy`      | Select policy for scale down                          | `Max`                  |
| `server.autoscaling.behavior.scaleDown.policies`          | Policies for scale down                               | `[{type: Pods, value: 1, periodSeconds: 300}]` |
| `server.autoscaling.behavior.scaleDown.policies[0].type`  | Type of resource for scaling down                     | `Pods`                 |
| `server.autoscaling.behavior.scaleDown.policies[0].value` | Number of resources to scale down                     | `1`                    |
| `server.autoscaling.behavior.scaleDown.policies[0].periodSeconds` | Period for applying the scale down policy          | `300`                  |
| `workers.adhoc.env.QUEUES`                                 | Queues for ad-hoc workers                            | `queries`              |
| `workers.adhoc.env.WORKERS_COUNT`                          | Number of ad-hoc workers                             | `2`                    |
| `workers.scheduled.env.QUEUES`                             | Queues for scheduled workers                         | `scheduled_queries,schemas` |
| `workers.scheduled.env.WORKERS_COUNT`                      | Number of scheduled workers                          | `1`                    |
| `workers.generic.env.QUEUES`                               | Queues for generic workers                           | `periodic,emails,default` |
| `workers.generic.env.WORKERS_COUNT`                        | Number of generic workers                            | `1`                    |
| `worker.replicaCount`                                      | Number of replicas for the worker                    | `1`                    |
| `worker.image.registry`                                    | Docker registry for the worker image                 | `docker.io`            |
| `worker.image.repository`                                  | Repository for the worker image                      | `formsflow/redash`     |
| `worker.image.pullPolicy`                                  | Image pull policy                                    | `IfNotPresent`         |
| `worker.image.tag`                                         | Tag for the worker image                             | `24.04.0`              |
| `worker.image.pullSecrets`                                 | Secrets for pulling the image                        | `forms-flow-ai-auth`   |
| `worker.nameOverride`                                      | Override for the worker name                         | `""`                   |
| `worker.fullnameOverride`                                  | Full override for the worker name                    | `""`                   |
| `worker.commonLabels`                                      | Common labels for the worker                         | `{}`                   |
| `worker.commonAnnotations`                                  | Common annotations for the worker                    | `{}`                   |
| `worker.podAnnotations`                                    | Annotations for the worker pod                       | `{}`                   |
| `worker.podLabels`                                         | Extra labels for the worker pod                      | `{}`                   |
| `worker.podSecurityContext.fsGroup`                        | File system group for the worker                     | `1001`                 |
| `worker.containerSecurityContext.runAsUser`               | User ID to run the container                         | `1001`                 |
| `worker.containerSecurityContext.runAsGroup`              | Group ID to run the container                        | `1001`                 |
| `worker.resources.limits.cpu`                              | CPU limit for the worker                             | `200m`                 |
| `worker.resources.limits.memory`                           | Memory limit for the worker                          | `2Gi`                  |
| `worker.resources.requests.cpu`                            | CPU request for the worker                           | `180m`                 |
| `worker.resources.requests.memory`                         | Memory request for the worker                        | `1Gi`                  |
| `worker.containerPorts.http`                               | HTTP port for the worker                             | `5000`                 |
| `scheduler.replicaCount`                                   | Number of replicas for the scheduler                 | `1`                    |
| `scheduler.image.registry`                                 | Docker registry for the scheduler image              | `docker.io`            |
| `scheduler.image.repository`                               | Repository for the scheduler image                   | `formsflow/redash`     |
| `scheduler.image.pullPolicy`                               | Image pull policy                                    | `IfNotPresent`         |
| `scheduler.image.tag`                                      | Tag for the scheduler image                          | `24.04.0`              |
| `scheduler.image.pullSecrets`                              | Secrets for pulling the image                        | `forms-flow-ai-auth`   |
| `scheduler.nameOverride`                                   | Override for the scheduler name                      | `""`                   |
| `scheduler.fullnameOverride`                               | Full override for the scheduler name                 | `""`                   |
| `scheduler.commonLabels`                                   | Common labels for the scheduler                      | `{}`                   |
| `scheduler.commonAnnotations`                               | Common annotations for the scheduler                 | `{}`                   |
| `scheduler.podAnnotations`                                 | Annotations for the scheduler pod                    | `{}`                   |
| `scheduler.podLabels`                                      | Extra labels for the scheduler pod                   | `{}`                   |
| `scheduler.podAffinityPreset`                              | Pod affinity preset for the scheduler                | `""`                   |
| `scheduler.podAntiAffinityPreset`                          | Pod anti-affinity preset for the scheduler           | `soft`                 |
| `scheduler.nodeSelector`                                   | Node labels for pod assignment                        | `{}`                   |
| `scheduler.tolerations`                                    | Tolerations for pod assignment                        | `[]`                   |
| `scheduler.affinity`                                       | Affinity rules for pod assignment                    | `{}`                   |
| `scheduler.priorityClassName`                              | Pod priority class name                              | `""`                   |
| `scheduler.schedulerName`                                  | Custom scheduler name for the scheduler              | `""`                   |
| `scheduler.terminationGracePeriodSeconds`                  | Grace period for termination                         | `""`                   |
| `scheduler.topologySpreadConstraints`                      | Topology spread constraints for pod assignment       | `[]`                   |
| `scheduler.diagnosticMode.enabled`                         | Enable diagnostic mode for the scheduler             | `false`                |
| `scheduler.hostAliases`                                    | Host aliases for the scheduler                       | `[]`                   |
| `scheduler.podSecurityContext.enabled`                     | Enable pod security context                          | `false`                |
| `scheduler.containerSecurityContext.enabled`               | Enable container security context                    | `false`                |
| `scheduler.updateStrategy.type`                            | Update strategy for the scheduler                    | `Recreate`             |
| `scheduler.rbac.create`                                   | Create RBAC resources for the scheduler              | `false`                |
| `scheduler.pdb.create`                                     | Create Pod Disruption Budget for the scheduler       | `true`                 |
| `scheduler.resourcesPreset`                                | Resources preset for the scheduler                   | `small`                |
| `scheduler.customStartupProbe`                             | Custom startup probe for the scheduler               | `{}`                   |
| `scheduler.customLivenessProbe`                            | Custom liveness probe for the scheduler              | `{}`                   |
| `scheduler.customReadinessProbe`                           | Custom readiness probe for the scheduler             | `{}`                   |
| `scheduler.autoscaling.enabled`                            | Enable autoscaling for the scheduler                 | `false`                |
| `scheduler.autoscaling.minReplicas`                        | Minimum replicas for autoscaling                     | `1`                    |
| `scheduler.autoscaling.maxReplicas`                        | Maximum replicas for autoscaling                     | `11`                   |
| `scheduler.autoscaling.targetCPU`                          | Target CPU utilization for autoscaling               | `""`                   |
| `scheduler.autoscaling.targetMemory`                       | Target memory utilization for autoscaling            | `""`                   |
| `autoscaling.behavior.scaleUp.stabilizationWindowSeconds` | Time in seconds to consider past recommendations when scaling up | `120`                  |
| `autoscaling.behavior.scaleUp.selectPolicy`             | Priority of policies that the autoscaler will apply when scaling up | `Max`                  |
| `autoscaling.behavior.scaleUp.policies`                 | Policies for scaling up                               | `[]`                   |
| `autoscaling.behavior.scaleDown.stabilizationWindowSeconds` | Time in seconds to consider past recommendations when scaling down | `300`                  |
| `autoscaling.behavior.scaleDown.selectPolicy`           | Priority of policies that the autoscaler will apply when scaling down | `Max`                  |
| `autoscaling.behavior.scaleDown.policies`               | Policies for scaling down                             | `- type: Pods, value: 1, periodSeconds: 300` |


## Ingress Parameters

| Parameter                                                 | Description                                           | Default Value                |
|-----------------------------------------------------------|-------------------------------------------------------|------------------------------|
| `ingress.enabled`                                         | Enable ingress record generation                      | `true`                       |
| `ingress.ingressClassName`                               | IngressClass to implement the Ingress                 | `""`                         |
| `ingress.pathType`                                       | Ingress path type                                     | `ImplementationSpecific`     |
| `ingress.apiVersion`                                     | Force Ingress API version                             | `""`                         |
| `ingress.controller`                                     | The ingress controller type                            | `default`                    |
| `ingress.hostname`                                       | Default host for the ingress record                   | `forms-flow-analytics.local` |
| `ingress.path`                                          | Default path for the ingress record                   | `/redash`                          |
| `ingress.servicePort`                                    | Backend service port to use                           | `5000`                       |
| `ingress.annotations`                                    | Additional annotations for the Ingress resource       | `{}`                         |
| `ingress.labels`                                         | Additional labels for the Ingress resource            | `{}`                         |
| `ingress.tls`                                           | Enable TLS configuration for the defined hostname      | `true`                       |
| `ingress.selfSigned`                                     | Create a TLS secret with self-signed certificates     | `false`                      |
| `ingress.extraHosts`                                     | Additional hostname(s) to be covered                  | `[]`                         |
| `ingress.extraPaths`                                     | Additional paths to be added to the ingress           | `[]`                         |
| `ingress.extraTls`                                       | TLS configuration for additional hostnames            | `[]`                         |
| `ingress.secrets`                                        | Add custom certificates as secrets                     | `[]`                         |
| `ingress.extraRules`                                     | Additional rules for the ingress record               | `[]`                         |
| `ingress.subFilterHost`                                     | 	Sub-filter host for analytics application; also used as ingress hostname               | `chart-example.local`                         |

## Service Parameters

| Parameter                                                  | Description                                            | Default Value      |
|------------------------------------------------------------|--------------------------------------------------------|--------------------|
| `service.type`                                            | Kubernetes service type (`ClusterIP`, `NodePort`, `LoadBalancer`) | `ClusterIP`        |
| `service.ports`                                          | Service ports (evaluated as a template)               |                     |
| `service.loadBalancerIP`                                  | LoadBalancer IP if service type is `LoadBalancer`     | `""`               |
| `service.loadBalancerSourceRanges`                        | Allowed addresses for LoadBalancer service             | `[]`               |
| `service.externalTrafficPolicy`                           | External traffic policy to preserve client source IP   | `""`               |
| `service.clusterIP`                                      | Static clusterIP or None for headless services         | `""`               |
| `service.annotations`                                     | Annotations for the service                            | `{}`               |
| `service.sessionAffinity`                                 | Session Affinity for Kubernetes service                 | `None`             |
| `service.sessionAffinityConfig`                           | Additional settings for sessionAffinity                | `{}`               |
| `service.headless.annotations`                            | Annotations for the headless service                   | `{}`               |

## Redash and Database Parameters

| Parameter                                                  | Description                                            | Default Value                      |
|------------------------------------------------------------|--------------------------------------------------------|------------------------------------|
| `redash.multiorg`                                        | Multi-organization setting for Redash                  | `"false"`                          |
| `redash.database.password`                                | Admin password for Redash database                      | `postgres`                         |
| `redash.database.url`                                     | Redash database URL                                    | `postgresql://postgres:postgres@forms-flow-analytics-postgresql:5432/postgres` |
| `database.username`                                       | Username for the database                               | `postgres`                         |
| `database.password`                                       | Password for the database                               | `postgres`                         |
| `database.servicename`                                    | Service name for the database                           | `forms-flow-ai-postgresql-ha-pgpool` |
| `database.port`                                           | Port for the database                                   | `5432`                             |
| `database.dbName`                                        | Database name for forms-flow-analytics                  | `forms-flow-analytics`             |
| `ExternalDatabase.ExistingDatabaseNameKey`                | Existing database name key                              | `""`                               |
| `ExternalDatabase.ExistingDatabaseUserNameKey`            | Existing database username key                          | `""`                               |
| `ExternalDatabase.ExistingDatabasePasswordKey`            | Existing database password key                          | `""`                               |
| `ExternalDatabase.ExistingDatabaseHostKey`                | Existing database host key                              | `""`                               |
| `ExternalDatabase.ExistingDatabasePortKey`                | Existing database port key                              | `""`                               |
| `ExternalDatabase.ExistingSecretName`                     | Name of the existing secret                             | `""`                               |
| `ExternalDatabase.ExistingConfigmapName`                  | Name of the existing config map                         | `""`                               |

