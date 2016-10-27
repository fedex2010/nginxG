upstream=$1
ci_endpoint=${2:-localhost}
staging_endpoint=${3:-localhost}
prod_endpoint=${4:-localhost}

echo "set \$$upstream http://${upstream}:3000;" >> proxy_env.conf
echo "set \$$upstream http://${ci_endpoint};" >> proxy_env.conf.ci
echo "set \$$upstream http://${staging_endpoint};" >> proxy_env.conf.staging
echo "set \$$upstream http://${prod_endpoint};" >> proxy_env.conf.prod
