../../bin/cryptogen generate --config=./add-org-crypto.yaml
echo '인증키 생성 중...'
sleep 3

# 생성된 인증키를 ../crypto-config/peerOrganizations/로 이동
mv crypto-config/peerOrganizations/org4.example.com ../crypto-config/peerOrganizations/

# -printOrg 옵션을 사용 하여 이 configtx.yaml 을 기반으로 JSON 파일을 생성. 
# 결과는 org4.json 에 저장되고 vice-network/channel-artifacts 디렉토리에 저장됩니다.
export FABRIC_CFG_PATH=$PWD/ && ../../bin/configtxgen -printOrg Org4MSP > ../channel-artifacts/org4.json

sudo rm -rf ./crypto-config