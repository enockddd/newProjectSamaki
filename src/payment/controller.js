// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');

// Get all users
const getAllpayment = (req, res) => {
  pool.query(queries.getAllpayment, (error, results) => {
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
const getpaymentById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getpaymentById, [id], (error, results) => {
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
const addpayment = (req, res) => {
  const { route_id,receipt_id} = req.body;
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
    pool.query(queries.addpayment, [route_id,receipt_id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(201).json({ message: 'User created successfully' });
      console.log(`User ${username} created successfully`);
    });
  });
};




      module.exports = {
        getAllpayment,
        getpaymentById,
        addpayment,
      
      };
