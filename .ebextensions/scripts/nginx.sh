#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions
export EC2_HOME=/opt/aws/apitools/ec2
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64
export AWS_PATH=/opt/aws
export PATH=$PATH:$AWS_PATH/bin
export CLASSPATH=$EC2_HOME/lib

/etc/init.d/nginx stop
cd /etc/nginx
cp nginx.conf nginx.back
cp $DIR_EBEXTEN/conf/nginx.conf .   

#Instalo awslogs, solo instalo si el ambiente es prod
env=$(ec2-describe-tags --filter "resource-type=instance" --filter "resource-id=$(ec2-metadata -i | /usr/bin/cut -d ' ' -f2)" --filter "key=Name" | /usr/bin/cut -f5)
echo $env > /tmp/env.txt
if [ $env == "nginx-prod" ]
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
