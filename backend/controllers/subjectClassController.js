const client = require("../config/db");
const { convertToPostgresDate } = require("../utils/formattor");

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
    return res.json({ class: rows[0], message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getAll = async (req, res) => {
  try {
    const { id } = req.body;
    if (id) {
      const { rows } = await client.query(
        `
        SELECT sc.id AS subject_class_id, sc.subject_id, sc.staff_id, s.subject_no, s.subject_name, st.staff_no, st.surname, st.given_name, st.sex, st.tel, (
        SELECT lesson_start FROM subject_class_schedule scs WHERE scs.subject_class_id = sc.id AND scs.is_deleted = FALSE ORDER BY lesson_start LIMIT 1)
        FROM subject_class sc
        LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
        LEFT JOIN staff st ON st.id = sc.staff_id AND st.is_deleted = FALSE
        WHERE s.id = $1 AND sc.is_deleted = FALSE
        `,
        [id]
      );
      return res.json({ classes: rows, message: "Success" });
    } else {
      const { rows } = await client.query(
        `
        SELECT sc.id AS subject_class_id, sc.subject_id, sc.staff_id, s.subject_no, s.subject_name, st.staff_no, st.surname, st.given_name, st.sex, st.tel, (
        SELECT lesson_start FROM subject_class_schedule scs WHERE scs.subject_class_id = sc.id AND scs.is_deleted = FALSE ORDER BY lesson_start LIMIT 1)
        FROM subject_class sc
        LEFT JOIN subject s ON s.id = sc.subject_id AND s.is_deleted = FALSE
        LEFT JOIN staff st ON st.id = sc.staff_id AND st.is_deleted = FALSE
        WHERE sc.is_deleted = FALSE
        `
      );
      return res.json({ subjects: rows, message: "Success" });
    }
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
        SELECT scs.subject_class_id, sc.subject_id, scs.student_id, s.subject_no, s.subject_name, st.student_no, st.surname, st.given_name, st.sex, st.tel, sch.lesson_start, sch.lesson_end,
        CASE 
            WHEN(
                SELECT 1 FROM attendance att
                WHERE att.student_id = st.id AND att.subject_class_schedule_id = sch.id AND att.is_deleted = FALSE) IS NULL THEN FALSE
            ELSE TRUE 
        END AS is_attend
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
      SELECT sc.id AS subject_class_id, sc.subject_id, st.id AS staff_id, sch.id AS subject_class_schedule_id, s.subject_no, s.subject_name, st.staff_no, st.surname, st.given_name, st.sex, st.tel, sch.lesson_start, sch.lesson_end
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
exports.getScheduleByClass = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `
      SELECT id, lesson_start, lesson_end FROM subject_class_schedule
      WHERE subject_class_id = $1 AND is_deleted = FALSE
      `,
      [id]
    );
    return res.json({ lessons: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.create = async (req, res) => {
  try {
    const { subject_id, staff_id, lesson_duration, schedules } = req.body;
    const { rows } = await client.query(
      `
      INSERT INTO subject_class (subject_id, staff_id, start_date, create_id) VALUES ($1, $2, $3, 1)
      RETURNING id;
      `,
      [subject_id, staff_id, convertToPostgresDate(schedules[0].lesson_start)]
    );
    const subject_class_id = rows[0].id;
    schedules.forEach(async (schedule) => {
      await client.query(
        `
        INSERT INTO subject_class_schedule (subject_class_id, lesson_start, lesson_end, create_id) VALUES ($1, $2, $3, 1)
        `,
        [
          subject_class_id,
          convertToPostgresDate(schedule.lesson_start),
          convertToPostgresDate(schedule.lesson_start, lesson_duration),
        ]
      );
    });
    return res.json({ classes: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.edit = async (req, res) => {
  try {
    const { class_id, staff_id, lesson_duration, schedules } = req.body;
    await client.query(
      `
      UPDATE subject_class SET staff_id = $1, update_date = NOW() WHERE id = $2;
      `,
      [staff_id, class_id]
    );
    schedules.forEach(async (schedule) => {
      await client.query(
        `
        UPDATE subject_class_schedule SET lesson_start = $1, lesson_end = $2, update_date = NOW() WHERE id = $3
        `,
        [
          convertToPostgresDate(schedule.lesson_start),
          convertToPostgresDate(schedule.lesson_start, lesson_duration),
          schedule.id,
        ]
      );
    });

    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};

exports.enrolltudents = async (req, res) => {
  try {
    const { subject_class_id, students } = req.body;
    await client.query(
      `
      UPDATE subject_class_student SET is_deleted = TRUE, update_date = NOW() 
      WHERE subject_class_id = $1 AND is_deleted = FALSE AND student_id NOT IN (SELECT unnest($2::int[]))
      `,
      [subject_class_id, students]
    );
    students.forEach(async (student) => {
      if (student) {
        await client.query(
          `
          INSERT INTO subject_class_student (subject_class_id, student_id, create_id) 
          SELECT $1, $2, 1
            WHERE NOT EXISTS (SELECT 1 FROM subject_class_student WHERE subject_class_id = $1 AND student_id = $2 AND is_deleted = FALSE);
          `,
          [subject_class_id, student]
        );
      }
    });
    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
