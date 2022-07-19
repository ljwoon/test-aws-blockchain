echo "start Orderer1 Crypto----------------------------------------------------------------------------------------"

echo "Enrolling the CA admin"

mkdir -p crypto-config/ordererOrganizations/example.com

sudo chmod -R 777 ./fabric-ca-server
sudo chmod -R 777 ./crypto-config

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/ordererOrganizations/example.com

set -x
../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:6054 --caname ca.orderer.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

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

echo "Registering the orderer admin"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the orderer msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer:ordererpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

echo "Generating the orderer-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://orderer:ordererpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the admin msp"
set -x
../bin/fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

echo "start Orderer2 Crypto----------------------------------------------------------------------------------------"

echo "Registering orderer2"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer2 --id.secret orderer2pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the orderer2 admin"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer2Admin --id.secret orderer2Adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the orderer2 msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml

echo "Generating the orderer-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls --enrollment.profile tls --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the admin msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer2Admin:orderer2Adminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "start Orderer3 Crypto----------------------------------------------------------------------------------------"

echo "Registering orderer3"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer3 --id.secret orderer3pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the orderer3 admin"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer3Admin --id.secret orderer3Adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the orderer3 msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/config.yaml

echo "Generating the orderer-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls --enrollment.profile tls --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the admin msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer3Admin:orderer3Adminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "start Orderer4 Crypto----------------------------------------------------------------------------------------"

echo "Registering orderer4"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer4 --id.secret orderer4pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the orderer4 admin"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer4Admin --id.secret orderer4Adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the orderer4 msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer4:orderer4pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp --csr.hosts orderer4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp/config.yaml

echo "Generating the orderer-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://orderer4:orderer4pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls --enrollment.profile tls --csr.hosts orderer4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/server.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the admin msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer4Admin:orderer4Adminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "start Orderer5 Crypto----------------------------------------------------------------------------------------"

echo "Registering orderer5"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer5 --id.secret orderer5pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the orderer5 admin"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer5Admin --id.secret orderer5Adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the orderer5 msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer5:orderer5pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp --csr.hosts orderer5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp/config.yaml

echo "Generating the orderer-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://orderer5:orderer5pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls --enrollment.profile tls --csr.hosts orderer5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/server.crt
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/server.key

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Generating the admin msp"
set -x
../bin/fabric-ca-client enroll -u https://orderer5Admin:orderer5Adminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null


# echo "start Orderer6 Crypto----------------------------------------------------------------------------------------"

# echo "Registering orderer6"
# set -x
# ../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer6 --id.secret orderer6pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Registering the orderer6 admin"
# set -x
# ../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer6Admin --id.secret orderer6Adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Generating the orderer6 msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://orderer6:orderer6pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp --csr.hosts orderer6.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp/config.yaml

# echo "Generating the orderer-tls certificates"
# set -x
# ../bin/fabric-ca-client enroll -u https://orderer6:orderer6pw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls --enrollment.profile tls --csr.hosts orderer6.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/ca.crt
# sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/signcerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/server.crt
# sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/keystore/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/server.key

# mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp/tlscacerts
# sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# mkdir -p ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts
# sudo cp ${PWD}/crypto-config/ordererOrganizations/example.com/orderers/orderer6.example.com/tls/tlscacerts/* ${PWD}/crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

# echo "Generating the admin msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://orderer6Admin:orderer6Adminpw@localhost:6054 --caname ca.orderer.example.com -M ${PWD}/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
# { set +x; } 2>/dev/null
 
echo "start Org1 Crypto----------------------------------------------------------------------------------------"

echo "Enrolling the CA admin"

mkdir -p crypto-config/peerOrganizations/nsmarts.co.kr/

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/

set -x
../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-nsmarts-co-kr.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-nsmarts-co-kr.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-nsmarts-co-kr.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-nsmarts-co-kr.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml

echo "Registering peer0"
set -x
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name org1peer0 --id.secret org1peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering user"
set -x
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the org admin"
set -x
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer0 msp"
set -x
../bin/fabric-ca-client enroll -u https://org1peer0:org1peer0pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/msp --csr.hosts peer0.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/msp/config.yaml

echo "Generating the peer0-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org1peer0:org1peer0pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls --enrollment.profile tls --csr.hosts peer0.nsmarts.co.kr --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca/tlsca.nsmarts.co.kr-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer0.nsmarts.co.kr/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca/ca.nsmarts.co.kr-cert.pem


echo "Registering peer1"
set -x
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name org1peer1 --id.secret org1peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer1 msp"
set -x
../bin/fabric-ca-client enroll -u https://org1peer1:org1peer1pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/msp --csr.hosts peer1.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/msp/config.yaml

echo "Generating the peer1-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org1peer1:org1peer1pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls --enrollment.profile tls --csr.hosts peer1.nsmarts.co.kr --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca/tlsca.nsmarts.co.kr-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer1.nsmarts.co.kr/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca/ca.nsmarts.co.kr-cert.pem


