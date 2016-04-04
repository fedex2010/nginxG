#!/bin/bash
if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri=$4
	dest=$5
	
	actual_rewrite_uri=$(curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri 2>/dev/null | jq -r '.url' ) 
else
	method=$1
	domain=$2
	uri=$3
	dest=$4
	
	actual_rewrite_uri=$(curl -v -X $method $domain$uri 2>/dev/null | jq -r '.url') 
fi

if [[ "$dest" == "$actual_rewrite_uri" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_rewrite_uri]"
	exit -1
fi