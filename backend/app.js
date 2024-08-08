var express = require('express');
var app = express();
const bodyParser = require('body-parser');

const loginRoutes = require('./routes/login');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.use('/login', loginRoutes);

// Session middleware
app.use(
  session({
    secret: undefined,
    resave: false,
    saveUninitialized: true,
  })
);
// Middleware to parse request body
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.get('/', function (req, res) {
  res.send('Wellcome to School Management System!');
});


app.listen(3000, function () {
  console.log('Server is running on port 3000!');
});