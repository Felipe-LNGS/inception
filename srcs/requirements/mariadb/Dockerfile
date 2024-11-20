FROM debian:bullseye

RUN apt update 
RUN apt-get install -y mariadb-server \
    mariadb-client \
    vim 

# Créer le répertoire pour les sockets
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# Copier le script personnalisé (si nécessaire)
COPY ./tools/mariadb.sh /usr/local/bin/

# Donner les bonnes permissions d'exécution
RUN chmod +x /usr/local/bin/mariadb.sh
# Exposer le port
EXPOSE 3306
# Copier la configuration MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Entrée pour démarrer MariaDB
ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]


