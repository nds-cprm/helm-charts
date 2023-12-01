{{/*
Memcached Common labels
*/}}
{{- define "memcached.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "memcached.selectorLabels" . }}
{{- if .Values.services.memcached.tag }}
app.kubernetes.io/version: {{ .Values.services.memcached.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: memcached
app.kubernetes.io/component: cache
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
Memcached Selector labels
*/}}
{{- define "memcached.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.memcached.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Memcached Service - hostname
*/}}
{{- define "memcached.hostname" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.memcached.name .Release.Namespace -}}
{{- end }}
