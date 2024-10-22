# forms-flow-ai-charts

Welcome to the forms-flow-ai Helm charts repository. This repository contains the Helm charts for deploying forms-flow-ai and its components.

## Repository Structure 

- `charts/`: Contains the Helm charts for various components of forms-flow-ai.
- `docs/`: Documentation related to the Helm charts.
- `scripts/`: Utility scripts for managing the Helm charts.

## Prerequisites

- Helm 3.x
- Kubernetes 1.18+
- A running Kubernetes cluster

## Adding the Repository

To add this Helm repository, use the following command:

```bash
helm repo add forms-flow-ai https://aot-technologies.github.io/forms-flow-ai-charts/
helm repo update
```

Installing a Chart
To install a chart from this repository, use the following command:

```bash
helm install <release-name> forms-flow-ai/<chart-name> --namespace <namespace> --values <values-file>
```
For example, to install the forms-flow-ai chart:

```bash
helm install forms-flow-ai forms-flow-ai/forms-flow-ai --namespace forms-flow --values my-values.yaml
```

Updating a Chart
To update a deployed chart, use the following command:

```bash
helm upgrade <release-name> forms-flow-ai/<chart-name> --namespace <namespace> --values <values-file>
```

Uninstalling a Chart
To uninstall a chart, use the following command:
```bash
helm uninstall <release-name> --namespace <namespace>
```

## Chart Versions

The versions of Helm charts available in this repository are as follows:

| Formsflow Version | Chart Name        | Chart Version |
|-------------------|-------------------|---------------|
| 6.0.2             | forms-flow-ai     | v6.0.2        |
| 6.0.1             | forms-flow-ai     | v6.0.1        |
| 6.0.0             | forms-flow-ai     | v6.0.0        |
| 5.3.1             | forms-flow-ai     | v5.3.1        |
| 5.3.0             | forms-flow-ai     | v5.3.0        |
| 5.2.2             | forms-flow-ai     | v5.2.2        |
| 5.2.1             | forms-flow-ai     | v5.2.1        |
| 5.2.0             | forms-flow-ai     | v5.2.0        |
| 5.1.1             | forms-flow-ai     | v5.1.1        |
| 5.1.0             | forms-flow-ai     | v5.1.0        |
