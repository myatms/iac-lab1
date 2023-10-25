#!/bin/bash
apt update -y
apt install nginx -y
chown ubuntu:ubuntu -R /var/www
rm -rf /var/www/html/*
chmod -R /var/www/
echo "Hello World 1" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx
