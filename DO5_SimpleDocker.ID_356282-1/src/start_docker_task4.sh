#!/bin/bash
docker rmi -f nginx:task4
docker build . -f Dockerfile_task4 -t nginx:task4
docker run -d --rm --name mydocker_task4 -p 80:81 -v ./server/nginx/nginx.conf:/etc/nginx/nginx.conf nginx:task4
docker ps -a