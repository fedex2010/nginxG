#!/bin/bash
#Hay que incluir un parámetro extra en la key para asegurar que los caches no interfieren con otros tests (HACK)

if [[ "$1" == "ssl" ]]
then
	method=$2
	domain=$3
	uri1=$4
	uri2=$5
	dest=$6
	
	if [[ "debug" == "${!#}" ]]; then
		curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri1
		curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri2
	fi

	actual_rewrite_uri1=$(curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri1 2>/dev/null | jq -r '.url' ) 
	actual_rewrite_uri2=$(curl -v -X $method -H 'X-Forwarded-Proto: https' $domain$uri2 2>/dev/null | jq -r '.url' ) 
else
	method=$1
	domain=$2
	uri1=$3
	uri2=$4
	dest=$5
	
	if [[ "debug" == "${!#}" ]]; then
	  	curl -v -X $method $domain$uri1
	  	curl -v -X $method $domain$uri2
	fi	

	actual_rewrite_uri1=$(curl -v -X $method $domain$uri1 2>/dev/null | jq -r '.url') 
	actual_rewrite_uri2=$(curl -v -X $method $domain$uri2 2>/dev/null | jq -r '.url') 
fi

if [[ "$dest" == "$actual_rewrite_uri2" ]]; then
	echo -n ·
else
	echo
	echo "Fail! Calling ($method) $domain$uri2 and expecting $dest but get [$actual_rewrite_uri2]"
	exit -1
fi