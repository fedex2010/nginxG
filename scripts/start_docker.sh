container=$(docker ps -a | grep garba-nginx | sed s/.*garba-nginx/exists/)
if [[ "$container" == "" ]]; then
	echo "no existe -> se crea"
	docker run -d -e EPI_UI_DNS=staging.garbarino.com -e EPI_API_DNS=staging.garbarino.com -e MAPI_DNS=mapi-staging.garbarino.com -e API_CORE_DNS=api-core-staging.garbarino.com  --name garba-nginx garba-nginx
else
	echo "existe -> lo arranca"
	docker start garba-nginx
fi