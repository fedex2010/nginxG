#!/bin/bash
upstreams=$(find /etc/nginx/ -type f -iname upstreams.conf* | tr "\n" " ")
echo "Upstreams to verify: $upstreams"
echo "Verifying all locations have their corresponding upstreams"
for location in $(find /etc/nginx/ -type f -iname locations.conf* -exec grep "proxy_pass" {} \; | grep -v "#" | tr -s [:space:] | awk 'BEGIN {$2=="http*"} {print $2}' | grep -v "\\$" | sort | uniq | tr -s "/" | cut -d "/" -f2 | tr -d ";"); do
	for upstream in $upstreams; do
		F=$(grep "\b$location\b" $upstream) 
		STATUS=$?
		if [ $STATUS -ne 0 ] 
		then
			echo "Location $location not found in upstream file $upstream"
			exit 1
		fi
	done
done

echo "Verifying all upstreams have their definition on every environment"
declare -a OUTPUT
for u in $upstreams
do
    item=$(echo "$u-$(grep '\bupstream\s*.*\s*{.*\}' $u | cut -d '{' -f1 | sed 's/upstream//'| sed 's/[[:space:]]*//g' | sort | md5sum  | cut -d " " -f1)" )
    OUTPUT=("${OUTPUT[@]}" "$item")
done


COUNT=$(echo ${OUTPUT[@]} | tr " " "\n" | cut -d "-" -f2 | sort | uniq | wc -l)
if [ $COUNT -ne 1 ]
then
    echo "Not all upstream are defined on every environment. Check them (upstream-file-md5)*: ${OUTPUT[*]}"
    exit 1
fi

exit 0
