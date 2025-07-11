#!/bin/bash
docker rmi -f nginx:task5
docker build . -f Dockerfile_task5 -t nginx:task5
dockle nginx:task5
docker run -d --rm --name mydocker_task5 -p 80:81 -v ./server/nginx/nginx.conf:/etc/nginx/nginx.conf nginx:task5
docker ps -a
docker logs mydocker_task5