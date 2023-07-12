const express = require("express");
const jwt = require('jsonwebtoken')
const usersRoute = require('./src/users/routes');
const routesRroutes = require('./src/routes/routes');
const routesRcars = require('./src/cars/routes');
const routesRpayment = require('./src/payment/routes');
const routesreceipt = require('./src/receipts/routes');
const getCarByRouteId = require('./src/getCarByRouteId/routes');
const login_sessionRoute = require('./src/login_session/routes');
const routesmakePayment = require('./src/makePayment/routes');
const cardRegistrationRoute = require('./src/cardRegistration/routes');
const user_registrationRoute = require('./src/user_registration/routes');

require('dotenv').config();


const app = express();
const port = 5000;

 app.use(express.json());

 app.use('/api/v1/login_session', login_sessionRoute);
 app.use('/api/v1/users', usersRoute);
 app.use('/api/v1/cardRegistration', cardRegistrationRoute);
 app.use('/api/v1/user_registration',user_registrationRoute);
 

 app.use((req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
  
    if (!token) {
      console.log('Token is missing');
      return res.sendStatus(401);
    }
  
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
      if (err) {
        console.log('Token verification failed');
        return res.sendStatus(401);
      }
  
      req.user = user;
      next();
    });
  });
  

function requireUser(req, res, next) {
  if (!req.user) {
    res.status(401).json({ error: 'Unauthorized request' });
  } else {
    next();
  }
}

app.get("/", (req, res) => {
    res.send("Hello newPostEnock");
});


 app.use('/api/v1/routes',requireUser, routesRroutes);
 app.use('/api/v1/cars', requireUser,routesRcars);
 app.use('/api/v1/payment',requireUser, routesRpayment);
 app.use('/api/v1/receipt',requireUser, routesreceipt);
 app.use('/api/v1/getCarByRouteId',requireUser, getCarByRouteId);
 app.use('/api/v1/makePayment',requireUser, routesmakePayment);
//  app.use('/api/v1/users',requireUser, usersRoute);


app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
}).on("error", err => {
    console.error("Server failed to start:", err);
});