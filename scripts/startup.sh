echo "---------------------" >> /var/log/nginx/startup.log
echo "[$(date)] Running env_gen" >> /var/log/nginx/startup.log
/etc/nginx/scripts/env_gen.sh 2>>/var/log/nginx/startup.err
echo "[$(date)] Finished env_gen" >> /var/log/nginx/startup.log

echo "[$(date)] Running NginX startup" >> /var/log/nginx/startup.log
nginx -g 'daemon off;' 2>>/var/log/nginx/startup.err
echo "[$(date)] Finished NginX startup" >> /var/log/nginx/startup.log

echo "[$(date)] Running nginx newrelic service" >> /var/log/nginx/startup.log
service nginx-nr-agent start 2>>/var/log/nginx/startup.err