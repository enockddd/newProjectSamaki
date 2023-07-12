const jwt = require('jsonwebtoken');
const pool = require('../../db');
const queries = require('./queries');

const loginUser = (req, res) => {
  const { email, password } = req.body;

  // Check if email and password are provided
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  pool.query(queries.getUserByEmail, [email], (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Internal server error' });
    }

    if (!results || results.length === 0) {
      return res.status(404).json({ error: 'Invalid login credentials' });
    }

    const user = results[0];
    console.log(user);

    if (user.password !== password) {
      return res.status(401).json({ error: 'Invalid login credentials' });
    }

    const jwtPayload = {
      user_id: user.user_id,
      username: user.username,
      email: user.email,
      account_id: user.account_id,
      user_role: user.user_role,
      phone_number: user.phone_number

    };

    const token = jwt.sign(jwtPayload, process.env.JWT_SECRET, { expiresIn: '1h' });
    console.log(jwtPayload)

    if (user.user_role === 'driver') {
      return res.status(200).json({ message: 'Logged in successfully as driver', token });
    } else if (user.user_role === 'customer') {
      return res.status(200).json({ message: 'Logged in successfully as customer', token });
    } else {
      return res.status(200).json({ message: 'Logged in successfully', token });
    }
  });
};

module.exports = {
  loginUser,
};






























































// const jwt = require('jsonwebtoken');
// const pool = require('../../db');
// const queries = require('./queries');
// const bcrypt = require('bcrypt');

// const loginUser = async (req, res) => {
//   const { email, password } = req.body;

//   // Check if email and password are provided
//   if (!email || !password) {
//     return res.status(400).json({ error: 'Email and password are required' });
//   }

//   try {
//     const results = await pool.query(
//       `
//       SELECT users.user_id, users.username, users.email, users.account_id, users.user_role, users.password
//       FROM users
//       INNER JOIN accounts ON users.account_id = accounts.account_id
//       WHERE users.email = ?
//       `,
//       [email]
//     );

//     console.log('Results:', results);

//     if (!results || results.length === 0) {
//       return res.status(404).json({ error: 'Invalid login credentials' });
//     }

//     const user = results[0];

//     console.log('User:', user);

//     if (!user.password) {
//       return res.status(500).json({ error: 'Internal server error' });
//     }

//     const isMatch = await bcrypt.compare(password, user.password);
//     if (!isMatch) {
//       return res.status(401).json({ error: 'Invalid login credentials' });
//     }

//     const jwtPayload = {
//       user_id: user.user_id,
//       username: user.username,
//       email: user.email,
//       account_id: user.account_id,
//       user_role: user.user_role,
//     };

//     const token = jwt.sign(jwtPayload, process.env.JWT_SECRET, { expiresIn: '1h' });

//     if (user.user_role === 'driver') {
//       return res.status(200).json({ message: 'Logged in successfully as driver', token });
//     } else if (user.user_role === 'customer') {
//       return res.status(200).json({ message: 'Logged in successfully as customer', token });
//     } else {
//       return res.status(200).json({ message: 'Logged in successfully', token });
//     }
//   } catch (error) {
//     console.error(error);
//     return res.status(500).json({ error: 'Internal server error' });
//   }
// };

// module.exports = {
//   loginUser,
// };
