const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const staffController = require('../controllers/staffController');
const courseController = require('../controllers/courseController');

router.post('/students', studentController.getAll);
router.post('/editStudent', studentController.editStudent);
router.post('/students/resetPassword', studentController.resetPassword);
router.post('/staffs', staffController.getAll);
router.post('/editStaff', staffController.editStaff);
router.post('/staffs/resetPassword', staffController.resetPassword);

router.post('/getCourseSubject', courseController.getCourseSubject);
router.post('/course/mappingList', courseController.getCourseMapping);
router.post('/course/mapping', courseController.courseMapping);


module.exports = router;