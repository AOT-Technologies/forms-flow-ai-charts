# Formsflow Admin API

Formsflow Admin API is a Python REST API to provision tenants in a multi tenanted environment.


## Introduction

This chart bootstraps a forms-flow-admin deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-admin`:

```console
helm install forms-flow-admin forms-flow-admin 
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install forms-flow-admin forms-flow-admin  --set ingress.ingressClassName=INGRESS_CLASS --set ingress.hostname=HOSTNAME
```

> Note: You need to substitute the placeholders `INGRESS_CLASS` and `HOSTNAME` with a reference to your Helm chart registry and repository. For example, in the case of Formsflow, you need to use`INGRESS_CLASS=nginx`

These commands deploy Forms-flow-admin on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Resource requests and limits

Forms-flow-admin charts allow setting resource requests and limits for all containers inside the chart deployment. These are inside the `resources` value (check parameter table). Setting requests is essential for production workloads and these should be adapted to your specific use case.

```yaml
resources:
  limits:
    cpu: 500m
    memory: 1Gi
  requests:
    cpu: 250m
    memory: 512Mi
```

### Change Forms-flow-admin version

To modify the Forms-flow-admin version used in this chart you can specify a [valid image tag](https://hub.docker.com/repository/docker/formsflow/forms-flow-ai-admin) using the `image.tag` parameter. For example, `image.tag=X.Y.Z`. This approach is also applicable to other images like exporters.

```yaml
image:
  registry: docker.io
  repository: formsflow/forms-flow-ai-admin
  tag: X.Y.Z 
