echo "---------------------" >> /var/log/nginx/startup.log
echo "[$(date)] Running env_gen" >> /var/log/nginx/startup.log
/etc/nginx/scripts/env_gen.sh 2>>/var/log/nginx/startup.err
echo "[$(date)] Finished env_gen" >> /var/log/nginx/startup.log

echo "[$(date)] Running NginX startup" >> /var/log/nginx/startup.log
nginx 2>>/var/log/nginx/startup.err
echo "[$(date)] Finished NginX startup" >> /var/log/nginx/startup.log

echo "[$(date)] Running nginx newrelic service" >> /var/log/nginx/startup.log
service nginx-nr-agent start 2>>/var/log/nginx/startup.err
echo "[$(date)] Startup finished" >>/var/log/nginx/startup.log

# Esto es para que no termine el container, seguro hay una mejor manera, pero todavía no la encontré
sleep 600d