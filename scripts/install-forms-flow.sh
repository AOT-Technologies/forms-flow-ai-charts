#!/bin/bash

main() {

    # Make sure that this is being run from the scripts folder
    checkdirectory

    # Get user input for install instructions
    displayPrompts

    # Make sure all prompts have been answered
    checkEmptyInput $is_from_registry $domain_name $namespace $is_premium $is_latest_release $classname $analytics_subdomain

    if [[ $is_premium =~ ^[Yy]$ ]]; then
        # Get username and access token for premium users
        read -p "Please enter your username for premium access:" premium_username
        read -s -p "Please enter your access token for premium access:" access_token
        echo
    fi

    printf "\nInstalling forms flow ...\n"

    # Decide whether to install from formsflow registry or local repo
    configureInstall

    # Decide whether to use the latest Chart release
    configureLatestOrStableReleases

    # Run helm install commands
    runHelmInstall

    printf "\nInstallation complete!\n"
}

runHelmInstall() {
    echo

    # Multitenancy check
    read -p "Is this a multitenant installation? (y/n):" is_multitenant

    if [[ $is_premium =~ ^[Yy]$ ]]; then
        if [[ $is_multitenant =~ ^[Yy]$ ]]; then
            # Commands for premium users with multitenancy enabled
            helm upgrade --install forms-flow-ai ../charts/forms-flow-ai --set Domain=$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true --set insight_api_key=$insight_api_key --set imageCredentials.registry=docker.io --set imageCredentials.username=$premium_username --set imageCredentials.password=$access_token --set forms-flow-idm.keycloak.EnableKeycloakClientAuth=true --set forms-flow-web.EnableMultitenant=true --set forms-flow-idm.realm=multitenant --set EnableChatBot=true -n $namespace --version $version_ff_ai
            read -p "Include forms-flow-analytics? (y/n):" include_analytics
            if [[ $include_analytics =~ ^[Yy]$ ]]; then
                helm upgrade --install forms-flow-analytics ../charts/forms-flow-analytics --set ingress.ingressClassName=$classname --set redash.multiOrg=true --set ingress.hosts[0].host=forms-flow-analytics-$namespace.$domain_name --set ingress.tls[0].secretName="forms-flow-analytics-$namespace.$domain_name-tls" --set ingress.tls[0].hosts[0]="forms-flow-analytics-$namespace.$domain_name" --set ingress.hosts[0].paths[0]="/" -n $namespace --version $version_ff_analytics
            # Call external script to get Redash API Key
            getRedashApiKey $namespace $domain_name $analytics_subdomain
            # Store Redash API key in a variable
            REDASH_API_KEY=$?
            echo "Redash API Key: $REDASH_API_KEY"
            # Step 3: Re-run forms-flow-ai with the Redash API Key
            helm upgrade --install forms-flow-ai ../charts/forms-flow-ai --set Domain=$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true --set insight_api_key=$REDASH_API_KEY --set imageCredentials.registry=docker.io --set imageCredentials.username=$premium_username --set imageCredentials.password=$access_token --set forms-flow-idm.keycloak.EnableKeycloakClientAuth=true --set forms-flow-web.EnableMultitenant=true --set forms-flow-idm.realm=multitenant --set EnableChatBot=true -n $namespace --version $version_ff_ai
            # Step 4: Re-run analytics if chosen
            if [[ $include_analytics =~ ^[Yy]$ ]]; then
                helm upgrade --install forms-flow-analytics ../charts/forms-flow-analytics --set ingress.ingressClassName=$classname --set ingress.hosts[0].host=form--set redash.multiOrg=true -flow-analytics-$namespace.$domain_name --set ingress.tls[0].secretName="forms-flow-analytics-$namespace.$domain_name-tls" --set ingress.tls[0].hosts[0]="forms-flow-analytics-$namespace.$domain_name" --set ingress.hosts[0].paths[0]="/" -n $namespace --version $version_ff_analytics
             fi
            fi
            helm upgrade --install forms-flow-idm ../charts/forms-flow-idm  --set keycloak.ingress.hostname=forms-flow-idm-$namespace.$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set keycloak.ingress.ingressClassName=$classname -n $namespace --version $version_ff_idm
            helm upgrade --install forms-flow-forms ../charts/forms-flow-forms --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-forms-$namespace.$domain_name --set ingress.tls=true -n $namespace --version $version_ff_forms
            helm upgrade --install forms-flow-api ../charts/forms-flow-api --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-api-$namespace.$domain_name --set image.repository=formsflow/forms-flow-webapi-ee -n $namespace --version $version_ff_api
            helm upgrade --install forms-flow-bpm ../charts/forms-flow-bpm --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-bpm-$namespace.$domain_name --set image.repository=formsflow/forms-flow-bpm-ee --set camunda.websocket.securityOrigin=https://forms-flow-web-$namespace.$domain_name --set image.repository=formsflow/forms-flow-bpm-ee -n $namespace --version $version_ff_bpm
            helm upgrade --install forms-flow-documents-api ../charts/forms-flow-documents-api --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-documents-api-$namespace.$domain_name --set image.repository=formsflow/forms-flow-documents-api-ee   -n $namespace --version $version_ff_documents_api
	    helm upgrade --install forms-flow-data-analysis ../charts/forms-flow-data-analysis --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-data-analysis-$namespace.$domain_name  --set ingress.tls=true --set image.repository=formsflow/forms-flow-data-analysis-api-ee  -n $namespace --version $version_ff_data_analysis
            helm upgrade --install forms-flow-web ../charts/forms-flow-web --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-web-$namespace.$domain_name --set image.repository=formsflow/forms-flow-web-ee  -n $namespace --version $version_ff_web
            helm upgrade --install forms-flow-admin ../charts/forms-flow-admin --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-admin-$namespace.$domain_name  --set ingress.tls=true -n $namespace --version $version_ff_admin
        else
            helm upgrade --install forms-flow-ai ../charts/forms-flow-ai --set Domain=$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true -–set imageCredentials.registry=docker.io -–set imageCredentials.username=$premium_username -–set imageCredentials.password=$access_token  -n $namespace --version $version_ff_ai
            read -p "Include forms-flow-analytics? (y/n):" include_analytics
            if [[ $include_analytics =~ ^[Yy]$ ]]; then
            helm upgrade --install forms-flow-analytics ../charts/forms-flow-analytics --set ingress.ingressClassName=$classname --set redash.multiOrg=true --set ingress.hosts[0].host=forms-flow-analytics-$namespace.$domain_name --set ingress.tls[0].secretName="forms-flow-analytics-$namespace.$domain_name-tls" --set ingress.tls[0].hosts[0]="forms-flow-analytics-$namespace.$domain_name" --set ingress.hosts[0].paths[0]="/" -n $namespace --version $version_ff_analytics
            # Call external script to get Redash API Key
            getRedashApiKey $namespace $domain_name $analytics_subdomain
            # Store Redash API key in a variable
            REDASH_API_KEY=$?
            echo "Redash API Key: $REDASH_API_KEY"
            # Step 3: Re-run forms-flow-ai with the Redash API Key
            helm upgrade --install forms-flow-ai ../charts/forms-flow-ai --set Domain=$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true -–set imageCredentials.registry=docker.io -–set imageCredentials.username=$premium_username -–set imageCredentials.password=$access_token  -n $namespace --version $version_ff_ai
            # Step 4: Re-run analytics if chosen
            if [[ $include_analytics =~ ^[Yy]$ ]]; then
                helm upgrade --install forms-flow-analytics ../charts/forms-flow-analytics --set ingress.ingressClassName=$classname --set ingress.hosts[0].host=form--set redash.multiOrg=true -flow-analytics-$namespace.$domain_name --set ingress.tls[0].secretName="forms-flow-analytics-$namespace.$domain_name-tls" --set ingress.tls[0].hosts[0]="forms-flow-analytics-$namespace.$domain_name" --set ingress.hosts[0].paths[0]="/" -n $namespace --version $version_ff_analytics
             fi
            fi
            helm upgrade --install forms-flow-idm ../charts/forms-flow-idm  --set keycloak.ingress.hostname=forms-flow-idm-$namespace.$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set keycloak.ingress.ingressClassName=$classname -n $namespace --version $version_ff_idm
            helm upgrade --install forms-flow-forms ../charts/forms-flow-forms --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-forms-$namespace.$domain_name --set ingress.tls=true -n $namespace --version $version_ff_forms
            helm upgrade --install forms-flow-api ../charts/forms-flow-api --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-api-$namespace.$domain_name --set image.repository=formsflow/forms-flow-webapi-ee -n $namespace --version $version_ff_api
            helm upgrade --install forms-flow-bpm ../charts/forms-flow-bpm --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-bpm-$namespace.$domain_name --set image.repository=formsflow/forms-flow-bpm-ee --set camunda.websocket.securityOrigin=https://forms-flow-web-$namespace.$domain_name --set image.repository=formsflow/forms-flow-bpm-ee -n $namespace --version $version_ff_bpm
            helm upgrade --install forms-flow-documents-api ../charts/forms-flow-documents-api --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-documents-api-$namespace.$domain_name --set image.repository=formsflow/forms-flow-documents-api-ee   -n $namespace --version $version_ff_documents_api
	    helm upgrade --install forms-flow-data-analysis ../charts/forms-flow-data-analysis --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-data-analysis-$namespace.$domain_name  --set ingress.tls=true --set image.repository=formsflow/forms-flow-data-analysis-api-ee  -n $namespace --version $version_ff_data_analysis
            helm upgrade --install forms-flow-web ../charts/forms-flow-web --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-web-$namespace.$domain_name --set image.repository=formsflow/forms-flow-web-ee  -n $namespace --version $version_ff_web
	    helm upgrade --install forms-flow-admin ../charts/forms-flow-admin --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-admin-$namespace.$domain_name  --set ingress.tls=true -n $namespace --version $version_ff_admin
          fi

    else
        # Commands for open-source users
        # Optional components for open-source users
        helm upgrade --install forms-flow-ai ../charts/forms-flow-ai --set Domain=$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true -n $namespace --version $version_ff_ai
        read -p "Include forms-flow-analytics? (y/n):" include_analytics
        if [[ $include_analytics =~ ^[Yy]$ ]]; then
            helm upgrade --install forms-flow-analytics ../charts/forms-flow-analytics --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-analytics-$namespace.$domain_name -n $namespace --version $version_ff_analytics
        # Call external script to get Redash API Key
        getRedashApiKey $namespace $domain_name $analytics_subdomain
        # Store Redash API key in a variable
        REDASH_API_KEY=$?
        echo "Redash API Key: $REDASH_API_KEY"
        # Step 3: Re-run forms-flow-ai with the Redash API Key
         helm upgrade --install forms-flow-ai ../charts/forms-flow-ai --set Domain=$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set mongodb.podSecurityContext.enabled=true -n $namespace --version $version_ff_ai
        # Step 4: Re-run analytics if chosen
        if [[ $include_analytics =~ ^[Yy]$ ]]; then
            helm upgrade --install forms-flow-analytics ../charts/forms-flow-analytics --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-analytics-$namespace.$domain_name -n $namespace --version $version_ff_analytics
           fi
         fi
	helm upgrade --install forms-flow-idm ../charts/forms-flow-idm  --set keycloak.ingress.hostname=forms-flow-idm-$namespace.$domain_name --set postgresql-ha.postgresql.podSecurityContext.enabled=true --set keycloak.ingress.ingressClassName=$classname -n $namespace --version $version_ff_idm
        helm upgrade --install forms-flow-forms ../charts/forms-flow-forms --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-forms-$namespace.$domain_name --set ingress.tls=true -n $namespace --version $version_ff_forms
        helm upgrade --install forms-flow-api ../charts/forms-flow-api --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-api-$namespace.$domain_name --set ingress.tls=true -n $namespace --version $version_ff_api
	helm upgrade --install forms-flow-bpm ../charts/forms-flow-bpm --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-bpm-$namespace.$domain_name --set ingress.tls=true --set camunda.websocket.securityOrigin=https://forms-flow-web-$namespace.$domain_name -n $namespace --version $version_ff_bpm
        helm upgrade --install forms-flow-documents-api ../charts/forms-flow-documents-api --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-documents-api-$namespace.$domain_name --set ingress.tls=true -n $namespace --version $version_ff_documents_api
        helm upgrade --install forms-flow-web ../charts/forms-flow-web --set ingress.ingressClassName=$classname --set ingress.hostname=forms-flow-web-$namespace.$domain_name  --set ingress.tls=true -n $namespace --version $version_ff_web
     fi
}

