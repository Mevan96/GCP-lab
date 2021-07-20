#!bin/bash
sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo 'Hello from Yauhen Mikhalchuk!' > /usr/share/nginx/html/index.html 