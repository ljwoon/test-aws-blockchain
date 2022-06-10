echo "mychannel 생성"
docker exec cli peer channel create -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/mychannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "peer0.nsmarts mychannel 참가"
docker exec cli peer channel join -b mychannel.block

echo "peer1.nsmarts mychannel 참가"
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt cli peer channel join -b mychannel.block

echo "peer2.nsmarts mychannel 참가"
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer channel join -b mychannel.block


# echo "peer2.nsmarts mychannel 참가"
# docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:17051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer channel join -b mychannel.block

echo "앵커피어 등록"
docker exec cli peer channel update -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/NsmartsMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "peer0.vice mychannel 참가"
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer channel join -b mychannel.block
echo "peer1.vice mychannel 참가"
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer1.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer channel join -b mychannel.block
echo "앵커피어 등록"
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer channel update -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/ViceMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "peer0.viceKR mychannel 참가"
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer channel join -b mychannel.block
echo "peer1.viceKR mychannel 참가"
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer channel join -b mychannel.block
echo "앵커피어 등록"
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer channel update -o orderer.example.com:7050 -c mychannel -f ./channel-artifacts/ViceKRMSPanchors.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# 체인코드 contract----------------------------------------------------------------

echo "체인코드 contract peer0.nsmarts에 설치"
docker exec cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5

echo "체인코드 contract peer1.nsmarts에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_LOCALMSPID=NsmartsMSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5

echo "체인코드 contract peer2.nsmarts에 설치"
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_LOCALMSPID=NsmartsMSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5

echo "체인코드 contract peer0.vice에 설치"
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5

echo "체인코드 contract peer1.vice에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer1.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5

echo "체인코드 contract peer0.viceKR에 설치"
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5

echo "체인코드 contract peer1.viceKR에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode install -n contract -v 1.0 -p github.com/chaincode/contract/go/
sleep 5



echo "mychannel에 체인코드 contract 인스턴스 화"
docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n contract -v 1.0 -c '{"Args":[]}' -P "AND ('NsmartsMSP.peer','NsmartsMSP.peer')" --collections-config /opt/gopath/src/github.com/chaincode/contract/go/collections_config.json
sleep 5

# echo "mychannel 체인코드 contract 인스턴스 화"
# docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n contract -v 1.0 -c '{"Args":[]}' -P "OutOf (3, 'NsmartsMSP.peer','ViceMSP.peer','ViceKRMSP.peer','Org4MSP.peer','Org5MSP.peer' )"
# sleep 5

echo "체인코드 contract 호출"
docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n contract --peerAddresses peer0.nsmarts.co.kr:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt --peerAddresses peer0.vice.com:10051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt --peerAddresses peer0.viceKR.com:12051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -c '{"Args":["queryTest","a"]}'



# echo "체인코드 contract 호출"
# docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n contract --peerAddresses peer0.nsmarts.co.kr:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt -c '{"Args":["queryTest","a"]}'


echo "체인코드 contract 쿼리"
# from peer0.nsmarts
docker exec cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 contract 쿼리"
# from peer1.nsmarts
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 contract 쿼리"
# from peer2.nsmarts
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5


# echo "체인코드 contract 쿼리"
# # from peer2.nsmarts
# docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:17051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
# sleep 5

echo "체인코드 contract 쿼리"
# from peer0.vice
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 contract 쿼리"
# from peer1.vice
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 contract 쿼리"
# from peer0.viceKR
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 contract 쿼리"
# from peer1.viceKR
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode query -n contract -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

# # 체인코드 document----------------------------------------------------------------

echo "체인코드 document peer0.nsmarts에 설치"
docker exec cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5

echo "체인코드 document peer1.nsmarts에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_LOCALMSPID=NsmartsMSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5

echo "체인코드 document peer2.nsmarts에 설치"
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_LOCALMSPID=NsmartsMSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5

echo "체인코드 document peer0.vice에 설치"
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5

echo "체인코드 document peer1.vice에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer1.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5

echo "체인코드 document peer0.viceKR에 설치"
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5

echo "체인코드 document peer1.viceKR에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode install -n document -v 1.0 -p github.com/chaincode/document/go/
sleep 5



echo "mychannel에 체인코드 document 인스턴스 화"
docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n document -v 1.0 -c '{"Args":[]}' -P "AND ('NsmartsMSP.peer','NsmartsMSP.peer')"
sleep 5

