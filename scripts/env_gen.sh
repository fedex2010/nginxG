cp -rf /etc/nginx/env.conf.$APP_ENV /etc/nginx/env.conf
cp -rf /etc/nginx-nr-agent/nginx-nr-agent.ini.$APP_ENV /etc/nginx-nr-agent/nginx-nr-agent.ini
echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/resolvers.conf
