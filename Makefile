SRCS_DIR		:=	srcs

COMPOSE_FILE	:=	${SRCS_DIR}/docker-compose.yml

NAME			:=	inception

FLAGS			:=	-f ${COMPOSE_FILE} \
					-p ${NAME}

all: run

run:
	@sudo mkdir -p /home/dpaccagn/data/wordpress
	@sudo mkdir -p /home/dpaccagn/data/mysql
	@sudo docker-compose ${FLAGS} up --build -d
	@echo "$(shell tput setaf 29)Docker services up √\n$(shell tput sgr0)"

start:
	@sudo docker-compose ${FLAGS} start > /dev/null
	@echo "$(shell tput setaf 29)Docker services started √\n$(shell tput sgr0)"

stop:
	@sudo docker-compose ${FLAGS} stop > /dev/null
	@echo "$(shell tput setaf 59)Docker services stopped √\n$(shell tput sgr0)"

status:
	@sudo docker-compose ${FLAGS} ps

clean :
	@sudo docker-compose ${FLAGS} down -v
	@sudo docker stop $(docker ps -aq)
	@sudo docker rm $(docker ps -aq)
	@echo "$(shell tput setaf 59)Docker services down and cleaned √\n$(shell tput sgr0)"

armageddon : clean
	@sudo docker network prune -f
	@sudo docker rmi -f $(sudo docker images --filter dangling=true -qa)
	@sudo docker volume rm $(sudo docker volume ls --filter dangling=true -q)
	@sudo docker rmi -f $(sudo docker images -qa)
	sudo rm -rf /home/dpaccagn/data/wordpress
	sudo rm -rf /home/dpaccagn/data/mysql

re: armageddon run

.PHONY: run start stop status clean armageddon
