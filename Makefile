COMPOSE_FILE = srcs/docker-compose.yml

make: up

re: fclean make

up:
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

clean: down
	docker compose -f $(COMPOSE_FILE) down -v

fclean: clean
	docker image rm srcs-mariadb

.PHONY: make re up down clean fclean
