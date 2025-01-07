{{/*
Expand the name of the chart.
*/}}
{{- define "forms-flow-data-analysis.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "forms-flow-data-analysis.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "forms-flow-data-analysis.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "forms-flow-data-analysis.labels" -}}
helm.sh/chart: {{ include "forms-flow-data-analysis.chart" . }}
{{ include "forms-flow-data-analysis.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "forms-flow-data-analysis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "forms-flow-data-analysis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "forms-flow-data-analysis.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "forms-flow-data-analysis.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "forms-flow-data-analysis.createConfigmap" -}}
{{- if and .Values.configuration (not .Values.existingConfigmap) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
    Return the proper forms-flow-data-analysis image name
*/}}
{{- define "forms-flow-data-analysis.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}
{{/*
Return the proper forms-flow-data-analysis side car nginx image name
*/}}
{{- define "forms-flow-data-analysis.nginx.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.ExtraContainer.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "forms-flow-data-analysis.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}