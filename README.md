# [FormsFlow.ai](https://formsflow.ai/)

[FormsFlow.ai](https://formsflow.ai/) formsflow.ai is a completely free and open source framework that integrates intelligent forms, decision making workflows, and powerful analytics.

This chart installs the forms-flow microservices needed for deploying formsflow.ai.

## Get Repo Info
Clone [forms-flow-ai-charts](https://github.com/AOT-Technologies/forms-flow-ai-charts) repository from the following command.
```console
$ helm repo add formsflow https://aot-technologies.github.io/forms-flow-ai-charts
$ helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._


> **Note:**  
> For installing formsflow in EKS cluster, you might need
>
> **Prerequisites**
> 1. [aws-ebs-csi driver](https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/install.md) 
>2. ingress-nginx
>- To install  Ingress-Nginx Controller, use this command,
>```console
>$ helm upgrade --install ingress-nginx ingress-nginx \
>  --repo https://kubernetes.github.io/ingress-nginx \
>  --namespace ingress-nginx --namespace $NAMESPACE
>```
>

## E.g Install Component Chart
```console
$ helm install [RELEASE_NAME] formsflow/[COMPONENT_NAME] [flags]
```

## Install [Formsflow.ai](https://formsflow.ai/)
### 1. forms-flow-ai
```console
$ helm install forms-flow-ai formsflow/forms-flow-ai -set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true --set Domain=$DOMAIN_NAME --set forms-flow-idm.keycloak.ingress.hostname=forms-flow-idm-$NAMESPACE.$DOMAIN_NAME --namespace $NAMESPACE
```
### 2. forms-flow-idm
```console
$ helm install forms-flow-idm formsflow/forms-flow-idm --set Domain=$DOMAIN_NAME --set keycloak.ingress.hostname=forms-flow-idm-$NAMESPACE.$DOMAIN_NAME --namespace $NAMESPACE 
```
### 3. forms-flow-analytics
```console
$ helm install forms-flow-analytics formsflow/forms-flow-analytics --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```
### 4. forms-flow-bpm
```console
$ helm install forms-flow-bpm formsflow/forms-flow-bpm --set Domain=$DOMAIN_NAME --set camunda.websocket.securityOrigin=https://*.$DOMAIN_NAME --namespace $NAMESPACE
```
### 5. forms-flow-forms
```console
$ helm install forms-flow-forms formsflow/forms-flow-forms --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```
### 6. forms-flow-api
```console
$ helm install forms-flow-api formsflow/forms-flow-api --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```
### 7. forms-flow-documents-api
```console
$ helm install forms-flow-documents-api formsflow/forms-flow-documents-api --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```
### 8. forms-flow-web
```console
$ helm install forms-flow-web formsflow/forms-flow-web --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```
### 9. forms-flow-data-analysis
```console
$ helm install forms-flow-data-analysis formsflow/forms-flow-data-analysis --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```
### 10. forms-flow-admin
```console
$ helm install forms-flow-admin formsflow/forms-flow-admin --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
```


## Uninstall Chart


 helm uninstall [RELEASE_NAME] -n $NAMESPACE
```console
$ helm uninstall forms-flow-admin -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-ai -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-api -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-analytics -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-bpm -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-data-analysis -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-forms -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-idm -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-web -n $NAMESPACE
```

```console
$ helm uninstall forms-flow-documents-api -n $NAMESPACE
```

This removes all the Kubernetes components associated with the chart and deletes the release.

Note: Kubernetes Persistent Volumes Claims are not deleted using the helm uninstall command.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrade Chart

```console
$ helm upgrade [RELEASE_NAME] forms-flow-ai/forms-flow-ai [flags]
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

Visit the chart's [CHANGELOG](./CHANGELOG.md) to view the chart's release history.
For migration between major version check [migration guide](#migration-guide).

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing).
To see all configurable options with detailed comments, visit the chart's [values.yaml](./values.yaml), or run these configuration commands:

```console
$ helm show values forms-flow-ai/forms-flow-ai
```

For a summary of all configurable options, see [VALUES_SUMMARY.md](./VALUES_SUMMARY.md)
