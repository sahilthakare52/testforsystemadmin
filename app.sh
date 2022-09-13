#! /bin/bash

echo "make sure your user is either root or having sudo access"

sleep 5

echo "===================================================================================\n
      ==================================================================================="

echo "checking the prerequisites- nginx and docker installations..."
## checking if the nginx is installed if not install the nginx on server
sudo apt update -y
which nginx
output=$?
[ $output = 0 ] && echo "nginx is already installed moving to the next step" || sudo apt install nginx -y 

which docker
output=$?

[ $output = 0 ] && echo "docker is already installed moving to the next step" || sh docker_install.sh

echo "===================================================================================\n
      ==================================================================================="

##building the application using docker compose....

echo "building the application using docker compose......."

sudo docker compose up -d 

echo "===================================================================================\n
      ==================================================================================="

echo "Adding server block to transfer all the http requests to https for https://demo.algonquainlanguages.ca"      


## adding server block to transfer all the http requests to https for https://demo.algonquainlanguages.ca
sudo cp demo.conf /etc/nginx/conf.d/

echo "=================##############Installation successful#################"

echo " use curl localhost:9000 to check the website, also you can use serverIP:9000 to check the website"
