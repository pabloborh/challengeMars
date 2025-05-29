{{/*
Expand the name of the chart.
*/}}
{{- define "mars-rover-fleet-tracker.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end }}
