{{/*
Expand the name of the chart.
*/}}
{{- define "forms-flow-immudb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "forms-flow-immudb.fullname" -}}
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
{{- define "forms-flow-immudb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "forms-flow-immudb.labels" -}}
helm.sh/chart: {{ include "forms-flow-immudb.chart" . }}
app.kubernetes.io/name: {{ include "forms-flow-immudb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "forms-flow-immudb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "forms-flow-immudb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
=============================================================================
Worker (forms-flow-immudb) Helpers
=============================================================================
*/}}

{{/*
Worker fullname (defaults to forms-flow-immudb to match pod name forms-flow-immudb-*)
*/}}
{{- define "forms-flow-immudb.worker.fullname" -}}
{{- if .Values.worker.fullnameOverride }}
{{- .Values.worker.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- include "forms-flow-immudb.fullname" . }}
{{- end }}
{{- end }}

{{/*
Worker selector labels
*/}}
{{- define "forms-flow-immudb.worker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "forms-flow-immudb.worker.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "forms-flow-immudb.worker.fullname" . }}
{{- end }}

{{/*
Worker labels
*/}}
{{- define "forms-flow-immudb.worker.labels" -}}
{{ include "forms-flow-immudb.labels" . }}
{{ include "forms-flow-immudb.worker.selectorLabels" . }}
app.kubernetes.io/component: worker
{{- end }}

{{/*
Worker image name
*/}}
{{- define "forms-flow-immudb.worker.image" -}}
{{- if .Values.worker.image.registry }}
{{- printf "%s/%s:%s" .Values.worker.image.registry .Values.worker.image.repository (default .Chart.AppVersion .Values.worker.image.tag) }}
{{- else }}
{{- printf "%s:%s" .Values.worker.image.repository (default .Chart.AppVersion .Values.worker.image.tag) }}
{{- end }}
{{- end }}

{{/*
Worker service name
*/}}
{{- define "forms-flow-immudb.worker.serviceName" -}}
{{- default (include "forms-flow-immudb.worker.fullname" .) .Values.worker.service.nameOverride }}
{{- end }}

{{/*
Worker secret name
*/}}
{{- define "forms-flow-immudb.worker.secretName" -}}
{{- if .Values.worker.auth.existingSecret }}
{{- .Values.worker.auth.existingSecret }}
{{- else }}
{{- printf "%s-secret" (include "forms-flow-immudb.worker.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Worker configmap name
*/}}
{{- define "forms-flow-immudb.worker.configMapName" -}}
{{- if .Values.worker.existingConfigmap }}
{{- .Values.worker.existingConfigmap }}
{{- else }}
{{- printf "%s-config" (include "forms-flow-immudb.worker.fullname" .) }}
{{- end }}
{{- end }}

{{/*
=============================================================================
ImmuDB Database Server Helpers
=============================================================================
*/}}

{{/*
ImmuDB database fullname (defaults to "immudb" to match pod name immudb-0)
*/}}
{{- define "forms-flow-immudb.immudb.fullname" -}}
{{- if .Values.immudb.fullnameOverride }}
{{- .Values.immudb.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- default "immudb" .Values.immudb.nameOverride }}
{{- end }}
{{- end }}

{{/*
ImmuDB selector labels
*/}}
{{- define "forms-flow-immudb.immudb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "forms-flow-immudb.immudb.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "forms-flow-immudb.immudb.fullname" . }}
{{- end }}

{{/*
ImmuDB labels
*/}}
{{- define "forms-flow-immudb.immudb.labels" -}}
{{ include "forms-flow-immudb.labels" . }}
{{ include "forms-flow-immudb.immudb.selectorLabels" . }}
app.kubernetes.io/component: database
{{- end }}

{{/*
ImmuDB image name
*/}}
{{- define "forms-flow-immudb.immudb.image" -}}
{{- if .Values.immudb.image.registry }}
{{- printf "%s/%s:%s" .Values.immudb.image.registry .Values.immudb.image.repository .Values.immudb.image.tag }}
{{- else }}
{{- printf "%s:%s" .Values.immudb.image.repository .Values.immudb.image.tag }}
{{- end }}
{{- end }}

{{/*
ImmuDB service name
*/}}
{{- define "forms-flow-immudb.immudb.serviceName" -}}
{{- default (include "forms-flow-immudb.immudb.fullname" .) .Values.immudb.service.nameOverride }}
{{- end }}

{{/*
ImmuDB secret name
*/}}
{{- define "forms-flow-immudb.immudb.secretName" -}}
{{- if .Values.immudb.auth.existingSecret }}
{{- .Values.immudb.auth.existingSecret }}
{{- else }}
{{- printf "%s-secret" (include "forms-flow-immudb.immudb.fullname" .) }}
{{- end }}
{{- end }}

{{/*
Host used to connect to ImmuDB
*/}}
{{- define "forms-flow-immudb.immudb.host" -}}
{{- if .Values.immudb.enabled }}
{{- printf "%s:%d" (include "forms-flow-immudb.immudb.serviceName" .) (int .Values.immudb.service.ports.grpc) }}
{{- else }}
{{- .Values.externalImmudb.host }}
{{- end }}
{{- end }}

{{/*
Image pull secrets
*/}}
{{- define "forms-flow-immudb.imagePullSecrets" -}}
{{- if .Values.imagePullSecrets }}
imagePullSecrets:
{{- range .Values.imagePullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- end }}
