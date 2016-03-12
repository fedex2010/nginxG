#!/bin/bash
if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri=$4
	dest=$5
	
	actual_upstream=$(docker run --link garba-nginx:$domain test-nginx curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri 2>&1 | grep "X-Proxy-Host" | awk '{print $3}' | sed 's/[^(a-z|_)]//g') 
else
	method=$1
	domain=$2
	uri=$3
	dest=$4
	
	actual_upstream=$(docker run --link garba-nginx:$domain test-nginx curl -v -X $method $domain$uri 2>&1 | grep "X-Proxy-Host" | awk '{print $3}' | sed 's/[^(a-z|_)]//g') 
fi

if [[ "$dest" == "$actual_upstream" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_upstream]"
	exit -1
fi