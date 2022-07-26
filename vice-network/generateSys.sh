sudo rm -rf channel-artifacts

echo "인증서 발급"
export FABRIC_CFG_PATH=$PWD
mkdir channel-artifacts

echo "orderer 채널 생성"
../bin/configtxgen -profile SampleMultiNodeEtcdRaft -outputBlock ./channel-artifacts/genesis.block -channelID system-channel

# ---------------------------------------------------------------------------------------------------------------

echo "ViceKRChannel 채널 생성"
../bin/configtxgen -profile ViceKRChannel -outputCreateChannelTx ./channel-artifacts/vicekrchannel.tx -channelID vicekrchannel

echo "org1 앵커피어 생성"
../bin/configtxgen -profile ViceKRChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors_ViceKRChannel.tx -channelID vicekrchannel -asOrg NsmartsMSP

echo "org2 앵커피어 생성"
../bin/configtxgen -profile ViceKRChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceMSPanchors_ViceKRChannel.tx -channelID vicekrchannel -asOrg ViceMSP

echo "org3 앵커피어 생성"
../bin/configtxgen -profile ViceKRChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceKRMSPanchors_ViceKRChannel.tx -channelID vicekrchannel -asOrg ViceKRMSP

# ---------------------------------------------------------------------------------------------------------------

echo "ViceChannel 채널 생성"
../bin/configtxgen -profile ViceChannel -outputCreateChannelTx ./channel-artifacts/vicechannel.tx -channelID vicechannel

echo "org1 앵커피어 생성"
../bin/configtxgen -profile ViceChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors_ViceChannel.tx -channelID vicechannel -asOrg NsmartsMSP

echo "org2 앵커피어 생성"
../bin/configtxgen -profile ViceChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceMSPanchors_ViceChannel.tx -channelID vicechannel -asOrg ViceMSP


# ---------------------------------------------------------------------------------------------------------------

echo "NsmartsChannel 채널 생성"
../bin/configtxgen -profile NsmartsChannel -outputCreateChannelTx ./channel-artifacts/nsmartschannel.tx -channelID nsmartschannel

echo "org1 앵커피어 생성"
../bin/configtxgen -profile NsmartsChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors_NsmartsChannel.tx -channelID nsmartschannel -asOrg NsmartsMSP


sudo chmod -R 755 ./crypto-config
sudo chmod -R 755 ./fabric-ca-server
