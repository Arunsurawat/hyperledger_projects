#!/bin/bash

function createManOrg2() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/manorg2.supplychain.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/

  set -x
  fabric-ca-client enroll -u https://adminman:adminpw@localhost:8054 --caname ca-manorg2 --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manorg2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manorg2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manorg2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manorg2.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-manorg2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-manorg2 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-manorg2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-manorg2 --id.name manorg2admin --id.secret manorg2adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-manorg2 -M "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/msp" --csr.hosts peer0.manorg2.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-manorg2 -M "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer0.manorg2.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/tlsca/tlsca.manorg2.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/ca"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/ca/ca.manorg2.supplychain.com-cert.pem"

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-manorg2 -M "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/msp" --csr.hosts peer1.manorg2.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/msp/config.yaml"

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca-manorg2 -M "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer1.manorg2.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/server.key"

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/tlscacerts/ca.crt"

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/tlsca/tlsca.manorg2.supplychain.com-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/ca/ca.manorg2.supplychain.com-cert.pem"


  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-manorg2 -M "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/users/User1@manorg2.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/users/User1@manorg2.supplychain.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://manorg2admin:manorg2adminpw@localhost:8054 --caname ca-manorg2 -M "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/users/Admin@manorg2.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/manorg2/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/users/Admin@manorg2.supplychain.com/msp/config.yaml"
}

function createWholeOrg3() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/wholeorg3.supplychain.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/

  set -x
  fabric-ca-client enroll -u https://adminwhole:adminpw@localhost:12054 --caname ca-wholeorg3 --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-wholeorg3.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-wholeorg3.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-wholeorg3.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-wholeorg3.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-wholeorg3 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-wholeorg3 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-wholeorg3 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-wholeorg3 --id.name wholeorg3admin --id.secret wholeorg3adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca-wholeorg3 -M "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/msp" --csr.hosts peer0.wholeorg3.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca-wholeorg3 -M "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer0.wholeorg3.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/tlsca/tlsca.wholeorg3.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/ca"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/ca/ca.wholeorg3.supplychain.com-cert.pem"

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:12054 --caname ca-wholeorg3 -M "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/msp" --csr.hosts peer1.wholeorg3.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/msp/config.yaml"

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:12054 --caname ca-wholeorg3 -M "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer1.wholeorg3.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/server.key"

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/tlscacerts/ca.crt"

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/tlsca/tlsca.wholeorg3.supplychain.com-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/ca/ca.wholeorg3.supplychain.com-cert.pem"


  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:12054 --caname ca-wholeorg3 -M "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/users/User1@wholeorg3.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/users/User1@wholeorg3.supplychain.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://wholeorg3admin:wholeorg3adminpw@localhost:12054 --caname ca-wholeorg3 -M "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/users/Admin@wholeorg3.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/wholeorg3/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/users/Admin@wholeorg3.supplychain.com/msp/config.yaml"
}

function createRetailOrg4() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/retailorg4.supplychain.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/

  set -x
  fabric-ca-client enroll -u https://adminretail:adminpw@localhost:10054 --caname ca-retailorg4 --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-retailorg4.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-retailorg4.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-retailorg4.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-retailorg4.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-retailorg4 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-retailorg4 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-retailorg4 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-retailorg4 --id.name retailorg4admin --id.secret retailorg4adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-retailorg4 -M "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/msp" --csr.hosts peer0.retailorg4.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca-retailorg4 -M "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer0.retailorg4.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/tlsca/tlsca.retailorg4.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/ca"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/ca/ca.retailorg4.supplychain.com-cert.pem"

  infoln "Generating the peer1 msp"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca-retailorg4 -M "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/msp" --csr.hosts peer1.retailorg4.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/msp/config.yaml"

  infoln "Generating the peer1-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:10054 --caname ca-retailorg4 -M "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer1.retailorg4.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/server.key"

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/tlscacerts/ca.crt"

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/tlsca/tlsca.retailorg4.supplychain.com-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/ca/ca.retailorg4.supplychain.com-cert.pem"


  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca-retailorg4 -M "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/users/User1@retailorg4.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/users/User1@retailorg4.supplychain.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://retailorg4admin:retailorg4adminpw@localhost:10054 --caname ca-retailorg4 -M "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/users/Admin@retailorg4.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/retailorg4/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/users/Admin@retailorg4.supplychain.com/msp/config.yaml"
}

