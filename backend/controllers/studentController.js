const client = require('../config/db');
const userController = require('../controllers/userController');

exports.get = async (req, res) => {
    try {
        const { id } = req.query;
        const { rows } = await client.query(
            'SELECT id, student_no AS no, course_id, surname, given_name, sex, tel, username FROM student WHERE id = $1 AND is_deleted = false',
            [id]
        );
        return res.json({ student: rows[0], message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};
exports.resetPassword = async (req, res) => {
    return userController.resetStudentPassword(req, res);
};