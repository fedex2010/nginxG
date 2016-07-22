#!/bin/bash
upstreams=$(find /etc/nginx/ -type f -iname upstreams.conf*)
echo "Upstreams to verify: $upstreams"
for location in $(find /etc/nginx/ -type f -iname locations.conf* -exec grep "proxy_pass" {} \; | awk 'BEGIN {$2=="http*"} {print $2}' | grep -v "\\$" | sort | uniq | tr -s "/" | cut -d "/" -f2 | tr -d ";"); do
	for upstream in $upstreams; do
		F=$(grep "\b$location\b" $upstream) 
		STATUS=$?
		if [ $STATUS -ne 0 ] 
		then
			echo "Location $location not found in upstream file $upstream"
			ERROR=1
		fi
	done
done
EXIT_STATUS=${ERROR:0}
exit $EXIT_STATUS
