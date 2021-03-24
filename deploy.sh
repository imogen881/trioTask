#!/bin/bash

#Create network
docker network create trio-task-network

#Build images
docker build -t trio-db db
docker build -t trio-flask-app flask-app

#Run database container (name is set as mysql in app.py file, not using -p as we don't want to publish it)
docker run -d --network trio-task-network --name mysql trio-db

#Run Flask app
docker run -d --network trio-task-network --name flask-app trio-flask-app

#Run Nginx container
docker run -d --network trio-task-network --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf -p 80:80 --name nginx nginx:alpine

#Show containers
docker ps