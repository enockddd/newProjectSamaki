
/*************USERS**********/
 const getAllpayment = "SELECT * FROM payment";
 const getpaymentById = "SELECT * FROM payment WHERE pay_record_id = ?";
 const addpayment = "INSERT INTO payment (route_id,receipt_id) VALUES (?,?)";

 



module.exports={
    getAllpayment,
    addpayment,
    getpaymentById,

}