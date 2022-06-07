export BYFN_CA3_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/viceKR.com/ca && ls *_sk)
docker-compose -f host3CA.yaml up -d
