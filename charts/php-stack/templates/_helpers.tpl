{{/*
Name of the Secret holding the mariadb credentials.

Must equal what the cloudpirates/mariadb subchart would have generated for itself
(its `mariadb.fullname`), so that switching to a php-stack-rendered Secret leaves the
StatefulSet's secretKeyRef untouched and does not restart the database pod.

That is `mariadb.fullnameOverride` when set — which is how consumers give the new
instance a distinct name during a migration — otherwise "<release>-mariadb".
*/}}
{{- define "php-stack.mariadb.secretName" -}}
{{- if .Values.mariadb.fullnameOverride -}}
{{- .Values.mariadb.fullnameOverride -}}
{{- else -}}
{{- printf "%s-mariadb" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Password for the mysqld-exporter user.

Prefer an explicit `mariadb.auth.metricsPassword`. When unset, derive a stable value
from the root password so that every render produces the same result — the whole point
is to avoid the subchart's `randAlphaNum`, which changes on every ArgoCD render and
eventually breaks the exporter against an already-initialised database.

Deriving is one-way (sha256), so the exporter password does not disclose the root one.
Existing deployments that already set metricsPassword explicitly keep their value, which
matters because the exporter user in a live database was created with it.
*/}}
{{- define "php-stack.mariadb.metricsPassword" -}}
{{- if .Values.mariadb.auth.metricsPassword -}}
{{- .Values.mariadb.auth.metricsPassword -}}
{{- else -}}
{{- printf "%s-mysqld-exporter" (required "mariadb.auth.rootPassword is required" .Values.mariadb.auth.rootPassword) | sha256sum | trunc 32 -}}
{{- end -}}
{{- end -}}
