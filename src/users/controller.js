// Import database pool and queries
const jwt = require('jsonwebtoken');
const pool = require('../../db');
const queries = require('./queries');

// Get all users
const getAllUsers = (req, res) => {
  pool.query(queries.getAllUsers, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all users');
  });
};

// Get user by id
const getUserById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getUserById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved user with id: ${id}`);
  });
};

// Add new user
const addUser = (req, res) => {
  const { username, email, password, user_role } = req.body;
  pool.query(queries.checkEmailExists, [email], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.rows) {
      res.status(400).json({ error: 'Email already exists' });
      return;
    }
    pool.query(queries.addUser, [username, email, password, user_role], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }

      const user_id = results.insertId;
      console.log(user_id);

     // create JWT token with all fields in payload

      const token = jwt.sign({
        user_id: user_id,
        username: username,
        email: email,
        user_role: user_role
      }, process.env.JWT_SECRET, { expiresIn: '1h' });

      const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
      console.log(decodedToken);
      console.log(token);


      res.status(201).json({ message: 'User created successfully',token });
      console.log(`User ${username} created successfully`);
    });
  });
};

// Remove user by id
const removeUserById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getUserById, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results.rows.length) {
      res.status(404).json({ error: 'User not found' });
      return;
    }
    pool.query(queries.removeUserById, [id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(200).json({ message: 'User deleted successfully' });
      console.log(`User with id: ${id} deleted successfully`);
    });
  });
};

// Update user by id

const updateUserById = (req, res) => {
  const id = parseInt(req.params.id);
  const { username, email} = req.body;

  // Validate input
  if (!username || !email) {
    return res.status(400).json({ error: "Please provide a name and email for the user" });
  }

  pool.query(
    queries.getUserById,
    [id],
    (error, results) => {
      if (error) {
        console.error(error);
        return res.status(500).json({ error: "Error fetching user from database" });
      }

      const user = results[0];
      if (!user) {
        return res.status(404).json({ error: "User not found in the database" });
      }

      // Update user in the database
      pool.query(
        queries.updateUserById,
        [username, email, id],
        (error, results) => {
          if (error) {
            console.error(error);
            return res.status(500).json({ error: "Error updating user in database" });
          }

          return res.status(200).json({ message: "User updated successfully" });
        }
      );
    }
  );
};


      module.exports = {
      getAllUsers,
      getUserById,
      addUser,
      removeUserById,
      updateUserById
      };
