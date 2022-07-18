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
../bin/configtxgen -profile ViceKRChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors.tx -channelID vicekrchannel -asOrg NsmartsMSP

echo "org2 앵커피어 생성"
../bin/configtxgen -profile ViceKRChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceMSPanchors.tx -channelID vicekrchannel -asOrg ViceMSP

echo "org3 앵커피어 생성"
../bin/configtxgen -profile ViceKRChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceKRMSPanchors.tx -channelID vicekrchannel -asOrg ViceKRMSP

# ---------------------------------------------------------------------------------------------------------------

echo "ViceChannel 채널 생성"
../bin/configtxgen -profile ViceChannel -outputCreateChannelTx ./channel-artifacts/vicechannel.tx -channelID vicechannel

echo "org1 앵커피어 생성"
../bin/configtxgen -profile ViceChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors.tx -channelID vicechannel -asOrg NsmartsMSP

echo "org2 앵커피어 생성"
../bin/configtxgen -profile ViceChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceMSPanchors.tx -channelID vicechannel -asOrg ViceMSP

echo "org3 앵커피어 생성"
../bin/configtxgen -profile ViceChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceKRMSPanchors.tx -channelID vicechannel -asOrg ViceKRMSP

# ---------------------------------------------------------------------------------------------------------------

echo "NsmartsChannel 채널 생성"
../bin/configtxgen -profile NsmartsChannel -outputCreateChannelTx ./channel-artifacts/nsmartschannel.tx -channelID nsmartschannel

echo "org1 앵커피어 생성"
../bin/configtxgen -profile NsmartsChannel -outputAnchorPeersUpdate ./channel-artifacts/NsmartsMSPanchors.tx -channelID nsmartschannel -asOrg NsmartsMSP

echo "org2 앵커피어 생성"
../bin/configtxgen -profile NsmartsChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceMSPanchors.tx -channelID nsmartschannel -asOrg ViceMSP

echo "org3 앵커피어 생성"
../bin/configtxgen -profile NsmartsChannel -outputAnchorPeersUpdate ./channel-artifacts/ViceKRMSPanchors.tx -channelID nsmartschannel -asOrg ViceKRMSP
