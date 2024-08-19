const client = require('../config/db');

exports.get = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            `SELECT id, course_code, course_name, category FROM course WHERE id = $1 AND is_deleted = false`,
            [id]
        );
        return res.json({ course: rows[0], message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getAll = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            `SELECT id, course_code, course_name, category FROM course WHERE is_deleted = false`
        );
        return res.json({ courses: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};