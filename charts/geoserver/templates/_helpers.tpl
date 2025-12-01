{{/*
Expand the name of the chart.
*/}}
{{- define "geoserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "geoserver.fullname" -}}
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

{{- define "geoserver.master.fullname" -}}
{{ printf "%s-master" ( include "geoserver.fullname" . | trunc 56 )}}
{{- end }}

{{- define "geoserver.slave.fullname" -}}
{{ printf "%s-slave" ( include "geoserver.fullname" . | trunc 57 )}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "geoserver.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "geoserver.labels" -}}
helm.sh/chart: {{ include "geoserver.chart" . }}
{{ include "geoserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "geoserver.master.labels" -}}
{{ include "geoserver.labels" . }}
app.kubernetes.io/component: master
{{- end }}

{{- define "geoserver.slave.labels" -}}
{{ include "geoserver.labels" . }}
app.kubernetes.io/component: slave
{{- end }}

{{/*
Selector labels
*/}}
{{- define "geoserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "geoserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "geoserver.master.selectorLabels" -}}
{{ include "geoserver.selectorLabels" . }}
app.kubernetes.io/component: master
{{- end }}

{{- define "geoserver.slave.selectorLabels" -}}
{{ include "geoserver.selectorLabels" . }}
app.kubernetes.io/component: slave
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "geoserver.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "geoserver.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
URLs and Context Paths
*/}}
{{- define "geoserver.url" -}}
{{- printf "http%s://%s" (ternary "" "s" (empty .Values.ingress.host.tlsSecretName)) .Values.ingress.host.name }}
{{- end -}}

{{- define "geoserver.master.contextPath" -}}
{{- .Values.master.config.contextPath | default (ternary "/geoserver-admin" "/geoserver" .Values.cluster.enabled) }}
{{- end -}}

{{- define "geoserver.slave.contextPath" -}}
{{- if .Values.cluster.enabled -}}
{{- $path := .Values.slave.config.contextPath | default "/geoserver" }}
{{- if eq $path (include "geoserver.master.contextPath" .) -}}
{{- fail "The master and slave contexts can't be equal" -}}
{{- end -}}
{{- $path }}
{{- end -}}
{{- end -}}

{{- define "geoserver.master.proxyBaseURL" -}}
{{- .Values.master.config.proxyBaseURL | default (printf "%s%s" (include "geoserver.url" .) (include "geoserver.master.contextPath" .)) }}
{{- end -}}

{{- define "geoserver.slave.proxyBaseURL" -}}
{{- .Values.slave.config.proxyBaseURL | default (printf "%s%s" (include "geoserver.url" .) (include "geoserver.slave.contextPath" .)) }}
{{- end -}}


{{/*
Cluster URLs
*/}}
{{- define "geoserver.cluster.brokerURL" -}}
{{- if .Values.cluster.enabled -}}
{{- .Values.cluster.brokerURL | default (printf "tcp://%s:61616" (include "activemq.fullname" .Subcharts.activemq)) }}
{{- end -}}
{{- end -}}
