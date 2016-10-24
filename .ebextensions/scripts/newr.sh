#!/bin/bash

export EC2_HOME=/opt/aws/apitools/ec2
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64
export AWS_PATH=/opt/aws
export PATH=$PATH:$AWS_PATH/bin
export CLASSPATH=$EC2_HOME/lib
LICENSE=c1593a6ba53870eb64095106a15c615f48d7d1e7

tag_env=$(ec2-describe-tags --filter "resource-type=instance" --filter "resource-id=$(ec2-metadata -i | /usr/bin/cut -d ' ' -f2)" --filter "key=Name" | /usr/bin/cut -f5)

env=$(echo $tag_env | grep "\-prod" | wc -l)

if [ $env -eq 1 ] 
then
	rpm -qa | grep -q newrelic-sysmond #Chequeo si ya esta instalado el plugin
	if [ $? == 1 ]
	then
		rpm -Uvh https://yum.newrelic.com/pub/newrelic/el5/x86_64/newrelic-repo-5-3.noarch.rpm	
		yum install -y newrelic-sysmond
		nrsysmond-config --set license_key=$LICENSE
		/etc/init.d/newrelic-sysmond start
	fi
fi
