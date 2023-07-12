const {Router} = require('express');
const controller = require('./controller');

const router = Router();



 router.post('/',controller.makePayment);


 

module.exports= router;