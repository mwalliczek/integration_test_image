# Base image for Java 22 JRE, Maven 3.x, NodeJS 16, NPM 8.x, Google Chrome, MariaDB and Keycloak

Ubuntu based `Docker` image for running apps that need `Java`, `Maven`, `NodeJS`, `NPM`, `Google Chrome`, `MariaDB` and `Keycloak`. Build for `amd64`.

## To use as base image

In your `Dockerfile`:

```docker
FROM mwalliczek/integration_test:latest
```
