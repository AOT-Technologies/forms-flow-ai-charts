# FormsFlow.ai

[FormsFlow.ai](https://formsflow.ai/) formsflow.ai is a completely free and open source framework that integrates intelligent forms, decision making workflows, and powerful analytics.

This chart installs the forms-flow microservices needed for deploying formsflow.ai.

## Get Repo Info

```console
helm repo add formsflow https://aot-technologies.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

```console
# Helm 3
$ helm install [RELEASE_NAME] forms-flow-ai/forms-flow-ai [flags]
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
