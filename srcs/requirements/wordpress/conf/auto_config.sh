#!/bin/bash

# Attente pour que MariaDB soit prêt
sleep 10

# Configuration automatique de WordPress si le fichier wp-config.php n'existe pas
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  echo "Création du fichier wp-config.php..."
  
  # Créer le fichier wp-config.php avec les informations de la base de données
  wp config create --allow-root \
                   --dbname=$SQL_DATABASE \
                   --dbuser=$SQL_USER \
                   --dbpass=$SQL_PASSWORD \
                   --dbhost=mariadb:3306 --path='/var/www/wordpress'
else
  echo "wp-config.php existe déjà, saut de la création."
fi
# Lancer PHP-FPM
php-fpm7.4 -F