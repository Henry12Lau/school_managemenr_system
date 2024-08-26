const express = require('express');
const cors = require('cors');
const session = require('express-session');
const authRoutes = require('./routes/authRoutes');
const manageRoutes = require('./routes/manageRoutes');
const studentRoutes = require('./routes/studentRoutes');
const staffRoutes = require('./routes/staffRoutes');
const courseRoutes = require('./routes/courseRoutes');
const subjectRoutes = require('./routes/subjectRoutes');

const port = 8080;
const app = express();
app.use(cors({
  origin: 'http://localhost:3000', // Replace with your Nuxt.js app's domain
  credentials: true
}));
app.use(express.json());
app.use(session({
  secret: 'DETtHQyF2WCTa4AWT+plvxQiyvydu6O2FJ55cltGfr0=',
  resave: false,
  saveUninitialized: true
}));

app.get('/', function (req, res) {
  res.send('Wellcome to School Management System!');
});


app.use('/auth', authRoutes);

app.use('/course', isLoggedIn(['student', 'admin', 'officer', 'teacher']), courseRoutes);
app.use('/subject', isLoggedIn(['student', 'admin', 'officer', 'teacher']), subjectRoutes);

app.use('/student', isLoggedIn(['student']), studentRoutes);
app.use('/staff', isLoggedIn(['admin', 'officer', 'teacher']), staffRoutes);
app.use('/manage', isLoggedIn(['admin', 'officer']), manageRoutes);

app.listen(port, function () {
  console.log(`Server is running on port ${port}!`);
});

function isLoggedIn(requiredPermissions = [])
{
  return (req, res, next) => {
    //FOR Develop
    return next();


    if (!req.session.user) {
      return res.status(500).json({ message: 'Missing Login session' });
    }
    if (requiredPermissions.some(permission => !req.session.user.permissions.includes(permission))) {
      return res.status(403).json({ message: 'Access Denied' });
    }
    return next();
  }
}