#!/bin/bash
if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri=$4
	agent=$5
	dest=$6

	if [[ "debug" == "${!#}" ]]; then
		curl -v -X $method -H 'X-Forwarded-Proto: https' -A "$agent" "$domain$uri"
	fi

	actual_upstream=$(curl -v -X $method -H 'X-Forwarded-Proto: https' -A "$agent" "$domain$uri" 2>&1 | grep "X-Proxy-Host" | awk '{print $3}' | sed 's/[^(a-z|_)]//g') 
else
	method=$1
	domain=$2
	uri=$3
	agent=$4
	dest=$5

	if [[ "debug" == "${!#}" ]]; then
	  	curl -v -X $method -A "$agent" "$domain$uri"
	fi	

	actual_upstream=$(curl -v -X $method -A "$agent" "$domain$uri" 2>&1 | grep "X-Proxy-Host" | awk '{print $3}' | sed 's/[^(a-z|_)]//g') 
fi

if [[ "$dest" == "$actual_upstream" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_upstream]"
	exit -1
fi