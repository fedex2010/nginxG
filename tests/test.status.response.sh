#!/bin/bash
if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri=$4
	dest=$5

	if [[ "debug" == "${!#}" ]]; then
	  	curl -I -X $method -H 'X-Forwarded-Proto: https' $domain$uri
	fi	

	actual_status=$(curl -I -X $method -H 'X-Forwarded-Proto: https' $domain$uri 2>/dev/null | grep "HTTP/1.1" | awk '{print $2}') 
else
	method=$1
	domain=$2
	uri=$3
	dest=$4

	if [[ "debug" == "${!#}" ]]; then
	  	curl -I -X $method $domain$uri
	fi	
	
	actual_status=$(curl -I -X $method -H 'X-Forwarded-Proto: http' $domain$uri 2>/dev/null | grep "HTTP/1.1" | awk '{print $2}') 
fi

if [[ "$dest" == "$actual_status" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $dest but get [$actual_status]"
	exit -1
fi