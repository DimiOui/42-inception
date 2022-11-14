FROM debian:buster

RUN		apt update
RUN		apt install -y gcc \
		python3 \
		python3-dev \
		python3-pip

RUN /usr/bin/pip3 install Flask flask-cors nltk pyyaml requests uwsgi

COPY conf/chat.html ./
COPY conf/chatbot.py ./

EXPOSE 9500

CMD ["/usr/local/bin/uwsgi", "--http", ":9500", "--manage-script-name", "--mount", "/=chatbot:app"]
