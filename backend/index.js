const express = require('express');
const swaggerUI = require('swagger-ui-express');
const fs = require('fs');
bodyParser = require('body-parser');

const app = express();

// Get all files in the routes folder
const files = fs.readdirSync('./src/routes');

// Loop through each file and require it
files.forEach(file => {
  const routes = require(`./src/routes/${file}`);
  app.use('/api', routes);
});

const { swaggerSpecs } = require('./src/services/swagger');

// support parsing of application/json type post data
app.use(bodyParser.json());

//support parsing of application/x-www-form-urlencoded post data
app.use(bodyParser.urlencoded({ extended: true }));

// // Use the middleware to parse the request body
// app.use(express.json());
// Accept these headers to avoid CORS errors on the client side
app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*"); // update to match the domain you will make the request from
  res.header("Access-Control-Allow-Headers", "Authorization, Origin, X-Requested-With, Content-Type, Accept");
  next();
});

///////////////////// Routes /////////////////////
app.use('/docs', swaggerUI.serve, swaggerUI.setup(swaggerSpecs));

const PORT = process.env.NODE_PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}!`);
});
