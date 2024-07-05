#!/bin/bash
# https://stackoverflow.com/questions/60379221/how-to-attach-a-remote-container-using-vscode-command-line

CONTAINER_NAME=ros2_ws
set -e
docker container rm -f $CONTAINER_NAME
cd .devcontainer
docker build --no-cache . -t $CONTAINER_NAME:latest
docker compose run -d --name $CONTAINER_NAME cpu
cd -
