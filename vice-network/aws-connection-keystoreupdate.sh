echo 'printing keystore for Org1'

ORG_1_KEYSTORE=$(ls /home/ubuntu/go/src/github.com/hyperledger/fabric-network/vice-network/crypto-config/peerOrganizations/nsmarts.co.kr/users/Admin\@nsmarts.co.kr/msp/keystore/)
ORG_2_KEYSTORE=$(ls /home/ubuntu/go/src/github.com/hyperledger/fabric-network/vice-network/crypto-config/peerOrganizations/vice.com/users/Admin\@vice.com/msp/keystore/)
ORG_3_KEYSTORE=$(ls /home/ubuntu/go/src/github.com/hyperledger/fabric-network/vice-network/crypto-config/peerOrganizations/viceKR.com/users/Admin\@viceKR.com/msp/keystore/)

ORG_1_PATH_TO_KEYSTORE="Admin@nsmarts.co.kr/msp/keystore/"
ORG_2_PATH_TO_KEYSTORE="Admin@vice.com/msp/keystore/"
ORG_3_PATH_TO_KEYSTORE="Admin@viceKR.com/msp/keystore/"


UPDATED_KEYSTORE_ORG_1="$ORG_1_PATH_TO_KEYSTORE$ORG_1_KEYSTORE"
UPDATED_KEYSTORE_ORG_2="$ORG_2_PATH_TO_KEYSTORE$ORG_2_KEYSTORE"
UPDATED_KEYSTORE_ORG_3="$ORG_3_PATH_TO_KEYSTORE$ORG_3_KEYSTORE"

echo $UPDATED_KEYSTORE_ORG_1

# sed -i "s|keystore/.*|${UPDATED_KEYSTORE}|g" connection.yaml
# .* is regex-ese for "any character followed by zero or more of any character(s)"

echo 'updating connection.yaml Org1 adminPrivateKey path with' ${UPDATED_KEYSTORE_ORG_1}

sed -i -e "s|Admin@nsmarts.co.kr/msp/keystore/.*|$UPDATED_KEYSTORE_ORG_1|g" connection.yaml

echo 'updating connection.yaml Org2 adminPrivateKey path with' ${UPDATED_KEYSTORE_ORG_2}

sed -i -e "s|Admin@vice.com/msp/keystore/.*|$UPDATED_KEYSTORE_ORG_2|g" connection.yaml

echo 'updating connection.yaml Org3 adminPrivateKey path with' ${UPDATED_KEYSTORE_ORG_3}

sed -i -e "s|Admin@viceKR.com/msp/keystore/.*|$UPDATED_KEYSTORE_ORG_3|g" connection.yaml
