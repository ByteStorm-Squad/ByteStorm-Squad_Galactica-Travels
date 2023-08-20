
require("dotenv").config({ path: './src/config/.env' });
const express = require('express');
const swaggerUI = require('swagger-ui-express');
const fs = require('fs');
bodyParser = require('body-parser');

// Constants
const HOST = process.env.HOST || "0.0.0.0";
const PORT = process.env.PORT || 8080;

const app = express();

app.use(bodyParser.json());
// Get all files in the routes folder
const files = fs.readdirSync('./src/routes');

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*"); // update to match the domain you will make the request from
  res.header("Access-Control-Allow-Headers", "Authorization, Origin, X-Requested-With, Content-Type, Accept");
  next();
});

// Loop through each file and require it
files.forEach(file => {
  const routes = require(`./src/routes/${file}`);
  app.use('/api', routes);
});

const { swaggerSpecs } = require('./src/services/swagger');


// // Use the middleware to parse the request body
// app.use(express.json());
// Accept these headers to avoid CORS errors on the client side

///////////////////// Routes /////////////////////
app.use('/docs', swaggerUI.serve, swaggerUI.setup(swaggerSpecs));
// support parsing of application/json type post data

// app.listen(HOST, PORT, () => {
//   console.log(`Server running on host:port ${HOST}:${PORT}!`);
// });

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}!`);
});