const Pool = require('pg').Pool;

// const connection =  new Pool(  {
//     user: process.env.DB_USER,
//     password: process.env.DB_PASSWORD,
//     host: process.env.DB_HOST,
//     database: process.env.DB_DBNAME,
//     port: process.env.DB_PORT,
// });

const connection =  new Pool(  {
        user: "admin",
        password: "1234",
        host: "localhost",
        database: "spaceline_res",
        port: 5432,
    });

module.exports = connection;