```

## Persistence

The `formsflow-admin` image stores the application logs at the `/opt/app-root/logs` path of the container.


## Sidecar Configuration

To add a sidecar to your `Forms-flow-admin` deployment, you can use the following configuration. In this case, the sidecar container is an Nginx container used for configuration management.

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
The `Forms-flow-admin` can now be accessed at the `/admin` route. Ensure that all configurations and requests reference this updated path.

For example:

```
https://<HOSTNAME>/admin
```


## Parameters

| Parameter                          | Description                                         | Default Value                      |
|------------------------------------|-----------------------------------------------------|------------------------------------|
| `replicaCount`                     | Number of replicas                                  | `1`                                |
| `image.registry`                   | Docker registry for the image                       | `docker.io`                        |
| `image.repository`                 | Repository for the image                            | `formsflow/forms-flow-ai-admin`   |
| `image.pullPolicy`                 | Image pull policy                                   | `IfNotPresent`                     |
| `image.tag`                        | Image tag                                          | `v7.0.0-alpha`                    |
| `image.pullSecrets`                | Array of image pull secrets                         | `forms-flow-ai-auth`               |
| `nameOverride`                     | String to partially override common.names.fullname | `""`                               |
| `fullnameOverride`                 | String to fully override common.names.fullname     | `""`                               |
| `commonLabels`                     | Labels to add to all deployed objects               | `{}`                               |
| `commonAnnotations`                | Annotations to add to all deployed objects          | `{}`                               |
| `nodeSelector`                     | Node labels for pod assignment                      | `{}`                               |
| `tolerations`                      | Tolerations for pod assignment                      | `[]`                               |
| `affinity`                         | Affinity for pod assignment                         | `{}`                               |
| `priorityClassName`                | Pod priority                                        | `""`                               |
| `schedulerName`                    | Name of the k8s scheduler                          | `""`                               |
| `terminationGracePeriodSeconds`    | Time given to the pod to terminate gracefully      | `""`                               |
| `topologySpreadConstraints`        | Topology Spread Constraints for pod assignment      | `[]`                               |
| `diagnosticMode.enabled`           | Enable diagnostic mode                              | `false`                            |
| `diagnosticMode.command`           | Command to override all containers in deployment    | `["sleep"]`                        |
| `diagnosticMode.args`              | Args to override all containers in deployment       | `["infinity"]`                     |
| `hostAliases`                      | Deployment host aliases                             | `[]`                               |
| `serviceAccount.create`            | Whether a service account should be created        | `true`                             |
| `serviceAccount.annotations`        | Annotations for the service account                | `{}`                               |
| `serviceAccount.name`              | Name of the service account                         | `""`                               |
| `serviceAccount.automountServiceAccountToken` | Mount Service Account token in pod         | `false`                            |
| `podAnnotations`                   | Pod annotations                                     | `{}`                               |
| `podLabels`                        | Extra labels for pods                               | `{}`                               |
| `podAffinityPreset`                | Pod affinity preset                                 | `""`                               |
| `podAntiAffinityPreset`            | Pod anti-affinity preset                            | `soft`                             |
| `nodeAffinityPreset.type`          | Node affinity preset type                           | `""`                               |
| `nodeAffinityPreset.key`           | Node label key to match                            | `""`                               |
| `nodeAffinityPreset.values`        | Node label values to match                         | `[]`                               |
| `podSecurityContext.enabled`       | Enable security context for pods                   | `true`                             |
| `podSecurityContext.fsGroupChangePolicy` | Set filesystem group change policy            | `Always`                           |
| `podSecurityContext.fsGroup`       | Pod's Security Context fsGroup                      | `1001`                             |
| `containerSecurityContext.enabled`  | Enable containers' Security Context                | `true`                             |
| `containerSecurityContext.runAsUser` | Containers' Security Context runAsUser           | `1001`                             |
| `containerSecurityContext.runAsGroup` | Containers' Security Context runAsGroup         | `1001`                             |
| `containerSecurityContext.runAsNonRoot` | Container's Security Context runAsNonRoot     | `false`                            |
| `command`                          | Override default container command                  | `[]`                               |
| `args`                             | Override default container args                     | `[]`                               |
| `lifecycleHooks`                   | Lifecycle hooks for containers                      | `{}`                               |
| `extraEnvVars`                     | Extra environment variables for containers          | `[]`                               |
| `extraEnvVarsCM`                  | Name of existing ConfigMap containing extra env vars| `""`                               |
| `extraVolumes`                     | Array to add extra volumes                          | `{}`                               |
| `extraVolumeMounts`                | Array to add extra mounts                           | `{}`                               |
| `existingSecret`                   | Existing secret containing database credentials     | `""`                               |
| `updateStrategy.type`              | Update strategy for installation                    | `RollingUpdate`                    |
| `rbac.create`                      | Whether to create and use RBAC resources            | `false`                            |
| `pdb.create`                       | If true, create a pod disruption budget             | `true`                             |
| `autoscaling.enabled`              | Enable autoscaling for forms-flow-admin             | `false`                            |
| `formsflow.configmap`                  | Name of the formsflow.ai ConfigMap                      | `forms-flow-ai`                |
| `formsflow.secret`                     | Name of the formsflow.ai secret                         | `forms-flow-ai`                |
| `formsflow.analytics`                  | Name of the analytics component                          | `forms-flow-analytics`          |

## Ingress Parameters

| Parameter                          | Description                                         | Default Value                      |
|------------------------------------|-----------------------------------------------------|------------------------------------|
| `ingress.enabled`                  | Enable ingress record generation                    | `true`                             |
| `ingress.ingressClassName`         | Ingress class used to implement Ingress            | `""`                               |
| `ingress.pathType`                 | Ingress path type                                   | `ImplementationSpecific`           |
| `ingress.controller`               | Ingress controller type                              | `default`                          |
| `ingress.hostname`                 | Default host for the ingress record                 | `forms-flow-admin.local`          |
| `ingress.path`                     | Default path for the ingress record                 | `"/admin"`                              |
| `ingress.servicePort`              | Backend service port to use                         | `5000`                             |
| `ingress.tls`                      | Enable TLS configuration                            | `true`                             |
| `ingress.selfSigned`               | Create a TLS secret using self-signed certificates  | `false`                            |

## Service Parameters

| Parameter                          | Description                                         | Default Value                      |
|------------------------------------|-----------------------------------------------------|------------------------------------|
| `service.type`                     | Kubernetes service type (`ClusterIP`, `NodePort`, or `LoadBalancer`) | `ClusterIP`                      |
| `service.ports`                    | Forms-flow-admin service ports                      | `[{name: http, port: 5000, protocol: TCP}]` |

## Resource Parameters

| Parameter                          | Description                                         | Default Value                      |
|------------------------------------|-----------------------------------------------------|------------------------------------|
| `resourcesPreset`                  | Set container resources according to preset         | `small`                            |
| `resources.limits.cpu`             | CPU limit                                          | `500m`                             |
| `resources.limits.memory`          | Memory limit                                       | `1Gi`                              |
| `resources.requests.cpu`           | CPU request                                        | `250m`                             |
| `resources.requests.memory`        | Memory request                                      | `512Mi`                            |

## Database Parameters

| Parameter                          | Description                                         | Default Value                      |
|------------------------------------|-----------------------------------------------------|------------------------------------|
| `postgresql.databasename`          | Database name for PostgreSQL                        | `forms-flow-admin`                |
| `postgresql.username`              | PostgreSQL username                                  | `postgres`                         |
| `postgresql.password`              | PostgreSQL password                                  | `postgres`                         |
| `postgresql.host`                  | PostgreSQL host                                     | `forms-flow-ai-postgresql-ha-pgpool` |
| `ExternalDatabase.ExistingDatabaseNameKey`  | Key for the existing database name                      | `""`                            |
| `ExternalDatabase.ExistingDatabaseUserNameKey` | Key for the existing database username                  | `""`                            |
| `ExternalDatabase.ExistingDatabasePasswordKey` | Key for the existing database password                  | `""`                            |
| `ExternalDatabase.ExistingDatabaseHostKey`     | Key for the existing database host                      | `""`                            |
| `ExternalDatabase.ExistingDatabasePortKey`     | Key for the existing database port                      | `""`                            |
| `ExternalDatabase.ExistingSecretName`           | Name of the existing secret                             | `""`                            |
