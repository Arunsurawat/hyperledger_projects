#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${ORGMSP}/$6/" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        -e "s/\${ORGMSP}/$6/" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=farmorg1
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/farmorg1.supplychain.com/tlsca/tlsca.farmorg1.supplychain.com-cert.pem
CAPEM=organizations/peerOrganizations/farmorg1.supplychain.com/ca/ca.farmorg1.supplychain.com-cert.pem
ORGMSP=FarmOrg1MSP
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/farmorg1.supplychain.com/connection-farmorg1.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/farmorg1.supplychain.com/connection-farmorg1.yaml

ORG=manorg2
P0PORT=8051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/manorg2.supplychain.com/tlsca/tlsca.manorg2.supplychain.com-cert.pem
CAPEM=organizations/peerOrganizations/manorg2.supplychain.com/ca/ca.manorg2.supplychain.com-cert.pem
ORGMSP=ManOrg2MSP
echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/manorg2.supplychain.com/connection-manorg2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/manorg2.supplychain.com/connection-manorg2.yaml


ORG=wholeorg3
P0PORT=10051
CAPORT=12054
PEERPEM=organizations/peerOrganizations/wholeorg3.supplychain.com/tlsca/tlsca.wholeorg3.supplychain.com-cert.pem
CAPEM=organizations/peerOrganizations/wholeorg3.supplychain.com/ca/ca.wholeorg3.supplychain.com-cert.pem
ORGMSP=WholeOrg3MSP

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/wholeorg3.supplychain.com/connection-wholeorg3.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/wholeorg3.supplychain.com/connection-wholeorg3.yaml

ORG=retailorg4
P0PORT=12051
CAPORT=10054
PEERPEM=organizations/peerOrganizations/retailorg4.supplychain.com/tlsca/tlsca.retailorg4.supplychain.com-cert.pem
CAPEM=organizations/peerOrganizations/retailorg4.supplychain.com/ca/ca.retailorg4.supplychain.com-cert.pem
ORGMSP=RetailOrg4MSP

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/retailorg4.supplychain.com/connection-retailorg4.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/retailorg4.supplychain.com/connection-retailorg4.yaml

ORG=custorg5
P0PORT=14051
CAPORT=11054
PEERPEM=organizations/peerOrganizations/custorg5.supplychain.com/tlsca/tlsca.custorg5.supplychain.com-cert.pem
CAPEM=organizations/peerOrganizations/custorg5.supplychain.com/ca/ca.custorg5.supplychain.com-cert.pem
ORGMSP=CustOrg5MSP

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/custorg5.supplychain.com/connection-custorg5.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM $ORGMSP)" > organizations/peerOrganizations/custorg5.supplychain.com/connection-custorg5.yaml
