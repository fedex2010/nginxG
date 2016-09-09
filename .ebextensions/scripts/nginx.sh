#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions

/etc/init.d/nginx stop
cd /etc/nginx
cp nginx.conf nginx.back
cp $DIR_EBEXTEN/conf/nginx.conf .   

cd /etc/logrotate.d
cp $DIR_EBEXTEN/conf/docker .
chmod 644 docker

#Borro directorio temporal
#rm -rf $DIR_TMP
