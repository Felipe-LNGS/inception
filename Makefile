
mkdir 

docker compose -f ./srcs/docker-compose.yml build
docker compose -f ./srcs/docker-compose.yml up
docker compose -f ./srcs/docker-compose.yml down


docker system prune -af
docker volume prune -f


fclean:
	docker compose -f ./srcs.docker-compose.yml down --volume --remove-orphans
	sudo rm -rf VOLUMES