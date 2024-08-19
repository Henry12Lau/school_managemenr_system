const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentController');

router.post('/', studentController.get);
router.post('/resetPassword', studentController.resetPassword);

module.exports = router;