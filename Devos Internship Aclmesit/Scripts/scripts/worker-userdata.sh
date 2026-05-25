#!/bin/bash
set -xe

yum update -y
yum install -y git python3-pip

cd /opt
git clone https://github.com/paramcodes/devops-infra.git
cd distributed-inference/app/worker

pip3 install -r requirements.txt

nohup python3 main.py > /var/log/worker.log 2>&1 &