# Étape 1 : Utilisation de debian:buster comme base
FROM debian:bullseye



# Étape 2 : Mise à jour des paquets et installation des dépendances
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget php7.4 php-fpm php-mysql mariadb-client tar curl

RUN apt-get -y install wget
# Étape 3 : Téléchargement et extraction de WordPress
RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.7-fr_FR.tar.gz && \
    rm wordpress-6.7-fr_FR.tar.gz

# Étape 4 : Donner les droits nécessaires
RUN chown -R root:root /var/www/wordpress

# Étape 5 : Configuration de PHP (fichier php-fpm.conf)
RUN sed -i "s/listen =.*/listen = wordpress:9000/" /etc/php/7.4/fpm/pool.d/www.conf && \
    echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

# Étape 6 : Installation de WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php

# Étape 7 : Ajout d'un script d'auto-configuration pour WordPress
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

# Expose le port 9000 pour PHP


WORKDIR /var/www/html/

EXPOSE 9000


CMD ["/usr/sbin/php-fpm7.4", "-F"]
