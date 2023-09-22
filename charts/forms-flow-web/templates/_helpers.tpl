{{- define "Values.extractKeyValuePairs" -}}
{{- $config := .Values.extraEnv }}
{{- with $config -}}
{{- range $key, $value := $config }}
{{ $key }}: {{ quote $value }}
{{- end }}
{{- end }}
{{- end }}

{{- define "Values.extractKeyValuePairsForJson" -}}
{{- $config := .Values.extraEnv }}
{{- with $config -}}
{{- range $key, $value := $config }}
{{ quote $key }}: {{ quote $value }},
{{- end }}
{{- end }}
{{- end }}
