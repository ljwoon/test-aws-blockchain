sudo rm -rf channel-artifacts

echo "인증서 발급"
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
