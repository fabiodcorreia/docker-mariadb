# Docker MariaDB Image

![Maintenance](https://img.shields.io/maintenance/yes/2020?style=plastic) [![Drone Status](https://img.shields.io/drone/build/fabiodcorreia/docker-mariadb?style=plastic)](https://cloud.drone.io/fabiodcorreia/docker-mariadb) [![Latest Release](https://img.shields.io/github/v/release/fabiodcorreia/docker-mariadb?style=plastic)](https://github.com/fabiodcorreia/docker-mariadb/releases/latest) [![GitHub Licence](https://img.shields.io/github/license/fabiodcorreia/docker-mariadb?style=plastic)](https://github.com/fabiodcorreia/docker-mariadb/blob/master/LICENSE)


![MicroBadger Layers](https://img.shields.io/microbadger/layers/fabiodcorreia/mariadb?style=plastic) [![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/fabiodcorreia/mariadb?style=plastic)](https://hub.docker.com/r/fabiodcorreia/mariadb) [![Docker Pulls](https://img.shields.io/docker/pulls/fabiodcorreia/mariadb?style=plastic)](https://hub.docker.com/r/fabiodcorreia/mariadb) ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/fabiodcorreia/mariadb?sort=semver&style=plastic)

A custom Mariadb image build with Alpine Linux.

## Base Packages

- mariadb
- mariadb-client
- mariadb-server-utils


## Versioning

This image follows the [Semantic Versioning](https://semver.org/) pattern.

- **MAJOR** version - Changes on Base Image version (1.0.0 to 2.0.0)
- **MINOR** version - Changes on MariaDB version (10.4.13 to 10.4.14)
- **PATCH** version - Package updates and other non breaking changes on the image
- **DRAFT** version - Unstable build for review (Optional)

### Version Mapping

| Version    | 1.0     | 1.1     | 2.0     |
| :----:     | ---     | ---     | ----    |
| Base Image | 1.x.x   | 1.x.x   | 2.x.x   |
| MariaDB    | 10.4.13 | 10.4.14 | 10.4.13 |

When Base Image gets upgraded the major version is incremented, when MariaDB gets upgraded the minor version is incremented.

## Tags

| Tag | Description |
| :----: | --- |
| latest | Latest version |
| 1.0.0 | Specific patch version |
| 1.0 | Specific minor version |
| 1 | Specific major version |
| 1.0.0-`arch` | Specific patch version to that `arch` |
| 1.0-`arch` | Specific minor version to that `arch` |
| 1-`arch` | Specific major version to that `arch` |
| test | Branch version - **DO NOT USE** |

The version tags are the same as the repository versioning tags but without the `v`. The `test` version is only for build purposes, it should not be pulled.

The `arch` can be one of the supported architectures described below.

## Supported Architectures

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64 |
| arm64 | arm64v8 |
| armhf | arm32v7 |


## Environment Variables

| Name                | Description |
| :-----------------: | ----------- |
| PUID                | Set the UserID - [Details](https://github.com/fabiodcorreia/docker-base-alpine#userid--groupid) |
| PGID                | Set the GroupID - [Details](https://github.com/fabiodcorreia/docker-base-alpine#userid--groupid) |
| TZ                  | Set the system timezone - [Options](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List) |
| DATABASE_ROOT       | Set the database root password |
| DATABASE_NAME       | Set the name of the database to be created |
| DATABASE_USER       | Set the username for the database that will created |
| DATABASE_PASS       | Set the password for the database user that will created |
| REMOTE_SQL          | Set the list of SQL files from an http/https endpoint (comma separated array)|
| LOG_TO_FILE         | Enable logging to file, `false` by default |

## Volumes and Ports

It exposes a single volume at `/config` where it keeps the configuration, logs and database files.

Also a single port is exposed at 3306 to allow external connections to the database.

## Bootstrapping the database
It's possible to bootstrap the database executing sql files the first time the container starts, just need to put the sql files in:

`/config/initdb.d/`

The result is the same as setting the REMOTE_SQL environment variable but in this case it uses local files instead of http(s).

## Start Container

```bash
docker run \
  -e PUID=1000 \
  -e PGID=1000 \
  -e MYSQL_ROOT_PASSWORD=password.123 \
  -p 3306:3306 \
  -v $PWD:/config \
  fabiodcorreia/mariadb
```

## Logging

By default the container will log to the stdout (console), so it will be handled by the docker logging system, if logging to a file is preferred that
can be changed with the environment variable `LOG_TO_FILE`, when it' set to `true` it will log to `/config/log/mysql/error.log`.