echo "Registering peer2"
set -x
../bin/fabric-ca-client register --caname ca.nsmarts.co.kr --id.name org1peer2 --id.secret org1peer2pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer2 msp"
set -x
../bin/fabric-ca-client enroll -u https://org1peer2:org1peer2pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/msp --csr.hosts peer2.nsmarts.co.kr --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/msp/config.yaml

echo "Generating the peer2-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org1peer2:org1peer2pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls --enrollment.profile tls --csr.hosts peer2.nsmarts.co.kr --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/tlsca/tlsca.nsmarts.co.kr-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/peers/peer2.nsmarts.co.kr/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/ca/ca.nsmarts.co.kr-cert.pem


echo "Generating the user msp"
set -x
../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/User1@nsmarts.co.kr/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/User1@nsmarts.co.kr/msp/config.yaml

echo "Generating the org admin msp"
set -x
../bin/fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca.nsmarts.co.kr -M ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/nsmarts.co.kr/users/Admin@nsmarts.co.kr/msp/config.yaml

echo "start Org2 Crypto----------------------------------------------------------------------------------------"

echo "Enrolling the CA admin"

mkdir -p crypto-config/peerOrganizations/vice.com/

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/vice.com/

set -x
../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.vice.com --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-vice-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-vice-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-vice-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-vice-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml

echo "Registering peer0"
set -x
../bin/fabric-ca-client register --caname ca.vice.com --id.name org2peer0 --id.secret org2peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering user"
set -x
../bin/fabric-ca-client register --caname ca.vice.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the org admin"
set -x
../bin/fabric-ca-client register --caname ca.vice.com --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer0 msp"
set -x
../bin/fabric-ca-client enroll -u https://org2peer0:org2peer0pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/msp --csr.hosts peer0.vice.com --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/msp/config.yaml

echo "Generating the peer0-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org2peer0:org2peer0pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls --enrollment.profile tls --csr.hosts peer0.vice.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca/tlsca.vice.com-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer0.vice.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/ca/ca.vice.com-cert.pem

echo "Registering peer1"
set -x
../bin/fabric-ca-client register --caname ca.vice.com --id.name org2peer1 --id.secret org2peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer1 msp"
set -x
../bin/fabric-ca-client enroll -u https://org2peer1:org2peer1pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/msp --csr.hosts peer1.vice.com --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/msp/config.yaml

echo "Generating the peer1-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org2peer1:org2peer1pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls --enrollment.profile tls --csr.hosts peer1.vice.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/tlsca/tlsca.vice.com-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/vice.com/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/peers/peer1.vice.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/vice.com/ca/ca.vice.com-cert.pem


echo "Generating the user msp"
set -x
../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/users/User1@vice.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/users/User1@vice.com/msp/config.yaml

echo "Generating the org admin msp"
set -x
../bin/fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca.vice.com -M ${PWD}/crypto-config/peerOrganizations/vice.com/users/Admin@vice.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.vice.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/vice.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/vice.com/users/Admin@vice.com/msp/config.yaml

echo "start Org3 Crypto----------------------------------------------------------------------------------------"

echo "Enrolling the CA admin"

mkdir -p crypto-config/peerOrganizations/viceKR.com/

export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/viceKR.com/

set -x
../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca.viceKR.com --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-viceKR-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-viceKR-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-viceKR-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-viceKR-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml

echo "Registering peer0"
set -x
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name org3peer0 --id.secret org3peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering user"
set -x
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Registering the org admin"
set -x
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name org3admin --id.secret org3adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer0 msp"
set -x
../bin/fabric-ca-client enroll -u https://org3peer0:org3peer0pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/msp --csr.hosts peer0.viceKR.com --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/msp/config.yaml

echo "Generating the peer0-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org3peer0:org3peer0pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls --enrollment.profile tls --csr.hosts peer0.viceKR.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca/tlsca.viceKR.com-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer0.viceKR.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca/ca.viceKR.com-cert.pem


echo "Registering peer1"
set -x
../bin/fabric-ca-client register --caname ca.viceKR.com --id.name org3peer1 --id.secret org3peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

echo "Generating the peer1 msp"
set -x
../bin/fabric-ca-client enroll -u https://org3peer1:org3peer1pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/msp --csr.hosts peer1.viceKR.com --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/msp/config.yaml

echo "Generating the peer1-tls certificates"
set -x
../bin/fabric-ca-client enroll -u https://org3peer1:org3peer1pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls --enrollment.profile tls --csr.hosts peer1.viceKR.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/ca.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/server.crt
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/server.key

mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/tlscacerts/ca.crt

mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/tlsca/tlsca.viceKR.com-cert.pem

mkdir -p ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca
sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/peers/peer1.viceKR.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/viceKR.com/ca/ca.viceKR.com-cert.pem



