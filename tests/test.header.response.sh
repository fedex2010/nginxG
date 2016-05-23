#!/bin/bash
if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri=$4
	header=$5
	value=$6

	actual_value=$(curl -I -X $method -H 'X-Forwarded-Proto: https' $domain$uri 2>/dev/null | grep "$header" | awk '{print $2}' | tr -d '\r') 
else
	method=$1
	domain=$2
	uri=$3
	header=$4
	value=$5

	actual_value=$(curl -I -X $method -H 'X-Forwarded-Proto: http' $domain$uri 2>/dev/null | grep "$header" | awk '{print $2}' | tr -d '\r') 
fi

if [[ "$value" == "$actual_value" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $header : $value but get [$actual_value]"
	exit -1
fi