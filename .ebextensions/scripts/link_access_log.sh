 #!/bin/bash
LAST_LOG=$(echo "/var/log/eb-docker/containers/eb-current-app/$(docker ps | grep ngin | awk '{print $1}')"-stdouterr.log)
echo $LAST_LOG
if [ -f $LAST_LOG ]
then
    LOG_LINK=/var/log/nginx-access.log
    echo "Creating access log link from $LOG_LINK to $LAST_LOG"
    ln -fs $LAST_LOG $LOG_LINK
    STATUS=$?
    echo "Link creation status: $STATUS"
    exit $STATUS
else
    echo "Last log not found."
    exit 1
fi