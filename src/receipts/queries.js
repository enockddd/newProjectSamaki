
/*************USERS**********/
 const getAllreceipts = "SELECT * FROM receipt";
 const getreceiptsById = "SELECT * FROM receipt WHERE receipt_id = ?";
 const addreceipts = "INSERT INTO receipt (receipt_number,user_id,amount,car_id,start_id,destination_id,route_id) VALUES (?,?,?,?,?,?,?)";

 
module.exports={
    getAllreceipts,
    addreceipts,
    getreceiptsById,

}