const pool = require("./db.js");

const Route = function (route) {
    this.Route_ID = route.Route_ID;
    this.Origin = route.Origin;
    this.Destination = route.Destination;
    this.Duration = route.Duration;
}

module.exports = Route;