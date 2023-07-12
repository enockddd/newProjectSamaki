/*************USERS**********/
const getAllAccounts = "SELECT * FROM payments";
const checkAccountExistsQuery = "SELECT * FROM accounts WHERE card_no = ? AND expire_date = ? AND cvv = ?";
const insertReceiptQuery = "INSERT INTO receipt (receipt_number, user_id, car_id, amount, start_id, destination_id, route_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
const insertPaymentRecordQuery = "INSERT INTO payments (receipt_id, amount) VALUES (?, ?)";
const getLastInsertedPayment = "SELECT * FROM payments WHERE id = LAST_INSERT_ID()";
const getCarByIdQuery = "SELECT * FROM cars WHERE car_id = ?";
const getStartByIdQuery = "SELECT * FROM start WHERE start_id = ?";
const getDestinationByIdQuery = "SELECT * FROM destination WHERE destination_id = ?";
const getRouteByIdQuery = "SELECT * FROM routes WHERE route_id = ?";
const getPaymentRecordByIdQuery = "SELECT * FROM payments WHERE payment_id = ?";

module.exports = {
  getAllAccounts,
  checkAccountExistsQuery,
  insertReceiptQuery,
  insertPaymentRecordQuery,
  getCarByIdQuery,
  getStartByIdQuery,
  getDestinationByIdQuery,
  getRouteByIdQuery,
  getLastInsertedPayment,
  getPaymentRecordByIdQuery
};
