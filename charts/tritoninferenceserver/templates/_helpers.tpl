{{- define "tritoninferenceserver.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "namespace" -}}
{{- .Values.namespace | default .Release.Namespace -}}
{{- end -}}


{{- define "tritoninferenceserver.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Common labels
*/}}
{{- define "tritoninferenceserver.labels" -}}
helm.sh/chart: {{ include "tritoninferenceserver.chart" . }}
{{ include "tritoninferenceserver.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tritoninferenceserver.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tritoninferenceserver.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
