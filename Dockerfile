FROM debian:testing

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -qy curl openssh-client openjdk-17-jre-headless mariadb-server chromium maven nginx
    
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash
RUN apt-get install --no-install-recommends -qy nodejs

# Setting up NodeJs
RUN npm install -g npm

#RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &&\
#    dpkg -i google-chrome-stable_current_amd64.deb; \
#	apt-get -fqy --no-install-recommends install 

#RUN apt-get install -qy wget unzip
#RUN wget https://github.com/keycloak/keycloak/releases/download/20.0.2/keycloak-20.0.2.zip
#RUN unzip keycloak-20.0.2.zip
#RUN rm keycloak-20.0.2.zip

RUN rm -rf /var/lib/mysql; \
	mkdir -p /var/lib/mysql /var/run/mysqld; \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld; \
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	chmod 777 /var/run/mysqld; \
# comment out a few problematic configuration values
	find /etc/mysql/ -name '*.cnf' -print0 \
		| xargs -0 grep -lZE '^(bind-address|log|user\s)' \
		| xargs -rt -0 sed -Ei 's/^(bind-address|log|user\s)/#&/'; \
# don't reverse lookup hostnames, they are usually another container
	printf "[mariadb]\nhost-cache-size=0\nskip-name-resolve\n" > /etc/mysql/mariadb.conf.d/05-skipcache.cnf; \
# Issue #327 Correct order of reading directories /etc/mysql/mariadb.conf.d before /etc/mysql/conf.d (mount-point per documentation)
	if [ -L /etc/mysql/my.cnf ]; then \
# 10.5+
		sed -i -e '/includedir/ {N;s/\(.*\)\n\(.*\)/\n\2\n\1/}' /etc/mysql/mariadb.cnf; \
	fi; \
	mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

# Command prompt
CMD /bin/bash
