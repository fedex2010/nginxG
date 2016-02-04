echo 'set $EPI_UI_DNS' $EPI_UI_DNS ';' > /etc/nginx/env.conf
echo 'set $EPI_API_DNS' $EPI_API_DNS ';' >> /etc/nginx/env.conf
sed -i "s/NEW_RELIC_KEY_PLACEHOLDER/$NEW_RELIC_KEY/g" "/etc/nginx-nr-agent/nginx-nr-agent.ini"
