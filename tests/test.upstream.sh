#!/bin/bash

method=$1
domain=$2
uri=$3
dest=$4

actual_upstream=$(docker run --link garba-nginx:$domain test-nginx curl -v -X $method "$domain$uri" 2>&1 | grep "X-Proxy-Host: $dest" )

if [[ -n "$actual_upstream" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_upstream]"
	exit -1
fi