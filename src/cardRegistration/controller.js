// Import database pool and queries
const jwt = require('jsonwebtoken');
const pool = require('../../db');
const queries = require('./queries');

// Get all users
const getAllCard = (req, res) => {
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
const getCardById = (req, res) => {
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



const addCard = (req, res) => {
  const {card_no,expire_date,cvv,card_name} = req.body;
  
  pool.query(queries.checkCardExists, [card_no], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (results.rows) {
      res.status(400).json({ error: 'Card already exists' });
      return;
    }
    pool.query(queries.addCardQuery, [card_no,expire_date,cvv,card_name,], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }

      const account_id = results.insertId;
      console.log(account_id);
      

      // create JWT token with all fields in payload
      const token = jwt.sign({
         account_id:account_id,
         card_no: card_no, 
         expire_date: expire_date,
         cvv: cvv, 
         card_name: card_name }, process.env.JWT_SECRET, { expiresIn: '1h' });

         const decodedToken = jwt.verify(token, process.env.JWT_SECRET);
         console.log(decodedToken);
         console.log(token);

      res.status(201).json({ message: 'Card created successfully',token});
      console.log(`Card ${card_no} created successfully`);
    });
  });
};

// Remove user by id
const cardUserById = (req, res) => {
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




      module.exports = {
      addCard,
      };
