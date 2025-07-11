#!/bin/bash

#debug
#set -x

#main
gcc hello_fcgi.c -lfcgi -o hello_world
spawn-fcgi -p 8080 ./hello_world
nginx -g 'daemon off;'