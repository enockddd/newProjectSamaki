
/*************USERS**********/
 const getAllUsers = "SELECT * FROM users ";
 const getUserById = "SELECT * FROM users WHERE user_id =?";
 const checkEmailExists = "SELECT * FROM users WHERE email=?";
  const addUser = `INSERT INTO users (email, username, password,user_role, phone_number)
  VALUES ( ?, ?, ?, ?, ?)`;



module.exports={
    getAllUsers,
    addUser,
    checkEmailExists,
    getUserById,
   
   
}