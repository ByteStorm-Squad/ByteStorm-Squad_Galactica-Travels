const pool = require("./db.js");

const Search = function (search) {
    this.Journey_ID = search.Journey_ID;
    this.Origin = search.Origin;
    this.Arrival_Date = search.Arrival_Date;
    this.Arrival_Time = search.Arrival_Time;
    this.Destination = search.Destination;
    this.Departure_Date = search.Departure_Date;
    this.Departure_Time = search.Departure_Time;
}
Search.getFlightSchedule = function (result) {
    sql = "SELECT * FROM search_table ";
    pool.query(sql, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Flight Schedule Details: ", res.rows);
            return result(null, res.rows);
        }
    });
}

module.exports = Search;