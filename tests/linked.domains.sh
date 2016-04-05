#!/bin/bash

ssl_domains=$(cat cases | grep -v '^#' | sort | awk '$2=="ssl" { print "--link garba-nginx:"$4 }' | uniq | tr '\n' ' ')
no_ssl_domains=$(cat cases | grep -v '^#' | sort | awk '$2!="ssl" { print "--link garba-nginx:"$3 }' | uniq | tr '\n' ' ')

linked_domains=$(echo "$ssl_domains $no_ssl_domains")
echo $linked_domains