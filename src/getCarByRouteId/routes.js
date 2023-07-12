const { Router } = require('express');
const controller = require('./controller');

const routerq = Router();

// routerq.get("/",(req,res)=>{
//     res.send("using api routPost");
// });
/*********USERS********** */

 routerq.get('/:id', controller.getCarsByRouteId);
 
 
module.exports= routerq;