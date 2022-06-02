sudo chmod -R 777 ./crypto-config
sudo chmod -R 777 ./fabric-ca-server


echo "start ca.orderer.example.com----------------------------------------------------------------------------------------"

mkdir -p ./crypto-config/ordererOrganizations/example.com

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/ordererOrganizations/example.com/

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:6054 --caname ca.orderer.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-6054-ca-orderer-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-6054-ca-orderer-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-6054-ca-orderer-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-6054-ca-orderer-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml

echo "Registering orderer"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering orderer2"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer2 --id.secret orderer2pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering orderer3"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer3 --id.secret orderer3pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering orderer4"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer4 --id.secret orderer4pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering orderer5"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer5 --id.secret orderer5pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering orderer6"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer6 --id.secret orderer6pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the orderer admin"
# ../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

echo "Generating the orderer msp"
../bin/fabric-ca-client enroll -u https://orderer:ordererpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

echo "Generating the orderer-tls certificates"
../bin/fabric-ca-client enroll -u https://orderer:ordererpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the orderer2 msp"
../bin/fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml

echo "Generating the orderer2-tls certificates"
../bin/fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls --enrollment.profile tls --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the orderer3 msp"
../bin/fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/config.yaml

echo "Generating the orderer3-tls certificates"
../bin/fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls --enrollment.profile tls --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the orderer4 msp"
../bin/fabric-ca-client enroll -u https://orderer4:orderer4pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp --csr.hosts orderer4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp/config.yaml

echo "Generating the orderer4-tls certificates"
../bin/fabric-ca-client enroll -u https://orderer4:orderer4pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls --enrollment.profile tls --csr.hosts orderer4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/ca.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/server.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the orderer5 msp"
../bin/fabric-ca-client enroll -u https://orderer5:orderer5pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp --csr.hosts orderer5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp/config.yaml

echo "Generating the orderer5-tls certificates"
../bin/fabric-ca-client enroll -u https://orderer5:orderer5pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls --enrollment.profile tls --csr.hosts orderer5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/ca.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/server.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the orderer6 msp"
../bin/fabric-ca-client enroll -u https://orderer6:orderer6pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp --csr.hosts orderer6.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp/config.yaml

echo "Generating the orderer6-tls certificates"
../bin/fabric-ca-client enroll -u https://orderer6:orderer6pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls --enrollment.profile tls --csr.hosts orderer6.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/ca.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/server.crt
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem


echo "Generating the admin msp"
../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

echo "start ca.nsmarts.co.kr----------------------------------------------------------------------------------------"

mkdir -p ./crypto-config/peerOrganizations/nsmarts.co.kr/

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-org1-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml

echo "Registering peer0"
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem 

echo "Registering peer1"
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem 

echo "Registering user1"
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

# echo "Registering the org admin"
# ../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

echo "Generating the peer0 msp"
../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/msp --csr.hosts peer0.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/msp/config.yaml

echo "Generating the peer1 msp"
../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/msp --csr.hosts peer1.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/msp/config.yaml


echo "Generating the peer0-tls certificates"

../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls --enrollment.profile tls --csr.hosts peer0.nsmarts.co.kr --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/server.key
mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts/ca.crt
mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca/tlsca.nsmarts.co.kr-cert.pem
mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca/ca.nsmarts.co.kr-cert.pem

echo "Generating the peer1-tls certificates"

../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls --enrollment.profile tls --csr.hosts peer1.nsmarts.co.kr --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/server.key
mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts/ca.crt
mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca/tlsca.nsmarts.co.kr-cert.pem
mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca/ca.nsmarts.co.kr-cert.pem


echo "Generating the user msp"

../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/User1@nsmarts.co.kr/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/User1@nsmarts.co.kr/msp/config.yaml

echo "Generating the org admin msp"

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp/config.yaml


echo "start ca.vice.com----------------------------------------------------------------------------------------"

mkdir -p ./crypto-config/peerOrganizations/vice.com/


export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/vice.com/

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.vice.com --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml

echo "Registering peer0"
../bin/fabric-ca-client register --caname ca.vice.com --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem 

echo "Registering peer1"
../bin/fabric-ca-client register --caname ca.vice.com --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem 

echo "Registering user1"
../bin/fabric-ca-client register --caname ca.vice.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

# echo "Registering the org admin"
# ../bin/fabric-ca-client register --caname ca.vice.com --id.name admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

echo "Generating the peer0 msp"
../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/msp --csr.hosts peer0.vice.com --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/msp/config.yaml

echo "Generating the peer1 msp"
../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/msp --csr.hosts peer1.vice.com --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/msp/config.yaml


echo "Generating the peer0-tls certificates"

../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls --enrollment.profile tls --csr.hosts peer0.vice.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/server.key
mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts/ca.crt
mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca/tlsca.vice.com-cert.pem
mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/ca
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/ca/ca.vice.com-cert.pem

echo "Generating the peer1-tls certificates"

../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls --enrollment.profile tls --csr.hosts peer1.vice.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/server.key
mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts/ca.crt
mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca/tlsca.vice.com-cert.pem
mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/ca
cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/ca/ca.vice.com-cert.pem


echo "Generating the user msp"

../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/users/User1@vice.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/users/User1@vice.com/msp/config.yaml

