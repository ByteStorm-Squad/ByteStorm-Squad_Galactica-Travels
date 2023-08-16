const pool = require("./db.js");

const RegisteredCustomerAccount = function (registeredCustomerAccount) {
  this.Customer_ID = registeredCustomerAccount.Customer_ID;
  this.Password = registeredCustomerAccount.Password;
  this.First_Name = registeredCustomerAccount.First_Name;
  this.Last_Name = registeredCustomerAccount.Last_Name;
  this.Gender = registeredCustomerAccount.Gender;
  this.DOB = registeredCustomerAccount.DOB;
  this.Email = registeredCustomerAccount.Email;
  this.Mobile = registeredCustomerAccount.Mobile;
  this.User_Type = registeredCustomerAccount.User_Type;
  this.Address = registeredCustomerAccount.Address;
  this.Galaxy = registeredCustomerAccount.Galaxy;
  this.SolarSystem = registeredCustomerAccount.SolarSystem;
  this.Planet = registeredCustomerAccount.Planet;
  this.Intergalactic_ID = registeredCustomerAccount.Intergalactic_ID;
  this.No_of_Journeys = registeredCustomerAccount.No_of_Journeys;
  this.Joined = registeredCustomerAccount.Joined;
};

RegisteredCustomerAccount.getUserByEmail = function (Email, result) {
  const sql = "SELECT * FROM Registered_Customer_Account WHERE Email = $1";
  const queryParams = [Email];
  pool.query(sql, queryParams, function (err, res) {
    if (err) {
      console.log("error: ", err);
      return result(err, null);
    } else {
      console.log("Retrieved user: ", res.rows);
      return result(null, res.rows);
    }
  });
};

RegisteredCustomerAccount.createUser = function (newCustomer, result) {
  pool.connect(function (err, client, release) {
    if (err) {
      console.log("Error getting connection: ", err);
      return result(err, null);
    }

    client.query("BEGIN", function (err) {
      if (err) {
        console.log("Error beginning transaction: ", err);
        release();
        return result(err, null);
      }
      const sql1 = "INSERT INTO Customer(Passport_no, Customer_Type) VALUES($1, $2)";
      const queryParams1 = [newCustomer.Intergalactic_ID, "registered"];
      client.query(sql1, queryParams1, function (err, res) {
        if (err) {
          console.log("Error executing statement 1: ", err);
          client.query("ROLLBACK", function () {
            return result(err, null);
          });
          return;
        }
        const sql2 = "INSERT INTO registeredCustomerAccount (Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Passport_no, No_of_Journeys, Joined, display_photo) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, CURRENT_TIMESTAMP, $13)";
        const queryParams2 = [
          newCustomer.Password,
          newCustomer.First_Name,
          newCustomer.Last_Name,
          newCustomer.Gender,
          newCustomer.DOB,
          newCustomer.Email,
          newCustomer.Mobile,
          newCustomer.User_Type,
          newCustomer.Address,
          newCustomer.Galaxy,
          newCustomer.Intergalactic_ID,
          newCustomer.No_of_Journeys,
        ];
        client.query(sql2, queryParams2, function (err, res) {
          if (err) {
            console.log("Error executing statement 2: ", err);
            client.query("ROLLBACK", function () {
              return result(err, null);
            });
            return;
          }
          client.query("COMMIT", function (err) {
            if (err) {
              console.log("Error committing transaction: ", err);
              client.query("ROLLBACK", function () {
                return result(err, null);
              });
            } else {
              console.log("Created user: ", { id: res.insertId, ...newCustomer });
              return result(null, { id: res.insertId, ...newCustomer });
            }
          });
        });
      });
    });

    release();
  });
};



module.exports = RegisteredCustomerAccount;