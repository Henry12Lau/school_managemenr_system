const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');
const subjectClassController = require('../controllers/subjectClassController');

router.post('/', studentController.get);
router.post('/schedule', subjectClassController.getByStudent);
router.post('/resetPassword', studentController.resetPassword);

module.exports = router;