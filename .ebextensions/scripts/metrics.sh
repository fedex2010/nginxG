#!/bin/bash

yum install perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA -y

yum install zip unzip -y

curl http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip -O

unzip -o CloudWatchMonitoringScripts-1.2.1.zip -d /opt

echo "*/3 * * * * /opt/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron" > /var/spool/cron/root
