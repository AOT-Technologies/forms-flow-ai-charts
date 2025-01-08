# Formsflow.ai 
The forms-flow-ai chart integrates components such as PostgreSQL, MongoDB, and Redis to manage version control effectively.

## Introduction

This chart bootstraps a forms-flow-ai deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the Chart

To install the chart with the release name `forms-flow-ai`:

```console
helm install forms-flow-ai forms-flow-ai
```

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


```console
helm upgrade --install forms-flow-ai forms-flow-ai --set Domain=DOMAIN_NAME --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true --set insight_api_key=INSIGHT_API_KEY
```
To deploy the enterprise version, provide Docker image credentials using the `imageCredentials.username` and `imageCredentials.password` settings.

> Note: You need to substitute the placeholders `DOMAIN_NAME`, and `INSIGHT_API_KEY` with your specific values. For example, in the case of Formsflow, you might use `DOMAIN_NAME=example.com` and `INSIGHT_API_KEY=your_insight_api_key` for Enterprise edition use, `--set imageCredentials.username=DOCKER_USERNAME` and` --set imageCredentials.password=DOCKER_PASSWORD`

**Important:** Both the Docker username `(DOCKER_USERNAME)` and password `(DOCKER_PASSWORD)` should be provided by the Formsflow.ai team. Ensure you receive these credentials before proceeding with the setup.

These commands deploy Forms-flow-ai chart on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

### Use an external database

Sometimes, you may want to have connect to an external PostgreSQL and MongoDB database rather than a database within your cluster - for example, when using a managed database service, or when running a single database server for all your applications. To do this,

For PostgreSQL database,
 set the `postgresql.enabled` parameter to `false` and specify the credentials for the external database using the `formsflowdb.postgresql.fullnameOverride` parameters. Here is an example:

```text
postgresql-ha.enabled=false
formsflowdb.postgresql.fullnameOverride=myexternalhost
```
```yaml
postgresql-ha:
  enabled: false
formsflowdb:
  postgresql:
    fullnameOverride: myexternalhost

```

For MongoDB, 
```text
mongodb.enabled=false
mongodb.service.nameOverride=mongodburl
mongodb.auth.databases=database
mongodb.auth.usernames=myuser
mongodb.auth.passwords=mypassword
```
```yaml
mongodb:
  enabled: false
  auth:
    databases: 
      - formsflow 
    passwords:
      - changeme
    usernames:
      - mongodb
  service:
    nameOverride: "mongodb_url"
```

## Parameters

| Parameter       | Description                                   | Default Value |
|-----------------|-----------------------------------------------|---------------|
| `Domain`        | Define the domain for the application.       | `#<DEFINE_ME>` |
| `formsflowdb.postgresql.fullnameOverride`| Custom name for the PostgreSQL service.                    | `forms-flow-ai-postgresql-ha-pgpool` |
| `formsflowdb.postgresql.enabled`         | Enable or disable the PostgreSQL database.                  | `true`                       |
| `formsflowdb.postgresql.database`        | Name of the database to create or use.                      | `postgres`                   |
| `formsflowdb.service.ports.postgresql`   | Port for the PostgreSQL service.                            | `5432`                       |
| `imageCredentials.registry`                | Container registry for the images.                           | `quay.io`                   |
| `imageCredentials.username`                | Username for the container registry.                         | `someone`                   |
| `imageCredentials.password`                | Password for the container registry.                         | `test`                      |
| `imageCredentials.email`                   | Email for the container registry.                            | `someone@host.com`          |
| `websocket_encrypt_key`                     | Key used for WebSocket encryption.                          | `FormsFlow.AI`              |
| `insight_api_key`                          | API key for insights.                                       | `""`                         |
| `redis_host`                               | Hostname for Redis server.                                  | `""`                         |
| `redis_port`                               | Port for Redis server.                                      | `""`                         |
| `EnableRedis`                              | Enable or disable Redis support.                            | `false`                      |
| `EnableChatBot`                            | Enable or disable chatbot feature.                          | `false`                      |
| `redis_pass_code`                          | Password for Redis.                                         | `""`                         |
| `draft_enabled`                            | Enable or disable draft feature.                            | `true`                       |
| `export_pdf_enabled`                       | Enable or disable PDF export feature.                       | `false`                      |
| `elastic_server`                           | Address for the Elastic server.                             | `forms-flow-elastic:9200`   |
| `redis_url`                               | URL for Redis connection.                                   | `redis://redis-exporter:6379/1` |
| `ipaas.embedded_api_key`                  | API key for embedded iPaaS.                                | `""`                         |
| `ipaas.jwt_private_key`                   | JWT private key for iPaaS.                                 | `""`                         |
| `ipaas.embed_base_url`                    | Base URL for embedded services.                             | `""`                         |
| `ipaas.api_base_url`                      | Base URL for API services.                                  | `""`                         |
| `configure_logs`                           | Enable or disable logging configuration.                    | `true`                       |

