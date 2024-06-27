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
helm upgrade --install forms-flow-ai forms-flow-ai --set Domain=DOMAIN_NAME --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true --set forms-flow-auth.imagesecret=IMAGE_SECRET_KEY --set insight_api_key=INSIGHT_API_KEY
```

> Note: You need to substitute the placeholders `DOMAIN_NAME`, `IMAGE_SECRET_KEY`, and `INSIGHT_API_KEY` with your specific values. For example, in the case of Formsflow, you might use `DOMAIN_NAME=example.com`, I`MAGE_SECRET_KEY=your_image_secret_key`, and `INSIGHT_API_KEY=your_insight_api_key`.

These commands deploy Forms-flow-api on the Kubernetes cluster

> **Tip**: List all releases using `helm list`

## Parameters

| Parameter                                     | Description                                                           | Default                                                          |
|-----------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------|
| `Domain`                                      | The domain for the application                                        | `""`                                                             |
| `formsflowdb.postgresql.fullnameOverride`     | Override for the PostgreSQL fullname                                  | `forms-flow-ai-postgresql-ha-pgpool`                            |
| `formsflowdb.postgresql.enabled`              | Whether PostgreSQL is enabled                                         | `true`                                                           |
| `formsflowdb.postgresql.database`             | PostgreSQL database name                                              | `postgres`                                                        |
| `formsflowdb.service.ports.postgresql`        | Port for the PostgreSQL service                                       | `5432`                                                           |
| `forms-flow-bpm.clientid`                     | Client ID for forms-flow-bpm                                          | `forms-flow-bpm`                                                |
| `forms-flow-bpm.clientsecret`                 | Client secret for forms-flow-bpm                                      | `BPM_CLIENT_SECRET`                         |
| `forms-flow-bpm.ingress.hostname`             | Hostname for forms-flow-bpm ingress                                   | `forms-flow-bpm-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-forms.admin.email`                | Email for forms-flow-forms admin                                      | `me@defineme.com`                                                |
| `forms-flow-forms.admin.password`             | Password for forms-flow-forms admin                                   | `admin`                                                          |
| `forms-flow-forms.ingress.hostname`           | Hostname for forms-flow-forms ingress                                 | `forms-flow-forms-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-api.ingress.hostname`             | Hostname for forms-flow-api ingress                                   | `forms-flow-api-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-admin.ingress.hostname`           | Hostname for forms-flow-admin ingress                                 | `forms-flow-admin-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-documents-api.ingress.hostname`   | Hostname for forms-flow-documents-api ingress                         | `forms-flow-documents-api-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-data-analysis.ingress.hostname`   | Hostname for forms-flow-data-analysis ingress                         | `forms-flow-data-analysis-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-analytics.ingress.hostname`       | Hostname for forms-flow-analytics ingress                             | `forms-flow-analytics-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-idm.keycloak.ingress.hostname`    | Hostname for forms-flow-idm Keycloak ingress                          | `forms-flow-idm-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-idm.realm`                        | Keycloak realm for forms-flow-idm                                     | `forms-flow-ai`                                                  |
| `forms-flow-idm.context-path`                 | Keycloak context path for forms-flow-idm                              | `/auth`                                                          |
| `forms-flow-web.clientid`                     | Client ID for forms-flow-web                                          | `forms-flow-web`                                                |
| `forms-flow-web.ingress.hostname`             | Hostname for forms-flow-web ingress                                   | `forms-flow-web-{{.Release.Namespace}}.{{tpl (.Values.Domain) .}}` |
| `forms-flow-auth.imagesecret`                 | Image secret for forms-flow-auth                                      | `#DEFINE_ME`                                                     |
| `mongodb.image.tag`                               | Tag of the MongoDB image                                              | `MONGODB_IMAGE_TAG`                                            |
| `mongodb.enabled`                                 | Enable the MongoDB deployment                                         | `true`                                                           |
| `mongodb.fullnameOverride`                        | Override the full name of the MongoDB deployment                      | `forms-flow-ai-mongodb`                                          |
| `mongodb.clusterDomain`                           | Domain for the cluster                                                | `cluster.local`                                                  |
| `mongodb.architecture`                            | MongoDB deployment architecture                                       | `replicaset`                                                     |
| `mongodb.useStatefulSet`                          | Use StatefulSet for the deployment                                    | `true`                                                           |
| `mongodb.auth.databases`                          | List of databases to be created                                       | `formsflow`                                                      |
| `mongodb.auth.passwords`                          | Passwords for the databases                                           | `changeme`                                                       |
| `mongodb.auth.usernames`                          | Usernames for the databases                                           | `mongodb`                                                        |
| `mongodb.auth.enabled`                            | Enable authentication                                                 | `true`                                                           |
| `mongodb.auth.rootUser`                           | Root user for MongoDB                                                 | `root`                                                           |
| `mongodb.auth.rootPassword`                       | Password for the root user                                            | `changeme`                                                       |
| `mongodb.auth.replicaSetKey`                      | Key for the replica set                                               | `formsflow`                                                      |
| `mongodb.initdbScripts.init-mongo.js`             | Initialization script for MongoDB                                     | `""`                                                        |
| `mongodb.replicaSetName`                          | Name of the replica set                                               | `rs0`                                                            |
| `mongodb.replicaSetHostnames`                     | Use hostnames for replica set                                         | `true`                                                           |
| `mongodb.directoryPerDB`                          | Use a directory per database                                          | `false`                                                          |
| `mongodb.replicaCount`                            | Number of replicas in the replica set                                 | `3`                                                              |
| `mongodb.podSecurityContext.enabled`              | Enable pod security context                                           | `false`                                                          |
| `mongodb.podSecurityContext.fsGroup`              | File system group for the pod security context                        | `1001`                                                           |
| `mongodb.containerSecurityContext.enabled`        | Enable container security context                                     | `false`                                                          |
| `mongodb.containerSecurityContext.runAsUser`      | User ID to run the container                                          | `1001`                                                           |
| `mongodb.containerSecurityContext.runAsNonRoot`   | Run the container as a non-root user                                  | `true`                                                           |
| `mongodb.containerPorts.mongodb`                  | Port for MongoDB                                                      | `27017`                                                          |
| `mongodb.service.nameOverride`                    | Override the service name                                             | `forms-flow-ai-mongodb`                                          |
| `mongodb.service.type`                            | Type of the service                                                   | `ClusterIP`                                                      |
| `mongodb.service.portName`                        | Name of the MongoDB service port                                      | `mongodb`                                                        |
| `mongodb.service.ports.mongodb`                   | Port number for the MongoDB service                                   | `27017`                                                          |
| `mongodb.persistence.enabled`                     | Enable persistence for MongoDB                                        | `true`                                                           |
| `mongodb.persistence.accessModes`                 | Access modes for the persistent volume                                | `ReadWriteOnce`                                                  |
| `mongodb.persistence.size`                        | Size of the persistent volume                                         | `8Gi`                                                            |
| `mongodb.persistence.mountPath`                   | Mount path for the persistent volume                                  | `/bitnami/mongodb`                                               |
| `mongodb.serviceAccount.create`                   | Create a service account                                              | `true`                                                           |
| `mongodb.arbiter.enabled`                         | Enable MongoDB arbiter                                                | `false`                                                          |
| `mongodb.arbiter.podSecurityContext.enabled`      | Enable pod security context for the arbiter                           | `false`                                                          |
| `mongodb.arbiter.podSecurityContext.fsGroup`      | File system group for the arbiter pod security context                | `1001`                                                           |
| `mongodb.arbiter.containerSecurityContext.enabled`| Enable container security context for the arbiter                     | `false`                                                          |
| `mongodb.arbiter.containerSecurityContext.runAsUser`| User ID to run the arbiter container                                  | `1001`                                                           |
| `websocket_encrypt_key`                   | Encryption key for WebSocket                                          | `FormsFlow.AI`                                                   |
| `insight_api_key`                         | API key for insight integration                                       | `""`                                                             |
| `redis_host`                              | Redis host address                                                    | `""`                                                             |
| `redis_port`                              | Redis port number                                                     | `""`                                                             |
| `redis_pass_code`                         | Redis password                                                        | `""`                                                             |
| `draft_enabled`                           | Enable draft feature                                                  | `true`                                                           |
| `export_pdf_enabled`                      | Enable export to PDF feature                                          | `false`                                                          |
| `elastic_server`                          | Elasticsearch server address                                          | `forms-flow-elastic:9200`                                        |
| `redis_url`                               | URL for Redis                                                         | `redis://redis-exporter:6379/1`                                  |
| `ipaas.embedded_api_key`                  | Embedded API key for IPaaS                                            | `""`                                                             |
| `ipaas.jwt_private_key`                   | JWT private key for IPaaS                                             | `""`                                                             |
| `ipaas.embed_base_url`                    | Base URL for embedding IPaaS                                          | `""`                                                             |
| `ipaas.api_base_url`                      | API base URL for IPaaS                                                | `""`                                                             |
| `configure_logs`                          | Enable log configuration                                              | `true`                                                           |
| `postgresql-ha.enabled`                   | Enable PostgreSQL High Availability                                   | `true`                                                           |
| `postgresql-ha.postgresql.image.registry` | Registry for PostgreSQL image                                         | `docker.io`                                                      |
| `postgresql-ha.postgresql.image.repository`| Repository for PostgreSQL image                                       | `bitnami/postgresql-repmgr`                                      |
| `postgresql-ha.postgresql.image.tag`      | Tag for PostgreSQL image                                              | `POSTGRES_IMAGE_TAG`                                            |
| `postgresql-ha.postgresql.replicaCount`   | Number of PostgreSQL replicas                                         | `3`                                                              |
| `postgresql-ha.postgresql.containerPorts.postgresql`| Port for PostgreSQL                                                | `5432`                                                           |
| `postgresql-ha.postgresql.podSecurityContext.enabled` | Enable pod security context for PostgreSQL                | `false`                                                          |
| `postgresql-ha.postgresql.podSecurityContext.fsGroup` | File system group for PostgreSQL pod security context    | `1001`                                                           |
| `postgresql-ha.postgresql.containerSecurityContext.enabled` | Enable container security context for PostgreSQL        | `false`                                                          |
| `postgresql-ha.postgresql.containerSecurityContext.runAsUser` | User ID to run the PostgreSQL container                 | `1001`                                                           |
| `postgresql-ha.postgresql.containerSecurityContext.runAsNonRoot` | Run the PostgreSQL container as a non-root user        | `true`                                                           |
| `postgresql-ha.postgresql.containerSecurityContext.readOnlyRootFilesystem` | Set root filesystem as read-only for PostgreSQL container | `false`                                                          |
| `postgresql-ha.postgresql.livenessProbe.enabled`                            | Enable liveness probe for PostgreSQL                                                             | `false`                                   |
| `postgresql-ha.postgresql.readinessProbe.enabled`                           | Enable readiness probe for PostgreSQL                                                            | `false`                                   |
| `postgresql-ha.postgresql.username`                                         | Username for PostgreSQL                                                                          | `postgres`                                |
| `postgresql-ha.postgresql.password`                                         | Password for PostgreSQL                                                                          | `postgres`                                |
| `postgresql-ha.postgresql.database`                                         | Default database for PostgreSQL                                                                  | `forms-flow-ai`                           |
| `postgresql-ha.postgresql.postgresPassword`                                 | Password for the PostgreSQL superuser                                                            | `changeme`                                |
| `postgresql-ha.postgresql.repmgrUsername`                                   | Username for Repmgr                                                                              | `repmgr`                                  |
| `postgresql-ha.postgresql.repmgrPassword`                                   | Password for Repmgr                                                                              | `changeme`                                |
| `postgresql-ha.postgresql.repmgrDatabase`                                   | Database for Repmgr                                                                              | `repmgr`                                  |
| `postgresql-ha.postgresql.repmgrLogLevel`                                   | Log level for Repmgr                                                                             | `NOTICE`                                  |
| `postgresql-ha.postgresql.repmgrConnectTimeout`                             | Connection timeout for Repmgr                                                                    | `5`                                       |
| `postgresql-ha.postgresql.repmgrReconnectAttempts`                          | Reconnect attempts for Repmgr                                                                    | `2`                                       |
| `postgresql-ha.postgresql.repmgrReconnectInterval`                          | Reconnect interval for Repmgr                                                                    | `3`                                       |
| `postgresql-ha.postgresql.repmgrFenceOldPrimary`                            | Fence old primary for Repmgr                                                                     | `false`                                   |
| `postgresql-ha.postgresql.repmgrChildNodesCheckInterval`                    | Check interval for Repmgr child nodes                                                            | `5`                                       |
| `postgresql-ha.postgresql.repmgrChildNodesConnectedMinCount`                | Minimum connected child nodes count for Repmgr                                                   | `1`                                       |
| `postgresql-ha.postgresql.repmgrChildNodesDisconnectTimeout`                | Disconnect timeout for Repmgr child nodes                                                        | `30`                                      |
| `ipostgresql-ha.postgresql.nitdbScripts.init_script.sql`                    | Initialization script for PostgreSQL                                                             | `""`                                 |
| `postgresql-ha.postgresql.pgpool.image.registry`                            | Registry for Pgpool image                                                                        | `docker.io`                               |
| `postgresql-ha.postgresql.pgpool.image.repository`                          | Repository for Pgpool image                                                                      | `bitnami/pgpool`                          |
| `postgresql-ha.postgresql.pgpool.image.tag`                                 | Tag for Pgpool image                                                                             | `PGPOOL_IMAGE_TAG`                      |
| `postgresql-ha.postgresql.pgpool.image.digest`                              | Digest for Pgpool image                                                                          | `""`                                      |
| `postgresql-ha.postgresql.pgpool.image.pullPolicy`                          | Pull policy for Pgpool image                                                                     | `IfNotPresent`                            |
| `postgresql-ha.postgresql.pgpool.replicaCount`                              | Number of Pgpool replicas                                                                        | `1`                                       |
| `postgresql-ha.postgresql.pgpool.podSecurityContext.enabled`                | Enable pod security context for Pgpool                                                           | `false`                                   |
| `postgresql-ha.postgresql.pgpool.podSecurityContext.fsGroup`                | File system group for Pgpool pod security context                                                | `1001`                                    |
| `postgresql-ha.postgresql.pgpool.containerSecurityContext.enabled`          | Enable container security context for Pgpool                                                     | `false`                                   |
| `postgresql-ha.postgresql.pgpool.containerSecurityContext.runAsUser`        | User ID to run the Pgpool container                                                              | `1001`                                    |
| `postgresql-ha.postgresql.pgpool.containerSecurityContext.runAsNonRoot`     | Run the Pgpool container as a non-root user                                                      | `true`                                    |
| `postgresql-ha.postgresql.pgpool.containerSecurityContext.readOnlyRootFilesystem` | Set root filesystem as read-only for Pgpool container                                      | `false`                                   |
| `postgresql-ha.postgresql.pgpool.livenessProbe.enabled`                     | Enable liveness probe for Pgpool                                                                 | `false`                                   |
| `postgresql-ha.postgresql.pgpool.readinessProbe.enabled`                    | Enable readiness probe for Pgpool                                                                | `false`                                   |
| `postgresql-ha.postgresql.pgpool.containerPorts.postgresql`                 | Port for Pgpool                                                                                  | `5432`                                    |
| `postgresql-ha.postgresql.pgpool.adminUsername`                             | Admin username for Pgpool                                                                        | `admin`                                   |
| `postgresql-ha.postgresql.pgpool.adminPassword`                             | Admin password for Pgpool                                                                        | `changeme`                                |
| `postgresql-ha.postgresql.pgpool.service.type`                              | Service type for Pgpool                                                                          | `ClusterIP`                               |
| `postgresql-ha.postgresql.pgpool.service.ports.metrics`                     | Metrics port for Pgpool service                                                                  | `9187`                                    |
| `postgresql-ha.postgresql.persistence.enabled`                              | Enable persistence for PostgreSQL                                                                | `true`                                    |
| `postgresql-ha.postgresql.persistence.storageClass`                         | Storage class for PostgreSQL persistence                                                         | `""`                                      |
| `postgresql-ha.postgresql.persistence.mountPath`                            | Mount path for PostgreSQL persistence                                                            | `/bitnami/postgresql`                     |
| `postgresql-ha.postgresql.persistence.accessModes`                          | Access modes for the PostgreSQL persistent volume                                                | `ReadWriteOnce`                           |
| `postgresql-ha.postgresql.persistence.size`                                 | Size of the PostgreSQL persistent volume                                                         | `8Gi`                                     |
| `postgresql-ha.postgresql.service.type`                                     | Service type for PostgreSQL                                                                      | `ClusterIP`                               |
| `postgresql-ha.postgresql.service.ports.postgresql`                         | Port for PostgreSQL service                                                                      | `5432`                                    |
| `postgresql-ha.postgresql.service.portName`                                 | Port name for PostgreSQL service                                                                 | `postgresql`                              |
| `postgresql-ha.postgresql.service.nodePorts.postgresql`                     | Node port for PostgreSQL service                                                                 | `""`                                      |
| `redis-expoter.exporter.replica`                   | Number of Redis exporter replicas                                                                | `2`                                       |
| `redis-expoter.redis.configMap.redis_conf`         | Configuration for Redis                                                                          | `""`                                |

