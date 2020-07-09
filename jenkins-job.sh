#!/bin/bash

DOCKER_MACHINE_IP="<<ip>>"
DOCKER_MACHINE_USER=magento

ssh $DOCKER_MACHINE_USER@$DOCKER_MACHINE_IP "mkdir -p ~/jenkins/workspace"
scp -r ./* $DOCKER_MACHINE_USER@$DOCKER_MACHINE_IP:~/jenkins/workspace/

ssh $DOCKER_MACHINE_USER@$DOCKER_MACHINE_IP "cp <<path to zip>> ~/jenkins/workspace/images/app/magento/"

ssh $DOCKER_MACHINE_USER@$DOCKER_MACHINE_IP "~/jenkins/workspace/build.sh -o url-replace"
ssh $DOCKER_MACHINE_USER@$DOCKER_MACHINE_IP "~/jenkins/workspace/build.sh -o build"
ssh $DOCKER_MACHINE_USER@$DOCKER_MACHINE_IP "~/jenkins/workspace/build.sh -o deploy"
