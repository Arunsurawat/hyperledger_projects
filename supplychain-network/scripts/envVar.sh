#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#

# This is a collection of bash functions used by different scripts

# imports
. scripts/utils.sh

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/msp/tlscacerts/tlsca.supplychain.com-cert.pem
export PEER0_FARMORG1_CA=${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/peers/peer0.farmorg1.supplychain.com/tls/ca.crt
export PEER0_MANORG2_CA=${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer0.manorg2.supplychain.com/tls/ca.crt
export PEER1_MANORG2_CA=${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/peers/peer1.manorg2.supplychain.com/tls/ca.crt
export PEER0_WHOLEORG3_CA=${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer0.wholeorg3.supplychain.com/tls/ca.crt
export PEER1_WHOLEORG3_CA=${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/peers/peer1.wholeorg3.supplychain.com/tls/ca.crt
export PEER0_RETAILORG4_CA=${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer0.retailorg4.supplychain.com/tls/ca.crt
export PEER1_RETAILORG4_CA=${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/peers/peer1.retailorg4.supplychain.com/tls/ca.crt
export PEER0_CUSTORG5_CA=${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/peers/peer0.custorg5.supplychain.com/tls/ca.crt
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer.supplychain.com/tls/server.key
export ORDERER2_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.crt
export ORDERER2_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer2.supplychain.com/tls/server.key
export ORDERER3_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.crt
export ORDERER3_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/supplychain.com/orderers/orderer3.supplychain.com/tls/server.key

# Set environment variables for the peer org
setGlobals() {
  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  infoln "Using organization ${USING_ORG}"
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_LOCALMSPID="FarmOrg1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_FARMORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/farmorg1.supplychain.com/users/Admin@farmorg1.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_LOCALMSPID="ManOrg2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MANORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/users/Admin@manorg2.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:8051
  elif [ $USING_ORG -eq 3 ]; then
    export CORE_PEER_LOCALMSPID="ManOrg2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_MANORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/manorg2.supplychain.com/users/Admin@manorg2.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
  elif [ $USING_ORG -eq 4 ]; then
    export CORE_PEER_LOCALMSPID="WholeOrg3MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_WHOLEORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/users/Admin@wholeorg3.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:10051
  elif [ $USING_ORG -eq 5 ]; then
    export CORE_PEER_LOCALMSPID="WholeOrg3MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_WHOLEORG3_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/wholeorg3.supplychain.com/users/Admin@wholeorg3.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
  elif [ $USING_ORG -eq 6 ]; then
    export CORE_PEER_LOCALMSPID="RetailOrg4MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_RETAILORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/users/Admin@retailorg4.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:12051
  elif [ $USING_ORG -eq 7 ]; then
    export CORE_PEER_LOCALMSPID="RetailOrg4MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_RETAILORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/retailorg4.supplychain.com/users/Admin@retailorg4.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
  elif [ $USING_ORG -eq 8 ]; then
    export CORE_PEER_LOCALMSPID="CustOrg5MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_CUSTORG5_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/custorg5.supplychain.com/users/Admin@custorg5.supplychain.com/msp
    export CORE_PEER_ADDRESS=localhost:14051
  else
    errorln "ORG Unknown"
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}

# Set environment variables for use in the CLI container 
setGlobalsCLI() {
  setGlobals $1

  local USING_ORG=""
  if [ -z "$OVERRIDE_ORG" ]; then
    USING_ORG=$1
  else
    USING_ORG="${OVERRIDE_ORG}"
  fi
  if [ $USING_ORG -eq 1 ]; then
    export CORE_PEER_ADDRESS=peer0.farmorg1.supplychain.com:7051
  elif [ $USING_ORG -eq 2 ]; then
    export CORE_PEER_ADDRESS=peer0.manorg2.supplychain.com:8051
  elif [ $USING_ORG -eq 3 ]; then
    export CORE_PEER_ADDRESS=peer1.manorg2.supplychain.com:9051
  elif [ $USING_ORG -eq 4 ]; then
    export CORE_PEER_ADDRESS=peer0.wholeorg3.supplychain.com:10051
  elif [ $USING_ORG -eq 5 ]; then
    export CORE_PEER_ADDRESS=peer1.wholeorg3.supplychain.com:11051
  elif [ $USING_ORG -eq 6 ]; then
    export CORE_PEER_ADDRESS=peer0.retailorg4.supplychain.com:12051
  elif [ $USING_ORG -eq 7 ]; then
    export CORE_PEER_ADDRESS=peer1.retailorg4.supplychain.com:13051
  elif [ $USING_ORG -eq 8 ]; then
    export CORE_PEER_ADDRESS=peer0.custorg5.supplychain.com:14051
  else
    errorln "ORG Unknown"
  fi
}

# parsePeerConnectionParameters $@
# Helper function that sets the peer connection parameters for a chaincode
# operation
# parsePeerConnectionParameters() {
#   PEER_CONN_PARMS=()
#   PEERS=""
#   while [ "$#" -gt 0 ]; do
#     setGlobals $1
#     PEER="peer0.org$1"
#     ## Set peer addresses
#     if [ -z "$PEERS" ]
#     then
# 	PEERS="$PEER"
#     else
# 	PEERS="$PEERS $PEER"
#     fi
#     PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" --peerAddresses $CORE_PEER_ADDRESS)
#     ## Set path to TLS certificate
#     CA=PEER0_ORG$1_CA
#     TLSINFO=(--tlsRootCertFiles "${!CA}")
#     PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" "${TLSINFO[@]}")
#     # shift by one to get to the next organization
#     shift
#   done
# }

parsePeerConnectionParameters() {
  PEER_CONN_PARMS=()
  PEERS=""
  while [ "$#" -gt 0 ]; do
    setGlobals $1
    local USING_ORG=""
    if [ -z "$OVERRIDE_ORG" ]; then
      USING_ORG=$1
    else
      USING_ORG="${OVERRIDE_ORG}"
    fi
    
    if [ $USING_ORG -eq 1 ]; then
      PEER="peer0.farmorg1"
      CA=PEER0_FARMORG1_CA
    elif [ $USING_ORG -eq 2 ]; then
      PEER="peer0.manorg2"
      CA=PEER0_MANORG2_CA
    elif [ $USING_ORG -eq 3 ]; then
      PEER="peer1.manorg2"
      CA=PEER1_MANORG2_CA
    elif [ $USING_ORG -eq 4 ]; then
      PEER="peer0.wholeorg3"
      CA=PEER0_WHOLEORG3_CA
    elif [ $USING_ORG -eq 5 ]; then
      PEER="peer1.wholeorg3"
      CA=PEER1_WHOLEORG3_CA
    elif [ $USING_ORG -eq 6 ]; then
      PEER="peer0.retailorg4"
      CA=PEER0_RETAILORG4_CA
    elif [ $USING_ORG -eq 7 ]; then
      PEER="peer1.retailorg4"
      CA=PEER1_RETAILORG4_CA
    elif [ $USING_ORG -eq 8 ]; then
      PEER="peer0.custorg5"
      CA=PEER0_CUSTORG5_CA
    else
      errorln "ORG Unknown"
    fi 
    # PEER="peer0.org$1"
    ## Set peer addresses
    if [ -z "$PEERS" ]
    then
	    PEERS="$PEER"
    else
	    PEERS="$PEERS $PEER"
    fi
    PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" --peerAddresses $CORE_PEER_ADDRESS)
    ## Set path to TLS certificate
    # CA=PEER0_ORG$1_CA
    TLSINFO=(--tlsRootCertFiles "${!CA}")
    PEER_CONN_PARMS=("${PEER_CONN_PARMS[@]}" "${TLSINFO[@]}")
    # shift by one to get to the next organization
    shift
  done
}

verifyResult() {
  if [ $1 -ne 0 ]; then
    fatalln "$2"
  fi
}
