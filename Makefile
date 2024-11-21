# Création des répertoires si nécessaire
mkdir:
	mkdir -p /home/felipe/data/mysql
	mkdir -p /home/felipe/data/wordpress

# Construction des conteneurs
build:
	@docker-compose -f ./srcs/docker-compose.yml build

# Lancement des conteneurs
up:
	@docker-compose -f ./srcs/docker-compose.yml up

# Arrêt et nettoyage des conteneurs
down:
	@docker-compose -f ./srcs/docker-compose.yml down --volumes --remove-orphans

# Nettoyage des ressources inutilisées
clean:
	@docker system prune -af
	@docker volume prune -f

# Nettoyage complet
fclean: down clean
	@sudo rm -rf /home/felipe/data
