cp /etc/nginx/env.conf.$APP_ENV /etc/nginx/env.conf
cp /etc/nginx/conf.d/upstreams.conf.$APP_ENV /etc/nginx/conf.d/upstreams.conf
echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/resolvers.conf
