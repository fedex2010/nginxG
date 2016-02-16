#!/bin/sh 
method=$1
domain=$2
uri=$3
dest=$4

capture_domain.sh $domain

actual_dest=$(curl -X $method "$domain$uri" 2>/dev/null | jq -r '.host + .url')

cp ./tmp/hosts.capture.bak /etc/hosts
chmod 444 /etc/hosts

if [[ "$dest" == "$actual_dest" ]]; then
	echo 'OK';
else
	echo "Fail! Expecting $dest but get $actual_dest";
	exit -1;
fi