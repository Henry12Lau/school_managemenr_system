const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const subjectClassController = require('../controllers/subjectClassController');
const attendanceController = require('../controllers/attendanceController');

router.post('/', studentController.get);
router.post('/schedule', subjectClassController.getByStudent);
router.post('/resetPassword', studentController.resetPassword);
router.get('/studentList', studentController.getStudentList);
router.get('/editStudent', studentController.editStudent);

module.exports = router;