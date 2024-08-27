const client = require("../config/db");

exports.get = async (req, res) => {
  try {
    const { id } = req.body;
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
    return res.json({ subject: rows[0], message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
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
    return res.json({ subjects: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getByStudent = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `
        SELECT scs.subject_class_id, sc.subject_id, scs.student_id, s.subject_no, s.subject_name, st.student_no, st.surname, st.given_name, st.sex, st.tel, sch.lesson_start, sch.lesson_end
        FROM subject_class sc
        LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
        LEFT JOIN subject_class_student scs ON scs.subject_class_id = sc.id AND scs.is_deleted = FALSE
        LEFT JOIN student st ON st.id = scs.student_id AND st.is_deleted = FALSE
        LEFT JOIN subject_class_schedule sch ON sch.subject_class_id = sc.id AND sch.is_deleted = FALSE
        WHERE st.id = $1 AND sc.is_deleted = FALSE
        `,
      [id]
    );
    return res.json({ classes: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getByStaff = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `
      SELECT sc.id AS subject_class_id, sc.subject_id, st.id AS staff_id, s.subject_no, s.subject_name, st.staff_no, st.surname, st.given_name, st.sex, st.tel, sch.lesson_start, sch.lesson_end
      FROM subject_class sc
      LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
      LEFT JOIN staff st ON st.id = sc.staff_id  AND st.is_deleted = FALSE
      LEFT JOIN subject_class_schedule sch ON sch.subject_class_id = sc.id AND sch.is_deleted = FALSE
      WHERE st.id = $1 AND sc.is_deleted = FALSE
      `,
      [id]
    );
    return res.json({ classes: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
