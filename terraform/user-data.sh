#!/bin/bash

sudo apt-get update -y
sudo apt-get install python3-pip -y
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get install -y ansible