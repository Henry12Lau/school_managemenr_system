const client = require('../config/db');
const { hashPassword } = require('../utils/hash');

exports.get = async (req, res) => {
    try {
        const { id } = req.body;
        const { rows } = await client.query(
            'SELECT id, student_no, course_id, surname, given_name, sex, tel, username FROM student WHERE id = $1 AND is_deleted = FALSE',
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
            'SELECT id, student_no, surname, given_name, tel, username, is_deleted FROM student WHERE is_deleted = FALSE ORDER BY surname, given_name'
        );
        return res.json({ students: rows, message: 'Success' });
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
            'UPDATE student SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = FALSE', [hashedPassword, id]
        );
        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getBySubjectClass = async (req, res) => {
    try {
        const { id } = req.body;
        const { rows } = await client.query(
            `
            SELECT scs.subject_class_id, sc.subject_id, scs.student_id, s.subject_no, s.subject_name, st.student_no, st.surname, st.given_name, st.sex, st.tel
            FROM subject_class sc
            LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
            LEFT JOIN subject_class_student scs ON scs.subject_class_id = sc.id AND scs.is_deleted = FALSE
            LEFT JOIN student st ON st.id = scs.student_id AND st.is_deleted = FALSE
            WHERE sc.id = $1 AND sc.is_deleted = FALSE
            `,
            [id]
        );
        return res.json({ students: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.editStudent = async (req, res) => {
    try {
        const { surname, given_name, tel, password, student_no, is_deleted } = req.body;
        if (password !== '') {
            const hashedPassword = await hashPassword(password);
            await client.query(
                'UPDATE student SET surname = $1, given_name = $2, tel = $3, password = $4, update_date = now() WHERE student_no = $5', 
                [surname, given_name, tel, hashedPassword, student_no]
            );
        } else {
            await client.query(
                'UPDATE student SET surname = $1, given_name = $2, tel = $3, update_date = now() WHERE student_no = $4', 
                [surname, given_name, tel, student_no]
            );
        }

        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};