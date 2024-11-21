FROM debian:bullseye

# Mettre à jour les paquets et installer MariaDB
RUN apt update && apt-get install -y mariadb-server mariadb-client vim

# Créer le répertoire pour les sockets (si nécessaire) et donner les permissions appropriées
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 777 /var/run/mysqld

# Copier le script d'initialisation
COPY ./tools/mariadb.sh /usr/local/bin/

# Donner les bonnes permissions d'exécution au script
RUN chmod +x /usr/local/bin/mariadb.sh

# Exposer le port MariaDB
EXPOSE 3306

# Copier la configuration MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Donner les permissions adéquates pour la configuration
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf

# Démarrer MariaDB en mode sécurisé
CMD ["mysqld"]
