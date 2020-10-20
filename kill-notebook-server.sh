#!/usr/bin/env bash

source notebook-server-docker-vars.sh
docker kill $CONTAINER_NAME
