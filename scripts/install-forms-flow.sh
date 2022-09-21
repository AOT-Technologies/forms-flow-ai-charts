#!/bin/bash
read -p "Install using forms-flow package registry? (y/n):" IS_FROM_REGISTRY
read -p "Please enter the domain name (ex: apps.bronze.aot-technologies.com):" DOMAIN_NAME
read -p "Please enter the namespace (ex: forms-flow):" NAMESPACE
read -p "Is this a premium installation? (y/n):" IS_PREMIUM

echo "Installing forms flow ..."

DIRECTORY="../charts"

if [[ $IS_FROM_REGISTRY =~ ^[Yy]$ ]]
then
	helm repo add formsflow https://aot-technologies.github.io/helm-charts
	helm repo update formsflow
	DIRECTORY="formsflow"
else
	helm dependency update $DIRECTORY/forms-flow-ai/
	helm dependency update $DIRECTORY/forms-flow-analytics/
	helm dependency update $DIRECTORY/forms-flow-forms/
	helm dependency update $DIRECTORY/forms-flow-idm/
	helm dependency update $DIRECTORY/forms-flow-admin/
	helm dependency update $DIRECTORY/forms-flow-api/
	helm dependency update $DIRECTORY/forms-flow-bpm/
	helm dependency update $DIRECTORY/forms-flow-data-analysis/
	helm dependency update $DIRECTORY/forms-flow-web/
	helm dependency update $DIRECTORY/forms-flow-documents-api/
fi


helm install forms-flow-ai $DIRECTORY/forms-flow-ai --set Domain=$DOMAIN_NAME --set forms-flow-idm.keycloak.ingress.hostname=forms-flow-idm-$NAMESPACE.$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-analytics $DIRECTORY/forms-flow-analytics --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-forms $DIRECTORY/forms-flow-forms --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-idm $DIRECTORY/forms-flow-idm --set Domain=$DOMAIN_NAME --set keycloak.ingress.hostname=forms-flow-idm-$NAMESPACE.$DOMAIN_NAME --namespace $NAMESPACE

if [[ $IS_PREMIUM =~ ^[Yy]$ ]]
then
	helm install forms-flow-admin $DIRECTORY/forms-flow-admin --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
fi

helm install forms-flow-api $DIRECTORY/forms-flow-api --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-bpm $DIRECTORY/forms-flow-bpm --set Domain=$DOMAIN_NAME --set camunda.websocket.securityOrigin=https://*.$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-data-analysis $DIRECTORY/forms-flow-data-analysis --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-web $DIRECTORY/forms-flow-web --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
helm install forms-flow-documents-api $DIRECTORY/forms-flow-documents-api --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

echo "Installation complete!"
