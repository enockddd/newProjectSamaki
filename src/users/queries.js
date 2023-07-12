
/*************USERS**********/
 const getAllUsers = "SELECT * FROM users";
 const getUserById = "SELECT * FROM users WHERE user_id = ?";
 const checkEmailExists = "SELECT * FROM users WHERE email = ?";
 const addUser = "INSERT INTO users (username, email, password,user_role) VALUES (?,?,?,?)";
 const removeUserById= "DELETE FROM users WHERE user_id=$1";
 const updateUserById = "UPDATE users SET username = ?, email = ? WHERE user_id = ?";



module.exports={
    getAllUsers,
    addUser,
    checkEmailExists,
    getUserById,
    removeUserById,
    updateUserById
}