const express = require('express');
const router = express.Router();
const loginController = require('../controllers/loginController');

app.post('/', loginController.login)

app.post('/login', async (req, res) => {
  const { type, username, password } = req.body;
  try {
    var result;
    if (type == "student")
      result = await client.query('SELECT * FROM students WHERE username = $1 and is_deleted = false', [username]);
    else
      result = await client.query('SELECT * FROM users WHERE username = $1 and is_deleted = false', [username]);

    if (result.rowCount === 0) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const user = result.rows[0];
    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    // Store the user's information in the session
    req.session.user = { id: user.id, username: user.username };
    return res.json({ message: 'Login successful' });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;