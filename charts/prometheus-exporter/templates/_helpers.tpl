{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus-exporter.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prometheus-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prometheus-exporter.labels" -}}
helm.sh/chart: {{ include "prometheus-exporter.chart" . }}
{{ include "prometheus-exporter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prometheus-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prometheus-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prometheus-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "prometheus-exporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "prometheus-exporter.containers" -}}
- name: php-fpm
  securityContext:
    {{- toYaml .Values.securityContext | nindent 4 }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  livenessProbe:
    exec:
        command:
            - php-fpm-healthcheck
    initialDelaySeconds: 0
    periodSeconds: 10
  readinessProbe:
    exec:
        command:
            - php-fpm-healthcheck # a simple ping since this means it's ready to handle traffic
    initialDelaySeconds: 1
    periodSeconds: 5
  resources:
    {{- toYaml .Values.resources | nindent 4 }}
  volumeMounts:
    - name: {{ include "prometheus-exporter.fullname" . }}-metrics-volume
      mountPath: /app/var/metrics/
  {{- with .Values.volumeMounts }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.env }}
  env:
    {{- toYaml . | nindent 4 }}
  {{- end }}
- name: nginx
  securityContext:
    {{- toYaml .Values.securityContext | nindent 4 }}
  image: "nginx:1.24-alpine"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  ports:
    - name: http
      containerPort: {{ .Values.service.port }}
      protocol: TCP
  livenessProbe:
    httpGet:
      path: /status
      port: http
  readinessProbe:
    httpGet:
      path: /status
      port: http
  resources:
    {{- toYaml .Values.resources | nindent 4 }}
  volumeMounts:
    - name: {{ include "prometheus-exporter.fullname" . }}-nginx-config-volume
      mountPath: /etc/nginx/conf.d/default.conf
      subPath: nginx.conf
    - name: {{ include "prometheus-exporter.fullname" . }}-nginx-config-volume
      mountPath: /etc/nginx/fastcgi_params
      subPath: fastcgi_params
    {{- with .Values.volumeMounts }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
{{- end }}
