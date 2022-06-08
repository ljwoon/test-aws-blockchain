sudo rm -rf channel-artifacts 

sudo rm -rf fabric-ca-server/ca.orderer.example.com/ca-cert.pem
sudo rm -rf fabric-ca-server/ca.orderer.example.com/tls-cert.pem
sudo rm -rf fabric-ca-server/ca.orderer.example.com/msp
sudo rm -rf fabric-ca-server/ca.orderer.example.com/fabric-ca-server.db
sudo rm -rf fabric-ca-server/ca.orderer.example.com/IssuerPublicKey
sudo rm -rf fabric-ca-server/ca.orderer.example.com/IssuerRevocationPublicKey

sudo rm -rf fabric-ca-server/ca.nsmarts.co.kr/ca-cert.pem
sudo rm -rf fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
sudo rm -rf fabric-ca-server/ca.nsmarts.co.kr/msp
sudo rm -rf fabric-ca-server/ca.nsmarts.co.kr/fabric-ca-server.db
sudo rm -rf fabric-ca-server/ca.nsmarts.co.kr/IssuerPublicKey
sudo rm -rf fabric-ca-server/ca.nsmarts.co.kr/IssuerRevocationPublicKey

sudo rm -rf fabric-ca-server/ca.vice.com/ca-cert.pem
sudo rm -rf fabric-ca-server/ca.vice.com/tls-cert.pem
sudo rm -rf fabric-ca-server/ca.vice.com/msp
sudo rm -rf fabric-ca-server/ca.vice.com/fabric-ca-server.db
sudo rm -rf fabric-ca-server/ca.vice.com/IssuerPublicKey
sudo rm -rf fabric-ca-server/ca.vice.com/IssuerRevocationPublicKey

sudo rm -rf fabric-ca-server/ca.viceKR.com/ca-cert.pem
sudo rm -rf fabric-ca-server/ca.viceKR.com/tls-cert.pem
sudo rm -rf fabric-ca-server/ca.viceKR.com/msp
sudo rm -rf fabric-ca-server/ca.viceKR.com/fabric-ca-server.db
sudo rm -rf fabric-ca-server/ca.viceKR.com/IssuerPublicKey
sudo rm -rf fabric-ca-server/ca.viceKR.com/IssuerRevocationPublicKey

sudo rm -rf fabric-ca-server/ca.org4.example.com/ca-cert.pem
sudo rm -rf fabric-ca-server/ca.org4.example.com/tls-cert.pem
sudo rm -rf fabric-ca-server/ca.org4.example.com/msp
sudo rm -rf fabric-ca-server/ca.org4.example.com/fabric-ca-server.db
sudo rm -rf fabric-ca-server/ca.org4.example.com/IssuerPublicKey
sudo rm -rf fabric-ca-server/ca.org4.example.com/IssuerRevocationPublicKey

sudo rm -rf fabric-ca-server/ca.org5.example.com/ca-cert.pem
sudo rm -rf fabric-ca-server/ca.org5.example.com/tls-cert.pem
sudo rm -rf fabric-ca-server/ca.org5.example.com/msp
sudo rm -rf fabric-ca-server/ca.org5.example.com/fabric-ca-server.db
sudo rm -rf fabric-ca-server/ca.org5.example.com/IssuerPublicKey
sudo rm -rf fabric-ca-server/ca.org5.example.com/IssuerRevocationPublicKey

# sudo rm -rf fabric-ca-server/ca.org6.example.com/msp
# sudo rm -rf fabric-ca-server/ca.org6.example.com/fabric-ca-server.db
# sudo rm -rf fabric-ca-server/ca.org6.example.com/IssuerPublicKey
# sudo rm -rf fabric-ca-server/ca.org6.example.com/IssuerRevocationPublicKey

echo "인증서 발급"
../bin/cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
mkdir channel-artifacts

echo "orderer 채널 생성"
../bin/configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./channel-artifacts/genesis.block -channelID system-channel

echo "mychannel 채널 생성"
../bin/configtxgen -profile MyChannel -outputCreateChannelTx ./channel-artifacts/mychannel.tx -channelID mychannel

echo "org1 앵커피어 생성"
../bin/configtxgen -profile MyChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors.tx -channelID mychannel -asOrg NsmartsMSP

echo "org2 앵커피어 생성"
../bin/configtxgen -profile MyChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceMSPanchors.tx -channelID mychannel -asOrg ViceMSP

echo "org3 앵커피어 생성"
../bin/configtxgen -profile MyChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceKRMSPanchors.tx -channelID mychannel -asOrg ViceKRMSP
