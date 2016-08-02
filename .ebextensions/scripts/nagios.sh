#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions
export EC2_HOME=/opt/aws/apitools/ec2
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64
export AWS_PATH=/opt/aws
export PATH=$PATH:$AWS_PATH/bin
export CLASSPATH=$EC2_HOME/lib

HOSTNAME=$(hostname)
IP_HOST=$(hostname -i)
IP_NAGIOS=10.212.15.51

env=$(ec2-describe-tags --filter "resource-type=instance" --filter "resource-id=$(ec2-metadata -i | /usr/bin/cut -d ' ' -f2)" --filter "key=Name" | /usr/bin/cut -f5)

if [ $env == "nginx-prod" ] #Solo cargo en nagios servers de prod
then
	EXISTE=$($DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest show/hosts | grep name | grep nginx-$HOSTNAME | wc -l)

	if [ $EXISTE -eq 0 ] #No esta dado de alta el host en nagios
	then
		$DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest add/hosts -d name:nginx-$HOSTNAME -d alias:nginx -d ipaddress:$IP_HOST -d template:hsttmpl-local -d servicesets:example-lin -d hostgroup:mgmt > /dev/null
		$DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest apply/nagiosconfig > /dev/null
		$DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest restart/nagios > /dev/null

		cp $DIR_EBEXTEN/conf/nrpe.cfg /etc/nagios
		/etc/init.d/nrpe start
	fi
fi

#rm -rf $DIR_TMP
