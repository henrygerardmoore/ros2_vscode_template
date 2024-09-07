#!/bin/bash
# https://stackoverflow.com/questions/60379221/how-to-attach-a-remote-container-using-vscode-command-line

if [ -z ${CONTAINER_NAME+x} ]; 
then 
  CONTAINER_NAME=$(basename $(pwd))
fi

echo "Building workspace $CONTAINER_NAME..."
set -e
docker container rm -f $CONTAINER_NAME > /dev/null 2>&1
export COLCON_WS=$(pwd)
cd .devcontainer
export COMPOSE_PROJECT_NAME=$CONTAINER_NAME
export CONTAINER_NAME=$CONTAINER_NAME
docker build --no-cache --pull -t $CONTAINER_NAME:latest .
docker compose run -d --name $CONTAINER_NAME cpu
unset COLCON_WS
cd -
