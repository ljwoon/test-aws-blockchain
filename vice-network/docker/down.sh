docker-compose -f host1.yaml -f host2.yaml -f host3.yaml down --volumes --remove-orphans
docker-compose -f host1.yaml -f host2.yaml -f host3.yaml rm -v
docker stop $(docker ps -aq)
docker rm $(docker ps -aq) -f
DOCKER_IMAGE_IDS=$(docker images | awk '($1 ~ /dev-peer.*/) {print $3}')
docker rmi -f $DOCKER_IMAGE_IDS
docker volume prune
