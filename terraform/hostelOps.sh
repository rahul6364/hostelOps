#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

sudo apt install git -y
sudo apt install docker.io -y
sudo apt install docker-compose -y



