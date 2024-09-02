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
router.get('/getCourseMapping', staffController.getCourseMapping);
router.get('/getCourseSubject', staffController.getCourseSubject);
router.get('/courseMapping', staffController.courseMapping);

module.exports = router;    // Export the router object