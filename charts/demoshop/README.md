# Demoshop
This chart can be used to set up a PHP via FastCGI, Nginx and Database (MySQL or MariaDB) stack.
You need to create an application images based on a PHP-FPM image (e.g. php:8.4-fpm).

## Prerequisites
- A Docker image containing a FastCGI service on port 9000 (e.g. PHP-FPM).
- `rysnc` for shared assets (see below)

## Values

| Parameter           | Type   | Default               | Description                                            |
|---------------------|--------|-----------------------|--------------------------------------------------------|
| `domain`            | string | `shop.k8s.makaira.io` | Domain under which the store is accessible.            |
| `imagePullSecrets`  | list   | `[]`                  | Image pull secrets to use.                             |
| `imagePullPolicy`   | string | `Always`              | Pull policy for all images.                            |
| `shop`              | dict   |                       | Shop settings                                          |
| `nginx`             | dict   |                       | Nginx settings                                         |
| `database`          | dict   |                       | Database settings                                      |

### Image Pull Secrets (`imagePullSecrets`)
| Parameter | Type   | Default | Description                        |
|-----------|--------|---------|------------------------------------|
| `name`    | string | `""`    | Name of the image pull secret.     |
| `repo`    | string | `""`    | Repository to use the secret with. |
| `auth`    | string | `""`    | Base64 encoded auth token.         |

### Shop settings (`shop`)
| Parameter      | Type   | Default     | Description                                             |
|----------------|--------|-------------|---------------------------------------------------------|
| `image.name`   | string | `"php"`     | Image repository and name                               |
| `image.tag`    | string | `"8.4-fpm"` | Image tag                                               |
| `sharedAssets` | dict   |             | Shared assets settings (see below)                      |
| `envVars`      | dict   | `{}`        | Environment variables for the shop (as key-value pairs) |
| `initCommands` | dict   | `[]`        | Commands to run on startup (see below)                  |
| `persistence`  | list   | `[]`        | Persistent volume settings (as list of dict, see below) |

### Shared assets settings (`shop.sharedAssets`)
| Parameter      | Type   | Default | Description                         |
|----------------|--------|---------|-------------------------------------|
| `enabled`      | bool   | `false` | Enable the feature                  |
| `storageClass` | string | `""`    | Storage class for persistent volume |
| `storageSize`  | string | `5Gi`   | Site for persistent volume          |

### Init commands (`shop.initCommands`)
| Parameter | Type   | Default | Description                |
|-----------|--------|---------|----------------------------|
| `name`    | string |         | Name of the command        |
| `user`    | string |         | User to run the command as |
| `command` | string |         | Command to run on startup  |

#### Example
If you need to run several commands in sequence, just use the default command splitter `;`:
```yaml
shop:
  initCommands:
    - name: "init-composer"
      command: "composer install --no-dev --prefer-dist --no-scripts --no-progress --no-interaction; php bin/console cache:clear"
```

Init commands are run as the default user (usually "root") of the container.
```yaml
shop:
  initCommands:
    - name: "migrate-db"
      command: "php bin/console doctrine migration migrate --no-interaction"
```

You can specify a different user for the command by setting the `user` field:
```yaml
shop:
  initCommands:
    - name: "init-composer"
      user: "www-data"
      command: "composer install --no-dev --prefer-dist --no-scripts --no-progress --no-interaction"
```

### Persistent volume settings (`shop.persistence`)
| Parameter      | Type   | Default | Description                  |
|----------------|--------|---------|------------------------------|
| `name`         | string |         | Name of the volume           |
| `path`         | string |         | Path to mount the volume to  |
| `storageClass` | string |         | Storage class for the volume |
| `storageSize`  | string |         | Size of the volume           |

### Nginx settings (`nginx`)
| Parameter    | Type   | Default                 | Description                                                    |
|--------------|--------|-------------------------|----------------------------------------------------------------|
| `image.name` | string | `"nginx"`               | Image repository and name                                      |
| `image.tag`  | string | `"stable"`              | Image tag                                                      |
| `locations`  | string | _Locations for FastCGI_ | Custom locations to finetune Nginx, see [Nginx documentation]. |

### Database settings (`database`)
| Parameter       | Type   | Default                   | Description                                           |
|-----------------|--------|---------------------------|-------------------------------------------------------|
| `image.name`    | string | `"mysql"`                 | Image repository and name                             |
| `image.tag`     | string | `"8.0"`                   | Image tag                                             |
| `name`          | string | `database`                | Name of the database to create.                       |
| `user`          | string | `username`                | Database user to create. **CHANGE THIS!**             |
| `password`      | string | `password`                | Password for the database user. **CHANGE THIS!**      |
| `rootPassword`  | string | `SetYourOwnRootPassword!` | Password for the database root user. **CHANGE THIS!** |
| `storageSize`   | string | `5Gi`                     | Size of the database persistent volume.               |
| `initialsDumps` | list   | `[]`                      | List of initial dumps to import.                      |

#### Initial dumps (`database.initialDumps`)
| Parameter   | Type   | Default | Description                                                   |
|-------------|--------|---------|---------------------------------------------------------------|
| `url`       | string |         | URL to the dump file.                                         |
| `auth`      | string |         | HTTP basic auth credentils (format: `<username>:<password>`). |
| `userAgent` | string |         | User agent to use for the download.                           |

## Shared Assets
You can serve assets such as Stylesheets, JavaScript files, images or even generated files via Nginx directly.
To use this feature you need to install `rsync`. Copy all assets to `/assets` and create symbolic links to the copies
at the source positions. The assets will be copied to a persistent volume and are served by Nginx directly.

[Nginx documentation]: http://nginx.org/en/docs/http/ngx_http_core_module.html#location
