const express = require('express');
const router = express.Router();
const subjectController = require('../controllers/subjectController');
const subjectClassController = require('../controllers/subjectClassController');
const studentController = require('../controllers/studentController');

router.post('/detail', subjectController.get);
router.post('/list', subjectController.getAll);
router.post('/class', subjectClassController.get);
router.post('/classes', subjectClassController.getAll);
router.post('/students', studentController.getBySubjectClass);

module.exports = router;