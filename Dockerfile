FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -qy curl wget unzip openssh-client openjdk-11-jre-headless mariadb-server maven chromium-browser
    
RUN curl -sL https://deb.nodesource.com/setup_16.x | sh
RUN apt-get install -qy nodejs

# Setting up NodeJs
RUN npm install -g npm@8.3.1

RUN wget https://github.com/keycloak/keycloak/releases/download/20.0.2/keycloak-20.0.2.zip
RUN unzip keycloak-20.0.2.zip
RUN rm keycloak-20.0.2.zip

# Command prompt
CMD /bin/bash
