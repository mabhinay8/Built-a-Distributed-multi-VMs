#!/bin/bash
set -xe

yum update -y
yum install -y git python3-pip

# Get your repo (replace URL)
cd /opt
git clone https://github.com/paramcodes/devops-infra.git
cd distributed-inference/app/gateway

pip3 install -r requirements.txt

# Export workers list from Terraform (injected as env)
echo "WORKERS=${WORKERS}" >> /etc/environment

# Simple systemd service or nohup
nohup python3 main.py > /var/log/gateway.log 2>&1 &