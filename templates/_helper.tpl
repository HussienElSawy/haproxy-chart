{{- define "haproxy.name" -}}
haproxy
{{- end }}

{{- define "haproxy.fullname" -}}
{{ .Release.Name }}-{{ include "haproxy.name" . }}
{{- end }}