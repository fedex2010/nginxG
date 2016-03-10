#!/bin/bash

method=$1
domain=$2
uri=$3
dest=$4

capture_domain.sh $domain

actual_upstream=$(curl -v -X $method "$domain$uri" 2>&1 | grep "X-Proxy-Host: $dest" )

cp ./tmp/hosts.capture.bak /etc/hosts
chmod 444 /etc/hosts

if [[ -z "$actual_upstream" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_upstream]"
	exit -1
fi