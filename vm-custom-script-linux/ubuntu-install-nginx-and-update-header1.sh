#!/bin/bash

apt-get install  -y nginx 
sed -i "s/nginx/$(hostname)/g" /var/www/html/index.nginx-debian.html