echo "Generating the org admin msp"

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/users/Admin@vice.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/users/Admin@vice.com/msp/config.yaml


echo "start ca.viceKR.com----------------------------------------------------------------------------------------"

mkdir -p ./crypto-config/peerOrganizations/viceKR.com/

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/viceKR.com/

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.viceKR.com --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-org3-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml

echo "Registering peer0"
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem 

echo "Registering peer1"
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem 

echo "Registering user1"
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

# echo "Registering the org admin"
# ../bin/fabric-ca-client register --caname ca.viceKR.com --id.name admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

echo "Generating the peer0 msp"
../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/msp --csr.hosts peer0.viceKR.com --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/msp/config.yaml

echo "Generating the peer1 msp"
../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/msp --csr.hosts peer1.viceKR.com --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/msp/config.yaml


echo "Generating the peer0-tls certificates"

../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls --enrollment.profile tls --csr.hosts peer0.viceKR.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/server.key
mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts/ca.crt
mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca/tlsca.viceKR.com-cert.pem
mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca/ca.viceKR.com-cert.pem

echo "Generating the peer1-tls certificates"

../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls --enrollment.profile tls --csr.hosts peer1.viceKR.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/server.crt
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/server.key
mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts/ca.crt
mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca/tlsca.viceKR.com-cert.pem
mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca/ca.viceKR.com-cert.pem


echo "Generating the user msp"

../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/User1@viceKR.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/User1@viceKR.com/msp/config.yaml

echo "Generating the org admin msp"

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem

cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp/config.yaml


# echo "start ca.org4.example.com----------------------------------------------------------------------------------------"

# mkdir -p ./crypto-config/peerOrganizations/org4.example.com/

# export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/org4.example.com/

# ../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.org4.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# echo 'NodeOUs:
#   Enable: true
#   ClientOUIdentifier:
#     Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
#     OrganizationalUnitIdentifier: client
#   PeerOUIdentifier:
#     Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
#     OrganizationalUnitIdentifier: peer
#   AdminOUIdentifier:
#     Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
#     OrganizationalUnitIdentifier: admin
#   OrdererOUIdentifier:
#     Certificate: cacerts/localhost-10054-ca-org4-example-com.pem
#     OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml

# echo "Registering peer0"
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem 

# echo "Registering peer1"
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem 

# echo "Registering user1"
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# # echo "Registering the org admin"
# # ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# echo "Generating the peer0 msp"
# ../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp --csr.hosts peer0.org4.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/config.yaml

# echo "Generating the peer0 msp"
# ../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp --csr.hosts peer1.org4.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/config.yaml


# echo "Generating the peer0-tls certificates"

# ../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls --enrollment.profile tls --csr.hosts peer0.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.crt
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.key
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem

# echo "Generating the peer1-tls certificates"

# ../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls --enrollment.profile tls --csr.hosts peer1.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.crt
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.key
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem


# echo "Generating the user msp"

# ../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/config.yaml

# echo "Generating the org admin msp"

# ../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp/config.yaml


# echo "start ca.org5.example.com----------------------------------------------------------------------------------------"

# mkdir -p ./crypto-config/peerOrganizations/org5.example.com/

# export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/org5.example.com/

# ../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca.org5.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# echo 'NodeOUs:
#   Enable: true
#   ClientOUIdentifier:
#     Certificate: cacerts/localhost-11054-ca-org5-example-com.pem
#     OrganizationalUnitIdentifier: client
#   PeerOUIdentifier:
#     Certificate: cacerts/localhost-11054-ca-org5-example-com.pem
#     OrganizationalUnitIdentifier: peer
#   AdminOUIdentifier:
#     Certificate: cacerts/localhost-11054-ca-org5-example-com.pem
#     OrganizationalUnitIdentifier: admin
#   OrdererOUIdentifier:
#     Certificate: cacerts/localhost-11054-ca-org5-example-com.pem
#     OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml

# echo "Registering peer0"
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name peer0 --id.secret peer0pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem 

# echo "Registering peer1"
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name peer1 --id.secret peer1pw --id.type peer --id.attrs '"hf.Registrar.Roles=peer"' --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem 

# echo "Registering user1"
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# # echo "Registering the org admin"
# # ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name admin --id.secret adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# echo "Generating the peer0 msp"
# ../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp --csr.hosts peer0.org5.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp/config.yaml

# echo "Generating the peer0 msp"
# ../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp --csr.hosts peer1.org5.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp/config.yaml


# echo "Generating the peer0-tls certificates"

# ../bin/fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls --enrollment.profile tls --csr.hosts peer0.org5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/server.crt
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/server.key
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts/ca.crt
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca/ca.org5.example.com-cert.pem

# echo "Generating the peer1-tls certificates"

# ../bin/fabric-ca-client enroll -u https://peer1:peer1pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls --enrollment.profile tls --csr.hosts peer1.org5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/ca.crt
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/server.crt
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/server.key
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts/ca.crt
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem
# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca/ca.org5.example.com-cert.pem


# echo "Generating the user msp"

# ../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/config.yaml

# echo "Generating the org admin msp"

# ../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem

# cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp/config.yaml


# # sudo chmod -R 755 ./crypto-config
# # sudo chmod -R 755 ./fabric-ca-server
