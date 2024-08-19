const client = require('../config/db');
const { hashPassword } = require('../utils/hash');

exports.get = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            'SELECT id, student_no AS no, course_id, surname, given_name, sex, tel, username FROM student WHERE id = $1 AND is_deleted = FALSE',
            [id]
        );
        return res.json({ student: rows[0], message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getAll = async (req, res) => {
    try {
        const { rows } = await client.query(
            'SELECT id, student_no AS no, username FROM student WHERE is_deleted = FALSE'
        );
        return res.json({ students: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.resetPassword = async (req, res) => {
    try {
        const { id, password } = req.query;
        const hashedPassword = await hashPassword(password);
        await client.query(
            'UPDATE student SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = FALSE', [hashedPassword, id]
        );
        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};