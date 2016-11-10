#!/bin/bash
if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri=$4
	header=$5
	expected_value=$6

	if [[ "debug" == "${!#}" ]]; then
	  	curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri
	fi	

	actual_header_value=$(curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri 2>/dev/null | jq -r ".headers.\"$header\"" ) 
else
	method=$1
	domain=$2
	uri=$3
	header=$4
	expected_value=$5

	if [[ "debug" == "${!#}" ]]; then
	  	curl -v -X $method $domain$uri
	fi	
	
	actual_header_value=$(curl -v -X $method $domain$uri 2>/dev/null | jq -r ".headers.\"$header\"") 
fi

if [[ "$expected_value" == "$actual_header_value" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri and expecting $expected_value but get [$actual_header_value]"
	exit -1
fi