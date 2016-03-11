#!/bin/bash

method=$1
domain=$2
uri=$3
dest=$4

seed=$RANDOM

./capture_domain.sh $domain $seed

actual_upstream=$(curl -v -X $method "$domain$uri" 2>&1 | grep "X-Proxy-Host: $dest" )

sed -i.bak "/##CleanIT($seed)/d" /etc/hosts
chmod 444 /etc/hosts

if [[ -n "$actual_upstream" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_upstream]"
	exit -1
fi