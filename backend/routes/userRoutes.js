const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

router.post('/students', userController.getAllStudents);
router.post('/resetStudentPassword', userController.resetStudentPassword);
router.post('/staffs', userController.getAllStaffs);
router.post('/resetStaffPassword', userController.resetStaffPassword);

module.exports = router;