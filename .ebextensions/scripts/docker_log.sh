#!/bin/bash

DOCKER=$(/usr/bin/docker ps --no-trunc -q)

cd /var/lib/docker/containers/$DOCKER

yes | cp /dev/null $DOCKER-json.log
