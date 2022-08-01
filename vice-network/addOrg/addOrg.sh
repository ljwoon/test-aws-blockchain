docker exec -it cli bash

sleep 3

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=vicekrchannel

peer channel fetch config config_block.pb -o orderer.example.com:7050 -c vicekrchannel --tls --cafile $ORDERER_CA

configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > config.json

jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"Org4MSP":.[1]}}}}}' config.json ./channel-artifacts/org4.json > modified_config.json

configtxlator proto_encode --input config.json --type common.Config --output config.pb

configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb

configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output org4_update.pb

configtxlator proto_decode --input org4_update.pb --type common.ConfigUpdate | jq . > org4_update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"vicekrchannel", "type":2}},"data":{"config_update":'$(cat org4_update.json)'}}}' | jq . > org4_update_in_envelope.json

configtxlator proto_encode --input org4_update_in_envelope.json --type common.Envelope --output org4_update_in_envelope.pb

peer channel update -f org4_update_in_envelope.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_CA

# 다른 터미널 키고 해야한다. 채널에 등록된 앵커피어 등록.

docker exec -e CORE_PEER_LOCALMSPID="ViceMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -it cli bash

sleep 3

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=vicekrchannel

peer channel signconfigtx -f org4_update_in_envelope.pb

peer channel update -f org4_update_in_envelope.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_CA

# 다른 터미널 키고 해야한다. 채널에 등록된 앵커피어 등록.

docker exec -e CORE_PEER_LOCALMSPID="ViceKRMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -it cli bash

sleep 3

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=vicekrchannel

peer channel signconfigtx -f org4_update_in_envelope.pb

peer channel update -f org4_update_in_envelope.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_CA

# 다른 터미널 키고 해야한다. 보증정책에 맞는만큼 갯수 필요 내껀 2개 필요.

# docker exec -e CORE_PEER_LOCALMSPID="NsmartsMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -it cli bash

# sleep 3

# export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=vicekrchannel

# peer channel signconfigtx -f org4_update_in_envelope.pb

# peer channel update -f org4_update_in_envelope.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_CA

# 다른 터미널 키고 해야한다. 보증정책에 맞는만큼 갯수 필요 내껀 2개 필요.

# docker exec -e CORE_PEER_LOCALMSPID="NsmartsMSP" -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -it cli bash

# sleep 3

# export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=vicekrchannel

# peer channel signconfigtx -f org4_update_in_envelope.pb

# peer channel update -f org4_update_in_envelope.pb -c $CHANNEL_NAME -o orderer.example.com:7050 --tls --cafile $ORDERER_CA


# 추가 조직이 채널에 가입
# 다른 터미널 키고 해야한다. org4 cli 실행
docker exec -it Org4cli bash

sleep 3

export ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem && export CHANNEL_NAME=vicekrchannel

# 다시 NsmartsMSP 터미널
peer channel fetch 0 vicekrchannel.block -o orderer.example.com:7050 -c $CHANNEL_NAME --tls --cafile $ORDERER_CA

# localhost의 'docker' 경로에서
docker cp cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/vicekrchannel.block .
docker cp vicekrchannel.block Org4cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/

#org4 cli 에서
peer channel join -b vicekrchannel.block 

peer channel getinfo -c vicekrchannel

# # org1 터미널 체인코드 업데이트
# peer chaincode install -n contract -v 2.0 -p github.com/chaincode/contract/go/
# # org2 터미널 체인코드 업데이트
# peer chaincode install -n contract -v 2.0 -p github.com/chaincode/contract/go/
# # org3 터미널 체인코드 업데이트
# peer chaincode install -n contract -v 2.0 -p github.com/chaincode/contract/go/
# # org4 터미널 체인코드 업데이트
# peer chaincode install -n contract -v 2.0 -p github.com/chaincode/contract/go/

# org4 cli에서
peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/

#local에서
docker exec -e CORE_PEER_ADDRESS=peer1.org4.example.com:15051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp -e CORE_PEER_LOCALMSPID=Org4MSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
docker exec -e CORE_PEER_ADDRESS=peer1.org4.example.com:15051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp -e CORE_PEER_LOCALMSPID=Org4MSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
docker exec -e CORE_PEER_ADDRESS=peer1.org4.example.com:15051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp -e CORE_PEER_LOCALMSPID=Org4MSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/

docker exec -e CORE_PEER_ADDRESS=peer1.org4.example.com:15051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org4.example.com/users/Admin@peer1.org4.example.com/msp -e CORE_PEER_LOCALMSPID=Nsmarts -it cli bash 


# org1 터미널 체인코드 업데이트
# peer chaincode upgrade -o orderer.example.com:7050 --tls true --cafile $ORDERER_CA -C $CHANNEL_NAME -n contract -v 2.0 -c '{"Args":[]}' -P "OutOf (2, 'NsmartsMSP.peer','NsmartsMSP.peer')"

# org4cli 쿼리
peer chaincode query -n contract -C vicekrchannel -c '{"Args":["queryTest","a"]}'

peer chaincode invoke -o orderer.example.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n contract -c '{"Args":["queryTest","a"]}'