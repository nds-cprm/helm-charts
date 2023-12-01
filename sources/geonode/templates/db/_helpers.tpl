{{/*
DB Common labels
*/}}
{{- define "db.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "db.selectorLabels" . }}
{{- if .Values.services.db.tag }}
app.kubernetes.io/version: {{ .Values.services.db.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: postgresql
app.kubernetes.io/component: database
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
DB Selector labels
*/}}
{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.db.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
DB Service - hostname
*/}}
{{- define "db.hostname" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.db.name .Release.Namespace -}}
{{- end }}
