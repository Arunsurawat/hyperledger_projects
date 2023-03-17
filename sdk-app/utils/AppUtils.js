/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

"use strict";

const fs = require("fs");
const path = require("path");

exports.buildCCP = (org) => {
  console.log(org);
  let ccpPath;
  switch (org) {
    case "FARM":
      ccpPath = path.resolve(
        __dirname,
        "..",
        "..",
        "supplychain-network",
        "organizations",
        "peerOrganizations",
        "farmorg1.supplychain.com",
        "connection-farmorg1.json"
      );
      break;
    case "MAN":
      ccpPath = path.resolve(
        __dirname,
        "..",
        "..",
        "supplychain-network",
        "organizations",
        "peerOrganizations",
        "manorg2.supplychain.com",
        "connection-manorg2.json"
      );
      break;
    case "WHOLE":
      ccpPath = path.resolve(
        __dirname,
        "..",
        "..",
        "supplychain-network",
        "organizations",
        "peerOrganizations",
        "wholeorg3.supplychain.com",
        "connection-wholeorg3.json"
      );
      break;
    case "RETAIL":
      ccpPath = path.resolve(
        __dirname,
        "..",
        "..",
        "supplychain-network",
        "organizations",
        "peerOrganizations",
        "retailorg4.supplychain.com",
        "connection-retailorg4.json"
      );
      break;
    case "CUSTOMER":
      ccpPath = path.resolve(
        __dirname,
        "..",
        "..",
        "SupplyChain_App",
        "supplychain-network",
        "organizations",
        "peerOrganizations",
        "custorg5.supplychain.com",
        "connection-custorg5.json"
      );
      break;
  }
  const fileExists = fs.existsSync(ccpPath);
  if (!fileExists) {
    throw new Error(`no such file or directory: ${ccpPath}`);
  }
  const contents = fs.readFileSync(ccpPath, "utf8");

  // build a JSON object from the file contents
  const ccp = JSON.parse(contents);

  console.log(`Loaded the network configuration located at ${ccpPath}`);
  return ccp;
};

exports.buildWallet = async (Wallets, walletPath) => {
  // Create a new  wallet : Note that wallet is for managing identities.
  let wallet;
  if (walletPath) {
    wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Built a file system wallet at ${walletPath}`);
  } else {
    wallet = await Wallets.newInMemoryWallet();
    console.log("Built an in memory wallet");
  }

  return wallet;
};

exports.prettyJSONString = (inputString) => {
  if (inputString) {
    return JSON.stringify(JSON.parse(inputString), null, 2);
  } else {
    return inputString;
  }
};
