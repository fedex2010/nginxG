#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions

/etc/init.d/nginx stop
cd /etc/nginx
cp nginx.conf nginx.back
cp $DIR_EBEXTEN/conf/nginx.conf .   

#Instalo awslogs, solo instalo si el ambiente es prod
docker_id=$(docker ps -q)
env=$(docker exec $docker_id env | grep APP_ENV | cut -d = -f2)

if [ $env == "prod" ]
then
	rpm -qa | grep  awslogs
	if [ $? -eq 1 ]
	then
		yum update -y
		yum install -y awslogs
	fi

	#Para iniciar luego de reboot
	chkconfig  awslogs on

	cd /etc/awslogs
	cp $DIR_EBEXTEN/conf/awslogs.conf .   

#rm -f /var/log/eb-docker/containers/eb-current-app/*.log

	/etc/init.d/awslogs start
fi

#Borro directorio temporal
rm -rf $DIR_TMP