echo "Generating the user msp"
set -x
../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/User1@viceKR.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/User1@viceKR.com/msp/config.yaml

echo "Generating the org admin msp"
set -x
../bin/fabric-ca-client enroll -u https://org3admin:org3adminpw@localhost:9054 --caname ca.viceKR.com -M ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.viceKR.com/tls-cert.pem
{ set +x; } 2>/dev/null

sudo cp ${PWD}/crypto-config/peerOrganizations/viceKR.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/viceKR.com/users/Admin@viceKR.com/msp/config.yaml

# echo "start Org4 Crypto----------------------------------------------------------------------------------------"

# echo "Enrolling the CA admin"

# mkdir -p crypto-config/peerOrganizations/org4.example.com/

# export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/org4.example.com/

# set -x
# ../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.org4.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

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
# set -x
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name org4peer0 --id.secret org4peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Registering user"
# set -x
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Registering the org admin"
# set -x
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name org4admin --id.secret org4adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Generating the peer0 msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://org4peer0:org4peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp --csr.hosts peer0.org4.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/config.yaml

# echo "Generating the peer0-tls certificates"
# set -x
# ../bin/fabric-ca-client enroll -u https://org4peer0:org4peer0pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls --enrollment.profile tls --csr.hosts peer0.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/ca.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/server.key

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer0.org4.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem

# echo "Registering peer1"
# set -x
# ../bin/fabric-ca-client register --caname ca.org4.example.com --id.name org4peer1 --id.secret org4peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Generating the peer1 msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://org4peer1:org4peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp --csr.hosts peer1.org4.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/config.yaml

# echo "Generating the peer1-tls certificates"
# set -x
# ../bin/fabric-ca-client enroll -u https://org4peer1:org4peer1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls --enrollment.profile tls --csr.hosts peer1.org4.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/ca.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/server.key

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/tlscacerts/ca.crt

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/tlsca/tlsca.org4.example.com-cert.pem

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/peers/peer1.org4.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org4.example.com/ca/ca.org4.example.com-cert.pem


# echo "Generating the user msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/User1@org4.example.com/msp/config.yaml

# echo "Generating the org admin msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://org4admin:org4adminpw@localhost:10054 --caname ca.org4.example.com -M ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org4.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org4.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org4.example.com/users/Admin@org4.example.com/msp/config.yaml

# echo "start Org5 Crypto----------------------------------------------------------------------------------------"

# echo "Enrolling the CA admin"

# mkdir -p crypto-config/peerOrganizations/org5.example.com/

# export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/peerOrganizations/org5.example.com/

# set -x
# ../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca.org5.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

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
# set -x
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name org5peer0 --id.secret org5peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Registering user"
# set -x
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Registering the org admin"
# set -x
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name org5admin --id.secret org5adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Generating the peer0 msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://org5peer0:org5peer0pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp --csr.hosts peer0.org5.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp/config.yaml

# echo "Generating the peer0-tls certificates"
# set -x
# ../bin/fabric-ca-client enroll -u https://org5peer0:org5peer0pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls --enrollment.profile tls --csr.hosts peer0.org5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/ca.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/server.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/server.key

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts/ca.crt

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer0.org5.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca/ca.org5.example.com-cert.pem

# echo "Registering peer1"
# set -x
# ../bin/fabric-ca-client register --caname ca.org5.example.com --id.name org5peer1 --id.secret org5peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# echo "Generating the peer1 msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://org5peer1:org5peer1pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp --csr.hosts peer1.org5.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp/config.yaml

# echo "Generating the peer1-tls certificates"
# set -x
# ../bin/fabric-ca-client enroll -u https://org5peer1:org5peer1pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls --enrollment.profile tls --csr.hosts peer1.org5.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/ca.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/signcerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/server.crt
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/keystore/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/server.key

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/tlscacerts/ca.crt

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/tls/tlscacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/tlsca/tlsca.org5.example.com-cert.pem

# mkdir -p ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca
# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/peers/peer1.org5.example.com/msp/cacerts/* ${PWD}/crypto-config/peerOrganizations/org5.example.com/ca/ca.org5.example.com-cert.pem


# echo "Generating the user msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/User1@org5.example.com/msp/config.yaml

# echo "Generating the org admin msp"
# set -x
# ../bin/fabric-ca-client enroll -u https://org5admin:org5adminpw@localhost:11054 --caname ca.org5.example.com -M ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp --tls.certfiles ${PWD}/fabric-ca-server/ca.org5.example.com/tls-cert.pem
# { set +x; } 2>/dev/null

# sudo cp ${PWD}/crypto-config/peerOrganizations/org5.example.com/msp/config.yaml ${PWD}/crypto-config/peerOrganizations/org5.example.com/users/Admin@org5.example.com/msp/config.yaml

./generateSys.sh
