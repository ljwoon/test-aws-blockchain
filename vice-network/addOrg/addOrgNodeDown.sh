# docker rm -f $(docker ps -aq)
docker-compose -f addOrgNode.yaml -f addOrgCA.yaml down -v
docker-compose -f addOrgNode.yaml -f addOrgCA.yaml rm -v
sudo rm -rf ../crypto-config/peerOrganizations/org4.example.com ../fabric-ca-server/ca.orderer.example.com