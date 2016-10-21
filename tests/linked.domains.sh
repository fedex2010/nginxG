#!/bin/bash

ssl_domains=$(cat *.cases | grep -v '^#' | sort | awk '$2=="ssl" { print "--link garba-nginx:"$4 }' | uniq | tr '\n' ' ')
no_ssl_domains=$(cat *.cases | grep -v '^#' | sort | awk '$2!="ssl" { print "--link garba-nginx:"$3 }' | uniq | tr '\n' ' ')
upstreams=$(./linked.upstreams.sh)

linked_domains=$(echo "$ssl_domains $no_ssl_domains $upstreams")
echo $linked_domains