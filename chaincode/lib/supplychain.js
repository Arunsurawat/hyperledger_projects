
'use strict';

const { Contract } = require('fabric-contract-api');

class SupplyChain extends Contract {
    async initLedger(ctx) {
        console.info('============= START : Initialize Ledger ===========');
        return;
    }

    async createRawMaterial(ctx, rawMaterialId, name, description, quantity, unit, rfId) {
        console.info('============= START : Create Raw Material ===========');

        const rawMaterial = {
            docType: 'RawMaterial',
            id: rawMaterialId,
            name: name,
            description: description,
            quantity: quantity,
            unit: unit,
            rfId: rfId,
            producer: ctx.clientIdentity.getID(),
            status: 'Produced',
            trascationsId: ctx.stub.getTxID()
        };
        console.info('============= END : Create Raw Material ===========');
        return await ctx.stub.putState(rawMaterialId, Buffer.from(JSON.stringify(rawMaterial)));
       
    }

    async createProduct(ctx, productId, name, description, rawMaterialId, quantity, manufacturingDate, expirationDate, location) {
        console.info('============= START : Create Product ===========');

        const getRawMaterial = await this.getRawMaterial(ctx, rawMaterialId);

        
        const product = {
            docType: 'Product',
            id: productId,
            name: name,
            description: description,
            quantity: quantity,
            rawMaterialId: rawMaterialId,
            rfId: getRawMaterial.rfId,
            manufacturingDate: manufacturingDate,
            expirationDate: expirationDate,
            location: location,
            manufacturer: ctx.clientIdentity.getID(),
            status: 'Manufactured',
            trascationsId: ctx.stub.getTxID()
        };

        return await ctx.stub.putState(productId, Buffer.from(JSON.stringify(product)));
  
    }

    async updateProduct(ctx, productId, name, description, rawMaterialId, quantity, manufacturingDate, expirationDate, location) {
        console.info('============= START : Update Product ===========');

        const product = await this.getProduct(ctx, productId);
        product.name = name;
        product.description = description;
        product.rawMaterialId = rawMaterialId;
        product.quantity = quantity;
        product.manufacturingDate = manufacturingDate;
        product.expirationDate = expirationDate;

       return await ctx.stub.putState(productId, Buffer.from(JSON.stringify(product)));
        console.info('============= END : Update Product ===========');
    }

    async createShipment(ctx, shipmentId, productId, quantity, location, date) {
        console.info('============= START : Create Shipment ===========');

        const getProduct = await this.getProduct(ctx, productId);

        const shipment = {
            docType: 'Shipment',
            id: shipmentId,
            quantity: quantity,
            location: location,
            product: getProduct,
            date: date,
            status: 'In Transit',
            trascationsId: ctx.stub.getTxID()
        };

        
       return await ctx.stub.putState(shipmentId, Buffer.from(JSON.stringify(shipment)));
        console.info('============= END : Create Shipment ===========');
    }

    async deliverShipment(ctx, shipmentId, location, date) {
        console.info('============= START : Deliver Shipment ===========');

        const shipment = await this.getShipment(ctx, shipmentId);
        shipment.status = 'With Wholesaler';
        shipment.location = location;
        shipment.date = date;

        return await ctx.stub.putState(shipmentId, Buffer.from(JSON.stringify(shipment)));
        console.info('============= END : Deliver Shipment ===========');
    }

    async sendToRetailer(ctx, shipmentId, location, date) {
        console.info('============= START : Send To Retailer ===========');

        const shipment = await this.getShipment(ctx, shipmentId);
        shipment.status = 'With Retailer';
        shipment.location = location;
        shipment.date = date;

       return  await ctx.stub.putState(shipmentId, Buffer.from(JSON.stringify(shipment)));
        console.info('============= END : Send To Retailer ===========');
    }

    //Getter functions
    async getRawMaterial(ctx, rawMaterialId) {
        console.info('============= START : Get Raw Material ===========');

        const rawMaterialAsBytes = await ctx.stub.getState(rawMaterialId); // get the rawMaterial from chaincode state
        if (!rawMaterialAsBytes || rawMaterialAsBytes.length === 0) {
            throw new Error(`${rawMaterialId} does not exist`);
        }

        console.info('============= END : Get Raw Material ===========');
        return JSON.parse(rawMaterialAsBytes.toString());
    }

    async getProduct(ctx, productId) {
        console.info('============= START : Get Product ===========');

        const productAsBytes = await ctx.stub.getState(productId); // get the product from chaincode state
        if (!productAsBytes || productAsBytes.length === 0) {
            throw new Error(`${productId} does not exist`);
        }

        console.info('============= END : Get Product ===========');
        return JSON.parse(productAsBytes.toString());

    }

    async getShipment(ctx, shipmentId) {

        console.info('============= START : Get Shipment ===========');

        const shipmentAsBytes = await ctx.stub.getState(shipmentId); // get the shipment from chaincode state
        if (!shipmentAsBytes || shipmentAsBytes.length === 0) {
            throw new Error(`${shipmentId} does not exist`);
        }

        console.info('============= END : Get Shipment ===========');
        return JSON.parse(shipmentAsBytes.toString());
    }

    async getAllProducts(ctx) {

        console.info('============= START : Get All Products ===========');

        const queryString = { selector: { docType: 'Product' } };
        const queryResults = await this.getQueryResultForQueryString(ctx, JSON.stringify(queryString));
        return queryResults;



        // const products = [];
        // const productsAsBytes = await ctx.stub.getStateByRange('', '');
        // while (true) {
        //     const product = await productsAsBytes.next();
        //     if (product.value && product.value.value.toString()) {
        //         const key = product.value.key;
        //         let record;
        //         try {
        //             record = JSON.parse(product.value.value.toString('utf8'));
        //         } catch (err) {
        //             console.log(err);
        //             record = product.value.value.toString('utf8');
        //         }
        //         products.push({ Key: key, Record: record });
        //     }
        //     if (product.done) {
        //         console.log('end of data');
        //         await productsAsBytes.close();
        //         console.info(products);
        //         return JSON.stringify(products);
        //     }
        // }
    }

    async getAllRawMaterials(ctx) {

        console.info('============= START : Get All Raw Materials ===========');

        const queryString = { selector: { docType: 'RawMaterial' } };
        const queryResults = await this.getQueryResultForQueryString(ctx, JSON.stringify(queryString));
        return queryResults;
}
    async getQueryResultForQueryString(ctx, queryString) {

        console.log('============= START : getQueryResultForQueryString ===========');

        const resultsIterator = await ctx.stub.getQueryResult(queryString);
        const results = await this.getAllResults(resultsIterator, false);

        return JSON.stringify(results);

}
    async getProductsByRfId(ctx, rfId) {

        console.info('============= START : Get Products By RfId ===========');

        const queryString = { selector: { docType: 'Product', rfId: rfId } };
        const queryResults = await this.getQueryResultForQueryString(ctx, JSON.stringify(queryString));
        return queryResults;
}
}

module.exports = SupplyChain;