#!/bin/bash
yum install -y nginx
systemctl enable nginx
systemctl status nginx
sed -i "s/nginx/$(hostname)/g" /usr/share/nginx/html/index.html
