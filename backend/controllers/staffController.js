const client = require("../config/db");
const { hashPassword } = require("../utils/hash");

exports.get = async (req, res) => {
  try {
    const { id } = req.body;
    const { rows } = await client.query(
      `SELECT s.id, s.staff_no, s.surname, s.given_name, s.sex, s.tel, s.username, t.title_name, st.title_id, s.surname || ' ' || s.given_name || ' (' || s.staff_no || ')' AS full_name
        FROM staff s
        LEFT JOIN staff_title st ON st.staff_id = s.id AND st.is_deleted = FALSE
        LEFT JOIN title t ON t.id = st.title_id AND t.is_deleted = FALSE
        WHERE s.id = $1 AND s.is_deleted = FALSE`,
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
      `SELECT s.id, s.staff_no, s.surname, s.given_name, s.sex, s.tel, s.username, t.title_name, st.title_id, s.surname || ' ' || s.given_name || ' (' || s.staff_no || ')' AS full_name
        FROM staff s
        LEFT JOIN staff_title st ON st.staff_id = s.id AND st.is_deleted = FALSE
        LEFT JOIN title t ON t.id = st.title_id AND t.is_deleted = FALSE
        WHERE s.is_deleted = FALSE`
    );
    return res.json({ staffs: rows, message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.getTitle = async (req, res) => {
  try {
    const { rows } = await client.query(
      `SELECT id, title_name
        FROM title 
        WHERE is_deleted = FALSE`
    );
    return res.json({ titles: rows, message: "Success" });
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
      "UPDATE staff SET password = $1, update_date = now() WHERE id = $2 AND is_deleted = FALSE",
      [hashedPassword, id]
    );
    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.create = async (req, res) => {
  try {
    const { staff_no, surname, given_name, sex, tel, username, password, onboard_date, title_id } = req.body;
    const hashedPassword = await hashPassword(password);
    const { rows } = await client.query(
      `INSERT INTO staff (staff_no, surname, given_name, sex, tel, username, password, onboard_date) VALUES ($1, $2, $3, $4, $5, $6, $7, NOW())
      RETURNING id;`,
      [staff_no, surname, given_name, sex, tel, username, hashedPassword]
    );
    const staff_id = rows[0].id;
    await client.query(
      `INSERT INTO staff_title (staff_id, title_id) VALUES ($1, $2)`,
      [staff_id, title_id]
    );
    return res.json({ message: "Success" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Error" });
  }
};
exports.edit = async (req, res) => {
    try {
        const { id, surname, given_name, tel, password, staff_no, title_id, is_deleted } = req.body;
        if (password !== '') {
            const hashedPassword = await hashPassword(password);
            await client.query(
                'UPDATE staff SET surname = $1, given_name = $2, tel = $3, password = $4, update_date = now() WHERE id = $5', 
                [surname, given_name, tel, hashedPassword, id]
            );
        } else {
            await client.query(
                'UPDATE staff SET surname = $1, given_name = $2, tel = $3, update_date = now() WHERE id = $4', 
                [surname, given_name, tel, id]
            );
        }
        await client.query(
          `UPDATE staff_title SET title_id = $1, update_date = NOW() WHERE staff_id = $2`,
          [title_id, id]
        )

        return res.json({ message: 'Success' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: 'Error' });
    }
};