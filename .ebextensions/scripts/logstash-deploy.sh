#!/bin/bash
if [ ! -f /opt/logstash/bin/logstash ];
then
	echo "Logstash not found, will now add repository and install it"
	DISTRO=$(cat /etc/issue | head -1)
	if [[ $DISTRO == *"Amazon Linux AMI"* ]]
	then
		rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
		printf "[logstash-2.3]\nname=Logstash repository for 2.3.x packages\nbaseurl=https://packages.elastic.co/logstash/2.3/centos\ngpgcheck=1\ngpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch\nenabled=1\n" > /etc/yum.repos.d/logstash.repo
		yum install -y  logstash
	elif [[ $DISTRO == *"Ubuntu"* ]]; then
		wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
		echo "deb https://packages.elastic.co/logstash/2.3/debian stable main" | tee -a /etc/apt/sources.list
		apt-get update && apt-get install logstash
	else
		echo "Wrong linux distro $DISTRO"
	fi
else
	echo "Logstash found. Nothing to be done here"
fi
NGINGX_LOGSTASH_CONFIG="/etc/logstash/conf.d/logstash-ngingx.conf"

#APP_ENV=$(docker inspect $(docker ps | grep ngin | awk '{print $1}') | grep APP_ENV | sed 's/APP_ENV=//' | tr -d [:punct:][:space:])

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AV_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
if [[ $AV_ZONE == us-east-1* ]] ;
then
	ZONE="us-east-1"
else
	ZONE=$AV_ZONE
fi
INSTANCE_NAME=$(aws ec2 describe-tags --filters Name=resource-id,Values=$INSTANCE_ID Name=key,Values=Name --query Tags[].Value --output text --region $ZONE)
APP_ENV=$(echo $INSTANCE_NAME | sed 's/nginx-//')

case  $APP_ENV  in
	"prod")
		LOGSTASH_HOST=ip-10-212-15-195.ec2.internal
		LOGSTASH_PORT=19000
	;;
	"staging")
		LOGSTASH_HOST=ip-10-211-15-62.ec2.internal
		LOGSTASH_PORT=18000
	;;
	*)
		LOGSTASH_HOST=ip-10-211-15-62.ec2.internal
		LOGSTASH_PORT=17000
	;;
esac
sed "s/OUTPUT_UDP_PORT/$LOGSTASH_PORT/g" /tmp/nginx/.ebextensions/conf/logstash.conf.template | sed "s/OUTPUT_UDP_HOST/$LOGSTASH_HOST/g" > $NGINGX_LOGSTASH_CONFIG
service logstash restart
echo "Logstash restart status is $?"