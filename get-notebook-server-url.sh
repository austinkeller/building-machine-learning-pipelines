#!/usr/bin/env bash

source notebook-server-docker-vars.sh

token=$(docker exec -it $CONTAINER_NAME cat /home/jovyan/.local/share/jupyter/runtime/notebook_cookie_secret)

echo "http://localhost:${JUPYTER_PORT:=8888}/?token=${token}"
