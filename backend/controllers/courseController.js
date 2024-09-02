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
      `SELECT c.id AS course_id, sc.subject_id, c.course_code, c.course_name, s.subject_no, s.subject_name FROM course c 
        LEFT JOIN course_subject sc ON c.id = sc.course_id AND sc.is_deleted = FALSE
        LEFT JOIN subject s on s.id = sc.subject_id AND s.is_deleted = FALSE
        WHERE c.is_deleted = FALSE`
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
      `SELECT id AS course_id, course_code, course_name FROM course where is_deleted = FALSE`
    );
    const { rows: subjects } = await client.query(
      `SELECT id AS subject_id, subject_no, subject_name FROM subject where is_deleted = FALSE`
    );
    return res.json({ courses, subjects, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.courseMapping = async (req, res) => {
  try {
    const { course, subjects } = req.body;
    await client.query(
      `
      UPDATE course_subject SET is_deleted = TRUE, update_date = NOW() 
      WHERE course_id = $1 AND is_deleted = FALSE AND subject_id NOT IN (SELECT unnest($2::int[]))
      `,
      [course, subjects]
    );
    subjects.forEach(async (subject) => {
      if (subject != null) {
        await client.query(
          `
          INSERT INTO course_subject (course_id, subject_id, create_id)
          SELECT $1, $2, 1
          WHERE NOT EXISTS (SELECT 1 FROM course_subject WHERE course_id = $1 AND subject_id = $2 AND is_deleted = FALSE);
          `,
          [course, subject]
        );
      }
    });

    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
