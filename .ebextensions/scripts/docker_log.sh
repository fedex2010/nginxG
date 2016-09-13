#!/bin/bash

DOCKER=$(/usr/bin/docker ps --no-trunc -q)

cd /var/lib/docker/containers/$DOCKER

yes | cp -n /dev/null $DOCKER-json.log
