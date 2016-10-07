#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions

#/etc/init.d/nginx stop
cd /etc/nginx
cp nginx.conf nginx.back
cp $DIR_EBEXTEN/conf/nginx.conf .   

grep -q "fs.file-max" /etc/security/limits.conf
if [ $? == 1 ]
then
	echo "fs.file-max = 70000" >> /etc/security/limits.conf
fi

grep -q "nginx soft" /etc/security/limits.conf
if [ $? == 1 ]
then
	echo "nginx soft nofile 10000" >> /etc/security/limits.conf
fi

grep -q "nginx hard" /etc/security/limits.conf
if [ $? == 1 ]
then
	echo "nginx hard nofile 50000" >> /etc/security/limits.conf
fi

/sbin/sysctl -n net.ipv4.tcp_fin_timeout=30

#Borro directorio temporal
#rm -rf $DIR_TMP
