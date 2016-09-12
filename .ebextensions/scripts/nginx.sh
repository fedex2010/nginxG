#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions

/etc/init.d/nginx stop
cd /etc/nginx
cp nginx.conf nginx.back
cp $DIR_EBEXTEN/conf/nginx.conf .   

cd /etc
cp $DIR_EBEXTEN/conf/log_rotate_docker.conf .
chmod 644 log_rotate_docker.conf

cd /etc/cron.hourly
cp $DIR_EBEXTEN/conf/cron.logrotate.dockerlogs.conf .
chmod 755 cron.logrotate.dockerlogs.conf

#Borro directorio temporal
#rm -rf $DIR_TMP
