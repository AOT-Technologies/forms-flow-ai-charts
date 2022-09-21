#!/bin/bash
read -p "Please enter the domain name (ex: apps.bronze.aot-technologies.com):" DOMAIN_NAME
read -p "Please enter the namespace (ex: forms-flow):" NAMESPACE
read -p "Is this a premium installation? (y/n):" IS_PREMIUM

echo "Installing forms flow ..."


helm dependency update ../charts/forms-flow-ai/
helm install forms-flow-ai ../charts/forms-flow-ai --set Domain=$DOMAIN_NAME --set forms-flow-idm.keycloak.ingress.hostname=forms-flow-idm-$NAMESPACE.$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-analytics/
helm install forms-flow-analytics ../charts/forms-flow-analytics --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-forms/
helm install forms-flow-forms ../charts/forms-flow-forms --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-idm/
helm install forms-flow-idm ../charts/forms-flow-idm --set Domain=$DOMAIN_NAME --set keycloak.ingress.hostname=forms-flow-idm-$NAMESPACE.$DOMAIN_NAME --namespace $NAMESPACE

if [[ $IS_PREMIUM =~ ^[Yy]$ ]]
then
	helm dependency update ../charts/forms-flow-admin/
	helm install forms-flow-admin ../charts/forms-flow-admin --set Domain=$DOMAIN_NAME --namespace $NAMESPACE
fi

helm dependency update ../charts/forms-flow-api/
helm install forms-flow-api ../charts/forms-flow-api --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-bpm/
helm install forms-flow-bpm ../charts/forms-flow-bpm --set Domain=$DOMAIN_NAME --set camunda.websocket.securityOrigin=https://*.$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-data-analysis/
helm install forms-flow-data-analysis ../charts/forms-flow-data-analysis --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-web/
helm install forms-flow-web ../charts/forms-flow-web --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

helm dependency update ../charts/forms-flow-documents-api/
helm install forms-flow-documents-api ../charts/forms-flow-documents-api/ --set Domain=$DOMAIN_NAME --namespace $NAMESPACE

echo "Installation complete!"
