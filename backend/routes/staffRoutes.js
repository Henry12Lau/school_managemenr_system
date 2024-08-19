const express = require('express');
const router = express.Router();
const staffController = require('../controllers/staffController');

router.post('/', staffController.get);
router.post('/resetPassword', staffController.resetPassword);

module.exports = router;