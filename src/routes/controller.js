// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');

// Get all routes
const getAllroutes = (req, res) => {
  pool.query(queries.getAllroutes, (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    res.status(200).json(results);
    console.log('Retrieved all routes');
  });
};


// Get route by id
const getRoutByid = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getRoutByid, [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }
    if (!results) {
      res.status(404).json({ error: 'route not found' });
      return;
    }
    res.status(200).json(results);
    console.log(`Retrieved routes with id: ${id}`);
  });
};

const addroute = (req, res) => {
  const { route_name,car_id, car_count,start_id,destination_id} = req.body;
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
    pool.query(queries.addroute, [route_name,car_id, car_count,start_id,destination_id], (error, results) => {
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
                getAllroutes,
                getRoutByid,
                addroute,
                };
                
                
                
                
                
                
                