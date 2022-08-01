echo "start Org4 Crypto----------------------------------------------------------------------------------------"

echo "Enrolling the CA admin"

mkdir -p ../crypto-config/peerOrganizations/org4.example.com/

export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/org4.example.com/

set -x
../../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.org4.example.com --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/config.yaml

echo "Registering peer0"
set -x
../../bin/fabric-ca-client register --caname ca.org4.example.com --id.name org4peer0 --id.secret org4peer0pw --id.type peer --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering user"
set -x
../../bin/fabric-ca-client register --caname ca.org4.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the org admin"
set -x
../../bin/fabric-ca-client register --caname ca.org4.example.com --id.name org4admin --id.secret org4adminpw --id.type admin --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer0 msp"
set -x
../../bin/fabric-ca-client enroll -u https://org4peer0:org4peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp --csr.hosts peer0.org4.example.com --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/config.yaml

echo "Generating the peer0-tls certificates"
set -x
../../bin/fabric-ca-client enroll -u https://org4peer0:org4peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls --enrollment.profile tls --csr.hosts peer0.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.crt
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.key

mkdir -p ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/../crypto-config/peerOrganizations/org4.example.com/tlsca
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem

mkdir -p ${PWD}/../crypto-config/peerOrganizations/org4.example.com/ca
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem

echo "Registering peer1"
set -x
../../bin/fabric-ca-client register --caname ca.org4.example.com --id.name org4peer1 --id.secret org4peer1pw --id.type peer --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer1 msp"
set -x
../../bin/fabric-ca-client enroll -u https://org4peer1:org4peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp --csr.hosts peer1.org4.example.com --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/config.yaml

echo "Generating the peer1-tls certificates"
set -x
../../bin/fabric-ca-client enroll -u https://org4peer1:org4peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls --enrollment.profile tls --csr.hosts peer1.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.crt
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.key

mkdir -p ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/../crypto-config/peerOrganizations/org4.example.com/tlsca
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem

mkdir -p ${PWD}/../crypto-config/peerOrganizations/org4.example.com/ca
sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem


echo "Generating the user msp"
set -x
../../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/../crypto-config/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/config.yaml

echo "Generating the org admin msp"
set -x
../../bin/fabric-ca-client enroll -u https://org4admin:org4adminpw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/../crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp --tls.certfiles ${PWD}/../fabric-ca-server/ca.org4.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/../crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp/config.yaml


sudo chmod -R 755 ../crypto-config/peerOrganizations/org4.example.com

# -printOrg 옵션을 사용 하여 이 configtx.yaml 을 기반으로 JSON 파일을 생성. 
# 결과는 org4.json 에 저장되고 vice-network/channel-artifacts 디렉토리에 저장됩니다.
export FABRIC_CFG_PATH=$PWD/ && ../../bin/configtxgen -printOrg Org4MSP > ../channel-artifacts/org4.json

# sudo rm -rf ./../crypto-config