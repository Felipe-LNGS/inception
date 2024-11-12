FROM debian:bullseye

RUN apt update && apt upgrade && apt-get install mariadb-server -y && \
    mkdir -p /var/run/mysql /run/mysql && \
    chown -R mysql:root /run/mysql /var/run/mysql

COPY ./tools/setup_database.sh ./

ENTRYPOINT [ "bash", "setup_database.sh" ]