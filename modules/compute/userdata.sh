#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>HA WebApp from $(hostname -f)</h1>" > /var/www/html/index.html
