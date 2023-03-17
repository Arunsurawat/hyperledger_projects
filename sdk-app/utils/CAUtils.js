/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

"use strict";

/**
 *
 * @param {*} FabricCAServices
 * @param {*} ccp
 */
exports.buildCAClient = (FabricCAServices, ccp, caHostName) => {
  // Create a new CA client for interacting with the CA.
  const caInfo = ccp.certificateAuthorities[caHostName]; //lookup CA details from config
  const caTLSCACerts = caInfo.tlsCACerts.pem;
  const caClient = new FabricCAServices(
    caInfo.url,
    { trustedRoots: caTLSCACerts, verify: false },
    caInfo.caName
  );

  console.log(`Built a CA Client named ${caInfo.caName}`);
  return caClient;
};

exports.enrollAdmin = async (caClient, wallet, org) => {
    try {

        console.log("Enrolling admin user", org);
      let adminUserId;
      let adminUserPasswd;
      let orgMsp
      switch (org) {
        case "FARM":
          adminUserId = "adminfarm";
          adminUserPasswd = "adminpw";
          orgMsp = "FarmOrg1MSP";
          break;
        case "MAN":
          adminUserId = "adminman";
          adminUserPasswd = "adminpw";
            orgMsp = "ManOrg2MSP";
          break;
        case "WHOLE":
          adminUserId = "adminwhole";
          adminUserPasswd = "adminpw";
            orgMsp = "WholeOrg3MSP";
          break;
        case "RETAIL":
          adminUserId = "adminretail";
          adminUserPasswd = "adminpw";
            orgMsp = "RetailOrg4MSP";
          break;
        case "CUSTOMER":
          adminUserId = "admincust";
          adminUserPasswd = "adminpw";
            orgMsp = "CustomerOrg5MSP";
            break;
    
      }
      // Check to see if we've already enrolled the admin user.
      const identity = await wallet.get(adminUserId);
      if (identity) {
        console.log(
          "An identity for the admin user already exists in the wallet"
        );
        return;
      }
  
      console.log(adminUserId, adminUserPasswd, orgMsp)
    
      // Enroll the admin user, and import the new identity into the wallet.
      const enrollment = await caClient.enroll({
        enrollmentID: adminUserId,
        enrollmentSecret: adminUserPasswd,
      });
      const x509Identity = {
        credentials: {
          certificate: enrollment.certificate,
          privateKey: enrollment.key.toBytes(),
        },
        mspId: orgMsp,
        type: "X.509",
      };
      await wallet.put(adminUserId, x509Identity);
      console.log(
        "Successfully enrolled admin user and imported it into the wallet"
      );
    } catch (error) {
      console.error(`Failed to enroll admin user : ${error}`);
    }
  };

exports.registerAndEnrollUser = async (
    caClient,
    wallet,
    orgMsp,
    userId,
    affiliation,
    org
  ) => {

    console.log("Registering user", userId, org);
    try {
      let adminUserId;
      let adminUserPasswd;
      const userIdentity = await wallet.get(userId);
      if (userIdentity) {
        console.log(
          `An identity for the user ${userId} already exists in the wallet`
        );
        return;
      }
  
      switch (org) {
        case "FARM":
          adminUserId = "adminfarm";
          adminUserPasswd = "adminpw";
          break;
        case "MAN":
          adminUserId = "adminman";
          adminUserPasswd = "adminpw";
          break;
        case "WHOLE":
          adminUserId = "adminwhole";
          adminUserPasswd = "adminpw";
          break;
        case "RETAIL":
          adminUserId = "adminretail";
          adminUserPasswd = "adminpw";
          break;
        case "CUSTOMER":
          adminUserId = "admincust";
          adminUserPasswd = "adminpw";
            break;
      }
      // Must use an admin to register a new user
      const adminIdentity = await wallet.get(adminUserId);
      if (!adminIdentity) {
        console.log(
          "An identity for the admin user does not exist in the wallet"
        );
        console.log("Enroll the admin user before retrying");
        res.status(400).json({
          success: false,
          meg: "Enroll the admin user before retrying",
        });
      }
  
      // build a user object for authenticating with the CA
      const provider = wallet
        .getProviderRegistry()
        .getProvider(adminIdentity.type);
      const adminUser = await provider.getUserContext(adminIdentity, adminUserId);
      // Register the user, enroll the user, and import the new identity into the wallet.
      // if affiliation is specified by client, the affiliation value must be configured in CA
      const secret = await caClient.register(
        {
          affiliation: affiliation,
          enrollmentID: userId,
          role: "client",
        },
        adminUser
      );
      const enrollment = await caClient.enroll({
        enrollmentID: userId,
        enrollmentSecret: secret,
      });
      const x509Identity = {
        credentials: {
          certificate: enrollment.certificate,
          privateKey: enrollment.key.toBytes(),
        },
        mspId: orgMsp,
        type: "X.509",
      };
      await wallet.put(userId, x509Identity);
      console.log(
        `Successfully registered and enrolled user ${userId} and imported it into the wallet`
      );
    } catch (error) {
      console.error(`Failed to register user : ${error}`);
    }
  };
  