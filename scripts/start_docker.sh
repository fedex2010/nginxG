container=$(docker ps -a | grep garba-nginx | awk '{print $1}')
if [[ "$container" == "" ]]; then
	echo "no existe"
else
	echo "existe -> lo borra"
	docker rm $container
fi
docker run -d -e APP_ENV=ci -p 80:80 -p 81:81 --name garba-nginx garba-nginx