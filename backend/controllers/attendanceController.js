const client = require("../config/db");

exports.getByClass = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `SELECT sc.subject_id, scs.subject_class_id, scst.student_id, s.subject_no, s.subject_name, scs.lesson_start, scs.lesson_end, st.student_no, st.surname, st.given_name, st.sex, st.tel, 
        CASE 
            WHEN(
                SELECT 1 FROM attendance att
                WHERE att.student_id = st.id AND att.subject_class_schedule_id = scs.id AND att.is_deleted = FALSE) IS NULL THEN FALSE
            ELSE TRUE 
        END AS isAttend
        FROM subject_class_schedule scs
        LEFT JOIN subject_class sc ON sc.id = scs.subject_class_id AND sc.is_deleted = FALSE
        LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
        LEFT JOIN subject_class_student scst ON scst.subject_class_id = scs.subject_class_id AND scst.is_deleted = FALSE
        LEFT JOIN student st ON st.id = scst.student_id AND st.is_deleted = FALSE
        WHERE scs.id = $1 AND scs.is_deleted = FALSE
        ORDER BY st.surname, st.given_name`,
      [id]
    );
    return res.json({ attendances: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.updateAttendances = async (req, res) => {
  try {
    const { id, lessonId, studentIds } = req.body;
    await client.query(
      `UPDATE attendance SET is_deleted = TRUE, update_id = $1, update_date = NOW() WHERE is_deleted = FALSE AND subject_class_schedule_id = $2`,
      [id, lessonId]
    );
    (query = `INSERT INTO attendance (subject_class_schedule_id, student_id, create_id, update_id) VALUES ($2, $3, $1, $1)`),
      Promise.all(studentIds.map((studentId) => client.query(query, [id, lessonId, studentId])));
    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getBySubjectStudent = async (req, res) => {
  try {
    const { id, studentId } = req.body;
    const { rows } = await client.query(
      `SELECT sc.subject_id, scs.subject_class_id, scst.student_id, s.subject_no, s.subject_name, scs.lesson_start, scs.lesson_end, st.student_no, st.surname, st.given_name, st.sex, st.tel, 
          CASE 
              WHEN(
                  SELECT 1 FROM attendance att
                  WHERE att.student_id = st.id AND att.subject_class_schedule_id = scs.id AND att.is_deleted = FALSE) IS NULL THEN FALSE
              ELSE TRUE 
          END AS isAttend
          FROM subject_class_schedule scs
          LEFT JOIN subject_class sc ON sc.id = scs.subject_class_id AND sc.is_deleted = FALSE
          LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
          LEFT JOIN subject_class_student scst ON scst.subject_class_id = scs.subject_class_id AND scst.is_deleted = FALSE
          LEFT JOIN student st ON st.id = scst.student_id AND st.is_deleted = FALSE
          WHERE s.id = $1 AND st.id = $2 AND scs.is_deleted = FALSE
          ORDER BY scs.lesson_start`,
      [id, studentId]
    );
    return res.json({ attendances: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
