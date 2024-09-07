#!/bin/bash

# setup env variables
if [ -z ${CONTAINER_NAME+x} ]; 
then 
  export CONTAINER_NAME=$(basename $(pwd))
fi
export COLCON_WS=$(pwd)
export COMPOSE_PROJECT_NAME=$CONTAINER_NAME

echo "Building workspace $CONTAINER_NAME in $COLCON_WS..."

set -e
docker container rm -f $CONTAINER_NAME > /dev/null 2>&1
cd .devcontainer
docker build --no-cache --pull -t $CONTAINER_NAME:latest .
docker compose run -d --name $CONTAINER_NAME cpu
unset COLCON_WS
cd -
