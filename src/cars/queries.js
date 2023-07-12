// /*************POSTS**********/
 const getAllcars = "SELECT * FROM cars";
 const getcarByid = "SELECT * FROM cars WHERE car_id =?";
 const addcars = "INSERT INTO cars (car_name,car_number,car_sit_count,car_cost,is_car_available) VALUES (?,?)";
 
 


module.exports={
    getAllcars,
    getcarByid,
    addcars
   
}