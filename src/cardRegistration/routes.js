const {Router} = require('express');
const controller = require('./controller');

const router = Router();

// router.get("/",(req,res)=>{
//     res.send("using api routenewEno");
// });
/*********CARD********** */
//  router.get('/',controller.getAllCard);
 router.post('/',controller.addCard);
 //router.get('/:id',controller.getCardById);
//  router.delete("/:id",controller.removeCardById);
//  router.put("/:id",controller.updateCardById);

module.exports= router;