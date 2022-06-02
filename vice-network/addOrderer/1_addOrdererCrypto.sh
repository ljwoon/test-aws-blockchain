export FABRIC_CA_CLIENT_HOME=${PWD}/crypto-config/ordererOrganizations/example.com/

../bin/fabric-ca-client enroll -u https://admin:adminpw@localhost:6054 --caname ca.orderer.example.com --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem

echo "Registering orderer6"
set -x
../bin/fabric-ca-client register --caname ca.orderer.example.com --id.name orderer6 --id.secret orderer6pw --id.type orderer --tls.certfiles ${PWD}/fabric-ca-server/ca.orderer.example.com/tls-cert.pem
{ set +x; } 2>/dev/null

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
