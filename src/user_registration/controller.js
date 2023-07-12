// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');

// Add new user
const addUser = (req, res) => {
  const {
    username,
    email,
    password,
    user_role,
    phone_number
  } = req.body;

  pool.query(queries.checkEmailExists, [email], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error', data: req.body });
      return;
    }

    if (results && results.length > 0) { // Check if results is defined and has length greater than 0
      res.status(400).json({ error: 'Email already exists', data: req.body });
      return;
    }

    // Insert the user details into the database
    pool.query(
      queries.addUser,
      [email, username, password, user_role, phone_number],
      (error, results) => {
        if (error) {
          console.error(error);
          res.status(500).json({ error: 'Internal server error', data: req.body });
          return;
        }

        res.status(201).json({ message: 'User created successfully', data: req.body });
        console.log(`User ${username} created successfully`);
      }
    );
  });
};

module.exports = {
  addUser,
};
