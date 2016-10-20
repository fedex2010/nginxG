#!/bin/bash

DIR_TMP=/tmp/nginx
DIR_EBEXTEN=$DIR_TMP/.ebextensions

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

grep "custom-conf-start" /etc/sysctl.conf
if [ $? == 1 ]
then
    printf "\n#custom-conf-start\n" >> /etc/sysctl.conf
    printf "fs.file-max = 2037581\nnet.core.somaxconn = 65536\nnet.core.netdev_max_backlog = 65536\n" >> /etc/sysctl.conf
    printf "\nnet.ipv4.tcp_fin_timeout = 30\nnet.ipv4.tcp_max_syn_backlog = 3240000\nnet.ipv4.tcp_max_tw_buckets = 1440000\n" >> /etc/sysctl.conf
    printf "\nnet.ipv4.ip_forward = 1\nnet.ipv4.ip_local_port_range = 1024 65000\nnet.netfilter.nf_conntrack_max = 700000\n" >> /etc/sysctl.conf
    printf "\n#custom-conf-end\n" >> /etc/sysctl.conf
    sysctl -p
fi
