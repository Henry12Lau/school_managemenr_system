const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const staffController = require('../controllers/staffController');
const courseController = require('../controllers/courseController');

router.post('/students', studentController.getAll);
router.post('/students/resetPassword', studentController.resetPassword);
router.post('/staffs', staffController.getAll);
router.post('/staffs/resetPassword', staffController.resetPassword);

router.post('/studentList', studentController.getStudentList);
router.post('/editStudent', studentController.editStudent);
router.post('/getCourseMapping', courseController.getCourseMapping);
router.post('/getCourseSubject', courseController.getCourseSubject);


module.exports = router;