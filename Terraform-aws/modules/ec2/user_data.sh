#!/bin/bash
apt update -y
apt install -y nginx
echo "<html><body><h1>${private_ip} - ${availability_zone}</h1></body></html>" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx

