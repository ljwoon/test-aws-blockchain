# docker rm -f $(docker ps -aq)
docker-compose -f addOrgNode.yaml down -v
docker-compose -f addOrgNode.yaml rm -v
docker volume prune

