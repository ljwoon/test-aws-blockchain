export BYFN_CA4_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/org4.example.com/ca && ls *_sk)
docker-compose -f addOrgCA.yaml up -d
