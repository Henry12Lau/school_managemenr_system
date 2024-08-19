const client = require('../config/db');
const bcrypt = require('bcrypt');

exports.getAllStudents = async (req, res) => {
    try {
        const { rows } = await client.query(
            'SELECT id, student_no AS no, username FROM student WHERE is_deleted = false'
        );
        return res.json({ students: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.resetStudentPassword = async (req, res) => {
    try {
        const { id, password } = req.query;
        const hashedPassword = await hashPassword(password);
        await client.query(
            'UPDATE student SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = false', [hashedPassword, id]
        );
        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.getAllStaffs = async (req, res) => {
    try {
        const { rows } = await client.query(
            `SELECT id, staff_no AS no, username, 
            (
                SELECT string_agg(title_name, ', ')
                FROM staff_title st
                LEFT JOIN title t ON t.id = st.title_id AND t.is_deleted = false
                WHERE staff_id = s.id AND st.is_deleted = false
            ) AS title FROM staff s WHERE is_deleted = false`
        );
        return res.json({ staffs: rows, message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.resetStaffPassword = async (req, res) => {
    try {
        const { id, password } = req.query;
        const hashedPassword = await hashPassword(password);
        await client.query(
            'UPDATE staff SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = false', [hashedPassword, id]
        );
        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
async function hashPassword(password) {
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);
    return hashedPassword;
}