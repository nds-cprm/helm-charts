# Django helpers
{{/*
Django Common labels
*/}}
{{- define "django.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "django.selectorLabels" . }}
{{- if .Values.services.django.tag }}
app.kubernetes.io/version: {{ .Values.services.django.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: django
app.kubernetes.io/component: backend
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
Django Selector labels
*/}}
{{- define "django.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.django.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Django Service - hostname
*/}}
{{- define "django.hostname" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.django.name .Release.Namespace -}}
{{- end }}
