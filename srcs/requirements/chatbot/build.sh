#!/bin/sh

yum --assumeyes install --installroot $MNT python3
pip3 install --prefix=$MNT/usr/ Flask flask-cors nltk pyyaml requests uwsgi

rm -rf $MNT/var/cache $MNT/var/log/*

cp chatbot.py $MNT/
cp chat.html $MNT/
cp $MNT/ /home/dpaccagn/data/chatbot_data/

#buildah config --port 9500/tcp $CONTAINER
docker config --entrypoint 'uwsgi --http :9500 --manage-script-name --mount /=chatbot:app' $CONTAINER

docker commit $CONTAINER cherdt/nltk-chatbot
