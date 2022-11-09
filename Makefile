SRCS_DIR		:=	srcs

COMPOSE_FILE	:=	${SRCS_DIR}/docker-compose.yml

NAME			:=	inception

FLAGS			:=	-f ${COMPOSE_FILE} \
					-p ${NAME}

all: run

run:
	@sudo mkdir -p /home/dpaccagn/data/wordpress
	@sudo mkdir -p /home/dpaccagn/data/mysql
	@sudo echo "127.0.0.1	dpaccagn.42.fr" >> /etc/hosts
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
	@sudo docker-compose ${FLAGS} down -v && cd -
	@echo "$(shell tput setaf 59)Docker services down and cleaned √\n$(shell tput sgr0)"

fclean : clean
	@sudo docker network prune -f
	sudo rm -rf /home/dpaccagn/data/wordpress
	sudo rm -rf /home/dpaccagn/data/mysql
	@echo "$(shell tput setaf 59)Home directories deleted √\n$(shell tput sgr0)"

re: fclean run

.PHONY: run start stop status clean fclean

