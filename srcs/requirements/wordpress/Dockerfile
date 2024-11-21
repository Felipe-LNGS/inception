FROM debian:bullseye

# Mise à jour et installation des dépendances
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y wget php7.4 php-fpm php-mysql mariadb-client tar curl netcat && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Création du répertoire /run/php avec les bonnes permissions
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Téléchargement et extraction de WordPress
RUN wget https://fr.wordpress.org/wordpress-6.7-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.7-fr_FR.tar.gz && \
    rm wordpress-6.7-fr_FR.tar.gz

# Donner les droits nécessaires à www-data
RUN chown -R www-data:www-data /var/www/wordpress

# Configuration de PHP
RUN [ ! -f /etc/php/7.4/fpm/pool.d/www.conf ] || sed -i "s/listen =.*/listen = wordpress:9000/" /etc/php/7.4/fpm/pool.d/www.conf && \
    echo "clear_env = no" >> /etc/php/7.4/fpm/pool.d/www.conf

# Installation de WP-CLI
RUN command -v wp || (wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp)

# Script d'auto-configuration pour WordPress
COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]

# Exposer le port 9000 pour PHP
WORKDIR /var/www/html/
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
