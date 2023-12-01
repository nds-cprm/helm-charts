{{/*
Geoserver Common labels
*/}}
{{- define "geoserver.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "geoserver.selectorLabels" . }}
{{- if .Values.services.geoserver.tag }}
app.kubernetes.io/version: {{ .Values.services.geoserver.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: hibernate
app.kubernetes.io/component: backend
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
Geoserver Selector labels
*/}}
{{- define "geoserver.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.geoserver.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Geoserver Service - hostname
*/}}
{{- define "geoserver.hostname" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.geoserver.name .Release.Namespace -}}
{{- end }}
