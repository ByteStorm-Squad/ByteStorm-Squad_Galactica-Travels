const pool = require("./db.js");

const Customer = function (customer) {
    this.Intergalactic_ID = customer.Intergalactic_ID;
    this.Customer_Type = customer.Customer_Type;
}

module.exports = Customer;