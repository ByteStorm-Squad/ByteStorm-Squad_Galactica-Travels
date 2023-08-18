const pool = require("./db.js");

const Flight = function (flight) {
    this.Journey_ID = flight.Journey_ID;
    this.Route_ID = flight.Route_ID;
    this.Spacecraft_ID = flight.Spacecraft_ID;
    this.ArrivalDate = flight.ArrivalDate;
    this.ArrivalTime = flight.ArrivalTime;
    this.DepartureDate = flight.DepartureDate;
    this.DepartureTime = flight.DepartureTime;
    this.Flight_Status = flight.Flight_Status;
    this.Flight_Percent = flight.Flight_Percent;
}


module.exports = Flight;

