const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const staffController = require('../controllers/staffController');
const courseController = require('../controllers/courseController');
const subjectController = require('../controllers/subjectController');
const subjectClassController = require('../controllers/subjectClassController');

router.post('/student/list', studentController.getAll);
router.post('/student/edit', studentController.edit);
router.post('/student/create', studentController.create);
// router.post('/students/resetPassword', studentController.resetPassword);
router.post('/staff/list', staffController.getAll);
router.post('/staff/title', staffController.getTitle);
router.post('/staff/edit', staffController.edit);
router.post('/staff/create', staffController.create);
// router.post('/staffs/resetPassword', staffController.resetPassword);

router.post('/getCourseSubject', courseController.getCourseSubject);
router.post('/course/mappingList', courseController.getCourseMapping);
router.post('/course/mapping', courseController.courseMapping);

router.post('/subject/edit', subjectController.edit);
router.post('/subject/createClass', subjectClassController.create);
router.post('/subject/editClass', subjectClassController.edit);
router.post('/class/enroll', subjectClassController.enrolltudents);



module.exports = router;