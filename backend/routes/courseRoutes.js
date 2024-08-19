const express = require('express');
const router = express.Router();
const courseController = require('../controllers/courseController');
const subjectController = require('../controllers/subjectController');

router.post('/', courseController.get);
router.post('/subjects', subjectController.getByCourse);

module.exports = router;