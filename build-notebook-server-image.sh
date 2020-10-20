#!/usr/bin/env bash

# Builds the docker image we use to run our local notebook server.  This is a
# convenient way to package up and run a jupyter notebook server that has
# dependencies we want already installed.
source notebook-server-docker-vars.sh
docker build -f notebook-server.Dockerfile -t $IMAGE_NAME .
