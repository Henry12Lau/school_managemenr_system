const client = require("../config/db");
const { hashPassword } = require("../utils/hash");

exports.get = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `SELECT id, student_no, course_id, surname, given_name, sex, tel, username,  surname || ' ' || given_name || ' (' || student_no || ')' AS full_name, id AS student_id FROM student WHERE id = $1 AND is_deleted = FALSE`,
      [id]
    );
    return res.json({ student: rows[0], message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getAll = async (req, res) => {
  try {
    const { rows } = await client.query(
      `SELECT id, student_no, course_id, surname, given_name, tel, username, is_deleted,  surname || ' ' || given_name || ' (' || student_no || ')' AS full_name, id AS student_id FROM student WHERE is_deleted = FALSE ORDER BY surname, given_name`
    );
    return res.json({ students: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.resetPassword = async (req, res) => {
  try {
    const { id, password } = req.body;
    const hashedPassword = await hashPassword(password);
    await client.query(
      "UPDATE student SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = FALSE",
      [hashedPassword, id]
    );
    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getBySubjectClass = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `
            SELECT scs.subject_class_id, sc.subject_id, scs.student_id, s.subject_no, s.subject_name, st.student_no, st.surname, st.given_name, st.sex, st.tel,
            st.surname || ' ' || st.given_name || ' (' || st.student_no || ')' AS full_name
            FROM subject_class sc
            LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
            LEFT JOIN subject_class_student scs ON scs.subject_class_id = sc.id AND scs.is_deleted = FALSE
            LEFT JOIN student st ON st.id = scs.student_id AND st.is_deleted = FALSE
            WHERE sc.id = $1 AND sc.is_deleted = FALSE
            `,
      [id]
    );
    return res.json({ students: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.create = async (req, res) => {
  try {
    const { student_no, course_id, surname, given_name, sex, tel, username, password } = req.body;
    const hashedPassword = await hashPassword(password);
    await client.query(
      `INSERT INTO student (student_no, course_id, surname, given_name, sex, tel, username, password) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
      [student_no, course_id, surname, given_name, sex, tel, username, hashedPassword]
    );
    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.edit = async (req, res) => {
    try {
      const { id, surname, given_name, tel, password, student_no, is_deleted } =
        req.body;
      if (password !== "") {
        const hashedPassword = await hashPassword(password);
        await client.query(
          "UPDATE student SET surname = $1, given_name = $2, tel = $3, password = $4, update_date = now() WHERE id = $5",
          [surname, given_name, tel, hashedPassword, id]
        );
      } else {
        await client.query(
          "UPDATE student SET surname = $1, given_name = $2, tel = $3, update_date = now() WHERE id = $4",
          [surname, given_name, tel, id]
        );
      }
  
      return res.json({ message: "Success" });
    } catch (err) {
      console.error(err);
      res.status(500).json({ message: "Error" });
    }
  };