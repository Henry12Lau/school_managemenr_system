const client = require('../config/db');
const { hashPassword } = require('../utils/hash');

exports.get = async (req, res) => {
    try {
        const { id } = req.body;
        const { rows } = await client.query(
            `SELECT id, staff_no AS no, username, 
            (
                SELECT string_agg(title_name, ', ')
                FROM staff_title st
                LEFT JOIN title t ON t.id = st.title_id AND t.is_deleted = FALSE
                WHERE staff_id = s.id AND st.is_deleted = FALSE
            ) AS title FROM staff s WHERE s.id = $1 AND is_deleted = FALSE`,
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
            `SELECT id, staff_no AS no, username, 
            (
                SELECT string_agg(title_name, ', ')
                FROM staff_title st
                LEFT JOIN title t ON t.id = st.title_id AND t.is_deleted = FALSE
                WHERE staff_id = s.id AND st.is_deleted = FALSE
            ) AS title FROM staff s WHERE is_deleted = FALSE`
        );
        return res.json({ staffs: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.resetPassword = async (req, res) => {
    try {
        const { id, password } = req.body;
        const hashedPassword = await hashPassword(password);
        await client.query(
            'UPDATE staff SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = FALSE', [hashedPassword, id]
        );
        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};

exports.getCourseMapping = async (req, res) => {
    try {
        const { rows } = await client.query(
            `SELECT c.course_code, c.course_name, s.subject_no, s.subject_name FROM course_subject sc
            LEFT JOIN course c ON c.id = sc.course_id AND c.is_deleted = 'false'
            LEFT JOIN subject s on s.id = sc.subject_id AND s.is_deleted = 'false'`
        );
        return res.json({ course: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};

exports.getCourseSubject = async (req, res) => {
    try {
        const { rows: courses } = await client.query(
            `SELECT course_code, course_name FROM course where is_deleted = 'false'`
        );
        const { rows: subjects } = await client.query(
            `SELECT subject_no, subject_name FROM subject where is_deleted = 'false'`
        );
        return res.json({ courses, subjects, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};