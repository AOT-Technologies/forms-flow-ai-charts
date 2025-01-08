{{/*
Expand the name of the chart.
*/}}
{{- define "forms-flow-forms.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "forms-flow-forms.fullname" -}}
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
{{- define "forms-flow-forms.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "forms-flow-forms.labels" -}}
helm.sh/chart: {{ include "forms-flow-forms.chart" . }}
{{ include "forms-flow-forms.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "forms-flow-forms.selectorLabels" -}}
app.kubernetes.io/name: {{ include "forms-flow-forms.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "forms-flow-forms.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "forms-flow-forms.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "forms-flow-forms.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.image) "context" $) -}}
{{- end -}}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "forms-flow-forms.createConfigmap" -}}
{{- if and .Values.configuration (not .Values.existingConfigmap) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
    Return the proper forms-flow-bpm image name
*/}}
{{- define "forms-flow-forms.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper forms-flow-forms side car nginx image name
*/}}
{{- define "forms-flow-forms.nginx.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.ExtraContainer.image "global" .Values.global) }}
{{- end -}}