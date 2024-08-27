const express = require('express');
const router = express.Router();
const staffController = require('../controllers/staffController');
const subjectClassController = require('../controllers/subjectClassController');

router.post('/', staffController.get);
router.post('/schedule', subjectClassController.getByStaff);
router.post('/resetPassword', staffController.resetPassword);

module.exports = router;