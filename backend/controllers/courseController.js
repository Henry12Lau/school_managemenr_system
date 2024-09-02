const client = require("../config/db");

exports.get = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `SELECT id, course_code, course_name, category FROM course WHERE id = $1 AND is_deleted = FALSE`,
      [id]
    );
    return res.json({ course: rows[0], message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getAll = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `SELECT id, course_code, course_name, category FROM course WHERE is_deleted = FALSE`
    );
    return res.json({ courses: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};

exports.getCourseMapping = async (req, res) => {
  try {
    const { rows } = await client.query(
      `SELECT c.course_code, c.course_name, s.subject_no, s.subject_name FROM course c 
        LEFT JOIN course_subject sc ON c.id = sc.course_id AND c.is_deleted = 'false'
        LEFT JOIN subject s on s.id = sc.subject_id AND s.is_deleted = 'false'`
    );
    return res.json({ course: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
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
    return res.json({ courses, subjects, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
