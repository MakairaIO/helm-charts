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
| `shop.iamge`        | string | `php:8.4-fpm`         | Full name of the image (including repository and tag). |
| `shop.sharedAssets` | dict   |                       | Shared asset settings.                                 |
| `shop.nginx`        | dict   |                       | Nginx settings                                         |
| `database`          | dict   |                       | Database settings                                      |

### Shared assets settings (`shop.sharedAssets`)
| Parameter      | Type   | Default | Description                         |
|----------------|--------|---------|-------------------------------------|
| `enabled`      | bool   | `false` | Enable the feature                  |
| `storageClass` | string | `""`    | Storage class for persistent volume |
| `storageSize`  | string | `5Gi`   | Site for persistent volume          |

### Nginx settings (`nginx`)
| Parameter   | Type   | Default                 | Description                                                    |
|-------------|--------|-------------------------|----------------------------------------------------------------|
| `image`     | string | `nginx:stable`          | Image to use for the Nginx container.                          |
| `locations` | string | _Locations for FastCGI_ | Custom locations to finetune Nginx, see [Nginx documentation]. |

### Database settings (`database`)
| Parameter      | Type   | Default                   | Description                                           |
|----------------|--------|---------------------------|-------------------------------------------------------|
| `image`        | string | `mysql:8.0`               | Container image to use, can be `mysql` or `mariadb`.  |
| `name`         | string | `database`                | Name of the database to create.                       |
| `user`         | string | `username`                | Database user to create. **CHANGE THIS!**             |
| `password`     | string | `password`                | Password for the database user. **CHANGE THIS!**      |
| `rootPassword` | string | `SetYourOwnRootPassword!` | Password for the database root user. **CHANGE THIS!** |
| `storageSize`  | string | `5Gi`                     | Size of the database persistent volume.               |


## Shared Assets
You can serve static assets such as Stylesheets, JavaScript files, images or even generated files via Nginx directly.
All you need to do is install `rsync`, copy some files and create some symbolic links.

### Static Assets
_tbd._

[Nginx documentation]: http://nginx.org/en/docs/http/ngx_http_core_module.html#location