## Forms Flow Component Parameters

| Parameter                                 | Description                                                 | Default Value                |
|-------------------------------------------|-------------------------------------------------------------|------------------------------|
| `formsflowdb.postgresql.fullnameOverride`| Custom name for the PostgreSQL service.                    | `forms-flow-ai-postgresql-ha-pgpool` |
| `formsflowdb.postgresql.enabled`         | Enable or disable the PostgreSQL database.                  | `true`                       |
| `formsflowdb.postgresql.database`        | Name of the database to create or use.                      | `postgres`                   |
| `formsflowdb.service.ports.postgresql`   | Port for the PostgreSQL service.                            | `5432`                       |
| `forms-flow-forms.admin.email`            | Admin email for Forms Flow Forms.                           | `me@defineme.com`           |
| `forms-flow-forms.admin.password`         | Admin password for Forms Flow Forms.                        | `admin`                     |
| `forms-flow-idm.keycloak.EnableKeycloakClientAuth` | Enable or disable Keycloak client authentication.         | `false`                     |
| `forms-flow-idm.keycloak.ingress.hostname`         | Hostname for the Forms Flow IDM ingress.                    | `forms-flow-idm-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-idm.realm`                     | Keycloak realm for the application.                         | `forms-flow-ai`             |
| `forms-flow-idm.context-path`             | Context path for Keycloak authentication.                   | `/auth`                     |
| `forms-flow-web.EnableMultitenant`        | Enable or disable multitenancy for the Forms Flow Web application. | `false`                   |
| `forms-flow-web.clientid`                 | Client ID for the Forms Flow Web application.               | `forms-flow-web`            |
| `forms-flow-web.ingress.hostname`         | Hostname for the Forms Flow Web ingress.                    | `forms-flow-web-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |

## Database Parameters
### MongoDB 

| Parameter                                        | Description                                                  | Default Value                    |
|--------------------------------------------------|--------------------------------------------------------------|----------------------------------|
| `mongodb.image.tag`                              | Docker image tag for MongoDB.                               | `7.0.12-debian-12-r5`           |
| `mongodb.image.pullSecrets`                      | Secrets for pulling the Docker image.                       | `forms-flow-auth`                |
| `mongodb.enabled`                                | Enable or disable MongoDB deployment.                       | `true`                           |
| `mongodb.fullnameOverride`                       | Custom name for the MongoDB service.                        | `forms-flow-ai-mongodb`         |
| `mongodb.clusterDomain`                          | Domain for the MongoDB cluster.                             | `cluster.local`                  |
| `mongodb.architecture`                           | Architecture type (replica set or standalone).              | `replicaset`                     |
| `mongodb.useStatefulSet`                         | Use StatefulSet for MongoDB pods.                           | `true`                           |
| `mongodb.auth.enabled`                           | Enable or disable authentication for MongoDB.               | `true`                           |
| `mongodb.auth.databases`                         | List of databases to create.                                | `formsflow`                     |
| `mongodb.auth.passwords`                         | List of passwords for the databases.                        | `changeme`                       |
| `mongodb.auth.usernames`                         | List of usernames for the databases.                        | `mongodb`                       |
| `mongodb.replicaSetName`                         | Name of the replica set.                                    | `rs0`                            |
| `mongodb.replicaSetHostnames`                   | Enable replica set hostnames.                               | `true`                           |
| `mongodb.directoryPerDB`                         | Use separate directories for each database.                 | `false`                          |
| `mongodb.replicaCount`                           | Number of replicas to create.                               | `3`                              |
| `mongodb.podSecurityContext.enabled`             | Enable pod security context for MongoDB pods.               | `false`                          |
| `mongodb.podSecurityContext.fsGroup`             | File system group ID for the MongoDB pod.                  | `1001`                           |
| `mongodb.containerSecurityContext.enabled`       | Enable container security context.                          | `false`                          |
| `mongodb.containerSecurityContext.runAsUser`     | User ID to run MongoDB container as.                        | `1001`                           |
| `mongodb.containerSecurityContext.runAsNonRoot`  | Ensure MongoDB container runs as a non-root user.          | `true`                           |
| `mongodb.containerPorts.mongodb`                 | Port for MongoDB service.                                   | `27017`                          |
| `mongodb.service.nameOverride`                   | Custom name for the MongoDB service.                        | `forms-flow-ai-mongodb`         |
| `mongodb.service.type`                           | Type of Kubernetes service (ClusterIP, NodePort, LoadBalancer). | `ClusterIP`                     |
| `mongodb.service.portName`                       | Name of the port for the MongoDB service.                  | `mongodb`                       |
| `mongodb.service.ports.mongodb`                  | Port number for MongoDB service.                            | `27017`                          |
| `mongodb.persistence.enabled`                    | Enable or disable persistence for MongoDB.                 | `true`                           |
| `mongodb.persistence.accessModes`                | Access modes for the persistent volume.                     | `ReadWriteOnce`                 |
| `mongodb.persistence.size`                       | Size of the persistent volume.                              | `8Gi`                            |
| `mongodb.persistence.mountPath`                  | Mount path for the persistent volume.                       | `/bitnami/mongodb`              |
| `mongodb.serviceAccount.create`                  | Create a service account for MongoDB.                       | `true`                           |
| `mongodb.arbiter.enabled`                        | Enable or disable arbiter for the replica set.              | `false`                          |
| `mongodb.arbiter.podSecurityContext.enabled`     | Enable pod security context for arbiter pod.                | `false`                          |
| `mongodb.arbiter.podSecurityContext.fsGroup`     | File system group ID for the arbiter pod.                  | `1001`                           |
| `mongodb.arbiter.containerSecurityContext.enabled`| Enable container security context for arbiter.             | `false`                          |
| `mongodb.arbiter.containerSecurityContext.runAsUser` | User ID for arbiter container.                             | `1001`                           |

### PostgreSQL 

| Parameter                                       | Description                                                  | Default Value                  |
|-------------------------------------------------|--------------------------------------------------------------|--------------------------------|
| `postgresql-ha.enabled`                         | Enable or disable PostgreSQL High Availability deployment.  | `true`                         |
| `postgresql.image.registry`                     | Docker image registry for PostgreSQL.                       | `docker.io`                   |
| `postgresql.image.repository`                   | Docker image repository for PostgreSQL.                     | `bitnami/postgresql-repmgr`   |
| `postgresql.image.tag`                          | Docker image tag for PostgreSQL.                            | `16.3.0-debian-12-r20`        |
| `postgresql.image.pullPolicy`                   | Image pull policy.                                          | `IfNotPresent`                 |
| `postgresql.image.pullSecrets`                  | Secrets for pulling the Docker image.                       | `forms-flow-auth`             |
| `postgresql.replicaCount`                       | Number of PostgreSQL replicas.                              | `3`                            |
| `postgresql.containerPorts.postgresql`          | Port for PostgreSQL service.                                | `5432`                         |
| `postgresql.podSecurityContext.enabled`         | Enable pod security context for PostgreSQL pods.            | `false`                        |
| `postgresql.podSecurityContext.fsGroup`         | File system group ID for the PostgreSQL pod.                | `1001`                         |
| `postgresql.containerSecurityContext.enabled`   | Enable container security context.                          | `false`                        |
| `postgresql.containerSecurityContext.runAsUser` | User ID to run PostgreSQL container as.                     | `1001`                         |
| `postgresql.containerSecurityContext.runAsNonRoot` | Ensure PostgreSQL container runs as a non-root user.     | `true`                         |
| `postgresql.livenessProbe.enabled`               | Enable liveness probe for PostgreSQL.                       | `false`                        |
| `postgresql.livenessProbe.initialDelaySeconds`  | Initial delay for liveness probe.                           | `30`                           |
| `postgresql.livenessProbe.periodSeconds`        | Period for liveness probe checks.                           | `10`                           |
| `postgresql.username`                           | Username for PostgreSQL database.                           | `postgres`                     |
| `postgresql.password`                           | Password for PostgreSQL user.                               | `postgres`                     |
| `postgresql.database`                           | Default database to create.                                 | `forms-flow-ai`               |
| `postgresql.postgresPassword`                   | PostgreSQL password.                                        | `changeme`                     |
| `postgresql.repmgrUsername`                     | Username for repmgr database.                               | `repmgr`                       |
| `postgresql.repmgrPassword`                     | Password for repmgr user.                                   | `changeme`                     |
| `postgresql.repmgrDatabase`                     | Database used by repmgr.                                   | `repmgr`                       |
| `postgresql.initdbScripts.init_script.sql`     | SQL script for initializing databases.                      | See below                     |

### Pgpool 

| Parameter                                        | Description                                                  | Default Value                  |
|--------------------------------------------------|--------------------------------------------------------------|--------------------------------|
| `pgpool.image.registry`                          | Docker image registry for Pgpool.                           | `docker.io`                   |
| `pgpool.image.repository`                        | Docker image repository for Pgpool.                         | `bitnami/pgpool`              |
| `pgpool.image.tag`                              | Docker image tag for Pgpool.                                | `4.5.2-debian-12-r5`          |
| `pgpool.image.pullPolicy`                       | Image pull policy.                                          | `IfNotPresent`                 |
| `pgpool.image.pullSecrets`                      | Secrets for pulling the Docker image.                       | `forms-flow-auth`             |
| `pgpool.replicaCount`                           | Number of Pgpool replicas.                                  | `1`                            |
| `pgpool.containerPorts.postgresql`              | Port for Pgpool service.                                    | `5432`                         |
| `pgpool.podSecurityContext.enabled`             | Enable pod security context for Pgpool pods.                | `false`                        |
| `pgpool.podSecurityContext.fsGroup`             | File system group ID for the Pgpool pod.                    | `1001`                         |
| `pgpool.containerSecurityContext.enabled`       | Enable container security context.                          | `false`                        |
| `pgpool.containerSecurityContext.runAsUser`     | User ID to run Pgpool container as.                         | `1001`                         |
| `pgpool.containerSecurityContext.runAsNonRoot`  | Ensure Pgpool container runs as a non-root user.           | `true`                         |
| `pgpool.livenessProbe.enabled`                   | Enable liveness probe for Pgpool.                           | `false`                        |
| `pgpool.livenessProbe.initialDelaySeconds`      | Initial delay for liveness probe.                           | `30`                           |
| `pgpool.livenessProbe.periodSeconds`            | Period for liveness probe checks.                           | `10`                           |
| `pgpool.adminUsername`                           | Username for Pgpool admin.                                  | `admin`                        |
| `pgpool.adminPassword`                           | Password for Pgpool admin.                                  | `changeme`                    |
| `pgpool.persistence.enabled`                   | Enable or disable persistence for Pgpool.                   | `true`                         |
| `pgpool.persistence.storageClass`              | Storage class for persistent volume claims.                 | `""`                           |
| `pgpool.persistence.mountPath`                 | Mount path for persistent storage.                           | `/bitnami/postgresql`         |
| `pgpool.persistence.accessModes`               | Access modes for persistent storage.                         | `ReadWriteOnce`               |
| `pgpool.persistence.size`                       | Size of the persistent volume.                               | `8Gi`                          |
| `pgpool.service.type`                          | Service type for Pgpool.                                    | `ClusterIP`                   |
| `pgpool.service.ports.postgresql`             | Port for Pgpool service.                                    | `5432`                         |
| `pgpool.service.portName`                      | Port name for the Pgpool service.                           | `postgresql`                  |
| `pgpool.service.nodePorts.postgresql`         | Node port for Pgpool service.                               | `""`                           |

### Redis 

| Parameter                                        | Description                                                  | Default Value                  |
|--------------------------------------------------|--------------------------------------------------------------|--------------------------------|
| `redisExporter.replicaCounts`                    | Number of Redis Exporter replicas.                           | `1`                            |
| `redisExporter.service.type`                     | Service type for Redis Exporter.                             | `ClusterIP`                   |
| `redisExporter.service.portNames.redis`          | Port name for Redis client.                                  | `client`                       |
| `redisExporter.service.portNames.redis2`         | Port name for Redis gossip.                                  | `gossip`                       |
| `redisExporter.service.ports.redis`              | Port for Redis client.                                       | `6379`                         |
| `redisExporter.service.ports.redis2`             | Port for Redis gossip.                                       | `16379`                       |
| `redisExporter.service.externalTrafficPolicy`     | External traffic policy for the service.                     | `Cluster`                     |
| `redisExporter.service.sessionAffinity`           | Session affinity for the service.                            | `None`                        |
| `redisExporter.service.annotations`               | Annotations for the service.                                 | `{}`                          |
| `redisExporter.podLabels`                         | Labels for Redis Exporter pods.                              | `{}`                          |
| `redisExporter.extraEnvVarsCM`                   | Additional environment variable config map.                  | `{}`                          |
| `redisExporter.extraEnvVars`                      | Additional environment variables.                             | `{}`                          |
| `redisExporter.extraEnvVarsSecret`               | Additional secret environment variables.                     | `{}`                          |
| `redisExporter.redis.configMap.redis_conf`      | Redis configuration settings.                                | See below for detailed config  |
| `redisExporter.image.registry`                   | Docker image registry for Redis.                             | `docker.io`                   |
| `redisExporter.image.repository`                 | Docker image repository for Redis.                           | `redis`                       |
| `redisExporter.image.tag`                        | Docker image tag for Redis.                                  | `7.2.4-alpine`                |
| `redisExporter.image.pullPolicy`                 | Image pull policy.                                          | `IfNotPresent`                 |
| `redisExporter.image.pullSecrets`                | Secrets for pulling the Docker image.                       | `[]`                          |
| `redisExporter.livenessProbe.enabled`            | Enable liveness probe for Redis Exporter.                   | `true`                         |
| `redisExporter.livenessProbe.initialDelaySeconds`| Initial delay for liveness probe.                           | `30`                           |
| `redisExporter.livenessProbe.periodSeconds`      | Period for liveness probe checks.                           | `5`                            |
| `redisExporter.readinessProbe.enabled`           | Enable readiness probe for Redis Exporter.                  | `true`                         |
| `redisExporter.readinessProbe.initialDelaySeconds`| Initial delay for readiness probe.                          | `10`                           |
| `redisExporter.readinessProbe.periodSeconds`     | Period for readiness probe checks.                          | `3`                            |
| `redisExporter.containerPorts.client`            | Client port for Redis Exporter.                             | `6379`                         |
| `redisExporter.containerPorts.gossip`            | Gossip port for Redis Exporter.                             | `16379`                       |
| `redisExporter.resources.limits.cpu`             | CPU limit for Redis Exporter.                               | `60m`                          |
| `redisExporter.resources.limits.memory`          | Memory limit for Redis Exporter.                            | `512Mi`                       |
| `redisExporter.resources.requests.cpu`           | CPU request for Redis Exporter.                             | `50m`                          |
| `redisExporter.resources.requests.memory`        | Memory request for Redis Exporter.                          | `256Mi`                       |
| `redisExporter.persistence.enabled`              | Enable or disable persistence for Redis Exporter.           | `true`                         |
| `redisExporter.persistence.storageClass`         | Storage class for persistent volume claims.                 | `""`                           |
| `redisExporter.persistence.mountPath`            | Mount path for persistent storage.                           | `""`                           |
| `redisExporter.persistence.accessModes`          | Access modes for persistent storage.                         | `ReadWriteOnce`               |
| `redisExporter.persistence.size`                 | Size of the persistent volume.                               | `2Gi`                          |
