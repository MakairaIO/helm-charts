# [php-stack-v2.4.1](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.4.0...php-stack-v2.4.1) (2023-09-20)


### Bug Fixes

* remove default scurity context ([013ec55](https://github.com/MakairaIO/helm-charts/commit/013ec551bc14d141fa7a7e09ef8a2f8af2fdd877))

# [php-stack-v2.4.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.3.0...php-stack-v2.4.0) (2023-07-07)


### Features

* Add suspend option ([9daf8e9](https://github.com/MakairaIO/helm-charts/commit/9daf8e90c9780a94764540645314bfac6dda26f3))

# [php-stack-v2.3.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.2.1...php-stack-v2.3.0) (2023-05-31)


### Features

* **db-copy:** Create copy job as CronJob ([f99df2e](https://github.com/MakairaIO/helm-charts/commit/f99df2eea5f9786c0750cd21d989786de4e6a2f1))

# [php-stack-v2.2.1](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.2.0...php-stack-v2.2.1) (2022-09-05)


### Bug Fixes

* add -n for doctrine migration ([1c48b2b](https://github.com/MakairaIO/helm-charts/commit/1c48b2b5a4517b847fb6be5cfb21052c7a37da38))

# [php-stack-v2.2.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.1.3...php-stack-v2.2.0) (2022-08-19)


### Features

* add charts ([9aac6b4](https://github.com/MakairaIO/helm-charts/commit/9aac6b40b04de04960dfec8af8f7e9bec42ba252))

# [php-stack-v2.1.3](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.1.2...php-stack-v2.1.3) (2022-08-18)


### Bug Fixes

* add default for matchLabels ([6e3f2e3](https://github.com/MakairaIO/helm-charts/commit/6e3f2e3f8b28cb08c41b9447ee46f4252c7dadef))
* add nameOverride for deployments and cronjobs ([ce4d1cb](https://github.com/MakairaIO/helm-charts/commit/ce4d1cb3ae5d1b20e9da108e3fb292e139d8e856))
* add service monitor discover label ([2c87b44](https://github.com/MakairaIO/helm-charts/commit/2c87b4407dc81a7ba5ad11e2dd0c432c5ca4368c))
* remove service monitor labels ([4a693f4](https://github.com/MakairaIO/helm-charts/commit/4a693f4dbbb78b1c0fdcffd307b3bb9a39aec008))

# [php-stack-v2.1.2](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.1.1...php-stack-v2.1.2) (2022-08-18)


### Bug Fixes

* update redis condition ([f7f5985](https://github.com/MakairaIO/helm-charts/commit/f7f5985cc2ec593bd4b00889802979aade041301))

# [php-stack-v2.1.1](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.1.0...php-stack-v2.1.1) (2022-08-18)


### Bug Fixes

* do not use all secrets for backup cronjob ([4d189fd](https://github.com/MakairaIO/helm-charts/commit/4d189fd104f69b4431c5f285bcce1ce5eade5bf6))

# [php-stack-v2.1.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v2.0.0...php-stack-v2.1.0) (2022-08-18)


### Features

* add redis chart ([760010f](https://github.com/MakairaIO/helm-charts/commit/760010f8d708453c37c6d0dfb0f3ead9da69b7eb))

# [php-stack-v2.0.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.2.5...php-stack-v2.0.0) (2022-08-18)


### Features

* switch to custom backup cronjob ([13d43f3](https://github.com/MakairaIO/helm-charts/commit/13d43f3377726fab624721f21563a14a4da0c023))


### BREAKING CHANGES

* update backup keys

# [php-stack-v1.2.5](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.2.4...php-stack-v1.2.5) (2022-08-18)


### Bug Fixes

* disable service and probes for cronjobs ([a75c74e](https://github.com/MakairaIO/helm-charts/commit/a75c74e9f8ee7c13bb82bef46f1a9cbf590f64e4))

# [php-stack-v1.2.4](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.2.3...php-stack-v1.2.4) (2022-08-18)


### Bug Fixes

* enable allowPrivilegeEscalation ([10a708b](https://github.com/MakairaIO/helm-charts/commit/10a708b1b59be00a4f37e9ff09dfae0461d8327d))

# [php-stack-v1.2.3](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.2.2...php-stack-v1.2.3) (2022-08-18)


### Bug Fixes

* change group and user to 33 ([a096302](https://github.com/MakairaIO/helm-charts/commit/a09630276b2a0634a11ad0e5210dc4294f0daed5))

# [php-stack-v1.2.2](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.2.1...php-stack-v1.2.2) (2022-08-18)


### Bug Fixes

* only print PORT if service is enabled ([cbd3154](https://github.com/MakairaIO/helm-charts/commit/cbd3154817742e9483dd0eb9349e85ba7cd0ba63))

# [php-stack-v1.2.1](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.2.0...php-stack-v1.2.1) (2022-08-18)


### Bug Fixes

* disable readOnlyRootFilesystem ([2156971](https://github.com/MakairaIO/helm-charts/commit/2156971978432839603c8fe455313c9005c7c27b))

# [php-stack-v1.2.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.1.3...php-stack-v1.2.0) (2022-08-18)


### Features

* add service and ingress support to deployments ([4d335db](https://github.com/MakairaIO/helm-charts/commit/4d335db937595f6568495fd94a7865e8b7366ad2))

# [php-stack-v1.1.3](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.1.2...php-stack-v1.1.3) (2022-08-18)


### Bug Fixes

* change default container port to 80 ([d9554b6](https://github.com/MakairaIO/helm-charts/commit/d9554b6a357ba2efaf9f17c35cc17cc963e578c3))

# [php-stack-v1.1.2](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.1.1...php-stack-v1.1.2) (2022-08-17)


### Bug Fixes

* update cronjob schedule ([fc098fb](https://github.com/MakairaIO/helm-charts/commit/fc098fbbcac1f11be6b9c7a5fb80730a0ce64b17))

# [php-stack-v1.1.1](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.1.0...php-stack-v1.1.1) (2022-08-17)


### Bug Fixes

* **cronjob:** update default schedule ([2ab66ff](https://github.com/MakairaIO/helm-charts/commit/2ab66ff4b308eb6be692f059a289434aeebdc706))

# [php-stack-v1.1.0](https://github.com/MakairaIO/helm-charts/compare/php-stack-v1.0.0...php-stack-v1.1.0) (2022-08-17)


### Features

* add php-stack chart ([7166714](https://github.com/MakairaIO/helm-charts/commit/716671481e73f473819c2931c2f23d52a2aef216))