function createCustOrg5() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/custorg5.supplychain.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/

  set -x
  fabric-ca-client enroll -u https://admincust:adminpw@localhost:11054 --caname ca-custorg5 --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-custorg5.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-custorg5.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-custorg5.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-custorg5.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-custorg5 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-custorg5 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-custorg5 --id.name custorg5admin --id.secret custorg5adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-custorg5 -M "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/msp" --csr.hosts peer0.custorg5.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-custorg5 -M "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer0.custorg5.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/tlsca/tlsca.custorg5.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/ca"
  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/ca/ca.custorg5.supplychain.com-cert.pem"

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-custorg5 -M "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/users/User1@custorg5.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/users/User1@custorg5.supplychain.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://custorg5admin:custorg5adminpw@localhost:11054 --caname ca-custorg5 -M "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/users/Admin@custorg5.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/custorg5/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/users/Admin@custorg5.supplychain.com/msp/config.yaml"
}

function createFarmOrg1() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/peerOrganizations/farmorg1.supplychain.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/

  set -x
  fabric-ca-client enroll -u https://adminfarm:adminpw@localhost:7054 --caname ca-farmorg1 --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmorg1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmorg1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmorg1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmorg1.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/msp/config.yaml"

  infoln "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-farmorg1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering user"
  set -x
  fabric-ca-client register --caname ca-farmorg1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-farmorg1 --id.name farmorg1admin --id.secret farmorg1adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-farmorg1 -M "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/msp" --csr.hosts peer0.farmorg1.supplychain.com --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/msp/config.yaml"

  infoln "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-farmorg1 -M "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls" --enrollment.profile tls --csr.hosts peer0.farmorg1.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/tlsca"
  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/tlsca/tlsca.farmorg1.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/ca"
  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/msp/cacerts/"* "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/ca/ca.farmorg1.supplychain.com-cert.pem"

  infoln "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-farmorg1 -M "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/users/User1@farmorg1.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/users/User1@farmorg1.supplychain.com/msp/config.yaml"

  infoln "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://farmorg1admin:farmorg1adminpw@localhost:7054 --caname ca-farmorg1 -M "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/users/Admin@farmorg1.supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/farmorg1/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/users/Admin@farmorg1.supplychain.com/msp/config.yaml"
}

function createOrderer() {
  infoln "Enrolling the CA admin"
  mkdir -p organizations/ordererOrganizations/supplychain.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/supplychain.com

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/config.yaml"

  infoln "Registering orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Registering the orderer admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp" --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/config.yaml"

  infoln "Generating the orderer-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls" --enrollment.profile tls --csr.hosts orderer.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/signcerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/keystore/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem"

  infoln "Registering orderer2"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret orderer2pw --id.type orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null


  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp" --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/config.yaml"

  infoln "Generating the orderer2-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer2:orderer2pw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls" --enrollment.profile tls --csr.hosts orderer2.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/signcerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/keystore/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem"



  infoln "Registering orderer3"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret orderer3pw --id.type orderer --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null


  infoln "Generating the orderer msp"
  set -x
  fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp" --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/config.yaml"

  infoln "Generating the orderer3-tls certificates"
  set -x
  fabric-ca-client enroll -u https://orderer3:orderer3pw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls" --enrollment.profile tls --csr.hosts orderer3.supplychain.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/ca.crt"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/signcerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.crt"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/keystore/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.key"

  mkdir -p "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem"

  mkdir -p "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem"


  infoln "Generating the admin msp"
  set -x
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/ordererOrg/tls-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/organizations/ordererOrganizations/supplychain.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/supplychain.com/users/Admin@supplychain.com/msp/config.yaml"
}
