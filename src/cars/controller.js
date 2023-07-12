// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');

// Get all routes
const getAllcars = (req, res) => {
  pool.query(queries.getAllcars, (error, results) => {
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
const getcarByid = (req, res) => {
  const id = parseInt(req.params.id);
  pool.query(queries.getcarByid, [id], (error, results) => {
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
    console.log(`Retrieved car with id: ${id}`);
  });
};

const addcars = (req, res) => {
  const { car_name, car_number, car_sit_count, car_cost, is_car_available } = req.body;

  pool.query(queries.checkCarExists, [car_number], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    if (results.rows.length) {
      res.status(400).json({ error: 'Car number already exists' });
      return;
    }

    pool.query(queries.addcars, [car_name, car_number, car_sit_count, car_cost, is_car_available], (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }

      res.status(201).json({ message: 'Car created successfully' });
      console.log(`Car ${car_number} created successfully`);
    });
  });
};


                module.exports = {
                  getAllcars,
                  getcarByid,
                  addcars 
                };
                
                
                
                
                
                
                