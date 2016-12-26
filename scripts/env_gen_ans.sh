echo "----------------------" >> /var/log/nginx/env_gen.log
echo "[$(date)] Environment set to $1" >> /var/log/nginx/env_gen.log
echo "[$(date)] Environment variables: $(env)" >> /var/log/nginx/env_gen.log


cp /etc/nginx/env.conf.$1 /etc/nginx/env.conf 2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/env.conf.$1" >> /var/log/nginx/env_gen.log

cp /etc/nginx/proxy_env.conf.$1 /etc/nginx/proxy_env.conf 2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/proxy_env.conf.$1" >> /var/log/nginx/env_gen.log

cp /etc/nginx/upstreams.conf.$1 /etc/nginx/upstreams.conf  2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/upstreams.conf.$1" >> /var/log/nginx/env_gen.log

cp /etc/nginx/security/test-ips.conf.$1 /etc/nginx/security/test-ips.conf  2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/security/test-ips.conf.$1" >> /var/log/nginx/env_gen.log

cp -f /etc/nginx/nginx-nr-agent.ini.$1 /etc/nginx-nr-agent/nginx-nr-agent.ini  2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx-nr-agent/nginx-nr-agent.ini.$1" >> /var/log/nginx/env_gen.log

echo "[$(date)] Replacing hostname on nr configuration file" >> /var/log/nginx/env_gen.log
sed "s/\$HOSTNAME/$HOSTNAME/" /etc/nginx-nr-agent/nginx-nr-agent.ini > /etc/nginx-nr-agent/nginx-nr-agent.ini.new
mv /etc/nginx-nr-agent/nginx-nr-agent.ini.new /etc/nginx-nr-agent/nginx-nr-agent.ini
echo "[$(date)] Replacing hostname on nr configuration file (DONE)" >> /var/log/nginx/env_gen.log

echo resolver $(awk 'BEGIN{ORS=" "} $1=="nameserver" {print $2}' /etc/resolv.conf) ";" > /etc/nginx/resolvers.conf
echo "[$(date)] Environment startup completed" >> /var/log/nginx/env_gen.log
