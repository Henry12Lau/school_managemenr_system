const express = require('express');
const session = require('express-session');
const authRoutes = require('./routes/authRoutes');

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

app.listen(port, function () {
  console.log(`Server is running on port ${port}!`);
});