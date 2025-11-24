#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2

echo "<h1>Deployed via Terraform! </h1>" > /var/www/html/index.html
