const pool = require("./db.js");

const PodPrice = function (podPrice) {
    this.Route_ID = podPrice.Route_ID;
    this.Class_ID = podPrice.Class_ID;
    this.Price = podPrice.Price;
}

module.exports = PodPrice;