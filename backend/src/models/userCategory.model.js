const pool = require("./db.js");

const UserCategory = function (userCategory) {
    this.User_Type = userCategory.User_Type;
    this.Minimum_Bookings = userCategory.Minimum_Bookings;
    this.Discount = userCategory.Discount;
}

module.exports = UserCategory;