// Import database pool and queries
const pool = require('../../db');
const queries = require('./queries');


const getCarsByRouteId = (req, res) => {
  const routeId = req.params.id;

  pool.query(queries.getCarsByRouteId, [routeId], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
      return;
    }

    res.status(200).json(results);
    console.log(`Retrieved cars for route with id: ${routeId}`);
  });
};





                module.exports = {
                getCarsByRouteId
                };
                
                
                
                
                
                
                