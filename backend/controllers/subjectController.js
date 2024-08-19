const client = require('../config/db');

exports.get = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            `SELECT id, subject_no, name, number_of_lesson FROM subject WHERE id = $1 AND is_deleted = false`,
            [id]
        );
        return res.json({ subject: rows[0], message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getAll = async (req, res) => {
    try {
        const { rows } = await client.query(
            `SELECT id, subject_no, name, number_of_lesson FROM subject WHERE is_deleted = false`
        );
        return res.json({ subjects: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getByCourse = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            `
            SELECT cs.course_id, cs.subject_id , subject_no, name, number_of_lesson
            FROM course_subject cs
            LEFT JOIN subject s ON s.id = cs.subject_id AND s.is_deleted = false
            WHERE cs.course_id = $1 AND cs.is_deleted = false
            `,
            [id]
        );
        return res.json({ subjects: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};