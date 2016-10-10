#!/bin/bash

echo "Hello" > /home/ubuntu/hello.txt
sudo apt-get update -y
sudo apt-get install -y apache2

sudo systemct1 enable apache2
sudo systemct1 start apache2

