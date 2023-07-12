const getUserByEmail = "SELECT * FROM users  WHERE email = ?";
const getUserByEmailAndPassword = "SELECT * FROM users  WHERE email = ? AND password = ?";


module.exports = {
  getUserByEmail,
  getUserByEmailAndPassword
};
