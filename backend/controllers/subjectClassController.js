const client = require('../config/db');

exports.get = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            `
            SELECT sc.id AS subject_class_id, sc.subject_id, sc.staff_id, s.subject_no, s.subject_name, st.staff_no, st.surname, st.given_name, st.sex, st.tel
            FROM subject_class sc
            LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
            LEFT JOIN staff st ON st.id = sc.staff_id AND st.is_deleted = FALSE
            WHERE sc.id = $1 AND sc.is_deleted = FALSE
            `,
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
            `
            SELECT sc.id AS subject_class_id, sc.subject_id, sc.staff_id, s.subject_no, s.subject_name, st.staff_no, st.surname, st.given_name, st.sex, st.tel
            FROM subject_class sc
            LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
            LEFT JOIN staff st ON st.id = sc.staff_id AND st.is_deleted = FALSE
            WHERE sc.is_deleted = FALSE
            `
        );
        return res.json({ subjects: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getSubjectResourse = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            `
            SELECT id, subject_class_id, title, description, start_date, end_date, file_path
            FROM subject_class_resources
            WHERE subject_class_id = $1 AND is_deleted = FALSE AND start_date >= NOW() AND end_date <= NOW()
            ORDER BY start_date
            `,
            [id]
        );
        return res.json({ resourses: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
