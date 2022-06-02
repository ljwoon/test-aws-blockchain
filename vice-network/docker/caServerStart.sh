export BYFN_CA1_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/nsmarts.co.kr/ca && ls *_sk)
export BYFN_CA2_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/vice.com/ca && ls *_sk)
export BYFN_CA3_PRIVATE_KEY=$(cd ../crypto-config/peerOrganizations/viceKR.com/ca && ls *_sk)
export BYFN_CAO_PRIVATE_KEY=$(cd ../crypto-config/ordererOrganizations/example.com/ca && ls *_sk)

# crypto-config 사용시 사용
docker-compose -f ordererCA.yaml -f host1CA.yaml -f host2CA.yaml -f host3CA.yaml up -d

# 직접CA를 사용해 인증서를 발급할 시 사용
# docker-compose -f ordererCA.yaml -f host1CA.yaml -f host2CA.yaml -f host3CA.yaml up -d
