{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "redash.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 43 chars because some Kubernetes name fields are limited to 64 (by the DNS naming spec),
and we use this as a base for component names (which can add up to 20 chars).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "redash.fullname" -}}
{{- with .Values.fullnameOverride -}}
{{- . | trunc 43 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 43 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 43 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified worker name.
*/}}
{{- define "redash.worker.fullname" -}}
{{- template "redash.fullname" . -}}-{{ .workerName }}-worker
{{- end -}}

{{/*
Create a default fully qualified scheduler name.
*/}}
{{- define "redash.scheduler.fullname" -}}
{{- template "redash.fullname" . -}}-scheduler
{{- end -}}

{{/*
Environment variables initialized from secret used across each component.
*/}}
{{- define "redash.envFrom" -}}
{{- with .Values.envSecretName -}}
- secretRef:
    name: {{ . }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "redash.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "redash.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

# This ensures a random value is provided for postgresql.auth.password:
required "A secure random value for .postgresql.auth.password is required" .Values.postgresql.auth.password
