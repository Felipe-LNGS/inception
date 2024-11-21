#!/bin/sh

# Démarrer MariaDB (sans --skip-networking, car on veut des connexions réseau)
echo "Démarrage de MariaDB..."
mysqld --user=mysql &

# Attente explicite pour s'assurer que MariaDB est prêt
echo "En attente que MariaDB soit prêt..."
until mysqladmin -u root ping --silent; do
  sleep 1
done

# Créer la base de données si elle n'existe pas
echo "Création de la base de données..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

# Créer l'utilisateur si nécessaire
echo "Création de l'utilisateur..."
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Accorder tous les privilèges à l'utilisateur
echo "Accorder les privilèges..."
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

# Changer le mot de passe root
echo "Changement du mot de passe root..."
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# Appliquer les privilèges
mysql -u root -e "FLUSH PRIVILEGES;"

# Ne pas arrêter MariaDB, juste continuer à le faire fonctionner
echo "MariaDB prêt, démarrage de mysqld..."
exec mysqld
