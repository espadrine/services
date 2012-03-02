#!/bin/bash

# clone repositories

git clone http://github.com/garden/tree /home/dom/tree
git clone http://github.com/garden/services /home/dom/services

# install service scripts

sudo cp /home/dom/services/tree /etc/init.d/
sudo cp /home/dom/services/update /etc/init.d/
sudo cp /home/dom/services/warden /etc/init.d/
sudo cp /home/dom/services/redirect /etc/init.d/

# generate HTTPS credentials

cd /home/dom/tree
openssl genrsa -aes256 -out https.key.tmp 1024
openssl rsa -in https.key.tmp -out https.key
openssl req -new -key https.key -out https.csr
openssl x509 -req -days 365 -in https.csr -signkey https.key -out https.crt
rm https.key.tmp

# start all services

sudo service redirect start
sudo service warden start
#sudo service update start