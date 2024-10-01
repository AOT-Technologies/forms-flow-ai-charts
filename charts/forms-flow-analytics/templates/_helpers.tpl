{{/*
Expand the name of the chart.
*/}}
{{- define "forms-flow-analytics.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "forms-flow-analytics.fullname" -}}
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
{{- define "forms-flow-analytics.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "forms-flow-analytics.labels" -}}
helm.sh/chart: {{ include "forms-flow-analytics.chart" . }}
{{ include "forms-flow-analytics.selectorLabels" . }}
{{- with .workerName }}
app.kubernetes.io/component: {{ . }}-worker
{{- end }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "forms-flow-analytics.selectorLabels" -}}
app.kubernetes.io/name: {{ include "forms-flow-analytics.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "forms-flow-analytics.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create }}
{{- default (include "forms-flow-analytics.fullname" .) .Values.server.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.server.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return true if a configmap object should be created
*/}}
{{- define "forms-flow-analytics.createConfigmap" -}}
{{- if and .Values.server.configuration (not .Values.server.existingConfigmap) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
    Return the proper forms-flow-analytics image name
*/}}
{{- define "forms-flow-analytics.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.server.image "global" .Values.global) }}
{{- end -}}


{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "forms-flow-analytics.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.server.image ) "context" $) -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "forms-flow-analytics.worker.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.server.image ) "context" $) -}}
{{- end -}}


{{/*
Create a default fully qualified worker name.
*/}}
{{- define "forms-flow-analytics.worker.fullname" -}}
{{- template "forms-flow-analytics.fullname" . -}}-{{ .workerName }}-worker
{{- end -}}

{{/*
Get the externaldatabase details.
*/}}
{{- define "forms-flow-analytics.existingExternalDatabaseUrlKey" -}}
{{- printf "%s" .Values.externalDatabase.existingDatabaseUrlKey -}}
{{- end -}}
{{- define "forms-flow-analytics.existingExternalSecretName" -}}
{{- printf "%s" .Values.externalDatabase.existingSecretName -}}
{{- end -}}


{{/*
Shared environment block used across worker component.
*/}}
{{- define "forms-flow-analytics.worker.env" -}}
{{- if .Values.externalDatabase.existingDatabaseUrlKey }}
- name: REDASH_DATABASE_URL
  valueFrom:
    secretKeyRef:
      key: {{ include "forms-flow-analytics.existingExternalDatabaseUrlKey" . }}
      name: {{ include "forms-flow-analytics.existingExternalSecretName" . }}
{{- else }}
- name: REDASH_DATABASE_URL
  valueFrom:
    configMapKeyRef:
      key: REDASH_DATABASE_URL
      name: "{{ .Chart.Name }}"
{{- end }}
- name: QUEUES
  value: "periodic_emails,default"
- name: WORKERS_COUNT
  value: "1"
{{- end }}

{{- define "forms-flow-analytics.worker.envFrom" -}}
{{- if .Values.worker.extraEnvVarsCM }}
- configMapRef:
    name: {{ .Values.worker.extraEnvVarsCM }}
{{- else}}
- configMapRef:
    name: {{ include "forms-flow-analytics.name" . }}
{{- end }} 
{{- if .Values.worker.extraEnvVarsSecret }}
- secretRef:
    name: {{ .Values.worker.extraEnvVarsSecret }}
{{- else}}
- secretRef:
    name: {{ include "forms-flow-analytics.name" . }}
{{- end }}
{{- end -}}

