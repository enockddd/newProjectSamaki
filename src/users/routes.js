const {Router} = require('express');
const controller = require('./controller');

const router = Router();

// router.get("/",(req,res)=>{
//     res.send("using api routenewEno");
// });
/*********USERS********** */
 router.get('/',controller.getAllUsers);
 router.post('/',controller.addUser);
 router.get('/:id',controller.getUserById);
 router.delete("/:id",controller.removeUserById);
 router.put("/:id",controller.updateUserById);

module.exports= router;