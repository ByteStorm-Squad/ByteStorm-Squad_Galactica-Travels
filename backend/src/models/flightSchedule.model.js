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


Journey.getFlightCount = function (destination, start, end, result) {
    sql = "SELECT count(flight_schedule.flight_id) as count FROM flight_schedule left join route on flight_schedule.route_id=route.route_id where route.destination=$1 and flight_schedule.departure_Date between $2 and $3";
    const queryParams = [destination, start, end];
    pool.query(sql, queryParams, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Count: ", res.rows);
            return result(null, res.rows);
        }
    });
};

Journey.getPlaneModelRevenue = function (result) {
    sql = "SELECT plane_type.model_name, plane_type.variant, SUM(COALESCE(booking.final_price,0)) " +
        "FROM plane_type " +
        "LEFT JOIN aircraft_instance ON plane_type.model_id=aircraft_instance.model_id " +
        "LEFT JOIN flight_schedule ON aircraft_instance.aircraft_id=flight_schedule.aircraft_id " +
        "LEFT JOIN booking ON flight_schedule.flight_id=booking.flight_id " +
        "GROUP BY plane_type.model_name, plane_type.variant;";
    pool.query(sql, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Revenue Details: ", res.rows);
            return result(null, res.rows);
        }
    });
}

//work in progress
Journey.getBookingCount = function (start, end, result) {
    sql = "SELECT COUNT(booking_view.passport_no),  COALESCE(CAST(booking_view.user_type AS character varying(15)) , 'Guest') AS user_type " +
        "FROM booking_view " +
        "WHERE booking_view.booking_date between $1 and $2 " +
        "GROUP BY user_type";
    const queryParams = [start, end];
    pool.query(sql, queryParams, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log(res);
            console.log("Revenue Details: ", res.rows);
            return result(null, res.rows);
        }
    });
}

Journey.getFlightRoutes = function (result) {
    sql = "SELECT route.origin, route.destination from route";
    pool.query(sql, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Route Details: ", res.rows);
            return result(null, res.rows);
        }
    });

}

Journey.getNextFlights = function (origin, destination, result) {
    // const current_date = new Date();
    // current_date = current_date.toISOString().slice(0,10);
    // console.log("Current Date: "+current_date);
    sql = "SELECT flight_schedule.journey_id, flight_schedule.route_id, flight_schedule.spacecraft_id, flight_schedule.flight_status," +
        "flight_schedule.departure_date, flight_schedule.arrival_date " +
        "FROM flight_schedule " +
        "WHERE flight_schedule.journey_id IN " +
        "(SELECT flight_schedule.journey_id FROM flight_schedule " +
        "LEFT JOIN route on flight_schedule.route_id=route.route_id " +
        "WHERE route.origin=$1 AND route.destination=$2 AND " +
        "flight_schedule.departure_date > '2020-05-01');"
    // "flight_schedule.departure_date > '2020-05-01');"
    const queryParams = [origin, destination];
    pool.query(sql, queryParams, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Passenger Details: ", res.rows);
            return result(null, res.rows);
        }
    });
}

Journey.getNextFlight = function (origin, destination, result) {
    // const current_date = new Date();
    // current_date = current_date.toISOString().slice(0,10);
    // console.log("Current Date: "+current_date);
    sql = "SELECT flight_schedule.journey_id, flight_schedule.route_id, flight_schedule.spacecraft_id, flight_schedule.flight_status," +
        "flight_schedule.departure_date, flight_schedule.arrival_date " +
        "FROM flight_schedule " +
        "WHERE flight_schedule.journey_id IN " +
        "(SELECT flight_schedule.journey_id FROM flight_schedule " +
        "LEFT JOIN route on flight_schedule.route_id=route.route_id " +
        "WHERE route.origin=$1 AND route.destination=$2 AND " +
        "flight_schedule.departure_date > CURRENT_DATE LIMIT 1);"
    // "flight_schedule.departure_date > '2020-05-01' LIMIT 1);"
    const queryParams = [origin, destination];
    pool.query(sql, queryParams, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Passenger Details: ", res.rows);
            return result(null, res.rows);
        }
    });
}


Journey.getPastFlight = function (origin, destination, result) {
    // const current_date = new Date();
    // current_date = current_date.toISOString().slice(0,10);
    // console.log("Current Date: "+current_date);
    sql = "SELECT flight_schedule.flight_id, COUNT(flight_schedule.passport_no) AS Passenger_Count, " +
        "flight_schedule.flight_status, flight_schedule.departure_date " +
        "FROM flight_schedule " +
        "WHERE flight_schedule.flight_id IN " +
        "(SELECT flight_schedule.flight_id FROM flight_schedule " +
        "LEFT JOIN route on flight_schedule.route_id=route.route_id " +
        "WHERE route.origin=$1 AND route.destination=$2 AND " +
        "flight_schedule.departure_date < CURRENT_DATE) " +
        "GROUP BY (flight_schedule.flight_id, flight_schedule.flight_status, flight_schedule.departure_date);"
    const queryParams = [origin, destination];
    pool.query(sql, queryParams, function (err, res) {
        if (err) {
            console.log("error: ", err);
            return result(err, null);
        }
        else {
            console.log("Journey Statistics: ", res.rows);
            return result(null, res.rows);
        }
    });
}

module.exports = Journey;

