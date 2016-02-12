echo 'set $EPI_UI_DNS' $EPI_UI_DNS ';' > /etc/nginx/env.conf
echo 'set $EPI_API_DNS' $EPI_API_DNS ';' >> /etc/nginx/env.conf
echo 'set $MAPI_DNS' $MAPI_DNS ';' >> /etc/nginx/env.conf
echo 'set $API_CORE_DNS' $API_CORE_DNS ';' >> /etc/nginx/env.conf
echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/resolvers.conf