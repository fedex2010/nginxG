#!/bin/sh 

domain=$1

if [[ -f ./tmp/hosts.capture.bak ]]; then
	rm ./tmp/hosts.capture.bak
fi
cp /etc/hosts ./tmp/hosts.capture.bak
chmod 666 /etc/hosts

echo >> /etc/hosts
echo "127.0.0.1 $domain" >> /etc/hosts