{{/*
RabbitMQ Common labels
*/}}
{{- define "rabbitmq.labels" -}}
helm.sh/chart: {{ include "geonode.chart" . }}
{{ include "rabbitmq.selectorLabels" . }}
{{- if .Values.services.rabbitmq.tag }}
app.kubernetes.io/version: {{ .Values.services.rabbitmq.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.openshift.io/runtime: rabbitmq
app.kubernetes.io/component: queue
app.kubernetes.io/part-of: geonode
{{- end }}

{{/*
RabbitMQ Selector labels
*/}}
{{- define "rabbitmq.selectorLabels" -}}
app.kubernetes.io/name: {{ .Values.services.rabbitmq.name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
RabbitMQ Service - hostname
*/}}
{{- define "rabbitmq.hostname" -}}
{{- printf "%s.%s.svc.cluster.local" .Values.services.rabbitmq.name .Release.Namespace -}}
{{- end }}
