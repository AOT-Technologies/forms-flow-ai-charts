# [FormsFlow.ai](https://formsflow.ai/)

[FormsFlow.ai](https://formsflow.ai/) formsflow.ai is a completely free and open source framework that integrates intelligent forms, decision making workflows, and powerful analytics.

This chart installs the forms-flow microservices needed for deploying formsflow.ai.


## Prerequisites

 1. **kubectl** - A command line tool for working with Kubernetes clusters. For more information, [see Installing or updating kubectl.](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
 2. **aws-cli** (optional) - A command line tool for working with AWS services, including Amazon EKS. For more information, see [Installing, updating, and uninstalling the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) in the AWS Command Line Interface User Guide. After installing the AWS CLI, we recommend that you also configure it. For more information, see [Quick configuration with aws configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-configure-quickstart-config) in the AWS Command Line Interface User Guide.
 3. **helm** - Helps to manage Kubernetes applications, [For more information see Installing and updating the Helm.](https://helm.sh/docs/intro/install/)

## Get Repo Info
Clone [forms-flow-ai-charts](https://github.com/AOT-Technologies/forms-flow-ai-charts) repository from the following command.
```console
$ helm repo add formsflow https://aot-technologies.github.io/forms-flow-ai-charts
$ helm repo update
$ cd forms-flow-ai-charts/charts
```

### Install Ingress Controller in Kubernetes using Helm

Add the nginx ingress helm repo in Kubernetes kops cluster, follow this Nginx ingress official page to install [latest nginx ingress helm chart.](https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-helm/)

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

Update the helm repo

```
helm repo update
```
Install Nginx Ingress Controller using Helm

```
helm install -n <namespace> ingress-nginx-<namespace> ingress-nginx/ingress-nginx --set controller.ingressClass=<namespace> --set controller.ingressClassResource.name=<namespace>
```
To check nginx ingress controller

```
kubectl get services ingress-nginx-controller
```
**Note:**
By default Nginx classname is configured as "nginx" 
You can modify the classname by using the following command

```
helm install -n <namespace> <release-name> ingress-nginx/ingress-nginx --set controller.ingressClass=<ingress-classname> --set controller.ingressClassResource.name=<ingress-classname>
```

## Installing ACM
For installing ACM execute the following command
```
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.11.0/cert-manager.yaml
```


## Installing ebs-csi driver
The driver requires IAM permissions to talk to Amazon EBS to manage the volume on user’s behalf.
For more information, review [“Creating the Amazon EBS CSI driver IAM role for service accounts” from the EKS User Guide.](https://docs.aws.amazon.com/eks/latest/userguide/csi-iam-role.html)

There are several methods to grant the driver IAM permissions:

- **Using IAM instance profile** - attach the policy to the instance profile IAM role and turn on access to instance metadata for the instance(s) on which the driver Deployment will run
- **EKS only**: Using IAM roles for ServiceAccounts - create an IAM role, attach the policy to it, then follow the IRSA documentation to associate the IAM role with the driver Deployment service account, which if you are installing via Helm is determined by value controller.serviceAccount.name, ebs-csi-controller-sa by default
- **Using secret object** - create an IAM user, attach the policy to it, then create a generic secret called aws-secret in the kube-system namespace with the user’s credentials.
```
kubectl create secret generic aws-secret \
    --namespace kube-system \
    --from-literal "key_id=${AWS_ACCESS_KEY_ID}" \
    --from-literal "access_key=${AWS_SECRET_ACCESS_KEY}"
```
Add the aws-ebs-csi-driver Helm repository.

```
helm repo add aws-ebs-csi-driver https://kubernetes-sigs.github.io/aws-ebs-csi-driver

helm repo update
```

Then install a release of the driver using the chart.
```
helm upgrade --install aws-ebs-csi-driver \
    --namespace kube-system \
    aws-ebs-csi-driver/aws-ebs-csi-driver
```

## Pointing Ingress Loadbalancer in Domain Name Provider to access the App using Domain Name.
To access your application/domain name using browser you can either access using Loadbalancer URL or you can point Loadbalancer URL by adding CNAME record in Domain Provider.


## Creating SSL for each domains
### 1. forms-flow-admin
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-admin --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 2. forms-flow-idm
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-idm --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 3. forms-flow-api
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-api --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 4. forms-flow-bpm
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-bpm --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 5. forms-flow-forms
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-forms --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 6. forms-flow-analytics
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-analytics --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 7. forms-flow-documents-api
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-documents-api --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```
### 8. forms-flow-web
```
helm install  <issuer-name> forms-flow-ssl/forms-flow-web --set domain=<domain> --set issuer.acmeEmail=<valid email-address>  --set issuer.ingressClass=<ingress-classname> -n <namespace>
```




## E.g Install Component Chart
```console
$ helm install [RELEASE_NAME] [COMPONENT_NAME] [flags] -n <namespace>
```

## Install [Formsflow.ai](https://formsflow.ai/)
### 1. forms-flow-ai
```console
$ helm install forms-flow-ai formsflow/forms-flow-ai -set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true --set forms-flow-auth.imagesecret=<image_secret> --set insight_api_key=<insight_api_key> --set Domain=<domain_name> --set forms-flow-idm.keycloak.ingress.hostname=forms-flow-idm-<namespace>.<domain_name> -n <namespace>
```
### 2. forms-flow-idm
```console
$ helm upgrade --install forms-flow-idm forms-flow-idm  --set keycloak.ingress.hostname=forms-flow-idm-<namespace>.<domain_name> --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set keycloak.ingress.ingressClassName=<ingress_class> --set keycloak.ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-idm -n <namespace> 
```
### 3. forms-flow-analytics
```console
$ helm upgrade --install forms-flow-analytics forms-flow-analytics --set Domain=<domain_name> --set ingress.ingressClassName=<ingress_class> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-analytics -n <namespace>
```
### 4. forms-flow-bpm
```console
$ helm upgrade --install forms-flow-bpm forms-flow-bpm --set Domain=<domain_name>  --set ingress.ingressClassName=<ingress_class> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-bpm --set camunda.websocket.securityOrigin=https://<web_url> -n <namespace> 
```
### 5. forms-flow-forms
```console
$ helm upgrade --install forms-flow-forms forms-flow-forms --set Domain=<domain_name> --set ingress.ingressClassName=<ingress_class> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-forms -n <namespace>
```
### 6. forms-flow-api
```console
$ helm upgrade --install forms-flow-api forms-flow-api --set Domain=<domain_name>  --set ingress.ingressClassName=<ingress_class> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-api -n <namespace>
```
### 7. forms-flow-documents-api
```console
$ helm upgrade --install forms-flow-documents-api forms-flow-documents-api --set Domain=<domain_name> --set ingress.ingressClassName=<ingress_class> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-documents-api -n <namespace>
```
### 8. forms-flow-web
```console
$ helm upgrade --install forms-flow-web forms-flow-web --set Domain=<domain_name> --set ingress.ingressClassName=qa --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-web -n qa 
```
### 9. forms-flow-data-analysis
```console
$ helm upgrade --install forms-flow-data-analysis forms-flow-data-analysis --set Domain=<domain_name>  --set ingress.ingressClassName=<ingress_class> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-data-analysis -n <namespace>
```
### 10. forms-flow-admin
```console
$ helm upgrade --install forms-flow-admin forms-flow-admin --set Domain=<domain_name> --set ingress.annotations."cert-manager\.io/cluster-issuer"=ssl-admin --set ingress.ingressClassName=<ingress_class> -n <namespace>
```


## Uninstall Chart

Uninstall the chart using the following command
```
 helm uninstall [RELEASE_NAME] -n <namespace>
```
 ## Example
```console
$ helm uninstall forms-flow-ai -n <namespace>
```
For uninstalling multiple charts

```
helm uninstall [RELEASE_NAME 1] [RELEASE_NAME 2] -n <namespace>
```
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
