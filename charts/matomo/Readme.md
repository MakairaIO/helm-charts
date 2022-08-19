Source: [t3n/helm-charts](https://github.com/t3n/helm-charts/tree/master/matomo) Commit: [cf1c7d2](https://github.com/t3n/helm-charts/commit/cf1c7d2b166c5d52caed6e4e96619aab710aa824)

Changes made to original chart: 
- Add `plugin-download.sh` in [scripts](scripts)
- Add `plugins` and `config` section in [values.yaml](values.yaml)
- Add `config.ini.php` in [templates/secret-config.yaml](templates/secret-config.yaml)
- Add `initContainers` in [templates/deployment.yaml](templates/deployment.yaml), [templates/cronjob-archive.yaml](templates/cronjob-archive.yaml) and [templates/_pod.tpl](templates/_pod.tpl)
- Add additional `volumes` and `volumeMounts` in [templates/deployment.yaml](templates/deployment.yaml), [templates/cronjob-archive.yaml](templates/cronjob-archive.yaml) and [templates/_pod.tpl](templates/_pod.tpl)
- Add `license_key` to values.yaml and [templates/secret.yaml](templates/secret.yaml)
- Edit `update-ipdb.sh` in [scripts](scripts) to support the maxmind database
- Add `geoip` section to values.yaml
- Add `MATOMO_MAXMIND_LICENSE` to [templates/secret.yaml](templates/secret.yaml)
- Add `backoffLimit` and `activeDeadlineSeconds` for archive job [templates/cronjob-archive.yaml](templates/cronjob-archive.yaml)
- Add `_pod.tpl` in order to make code more reusable for [templates/deployment.yaml](templates/deployment.yaml), [templates/cronjob-archive.yaml](templates/cronjob-archive.yaml)
- Update [templates/horizontalpodautoscaler.yaml](templates/horizontalpodautoscaler.yaml) to `v2beta2` and add memory based scaling