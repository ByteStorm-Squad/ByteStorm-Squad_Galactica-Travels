const pool = require("./db.js");

const Journey = function (journey) {
    this.Journey_ID = journey.Journey_ID;
    this.Route_ID = journey.Route_ID;
    this.Spacecraft_ID = journey.Spacecraft_ID;
    this.ArrivalDate = journey.ArrivalDate;
    this.ArrivalTime = journey.ArrivalTime;
    this.DepartureDate = journey.DepartureDate;
    this.DepartureTime = journey.DepartureTime;
    this.Flight_Status = journey.Flight_Status;
    this.Flight_Percent = journey.Flight_Percent;
}


module.exports = Journey;

