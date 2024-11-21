#!/bin/bash

# Vérifier que WP-CLI est installé
if ! command -v wp &> /dev/null; then
  echo "WP-CLI n'est pas installé, aborting."
  exit 1
fi

# Attente que MariaDB soit prêt à accepter des connexions
until nc -z -v -w30 mariadb 3306; do
  echo "En attente que MariaDB soit prêt..."
  sleep 1
done

# Vérifier que les variables d'environnement nécessaires sont définies
if [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ]; then
  echo "Les variables d'environnement nécessaires (MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD) ne sont pas définies."
  exit 1
fi

# Configuration automatique de WordPress si le fichier wp-config.php n'existe pas
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  echo "Création du fichier wp-config.php..."

  # Créer le fichier wp-config.php avec les informations de la base de données
  wp config create --allow-root \
                   --dbname=$MYSQL_DATABASE \
                   --dbuser=$MYSQL_USER \
                   --dbpass=$MYSQL_PASSWORD \
                   --dbhost=mariadb:3306 --path='/var/www/wordpress'
else
  echo "wp-config.php existe déjà, saut de la création."
fi

# Lancer PHP-FPM
php-fpm7.4 -F
