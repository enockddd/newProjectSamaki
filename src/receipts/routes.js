const {Router} = require('express');
const controller = require('./controller');

const router = Router();

// router.get("/",(req,res)=>{
//     res.send("using api routenewEno");
// });
/*********USERS********** */
 router.get('/',controller.getAllreceipts);
 router.post('/',controller.addreceipts);
 router.get('/:id',controller.getreceiptsById);



module.exports= router;