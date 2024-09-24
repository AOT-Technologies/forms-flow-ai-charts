{{/*
Expand the name of the chart.
*/}}
{{- define "forms-flow-ai.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "forms-flow-ai.fullname" -}}
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
{{- define "forms-flow-ai.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "forms-flow-ai.labels" -}}
helm.sh/chart: {{ include "forms-flow-ai.chart" . }}
{{ include "forms-flow-ai.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "forms-flow-ai.selectorLabels" -}}
app.kubernetes.io/name: {{ include "forms-flow-ai.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/* Fullname suffixed with redis-exporter */}}
{{- define "forms-flow-ai.redisExporter.fullname" -}}
{{- printf "redis-exporter"
 -}}
{{- end -}}

{{/*
Return the proper redisExporter image name
*/}}
{{- define "forms-flow-ai.redisExporter.image" -}}
{{- include "common.images.image" ( dict "imageRoot" .Values.redisExporter.image "global" .Values.global ) -}}
{{- end -}}
{{/*
Labels for redis-exporter
*/}}
{{- define "forms-flow-ai.redisExporter.labels" -}}
{{- include "common.labels.standard" ( dict "customLabels" .Values.commonLabels "context" $ ) }}
app.kubernetes.io/component: redis-exporter
{{- end -}}

{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.imageCredentials.registry (printf "%s:%s" .Values.imageCredentials.username .Values.imageCredentials.password | b64enc) | b64enc }}
{{- end }}



