#!/usr/bin/env bash
# Script to set up web servers for deployment of web_static

# Install Nginx if it not already installed
sudo apt-get update
sudo apt-get -y install nginx

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create a fake HTML file
echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" | sudo tee /data/web_static/releases/test/index.html

# Create a symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Update the Nginx configuration to serve the content
config="server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location /hbnb_static {
        alias /data/web_static/current;
    }

    location / {
        try_files \$uri \$uri/ =404;
    }
}"
echo "$config" | sudo tee /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart
