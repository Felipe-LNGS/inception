FROM debian:bullseye

RUN apt update && apt upgrade && apt-get install mariadb-server -y && \
    mkdir -p /var/run/mysql /run/mysql && \
    chown -R mysql:root /run/mysql /var/run/mysql

# COPY ./tools/setup_database.sh ./

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT [ "bash", "setup_database.sh" ]