var express = require('express');
const userRoutes = require('./routes/user');

var app = express();
const port = 3000;
app.use(express.json());

app.get('/', function (req, res) {
  res.send('Wellcome to School Management System!');
});


app.use('/user', userRoutes);

app.listen(port, function () {
  console.log(`Server is running on port ${port}!`);
});