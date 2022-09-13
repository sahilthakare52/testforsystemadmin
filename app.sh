#! /bin/bash

echo "checking the prerequisites- nginx and docker installations..."
## checking if the nginx is installed if not install the nginx on server
sudo apt-update -y
which nginx
output=$?
[ $output = 0 ] && echo "nginx is already installed moving to the next step" || sudo apt install nginx -y 

which docker
output=$?

[ $output = 0 ] && echo "docker is already installed moving to the next step" || sh docker_install.sh

##building the application using docker compose....

echo "building the application using docker compose......."

sudo docker compose up -d 

## adding server block to transfer all the http requests to https for https://demo.algonquainlanguages.ca
sudo touch /etc/nginx/conf.d/demo.conf
sudo echo "server {
    listen 80;
    server_name demo.algonquainlanguages.ca;
    return 301 https://demo.algonquainlanguages.ca$request_uri;
}" >> /etc/nginx/conf.d/demo.conf

sudo echo "server {
    listen 443 ssl;

    server_name demo.algonquainlanguages.ca;

    ssl_certificate ...;
    ssl_certificate_key ...;

    location / {
        proxy_pass http://127.0.0.1:9000;
    }
}" >> /etc/nginx/conf.d/demo.conf
