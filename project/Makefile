USER_PATH = /home/$(shell echo $$USER)/data
SECRETS_TAR = oops.tar.xz

all:  setup

setup: data extract datadir 
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env build

up: 
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

uplog: 
	docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up  --build

data:
	   mkdir -p $(USER_PATH)/mariadb \
		   && mkdir -p $(USER_PATH)/wordpress \
		   && mkdir -p $(USER_PATH)/portainer \
		   && mkdir -p $(USER_PATH)/redis

datadir:
	@if ! grep -q "DATA_PATH=" ./srcs/.env; then \
		echo "DATA_PATH=$(USER_PATH)" >> ./srcs/.env; \
	fi

extract:
	@if [ ! -d "secrets" ] || [ ! -f "srcs/.env" ]; then \
		echo "Extracting $(SECRETS_TAR)..."; \
		tar -xf $(SECRETS_TAR); \
	else \
		echo "Both 'secrets' folder and 'srcs/.env' file already exist. Skipping extraction."; \
	fi

vi:
	nvim $$(find . -type f -not -path "*/\.*")

clean: 
	docker-compose -f ./srcs/docker-compose.yml down
	
down: clean

fcleanimsure:
	@docker stop $$(docker ps -qa); \
		docker rm $$(docker ps -qa); \
		docker rmi -f $$(docker images -qa); \
		docker volume rm $$(docker volume ls -q); \
		docker network rm $$(docker network ls -q) 2>/dev/null

adminer:
	docker exec -it adminer sh

mariadb:
	docker exec -it mariadb sh

redis:
	docker exec -it redis redis-cli
	
###############################################

.PHONY: out
out:
	@touch outfile
	@rm outfile
	@find . -type f ! -name "outfile" ! -name "*.xz" | while read file; do \
		echo "### Starting file: $$file" >> outfile; \
		echo "" >> outfile; \
		cat "$$file" >> outfile; \
		echo "\n" >> outfile; \
	done

######################################## 
