#!/bin/bash 

domain=$1
seed=$2

chmod 666 /etc/hosts

echo "##CleanIT($seed)" >> /etc/hosts
echo "192.168.99.100 $domain    ##CleanIT($seed)" >> /etc/hosts