## cert-manager-cloudflare

### Usage
```yaml Chart.yaml
apiVersion: v2
name: cert-manager
description: A Helm chart for Kubernetes
type: application
version: 1.0.0
appVersion: 1.0.0
dependencies:
  - name: cert-manager-cloudflare
    version: ^1.0
    repository: https://charts.makaira.io/
```

### Configuration
```yaml
apiToken: ""                                           # Token for Cloudflare API
adminEmail: ""                                         # Email of the admin user

issuers:
- name: example                                        # Name of the issuer
  url: https://acme-v02.api.letsencrypt.org/directory  # URL of the ACME server
  email: user@example.com                              # Email of the user
```
