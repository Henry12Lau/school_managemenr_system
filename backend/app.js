const express = require('express');
const session = require('express-session');
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const studentRoutes = require('./routes/studentRoutes');

const port = 3000;
const app = express();
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



app.use('/student', isLoggedIn(['student']), studentRoutes);

app.use('/user', isLoggedIn(['admin']), userRoutes);

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