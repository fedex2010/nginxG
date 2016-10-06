#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions

/etc/init.d/nginx stop
cd /etc/nginx
cp nginx.conf nginx.back
cp $DIR_EBEXTEN/conf/nginx.conf .   

echo "fs.file-max = 70000" >> /etc/security/limits.conf
echo "nginx soft nofile 10000" >> /etc/security/limits.conf
echo "nginx hard nofile 50000" >> /etc/security/limits.conf

/sbin/sysctl -p

#Borro directorio temporal
#rm -rf $DIR_TMP
