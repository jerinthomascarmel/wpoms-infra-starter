#!/bin/bash

curl -fsSL get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh


# Allow using docker without sudo
sudo usermod -aG docker $(whoami)

sudo service docker restart 
sudo systemctl enable docker