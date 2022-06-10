docker-compose -f ordererCA.yaml -f host1CA.yaml -f host2CA.yaml -f host3CA.yaml down -v
docker-compose -f ordererCA.yaml -f host1CA.yaml -f host2CA.yaml -f host3CA.yaml rm -v
docker volume prune

sudo rm -rf ../crypto-config/peerOrganizations/nsmarts.co.kr/ca
sudo rm -rf ../crypto-config/peerOrganizations/nsmarts.co.kr/msp
sudo rm -rf ../crypto-config/peerOrganizations/nsmarts.co.kr/peers
sudo rm -rf ../crypto-config/peerOrganizations/nsmarts.co.kr/tlsca
sudo rm -rf ../crypto-config/peerOrganizations/nsmarts.co.kr/users

sudo rm -rf ../crypto-config/peerOrganizations/vice.com/ca
sudo rm -rf ../crypto-config/peerOrganizations/vice.com/msp
sudo rm -rf ../crypto-config/peerOrganizations/vice.com/peers
sudo rm -rf ../crypto-config/peerOrganizations/vice.com/tlsca
sudo rm -rf ../crypto-config/peerOrganizations/vice.com/users

sudo rm -rf ../crypto-config/peerOrganizations/viceKR.com/ca
sudo rm -rf ../crypto-config/peerOrganizations/viceKR.com/msp
sudo rm -rf ../crypto-config/peerOrganizations/viceKR.com/peers
sudo rm -rf ../crypto-config/peerOrganizations/viceKR.com/tlsca
sudo rm -rf ../crypto-config/peerOrganizations/viceKR.com/users

sudo rm -rf ../crypto-config/peerOrganizations/org4.example.com/ca
sudo rm -rf ../crypto-config/peerOrganizations/org4.example.com/msp
sudo rm -rf ../crypto-config/peerOrganizations/org4.example.com/peers
sudo rm -rf ../crypto-config/peerOrganizations/org4.example.com/tlsca
sudo rm -rf ../crypto-config/peerOrganizations/org4.example.com/users

sudo rm -rf ../crypto-config/peerOrganizations/org5.example.com/ca
sudo rm -rf ../crypto-config/peerOrganizations/org5.example.com/msp
sudo rm -rf ../crypto-config/peerOrganizations/org5.example.com/peers
sudo rm -rf ../crypto-config/peerOrganizations/org5.example.com/tlsca
sudo rm -rf ../crypto-config/peerOrganizations/org5.example.com/users

sudo rm -rf ../crypto-config/ordererOrganizations/example.com/ca
sudo rm -rf ../crypto-config/ordererOrganizations/example.com/tlsca
sudo rm -rf ../crypto-config/ordererOrganizations/example.com/msp
sudo rm -rf ../crypto-config/ordererOrganizations/example.com/orderers
sudo rm -rf ../crypto-config/ordererOrganizations/example.com/users

# # sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/fabric-ca-server-config.yaml
# sudo rm -rf ../fabric-ca-server/ca.tls.example.com/msp
# sudo rm -rf ../fabric-ca-server/ca.tls.example.com/fabric-ca-server.db
# sudo rm -rf ../fabric-ca-server/ca.tls.example.com/IssuerPublicKey
# sudo rm -rf ../fabric-ca-server/ca.tls.example.com/IssuerRevocationPublicKey
# sudo rm -rf ../fabric-ca-server/ca.tls.example.com/tls-cert.pem
# sudo rm -rf ../fabric-ca-server/ca.tls.example.com/ca-cert.pem

# sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/fabric-ca-server-config.yaml
sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/msp
sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/fabric-ca-server.db
sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/IssuerPublicKey
sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/IssuerRevocationPublicKey
sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/tls-cert.pem
sudo rm -rf ../fabric-ca-server/ca.nsmarts.co.kr/ca-cert.pem

# sudo rm -rf ../fabric-ca-server/ca.vice.com/fabric-ca-server-config.yaml
sudo rm -rf ../fabric-ca-server/ca.vice.com/msp
sudo rm -rf ../fabric-ca-server/ca.vice.com/fabric-ca-server.db
sudo rm -rf ../fabric-ca-server/ca.vice.com/IssuerPublicKey
sudo rm -rf ../fabric-ca-server/ca.vice.com/IssuerRevocationPublicKey
sudo rm -rf ../fabric-ca-server/ca.vice.com/tls-cert.pem
sudo rm -rf ../fabric-ca-server/ca.vice.com/ca-cert.pem

# sudo rm -rf ../fabric-ca-server/ca.viceKR.com/fabric-ca-server-config.yaml
sudo rm -rf ../fabric-ca-server/ca.viceKR.com/msp
sudo rm -rf ../fabric-ca-server/ca.viceKR.com/fabric-ca-server.db
sudo rm -rf ../fabric-ca-server/ca.viceKR.com/IssuerPublicKey
sudo rm -rf ../fabric-ca-server/ca.viceKR.com/IssuerRevocationPublicKey
sudo rm -rf ../fabric-ca-server/ca.viceKR.com/tls-cert.pem
sudo rm -rf ../fabric-ca-server/ca.viceKR.com/ca-cert.pem

# sudo rm -rf ../fabric-ca-server/ca.org4.example.com/fabric-ca-server-config.yaml
sudo rm -rf ../fabric-ca-server/ca.org4.example.com/msp
sudo rm -rf ../fabric-ca-server/ca.org4.example.com/fabric-ca-server.db
sudo rm -rf ../fabric-ca-server/ca.org4.example.com/IssuerPublicKey
sudo rm -rf ../fabric-ca-server/ca.org4.example.com/IssuerRevocationPublicKey
sudo rm -rf ../fabric-ca-server/ca.org4.example.com/tls-cert.pem
sudo rm -rf ../fabric-ca-server/ca.org4.example.com/ca-cert.pem

# sudo rm -rf ../fabric-ca-server/ca.org5.example.com/fabric-ca-server-config.yaml
sudo rm -rf ../fabric-ca-server/ca.org5.example.com/msp
sudo rm -rf ../fabric-ca-server/ca.org5.example.com/fabric-ca-server.db
sudo rm -rf ../fabric-ca-server/ca.org5.example.com/IssuerPublicKey
sudo rm -rf ../fabric-ca-server/ca.org5.example.com/IssuerRevocationPublicKey
sudo rm -rf ../fabric-ca-server/ca.org5.example.com/tls-cert.pem
sudo rm -rf ../fabric-ca-server/ca.org5.example.com/ca-cert.pem

# sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/fabric-ca-server-config.yaml
sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/msp
sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/fabric-ca-server.db
sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/IssuerPublicKey
sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/IssuerRevocationPublicKey
sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/tls-cert.pem
sudo rm -rf ../fabric-ca-server/ca.orderer.example.com/ca-cert.pem
