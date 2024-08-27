const express = require('express');
const router = express.Router();
const staffController = require('../controllers/staffController');
const subjectClassController = require('../controllers/subjectClassController');
const attendanceController = require('../controllers/attendanceController');

router.post('/', staffController.get);
router.post('/schedule', subjectClassController.getByStaff);
router.post('/lessonAttendance', attendanceController.getByClass);
router.post('/updateAttendances', attendanceController.updateAttendances);
router.post('/resetPassword', staffController.resetPassword);

module.exports = router;