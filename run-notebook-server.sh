#!/usr/bin/env bash

source notebook-server-docker-vars.sh

docker run -it --rm -d \
  --name $CONTAINER_NAME \
  -v "$HOME/.aws:/home/jovyan/.aws" \
  -e AWS_DEFAULT_REGION \
  -e AWS_ACCESS_KEY_ID \
  -e AWS_SECRET_ACCESS_KEY \
  -e AWS_REGION \
  -e AWS_SESSION_TOKEN \
  -e AWS_SECURITY_TOKEN \
  -v $SSH_AUTH_SOCK:/ssh-agent \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -p ${JUPYTER_PORT:=8888}:8888 \
  -p ${TENSORBOARD_PORT:=6006}:6006 \
  -v "${PWD}:/home/jovyan/work" \
  -w "/home/jovyan/work" \
  --shm-size 512m \
  $IMAGE_NAME "$@"

echo 'showing logs'
docker logs -f $CONTAINER_NAME &
