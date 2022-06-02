export BYFN_CA1_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/nsmarts.co.kr/ca && ls *_sk)
docker-compose -f host1CA.yaml up -d
