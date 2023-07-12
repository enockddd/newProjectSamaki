const { Router } = require('express');
const controller = require('./controller');

const routerq = Router();

// routerq.get("/",(req,res)=>{
//     res.send("using api routPost");
// });
/*********USERS********** */

 routerq.get('/',controller.getAllcars);
 routerq.get('/:id',controller.getcarByid);
 routerq.post('/',controller.addcars);
 
 
module.exports= routerq;