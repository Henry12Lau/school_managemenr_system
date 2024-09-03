const client = require('../config/db');

exports.get = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.body(
            `SELECT id, subject_no, subject_name, number_of_lesson, lesson_duration FROM subject WHERE id = $1 AND is_deleted = FALSE`,
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
            `SELECT id, subject_no, subject_name, number_of_lesson, lesson_duration FROM subject WHERE is_deleted = FALSE ORDER BY subject_no`
        );
        return res.json({ subjects: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getByCourse = async (req, res) => {
    try {
        const { id } = req.body;
        const { rows } = await client.query(
            `
            SELECT cs.course_id, cs.subject_id , subject_no, subject_name, number_of_lesson
            FROM course_subject cs
            LEFT JOIN subject s ON s.id = cs.subject_id AND s.is_deleted = false
            WHERE cs.course_id = $1 AND cs.is_deleted = FALSE
            `,
            [id]
        );
        return res.json({ subjects: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.edit = async (req, res) => {
    try {
        const { id, subject_no, subject_name, number_of_lesson, lesson_duration } = req.body;
        await client.query(
            'UPDATE subject SET subject_name = $1, number_of_lesson = $2, lesson_duration = $3, update_date = now() WHERE id = $4', 
            [subject_name, number_of_lesson, lesson_duration, id]
        );
        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
}