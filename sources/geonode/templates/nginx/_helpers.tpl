{{/*
Nginx Common labels
*/}}
{{- define "nginx.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "nginx.selectorLabels" . }}
{{- if .Values.services.nginx.tag }}
app.kubernetes.io/version: {{ .Values.services.nginx.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: nginx
app.kubernetes.io/component: frontend
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
Nginx Selector labels
*/}}
{{- define "nginx.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.nginx.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Nginx Service - hostname
*/}}
{{- define "nginx.hostname" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.nginx.name .Release.Namespace -}}
{{- end }}
