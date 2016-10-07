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
/sbin/sysctl -n net.ipv4.tcp_max_syn_backlog = 3240000 
/sbin/sysctl -n net.ipv4.ip_local_port_range 1024 65000
/sbin/sysctl -n net.core.somaxconn = 65536
/sbin/sysctl -n net.ipv4.tcp_max_tw_buckets = 1440000

#Borro directorio temporal
#rm -rf $DIR_TMP
