# Base image for Java 11 JRE, Maven 3.x, NodeJS 16, NPM 8.x, MariaDB and Keycloak

Ubuntu based `Docker` image for running apps that need `Java`, `Maven`, `NodeJS`, `NPM`, `MariaDB` and `Keycloak`. Build for `amd64`, `arm64` and `arm/v7`.

## To use as base image

In your `Dockerfile`:

```docker
FROM mwalliczek/integration_test:latest
```
