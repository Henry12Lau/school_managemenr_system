const client = require('../config/db');
const bcrypt = require('bcrypt');

exports.login = async (req, res) => {
    try {
        const { type, username, password } = req.query;
        let user;
        let permission = [];
        if (type == "student") {
            const studentResult = await client.query(
                'SELECT id, student_no AS no, username, password FROM student WHERE username = $1 and is_deleted = false',
                [username]
            );

            if (studentResult.rows.length > 0) {
                user = studentResult.rows[0];
                permission = ["student"];
            } else {
                return res.status(404).json({ message: 'Invalid username or password' });
            }
        } else {
            const staffResult = await client.query(
                'SELECT id, staff_no AS no, username, password FROM staff WHERE username = $1 and is_deleted = false',
                [username]
            );

            if (staffResult.rows.length > 0) {
                user = staffResult.rows[0];

                const titleResult = await client.query(
                    `
                    SELECT title_name FROM staff_title st
                    LEFT JOIN title t ON st.title_id = t.id AND t.is_deleted = false
                    WHERE staff_id = $1 AND st.is_deleted = false
                    `,
                    [user.id]
                );

                if (titleResult.rows.length > 0) {
                    permission = titleResult.rows.map(row => row.title_name);
                } else {
                    return res.status(404).json({ message: 'Invalid permission' });
                }
            } else {
                return res.status(404).json({ message: 'Invalid username or password' });
            }
        }
        const isMatch = bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ error: 'Invalid username or password' });
        }
        const loginUser = { id: user.id, no: user.no, username: user.username, permission: permission };
        req.session.user = loginUser;
       
        return res.json({ message: 'Login successful' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error fetching user' });
    }
};
