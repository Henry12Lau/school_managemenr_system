const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const staffController = require('../controllers/staffController');

router.post('/students', studentController.getAll);
router.post('/resetStudentPassword', studentController.resetPassword);
router.post('/staffs', staffController.getAll);
router.post('/resetStaffPassword', staffController.resetPassword);

module.exports = router;