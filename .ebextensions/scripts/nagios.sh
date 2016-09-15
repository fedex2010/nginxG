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
IP_NAGIOS_PROD=10.212.15.51
IP_NAGIOS_TEST=10.211.15.9
DNS_NAGIOS_PROD=nagios.garba.ninja
DNS_NAGIOS_TEST=nagiostest.garba.ninja

tag_env=$(ec2-describe-tags --filter "resource-type=instance" --filter "resource-id=$(ec2-metadata -i | /usr/bin/cut -d ' ' -f2)" --filter "key=Name" | /usr/bin/cut -f5)

#Se cambia el grep porque las instancias de mapi-notifications terminan en prd2 en lugar de prod
env=$(echo $tag_env | grep "\-prod" | wc -l)

if [ $env -eq 1 ]
then
	IP_NAGIOS=$DNS_NAGIOS_PROD
else
	IP_NAGIOS=$DNS_NAGIOS_TEST
fi

	EXISTE=$($DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest show/hosts | grep name | grep $HOSTNAME | wc -l)

	if [ $EXISTE -eq 0 ] #No esta dado de alta el host en nagios
	then
		$DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest add/hosts -d name:$tag_env-$HOSTNAME -d alias:$HOSTNAME -d ipaddress:$IP_HOST -d template:hsttmpl-local -d servicesets:example-lin -d hostgroup:mgmt > /dev/null
		$DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest apply/nagiosconfig > /dev/null
		$DIR_EBEXTEN/bin/nrcq http://$IP_NAGIOS/rest restart/nagios > /dev/null

		cp $DIR_EBEXTEN/conf/nrpe.cfg /etc/nagios
		chkconfig nrpe on
		/etc/init.d/nrpe start
	fi

#rm -rf $DIR_TMP
