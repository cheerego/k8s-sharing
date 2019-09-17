{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart-intro" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- printf "%s-%s"  $name .Values.version | trunc 63 | trimSuffix "-" -}}
{{- end -}}


