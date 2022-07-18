export BYFN_CAO_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/viceKR.com/ca && ls *_sk)
docker-compose -f ordererCA.yaml up -d
