# php-stack

This Chart provides an all in one solution for PHP microservices used at Makaira. This includes:

- define extra deployments (for e.g. worker processes)
- define cronjobs (for repeated tasks such as db cleanups)
- a migration helm hook to migrate the database to the newest schema version (by default the symfony/doctrine command for migrations is used)
- the MariaDB helm chart from Bitnami
- a backup cronjob to backup the database
- defaults that are useful for PHP microservices (using port 80 for Apache2, www-data user by default)
- hardened pod and containers
  - by dropping unnecessary capabilities (e.g. `AUDIT_WRITE`, `SETPCAP`, `FOWNER`) `NET_BIND_SERVICE` is still enabled to allow port 80 for Apache2
  - by defining `podSecurityContext` without root privileges and 33 as user and group
  - by disabling `enableServiceLinks` and `automountServiceAccountToken`
