/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { 
	Gateway,
	Wallets
} = require('fabric-network');
const FabricCAServices = require('fabric-ca-client');
const path = require('path');
const {
	buildCAClient
} = require('../utils/CAUtils.js');
const {
	buildCCP,
	buildWallet
} = require('../utils/AppUtils.js');

const channelName = 'supplychainchannel';
const chaincodeName = 'supply_chaincode';
const walletPath = path.join(__dirname, '../wallet');

function prettyJSONString(inputString) {
	return JSON.stringify(JSON.parse(inputString), null, 2);
}

async function createRawmaterial(req, res) {
	let response;
	try {
		console.log("Userid", req.body.userId)
		// build an in memory object with the network configuration (also known as a connection profile)
		const ccp = buildCCP(req.body.org);
        let cahost;
        let OrgMSPID;
        switch (req.body.org) {
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

		// Create a new gateway instance for interacting with the fabric network.
		// In a real application this would be done as the backend server session is setup for
		// a user that has been verified.
		const gateway = new Gateway();

		try {
			// setup the gateway instance
			// The user will now be able to create connections to the fabric network and be able to
			// submit transactions and query. All transactions submitted by this gateway will be
			// signed by this user using the credentials stored in the wallet.
			await gateway.connect(ccp, {
				wallet,
				identity: req.body.userId,
				discovery: {
					enabled: true,
					asLocalhost: true
				} // using asLocalhost as this gateway is using a fabric network deployed locally
			});

			// Build a network instance based on the channel where the smart contract is deployed
			const network = await gateway.getNetwork(channelName);

			// Get the contract from the network.
			const contract = network.getContract(chaincodeName);
			// contract.addDiscoveryInterest({ name: chaincodeName, collectionNames: ['HDFCMSPUserCollection'] });

			let result;

			console.log('\n**************** As HDFC Client ****************');
			console.log('\n--> Submit Transaction: createRawMaterial');
			result = await contract.submitTransaction('createRawMaterial', req.body.rawmaterialId, req.body.name, req.body.description, req.body.quantity, req.body.unit, req.body.rfId);
			console.log(`<-- result: ${prettyJSONString(result.toString())}`);
			return JSON.parse(result.toString());
			// response = {
			// 	success: true,
			// 	message: `${prettyJSONString(result.toString())}`
			// };
		} catch (error) {
			console.error(`******** FAILED to submit transation: ${error}`);
			response = {
				success: false,
				message: `${error}`
			};
		} finally {
			// Disconnect from the gateway peer when all work for this client identity is complete
			gateway.disconnect();
		}
	} catch (error) {
		console.error(`******** FAILED to run the application: ${error}`);
		response = {
			success: false,
			message: `${error}`
		};
	}
	return response;
}

module.exports = createRawmaterial;
//registerUserAccount('calvin', "HDFC");