#!/bin/bash

# Exit when script tries to use undeclared variables
set -o nounset

# Assign versions
# See https://github.com/AOT-Technologies/forms-flow-ai-charts/releases
version_ff_admin="v2.1.1"
version_ff_ai="v2.1.4"
version_ff_analytics="v2.1.1"
version_ff_api="v2.1.2"
version_ff_bpm="v2.1.1"
version_ff_data_analysis="v2.1.1"
version_ff_documents_api="v2.1.1"
version_ff_forms="v2.1.1"
version_ff_idm="v2.1.2"
version_ff_web="v2.1.1"

main() {

	# Make sure that this is being run from the scripts folder
	checkdirectory

	# Get user input for install instructions
	displayPrompts

	# Make sure all prompts have been answered
	# Checks if number of arguments = 4
	checkEmptyInput $is_from_registry $domain_name $namespace $is_premium

	printf "\nInstalling forms flow ...\n"

	# Decide whether to install from formsflow registry (https://aot-technologies.github.io/forms-flow-ai-charts) or from this local repo
	configureInstall

	# Run helm install commands
	runHelmInstall

	printf "\nInstallation complete!\n"

}

runHelmInstall() {
	echo
	helm install forms-flow-ai $directory/forms-flow-ai --set Domain=$domain_name --set forms-flow-idm.keycloak.ingress.hostname=forms-flow-idm-$namespace.$domain_name --namespace $namespace --version $version_ff_ai
	helm install forms-flow-analytics $directory/forms-flow-analytics --set Domain=$domain_name --namespace $namespace --version $version_ff_analytics
	helm install forms-flow-forms $directory/forms-flow-forms --set Domain=$domain_name --namespace $namespace --version $version_ff_forms
	helm install forms-flow-idm $directory/forms-flow-idm --set Domain=$domain_name --set keycloak.ingress.hostname=forms-flow-idm-$namespace.$domain_name --namespace $namespace --version $version_ff_idm

	if [[ $is_premium =~ ^[Yy]$ ]]; then
		helm install forms-flow-admin $directory/forms-flow-admin --set Domain=$domain_name --namespace $namespace --version $version_ff_admin
	fi

	helm install forms-flow-api $directory/forms-flow-api --set Domain=$domain_name --namespace $namespace --version $version_ff_api
	helm install forms-flow-bpm $directory/forms-flow-bpm --set Domain=$domain_name --set camunda.websocket.securityOrigin=https://*.$domain_name --namespace $namespace --version $version_ff_bpm
	helm install forms-flow-data-analysis $directory/forms-flow-data-analysis --set Domain=$domain_name --namespace $namespace --version $version_ff_data_analysis
	helm install forms-flow-web $directory/forms-flow-web --set Domain=$domain_name --namespace $namespace --version $version_ff_web
	helm install forms-flow-documents-api $directory/forms-flow-documents-api --set Domain=$domain_name --namespace $namespace --version $version_ff_documents_api
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

addRegistry() {
	helm repo remove formsflow
	helm repo add formsflow https://aot-technologies.github.io/forms-flow-ai-charts
	echo
	helm repo update formsflow
}

updateLocalDependencies(){
	helm dependency update $directory/forms-flow-ai/
	helm dependency update $directory/forms-flow-analytics/
	helm dependency update $directory/forms-flow-forms/
	helm dependency update $directory/forms-flow-idm/
	helm dependency update $directory/forms-flow-admin/
	helm dependency update $directory/forms-flow-api/
	helm dependency update $directory/forms-flow-bpm/
	helm dependency update $directory/forms-flow-data-analysis/
	helm dependency update $directory/forms-flow-web/
	helm dependency update $directory/forms-flow-documents-api/
}

displayPrompts() {
	read -p "Install using forms-flow package registry? (y/n):" is_from_registry
	read -p "Please enter the domain name (ex: apps.bronze.aot-technologies.com):" domain_name
	read -p "Please enter the namespace (ex: forms-flow):" namespace
	read -p "Is this a premium installation? (y/n):" is_premium
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
	if [ ! ${#} = 4 ]; then
		echo "Please provide input for all prompts."
		exit 2
	fi
}


main "$@"