// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');

// Get all getAllreceipts
const getAllreceipts = (req, res) => {
  pool.query(queries.getAllreceipts, (error, results) => {
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
const getreceiptsById = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getreceiptsById, [id], (error, results) => {
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
const addreceipts = (req, res) => {
  const {receipt_number,user_id,amount,car_id,start_id,destination_id,route_id} = req.body;
 
    pool.query(queries.addreceipts, [receipt_number,user_id,amount,car_id,start_id,destination_id,route_id], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }
      res.status(201).json({ message: 'User created successfully' });
      console.log(`User ${route_id+receipt_id} created successfully`);
    });

};




      module.exports = {
        getAllreceipts,
        getreceiptsById,
        addreceipts,
      
      };
