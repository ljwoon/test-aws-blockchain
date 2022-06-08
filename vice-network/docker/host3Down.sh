docker-compose -f host3.yaml down --volumes --remove-orphans
docker-compose -f host3.yaml rm -v
DOCKER_IMAGE_IDS=$(docker images | awk '($1 ~ /dev-peer.*/) {print $3}')
docker rmi -f $DOCKER_IMAGE_IDS
docker volume prune