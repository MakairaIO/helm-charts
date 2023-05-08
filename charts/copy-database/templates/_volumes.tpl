{{/*
volumeMount for configs
*/}}
{{- define "copy-database.config.volumeMounts" }}
- name: connection-config
  mountPath: /etc/copy-database/
  readOnly: true
{{- end -}}

{{/*
volume for configs
*/}}
{{- define "copy-database.config.volumes" }}
- name: connection-config
  secret:
    secretName: {{ include "copy-database.fullname" . }}-connection-config
{{- end -}}
