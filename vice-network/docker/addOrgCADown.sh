# docker rm -f $(docker ps -aq)
docker-compose -f addOrgCA.yaml down -v
docker-compose -f addOrgCA.yaml rm
docker volume prune

