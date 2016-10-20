#!/bin/bash

dest_server=${1:-test-nginx}

cat ../proxy_env.conf | grep -v '^#' | sort | awk -v dest_server=$dest_server '$2 ~ /\$/ {split($2, upstream, "$");  print "--link "dest_server":"upstream[2] }' | uniq | tr '\n' ' '