getRedashApiKey() {
    # Call the external script to get Redash API Key
    bash ./get_redash_api_key.sh "$1" "$2" "$3"
    return $REDASH_API_KEY
}

configureInstall() {
    directory="../charts"
    if [[ $is_from_registry =~ ^[Yy]$ ]]; then
        addRegistry
        directory="formsflow"
    else
        updateLocalDependencies
    fi
}

configureLatestOrStableReleases() {
    if [[ $is_latest_release =~ ^[Yy]$ ]]; then
        version_ff_admin="latest"
        version_ff_ai="latest"
        version_ff_analytics="latest"
        version_ff_api="latest"
        version_ff_bpm="latest"
        version_ff_data_analysis="latest"
        version_ff_documents_api="latest"
        version_ff_forms="latest"
        version_ff_idm="latest"
        version_ff_web="latest"
    else
        # See https://github.com/AOT-Technologies/forms-flow-ai-charts/releases
        version_ff_admin="v7.1.1"
        version_ff_ai="v7.1.1"
        version_ff_analytics="v7.1.1"
        version_ff_api="v7.1.1"
        version_ff_bpm="v7.1.1"
        version_ff_data_analysis="v7.1.1"
        version_ff_documents_api="v7.1.1"
        version_ff_forms="v7.1.1"
        version_ff_idm="v7.1.1"
        version_ff_web="v7.1.1"
    fi
}