# echo "mychannel 체인코드 document 인스턴스 화"
# docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n document -v 1.0 -c '{"Args":[]}' -P "OutOf (3, 'NsmartsMSP.peer','ViceMSP.peer','ViceKRMSP.peer','Org4MSP.peer','Org5MSP.peer' )"
# sleep 5

echo "체인코드 document 호출"
docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n document --peerAddresses peer0.nsmarts.co.kr:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt --peerAddresses peer0.vice.com:10051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt --peerAddresses peer0.viceKR.com:12051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -c '{"Args":["queryTest","a"]}'


# echo "체인코드 document 호출"
# docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n document --peerAddresses peer0.nsmarts.co.kr:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt -c '{"Args":["queryTest","a"]}'


echo "체인코드 document 쿼리"
# from peer0.nsmarts
docker exec cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 document 쿼리"
# from peer1.nsmarts
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 document 쿼리"
# from peer2.nsmarts
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

# echo "체인코드 document 쿼리"
# # from peer2.nsmarts
# docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:17051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
# sleep 5

echo "체인코드 document 쿼리"
# from peer0.vice
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 document 쿼리"
# from peer1.vice
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 document 쿼리"
# from peer0.viceKR
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 document 쿼리"
# from peer1.viceKR
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode query -n document -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5
 
# # 체인코드 leave----------------------------------------------------------------

echo "체인코드 leave peer0.nsmarts에 설치"
docker exec cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5

echo "체인코드 leave peer1.nsmarts에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_LOCALMSPID=NsmartsMSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5

echo "체인코드 leave peer2.nsmarts에 설치"
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp -e CORE_PEER_LOCALMSPID=NsmartsMSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5

echo "체인코드 leave peer0.vice에 설치"
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5

echo "체인코드 leave peer1.vice에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer1.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5

echo "체인코드 leave peer0.viceKR에 설치"
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5

echo "체인코드 leave peer1.viceKR에 설치"
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode install -n leave -v 1.0 -p github.com/chaincode/company/go/
sleep 5



echo "mychannel에 체인코드 leave 인스턴스 화"
docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n leave -v 1.0 -c '{"Args":[]}' -P "AND ('NsmartsMSP.peer','NsmartsMSP.peer')"
sleep 5

# echo "mychannel 체인코드 company 인스턴스 화"
# docker exec cli peer chaincode instantiate -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n leave -v 1.0 -c '{"Args":[]}' -P "OutOf (3, 'NsmartsMSP.peer','ViceMSP.peer','ViceKRMSP.peer','Org4MSP.peer','Org5MSP.peer' )"
# sleep 5

echo "체인코드 leave 호출"
docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n leave --peerAddresses peer0.nsmarts.co.kr:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt --peerAddresses peer0.vice.com:10051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt --peerAddresses peer0.viceKR.com:12051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -c '{"Args":["queryTest","a"]}'


# echo "체인코드 company 호출"
# docker exec cli peer chaincode invoke -o orderer.example.com:7050 --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n leave --peerAddresses peer0.nsmarts.co.kr:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt -c '{"Args":["queryTest","a"]}'


echo "체인코드 leave 쿼리"
# from peer0.nsmarts
docker exec cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 leave 쿼리"
# from peer1.nsmarts
docker exec -e CORE_PEER_ADDRESS=peer1.nsmarts.co.kr:8051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 leave 쿼리"
# from peer2.nsmarts
docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:9051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5


# echo "체인코드 leave 쿼리"
# # from peer2.nsmarts
# docker exec -e CORE_PEER_ADDRESS=peer2.nsmarts.co.kr:17051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
# sleep 5

echo "체인코드 leave 쿼리"
# from peer0.vice
docker exec -e CORE_PEER_ADDRESS=peer0.vice.com:10051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 leave 쿼리"
# from peer1.vice
docker exec -e CORE_PEER_ADDRESS=peer1.vice.com:11051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/vice.com/users/Admin@vice.com/msp -e CORE_PEER_LOCALMSPID=ViceMSP cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 leave 쿼리"
# from peer0.viceKR
docker exec -e CORE_PEER_ADDRESS=peer0.viceKR.com:12051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

echo "체인코드 leave 쿼리"
# from peer1.viceKR
docker exec -e CORE_PEER_ADDRESS=peer1.viceKR.com:13051 -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp -e CORE_PEER_LOCALMSPID=ViceKRMSP cli peer chaincode query -n leave -C mychannel -c '{"Args":["queryTest","a"]}'
sleep 5

