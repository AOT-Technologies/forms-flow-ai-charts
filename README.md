# FormsFlow.ai

[FormsFlow.ai](https://formsflow.ai/) formsflow.ai is a completely free and open source framework that integrates intelligent forms, decision making workflows, and powerful analytics.

This chart installs the forms-flow microservices needed for deploying formsflow.ai.

## Get Repo Info

```console
helm repo add formsflow https://aot-technologies.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

##E.g Install Component Chart
```console
# Helm 3
$ helm install [RELEASE_NAME] formsflow/forms-flow-ai [flags]
```

## Pre-requisites
Builds and deploys should* be installed into seperate namespaces.
Releases should be installed into ${PROJECT_NAMESPACE}. 
Builds should be installed in ${PROJECT_NAMEPACE}-tools namespace.

E.g
 
	formsflow-demo 				- deploys

	formsflow-demo-tools	-	builds 

*This constraint can be adjusted by setting image_url in formsflow deploys 

## Install Formsflow.ai builds
```console
# Helm 3
helm install forms-flow-analytics.build formsflow/forms-flow-analytics.build --set cpu_limit=2 --set cpu_request=1 --set memory_limit=8Gi --set memory_request=5Gi --namespace formsflow-demo-tools

helm install forms-flow-bpm.build formsflow/forms-flow-bpm.build --set cpu_limit=2 --set cpu_request=1 --set memory_limit=8Gi --set memory_request=5Gi --namespace formsflow-demo-tools

helm install forms-flow-forms.build formsflow/forms-flow-forms.build --set cpu_limit=2 --set cpu_request=1 --set memory_limit=8Gi --set memory_request=5Gi --namespace formsflow-demo-tools

helm install forms-flow-web.build formsflow/forms-flow-web.build --set cpu_limit=2 --set cpu_request=1 --set memory_limit=8Gi --set memory_request=5Gi --namespace formsflow-demo-tools

helm install forms-flow-webapi.build formsflow/forms-flow-webapi.build --set cpu_limit=2 --set cpu_request=1 --set memory_limit=8Gi --set memory_request=5Gi --namespace formsflow-demo-tools
```
## Install Formsflow.ai
```console
# Helm 3
helm install formio-mongodb formsflow/formio-mongodb --set volume_capacity=2Gi --set sc_mongo=nfs-client --namespace formsflow-demo

#OPTIONAL
helm install forms-flow-idm formsflow/forms-flow-idm --set keycloak.podSecurityContext.fsGroup=1000800000 --set keycloak.securityContext.runAsUser=1000800000 --set keycloak.pgchecker.securityContext.runAsUser=1000800000 --set keycloak.postgresql.securityContext.runAsUser=1000800000 --set cpu_limit=1 --namespace formsflow-demo

helm install forms-flow-ai formsflow/forms-flow-ai --set camunda_bpm_url="bpm-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set keycloak_url="idm-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set web_api_url="webapi-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --namespace formsflow-demo

helm install forms-flow-forms formsflow/forms-flow-forms --set forms_url="formio-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set "image_url=image-registry.openshift-image-registry.svc:5000/\{\{ .Release.Namespace \}\}-tools/\{\{ .Chart.Name \}\}.build" --set cpu_limit=200m --set cpu_request=100m --set memory_limit=512M --set memory_request=256M --namespace formsflow-demo 

helm install forms-flow-webapi formsflow/forms-flow-webapi --set forms-flow-webapi-postgresql.persistent_volume_class=nfs-client --set web_api_url="webapi-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set cpu_limit=100m --set cpu_request=50m --set memory_limit=200Mi --set memory_request=100Mi --namespace formsflow-demo

helm install forms-flow-analytics formsflow/forms-flow-analytics --set redash_host="analytics-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set analytics_url="analytics-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set cpu_limit=800m --set cpu_request=600m --set memory_limit=1.2Gi --set memory_request=1Gi --set imagestream_name=forms-flow-analytics.build-redash --namespace formsflow-demo

helm install forms-flow-bpm formsflow/forms-flow-bpm --set camunda_url="bpm-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set forms_url="https://forms-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set keycloak_url="https://idm-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set web_api_url="https://webapi-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set camunda-postgresql.persistent_volume_class=nfs-client --set cpu_limit=800m --set cpu_request=600m --set memory_limit=1.5Gi --set memory_request=1Gi --namespace formsflow-demo

helm install forms-flow-web formsflow/forms-flow-web --set camunda_url="https://bpm-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set forms_url="https://formio-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set keycloak_url="https://idm-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set web_api_url="https://webapi-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set web_url="web-\{\{ .Release.Namespace \}\}.apps.devops.aot-technologies.com" --set cpu_limit=301m --set cpu_request=250m --set memory_limit=512Mi --set memory_request=256Mi --namespace formsflow-demo
```
_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Chart

```console
# Helm 3
$ helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrade Chart

```console
# Helm 3
$ helm upgrade [RELEASE_NAME] forms-flow-ai/forms-flow-ai [flags]
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

Visit the chart's [CHANGELOG](./CHANGELOG.md) to view the chart's release history.
For migration between major version check [migration guide](#migration-guide).

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
# Helm 3
$ helm show values forms-flow-ai/forms-flow-ai
```

#For a summary of all configurable options, see [VALUES_SUMMARY.md](./VALUES_SUMMARY.md)
