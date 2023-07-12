// const getAllroutes =`SELECT routes.*, start.name AS start_name, destination.name AS destination_name
// FROM routes
// JOIN locations AS start ON start.id = routes.start_id
// JOIN locations AS destination ON destination.id = routes.destination_id`;

const getAllroutes =`SELECT routess.*, start.name AS start_name, destination.name AS destination_name
FROM routess
JOIN locations AS start ON start.id = routess.start_id
JOIN locations AS destination ON destination.id = routess.destination_id`;





// const getAllroutes = `
// SELECT r.route_name, start.name AS start_name, destination.name AS destination_name, r.car_count
// FROM routes AS r
// JOIN locations AS start ON start.id = r.start_id
// JOIN locations AS destination ON destination.id = r.destination_id`;



const getRoutByid = "SELECT * FROM routes WHERE route_id = ?";

const addroute = "INSERT INTO routes (route_name, car_id, car_count, start_id, destination_id) VALUES (?, ?, ?, ?, ?)";

module.exports = {
  getAllroutes,
  getRoutByid,
  addroute,
 
};
