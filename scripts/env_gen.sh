echo "----------------------" >> /var/log/nginx/startup.log
echo "[$(date)] Environment set to $APP_ENV" >> /var/log/nginx/startup.log
echo "[$(date)] Environment variables: \n$(env)" >> /var/log/nginx/startup.log


cp /etc/nginx/env.conf.$APP_ENV /etc/nginx/env.conf 2>> /var/log/nginx/startup.err
echo "[$(date)] Using /etc/nginx/env.conf.$APP_ENV" >> /var/log/nginx/startup.log

cp /etc/nginx/upstreams.conf.$APP_ENV /etc/nginx/upstreams.conf  2>> /var/log/nginx/startup.err
echo "[$(date)] Using /etc/nginx/upstreams.conf.$APP_ENV" >> /var/log/nginx/startup.log

cp /etc/nginx/security/test-ips.conf.$APP_ENV /etc/nginx/security/test-ips.conf  2>> /var/log/nginx/startup.err
echo "[$(date)] Using /etc/nginx/security/test-ips.conf.$APP_ENV" >> /var/log/nginx/startup.log

cp -rf /etc/nginx-nr-agent/nginx-nr-agent.ini.$APP_ENV /etc/nginx-nr-agent/nginx-nr-agent.ini  2>> /var/log/nginx/startup.err
echo "[$(date)] Using /etc/nginx-nr-agent/nginx-nr-agent.ini.$APP_ENV" >> /var/log/nginx/startup.log

echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/resolvers.conf
echo "[$(date)] Environment startup completed" >> /var/log/nginx/startup.log