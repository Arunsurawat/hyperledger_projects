/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const {
    Wallets
} = require('fabric-network');
const FabricCAServices = require('fabric-ca-client');
const path = require('path');
const {
    buildCAClient,
    enrollAdmin,
    registerAndEnrollUser
} = require('../utils/CAUtils.js');
const {
    buildCCP,
    buildWallet
} = require('../utils/AppUtils.js');

const walletPath = path.join(__dirname, '../wallet');

async function Admin(org) {
    let response;
    try {
        // build an in memory object with the network configuration (also known as a connection profile)
        const ccp = buildCCP(org);
        let cahost;
        let OrgMSPID;
        switch (org) {
            case "FARM":
              cahost = "ca.farmorg1.supplychain.com";
                OrgMSPID = "FarmOrg1MSP";
              break;
            case "MAN":
                cahost = "ca.manorg2.supplychain.com";
                OrgMSPID = "ManOrg2MSP";
              break;
            case "WHOLE":
                cahost = "ca.wholeorg3.supplychain.com";
                OrgMSPID = "WholeOrg3MSP";
              break;
            case "RETAIL":
                cahost = "ca.retailorg4.supplychain.com";
                OrgMSPID = "RetailOrg4MSP";
              break;
            case "CUSTOMER":
                cahost = "ca.custorg5.supplychain.com";
                OrgMSPID = "CustOrg5MSP";
                break;
        }
        // build an instance of the fabric ca services client based on
        // the information in the network configuration
        const caClient = buildCAClient(FabricCAServices, ccp, cahost);

        // setup the wallet to hold the credentials of the application user
        const wallet = await buildWallet(Wallets, walletPath);

        // in a real application this would be done on an administrative flow, and only once
        await enrollAdmin(caClient, wallet, org);

        response = {
            success: true,
            message: `Enrolled Admin successfully`
        };

    } catch (error) {
        console.error(`******** FAILED to run the application: ${error}`);
        response = {
            success: false,
            message: `${error}`
        };
    }
    return response;
}

async function User(org, userId, affiliation) {

    let response;
    try {
        // build an in memory object with the network configuration (also known as a connection profile)
        const ccp = buildCCP(org);
        let cahost;
        let OrgMSPID;
        switch (org) {
            case "FARM":
              cahost = "ca.farmorg1.supplychain.com";
                OrgMSPID = "FarmOrg1MSP";
              break;
            case "MAN":
                cahost = "ca.manorg2.supplychain.com";
                OrgMSPID = "ManOrg2MSP";
              break;
            case "WHOLE":
                cahost = "ca.wholeorg3.supplychain.com";
                OrgMSPID = "WholeOrg3MSP";
              break;
            case "RETAIL":
                cahost = "ca.retailorg4.supplychain.com";
                OrgMSPID = "RetailOrg4MSP";
              break;
            case "CUSTOMER":
                cahost = "ca.custorg5.supplychain.com";
                OrgMSPID = "CustOrg5MSP";
                break;
        }
        // build an instance of the fabric ca services client based on
        // the information in the network configuration
        const caClient = buildCAClient(FabricCAServices, ccp, cahost);

        // setup the wallet to hold the credentials of the application user
        const wallet = await buildWallet(Wallets, walletPath);

        // in a real application this would be done only when a new user was required to be added
        // and would be part of an administrative flow
        await registerAndEnrollUser(caClient, wallet, OrgMSPID, userId, affiliation, org);

        response = {
            success: true,
            message: `Successfully enrolled client user ${userId} and imported it into the wallet`
        };
    } catch (error) {
        console.error(`******** FAILED to run the application: ${error}`);
        response = {
            success: false,
            message: `${error}`
        };
    }

    return response;
}
module.exports = { Admin, User };

//enrollHDFCAdmin();