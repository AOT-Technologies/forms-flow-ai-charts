<div align="center"><img src="https://149641023.v2.pressablecdn.com/wp-content/uploads/2022/05/Site_logo.png"/></div>
<hr/> 


[**formsflow.ai**](https://formsflow.ai/) is a Free, Open-Source, Low Code Development Platform for rapidly building powerful business applications. [**formsflow.ai**](https://formsflow.ai/) combines leading Open-Source applications including [form.io](https://form.io) forms, Camunda’s workflow engine, Keycloak’s security, and Redash’s data analytics into a seamless, integrated platform.


## Before you begin

### Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+

### Setup a Kubernetes Cluster

The quickest way to set up a Kubernetes cluster to install [formsflow.ai](https://formsflow.ai/) Charts is by following the "[formsflow.ai](https://formsflow.ai/) Get Started" guides for the different services:

- [Get Started with Formsflow Charts using the Amazon Elastic Container Service for Kubernetes (EKS)](https://aot-technologies.github.io/forms-flow-installation-eks/docs/intro/)

### Install Helm

Helm is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

To install Helm, refer to the [Helm install guide](https://github.com/helm/helm#install) and ensure that the `helm` binary is in the `PATH` of your shell.

### Using Helm

Once you have installed the Helm client, you can deploy a Bitnami Helm Chart into a Kubernetes cluster.

Please refer to the [Quick Start guide](https://helm.sh/docs/intro/quickstart/) if you wish to get running in just a few commands, otherwise, the [Using Helm Guide](https://helm.sh/docs/intro/using_helm/) provides detailed instructions on how to use the Helm client to manage packages on your Kubernetes cluster.

## License

Copyright 2020 AppsOnTime-Technologies 2020

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.