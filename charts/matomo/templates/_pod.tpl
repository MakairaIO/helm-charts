
{{/*
volumeMount for configs
*/}}
{{- define "matomo.config.volumeMounts" -}}
- name: config-volume
  mountPath: /var/www/html/config/config.ini.php
  subPath: config.ini.php
- name: config
  mountPath: /usr/local/etc/php/conf.d/php-matomo-custom.ini
  subPath: php.ini

  {{- if .Values.database.ssl }}
  {{- if .Values.database.ssl.serverCA }}
- name: {{ include "matomo.fullname" . }}-db-certs
  mountPath: /etc/ssl/certs/db-server-ca.pem
  subPath: server-ca.pem
  {{- end }}
  {{- if .Values.database.ssl.clientCert }}
- name: {{ include "matomo.fullname" . }}-db-certs
  mountPath: /etc/ssl/certs/db-client-cert.pem
  subPath: client-cert.pem
  {{- end }}
  {{- if .Values.database.ssl.clientKey }}
- name: {{ include "matomo.fullname" . }}-db-certs
  mountPath: /etc/ssl/private/db-client-key.pem
  subPath: client-key.pem
  {{- end }}
  {{- end }}

  {{- if .Values.misc.favicon }}
- name: config-volume
  mountPath: /var/www/html/misc/user/favicon.png
  subPath: favicon.png
  {{- end }}

  {{- if .Values.misc.logo }}
- name: config-volume
  mountPath: /var/www/html/misc/user/logo.png
  subPath: logo.png
  {{- end }}

  {{- if index .Values.misc "logo-header" }}
- name: config-volume
  mountPath: /var/www/html/misc/user/logo-header.png
  subPath: logo-header.png
  {{- end }}

{{- end -}}

{{/*
volume for configs
*/}}
{{- define "matomo.config.volumes" -}}
- name: secret-config
  secret:
    secretName: {{ include "matomo.fullname" . }}-config
- name: config-volume
  emptyDir: {}
- name: config
  configMap:
    name: {{ include "matomo.fullname" . }}
  {{- if .Values.database.ssl.enabled }}
- name: db-certs
  secret:
    secretName: {{ include "matomo.fullname" . }}-db-certs
  {{- end }}
{{- end -}}

{{/*
initContainers for plugin and geoip download
*/}}
{{- define "matomo.custom.initContainers" -}}
  {{/* - if or .Values.plugins.custom.enabled .Values.geoip.enabled - */}}
initContainers:
- name: matomo-init
  image: alpine:3.12
  command: [sh, -c]
  args:
    - apk add curl unzip &&
      sh files/matomo-init.sh {{- if or .Values.geoip.enabled .Values.plugins.custom.enabled }} &&{{- end }}
  {{- if .Values.geoip.enabled }}
      sh files/update-ipdb.sh {{- if .Values.plugins.custom.enabled }} &&{{- end }}
  {{- end }}
  {{- if .Values.plugins.custom.enabled }}
      sh files/plugin-download.sh
  {{- end }}
  volumeMounts:
    {{- if .Values.plugins.custom.enabled }}
    - mountPath: /custom-plugins
      name: custom-plugins
    {{- end }}
    {{- if .Values.geoip.enabled }}
    - mountPath: /geoip
      name: geoip
    {{- end }}
    - name: files
      mountPath: /files
      readOnly: true
    - name: secret-config
      mountPath: /var/www/html/config/config.ini.php
      subPath: config.ini.php
    - name: config-volume
      mountPath: /config
  env:
    - name: MATOMO_VERSION
      value: {{ (split "-" .Values.image.tag)._0 | quote }}
  envFrom:
    - secretRef:
        name: {{ include "matomo.fullname" . }}-envs
  {{- end -}}
{{/* - end - */}}

{{/*
volumes for custom components
*/}}
{{- define "matomo.custom.volumes" -}}
  {{- if or .Values.plugins.custom.enabled .Values.geoip.enabled -}}
- name: files
  configMap:
    name: {{ include "matomo.fullname" . }}
    defaultMode: 0555
  {{- end }}
  {{- if .Values.plugins.custom.enabled }}
- name: custom-plugins
  emptyDir: {}
  {{- end }}
  {{- if .Values.geoip.enabled }}
- name: geoip
  emptyDir: {}
  {{- end -}}
{{- end -}}

{{/*
volumeMounts for custom components
*/}}
{{- define "matomo.custom.volumeMounts" -}}
  {{- if .Values.plugins.custom.enabled }}
    {{- range .Values.plugins.custom.plugins }}
- name: custom-plugins
  mountPath: /var/www/html/plugins/{{ regexSplit ":" . -1 | first }}
  subPath: {{ regexSplit ":" . -1 | first }}
    {{- end }}
  {{- end }}
  {{- if .Values.geoip.enabled }}
    {{- range .Values.geoip.databases }}
- mountPath: /var/www/html/misc/{{ . }}.mmdb
  name: geoip
  subPath: {{ . }}.mmdb
    {{- end -}}
  {{- end -}}
{{- end -}}
