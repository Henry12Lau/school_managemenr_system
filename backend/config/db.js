const { Client  } = require('pg');

const dbConfig = {
  user: 'postgres',
  host: '127.0.0.1',
  database: 'hkit_sms',
  password: '',
  port: 5432
};

const client = new Client(dbConfig);
client.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    return;
  }

  console.log('Connected to the database');
});

module.exports = {
  query: (text, params) => client.query(text, params),
};