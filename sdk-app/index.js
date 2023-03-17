const express = require('express');


const app = express();
app.use(express.json());


const {Admin, User } = require('./app/admin');
const createRawmaterial = require('./app/createRawmaterial');


app.post('/api/enroll/admin', async (req, res) => {
    let response;
    console.log(req.body.org);
    try {
        response = await Admin(req.body.org);
        res.status(200).json({ success: true, msg: response });

        
    }
    catch (error) {
        console.log(error);
    }

});

app.post('/api/register/user', async (req, res) => {
    let response;
    try {
        response = await User(req.body.org, req.body.userId, req.body.userAffiliation);
    }
    catch (error) {
        console.log(error);
    }
});

app.post('/api/farmer/create', async (req, res) => {
    let response;
    try {
        response = await createRawmaterial(req)
    }
    catch (error) {
        console.log(error);
    }
});


let port = process.env.PORT || 3000;
app.listen(port, () => console.log(`server listening on port ${port}....`));