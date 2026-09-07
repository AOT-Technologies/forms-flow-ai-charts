{{/*
Expand the name of the chart.
*/}}
{{- define "ehr-connector.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ehr-connector.fullname" -}}
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
{{- define "ehr-connector.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ehr-connector.labels" -}}
helm.sh/chart: {{ include "ehr-connector.chart" . }}
{{ include "ehr-connector.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ehr-connector.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ehr-connector.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "ehr-connector.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ehr-connector.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ehr-connector.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper ehr-connector image name
*/}}
{{- define "ehr-connector.image" -}}
{{- if .Values.image.registry }}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.repository (default .Chart.AppVersion .Values.image.tag) }}
{{- else }}
{{- printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) }}
{{- end }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "ehr-connector.imagePullSecrets" -}}
{{- if .Values.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Return the secret name
*/}}
{{- define "ehr-connector.secretName" -}}
{{- if .Values.auth.existingSecret }}
{{- .Values.auth.existingSecret }}
{{- else }}
{{- printf "%s-secrets" (include "ehr-connector.fullname" .) }}
{{- end }}
{{- end -}}

{{/*
Return the service name
*/}}
{{- define "ehr-connector.serviceName" -}}
{{- if .Values.service.nameOverride }}
{{- .Values.service.nameOverride }}
{{- else }}
{{- printf "%s-service" (include "ehr-connector.fullname" .) }}
{{- end }}
{{- end -}}
