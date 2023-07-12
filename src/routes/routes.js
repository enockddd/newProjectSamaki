const { Router } = require('express');
const controller = require('./controller');

const routerq = Router();

// routerq.get("/",(req,res)=>{
//     res.send("using api routPost");
// });
/*********USERS********** */

 routerq.get('/',controller.getAllroutes);
 routerq.get('/:id',controller.getRoutByid);
 routerq.post('/',controller.addroute);

 
 
module.exports= routerq;