const User = require('../models/User');
const pool = require('../config/db');


exports.login = async (req, res) => {
    try {
        const { type, username, password } = req.params;
        var result;
        if (type == "student")
            result = await pool.query('SELECT * FROM student WHERE username and is_delete = false', [username]);
        else
            result = await pool.query('SELECT * FROM users WHERE username and is_delete = false', [username]);
        if (result.rows.length === 0) {
            return res.status(404).json({ message: 'Invalid username or password' });
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
        res.status(500).json({ message: 'Error fetching user' });
    }
};