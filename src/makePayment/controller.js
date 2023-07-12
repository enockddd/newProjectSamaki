const jwt = require('jsonwebtoken');
const uuidv4 = require('uuid').v4;
const pool = require('../../db');
const queries = require('./queries');
const util = require('util');

const makePayment = async (req, res) => {
  const { card_no, expire_date, cvv, car_id, start_id, destination_id, route_id, amount } = req.body;
  const receipt_number = "REC" + uuidv4();

  if (!card_no || !expire_date || !cvv || !car_id || !start_id || !destination_id || !route_id || !amount ) {
    return res.status(400).json({ error: 'All required data fields are needed' });
  }

  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Token is missing' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const username = decoded.username;
    const user_id = decoded.user_id;
    const phone_number = decoded.phone_number;

    const query = util.promisify(pool.query).bind(pool);

    const accountExistsResults = await query(queries.checkAccountExistsQuery, [card_no, expire_date, cvv]);

    if (!accountExistsResults || accountExistsResults.length === 0) {
      return res.status(400).json({ error: 'Account does not exist' });
    }

    const receiptResults = await query(
      queries.insertReceiptQuery,
      [receipt_number, user_id, car_id, amount, start_id, destination_id, route_id]
    );

    const receipt_id = receiptResults.insertId;
    console.log(receipt_id);

    const carResult = await query(queries.getCarByIdQuery, [car_id]);
    const carName = carResult[0].car_name;

    const startResult = await query(queries.getStartByIdQuery, [start_id]);
    const startName = startResult[0].start_name;

    const destinationResult = await query(queries.getDestinationByIdQuery, [destination_id]);
    const destinationName = destinationResult[0].destination_name;

    const routeResult = await query(queries.getRouteByIdQuery, [route_id]);
    const routeName = routeResult[0].route_name;

    const paymentRecord = [receipt_id, amount, carName, startName, destinationName, routeName];

    const paymentResults = await query(queries.insertPaymentRecordQuery, paymentRecord);
    const insertedId = paymentResults.insertId;

    // Use getPaymentRecordByIdQuery to get the newly created payment record
    const paymentRecordResult = await query(queries.getPaymentRecordByIdQuery, [insertedId]);
    console.log(paymentRecordResult);
    const createdDate = paymentRecordResult[0].created_at;

    res.status(201).json({
      message: 'Payment successful',
      car_name: carName,
      start_name: startName,
      destination_name: destinationName,
      route_name: routeName,
      payment_id: insertedId,
      created_date: createdDate,  // return created date as well
      receipt_number:receipt_number,
      phone_number:phone_number
    });

    console.log(`Payment for user ${username} created successfully with id ${insertedId} on ${createdDate}`);
    console.log(receipt_number);
    console.log(phone_number);
    
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
 
  }
};

module.exports = {
  makePayment,
};
