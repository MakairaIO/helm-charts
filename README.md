# MakairaIO helm-charts

In this repository ou can find custom helm-charts that are used at Makaira.

## Charts inside this repository
### matomo
We are using Matomo for our analytics. For that, we adjusted the matomo chart from t3n to our own needs and published it here.

### php-stack
We created a chart that is used for all of our custom PHP microservices. We needed a flexibile solution that offer support for workers, cronjobs, migrations and some other things. These and more features are provided by this chart. 

*It is based on the common chart from k8s-at-home, the MariaDB and the the Redis chart by Bitnami.*

More information about this chart can be found inside the [readme](/charts/php-stack) of the chart.

## How to use this repository

### Add the repository to your Helm repositories
```bash
helm repo add makaira https://charts.makaira.io
```

### Reference the chart inside your Chart.yaml as a dependency
```yaml
dependencies:
  - name: php-stack
    version: 2.2.0
    repository: https://charts.makaira.io
    alias: example-deployment
```