addRegistry() {
    helm repo remove formsflow
    helm repo add formsflow https://aot-technologies.github.io/forms-flow-ai-charts
    echo
    helm repo update formsflow
}

updateLocalDependencies(){
    helm dependency build $directory/forms-flow-ai/
    helm dependency build $directory/forms-flow-analytics/
    helm dependency build $directory/forms-flow-forms/
    helm dependency build $directory/forms-flow-idm/
    helm dependency build $directory/forms-flow-admin/
    helm dependency build $directory/forms-flow-api/
    helm dependency build $directory/forms-flow-bpm/
    helm dependency build $directory/forms-flow-data-analysis/
    helm dependency build $directory/forms-flow-web/
    helm dependency build $directory/forms-flow-documents-api/
}

displayPrompts() {
    read -p "Install using forms-flow package registry? (y/n):" is_from_registry
    read -p "Please enter the domain name (ex: apps.bronze.$domain_name):" domain_name
    read -p "Please enter the namespace (ex: forms-flow):" namespace
    read -p "Please enter the ingress class name (ex: formsflow):" classname
    read -p "Is this a premium installation? (y/n):" is_premium
    read -p "Use the latest version release? (y) or stable release (n):" is_latest_release
    analytics_subdomain="forms-flow-analytics"
}

checkdirectory() {
    pwd=$(pwd)
    dirname=$(basename ${pwd})
    if [ ! ${dirname} = "scripts" ]; then
        echo "Must run from scripts folder"
        exit 1
    fi
}

checkEmptyInput() {
    if [ ! ${#} = 7 ]; then
        echo "Please provide input for all prompts."
        exit 2
    fi
}

main "$@"
