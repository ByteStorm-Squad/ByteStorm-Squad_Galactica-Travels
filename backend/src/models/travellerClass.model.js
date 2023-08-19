const pool = require("./db.js");

const TravellerClass = function (travellerClass) {
    this.Class_ID = travellerClass.Class_ID;
    this.Class_Name = travellerClass.Class_Name;
}

module.exports = TravellerClass;