container=$(docker ps -a | grep garba-nginx)
if [[ "$container" -eq "" ]]; then
	echo "no existe -> se crea"
	docker run -d -e EPI_UI_DNS=staging.garbarino.com -e EPI_API_DNS=staging.garbarino.com -e MAPI_DNS=mapi-staging.garbarino.com --name garba-nginx garba-nginx
else
	echo "existe -> lo arranca"
	docker start garba-nginx
fi