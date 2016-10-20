echo "----------------------" >> /var/log/nginx/env_gen.log
echo "[$(date)] Environment set to $APP_ENV" >> /var/log/nginx/env_gen.log
echo "[$(date)] Environment variables: $(env)" >> /var/log/nginx/env_gen.log


cp /etc/nginx/env.conf.$APP_ENV /etc/nginx/env.conf 2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/env.conf.$APP_ENV" >> /var/log/nginx/env_gen.log

cp /etc/nginx/proxy_env.conf.$APP_ENV /etc/nginx/proxy_env.conf 2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/proxy_env.conf.$APP_ENV" >> /var/log/nginx/env_gen.log

cp /etc/nginx/upstreams.conf.$APP_ENV /etc/nginx/upstreams.conf  2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/upstreams.conf.$APP_ENV" >> /var/log/nginx/env_gen.log

cp /etc/nginx/security/test-ips.conf.$APP_ENV /etc/nginx/security/test-ips.conf  2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx/security/test-ips.conf.$APP_ENV" >> /var/log/nginx/env_gen.log

cp -rf /etc/nginx-nr-agent/nginx-nr-agent.ini.$APP_ENV /etc/nginx-nr-agent/nginx-nr-agent.ini  2>> /var/log/nginx/env_gen.err
echo "[$(date)] Using /etc/nginx-nr-agent/nginx-nr-agent.ini.$APP_ENV" >> /var/log/nginx/env_gen.log

echo "[$(date)] Replacing hostname on nr configuration file" >> /var/log/nginx/env_gen.log
sed "s/\$HOSTNAME/$HOSTNAME/" /etc/nginx-nr-agent/nginx-nr-agent.ini > /etc/nginx-nr-agent/nginx-nr-agent.ini.new
mv /etc/nginx-nr-agent/nginx-nr-agent.ini.new /etc/nginx-nr-agent/nginx-nr-agent.ini
echo "[$(date)] Replacing hostname on nr configuration file (DONE)" >> /var/log/nginx/env_gen.log

echo "resolver 127.0.0.1 ;" > /etc/nginx/resolvers.conf
echo "[$(date)] Environment startup completed" >> /var/log/nginx/env_gen.log
