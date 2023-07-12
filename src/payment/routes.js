const {Router} = require('express');
const controller = require('./controller');

const router = Router();

// router.get("/",(req,res)=>{
//     res.send("using api routenewEno");
// });
/*********USERS********** */
 router.get('/',controller.getAllpayment);
 router.post('/',controller.addpayment);
 router.get('/:id',controller.getpaymentById);



module.exports= router;