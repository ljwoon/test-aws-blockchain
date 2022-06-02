export BYFN_CA2_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/vice.com/ca && ls *_sk)
docker-compose -f host2CA.yaml up -d
