
const pool = require("./db.js");

// Booking object create
var Booking = function (booking) {
    this.Booking_ID = booking.Booking_ID;
    this.Intergalactic_ID = booking.Intergalactic_ID;
    this.Journey_ID = booking.Journey_ID;
    this.Pod_ID = booking.Pod_ID;
    this.Model_ID = booking.Model_ID;
    this.Pod_Price = booking.Pod_Price;
    this.Discount = booking.Discount;
    this.Final_Price = booking.Final_Price;
    this.Booking_Status = booking.Booking_Status;
    this.Booking_Date = new Date();
};

Booking.getpaymentstatus = async function (bookingid) {
    let status = await pool.query("SELECT booking_status FROM Booking WHERE booking_id=$1", [bookingid]);
    console.log("status :::::", status.rows[0])
    return status.rows[0];
}

Booking.getprice = async function (bookingid) {
    let prices = await pool.query("SELECT Pod_Price,final_price FROM Booking WHERE booking_id=$1", [bookingid]);
    return prices.rows[0];
}

Booking.createbooking = async function (newseat) {
    console.log(newseat)
    let booking_id = await pool.query("SELECT insertbooking($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)", [newseat.Intergalactic_ID, newseat.Journey_ID, newseat.Passport_Name, newseat.Passno, newseat.passDOB, newseat.seatNo, newseat.firstname, newseat.lastname, newseat.gender, newseat.dob, newseat.email, newseat.mobile, newseat.custtype]);
    console.log("booking id = ", booking_id.rows[0].insertbooking)
    return booking_id.rows[0].insertbooking;
}

Booking.getPods = async function (Journey_ID) {
    let capacities = await pool.query("SELECT Economy_Pod_Capacity, Business_Pod_Capacity, Platinum_Pod_Capacity, E_Pods_Per_row, B_Pods_Per_row, P_Pods_Per_row FROM Spacecraft_Type NATURAL JOIN Flight_Schedule WHERE Journey_ID = $1", [Journey_ID]);
    let booked_seat = await pool.query("SELECT pod_id FROM Passenger_Pod LEFT JOIN Booking on Passenger_Pod.booking_id=Booking.booking_id Where Journey_ID=$1", [Journey_ID]);
    let model_id = await pool.query("SELECT model_id FROM Spacecraft_Instance NATURAL JOIN Flight_Schedule WHERE Journey_ID=$1", [Journey_ID]);
    console.log([capacities.rows[0], booked_seat.rows, model_id.rows[0]])
    return [capacities.rows[0], booked_seat.rows, model_id.rows[0]];
}

Booking.getflightinfo = async function (Journey_ID) {
    let flightinfo = await pool.query("SELECT Journey_ID,Route_ID, Departure_Date, Departure_Time, Arrival_Date, Arrival_Time, Route.Origin, Route.Destination, Route.Duration FROM Flight_Schedule NATURAL JOIN Route WHERE Journey_ID=$1", [Journey_ID]);
    let priceinfo = await pool.query("SELECT Class_ID, price FROM Pod_Price WHERE Route_ID=$1", [flightinfo.rows[0].route_id]);
    console.log("Flight info = ", flightinfo.rows[0])
    return [flightinfo.rows[0], priceinfo.rows];
}

Booking.getlocations = async function () {
    let locations = await pool.query("SELECT Code FROM Spaceport");
    let location_codes = []
    locations.rows.forEach(element => location_codes.push(element.code))
    console.log("location codes = ", location_codes)
    return location_codes;
}

Booking.getbookingdetails = async function (booking_id) {
    let query = await pool.query("SELECT passenger_seat.name,passenger_seat.Intergalactic_ID,passenger_seat.seat_id,booking.Journey_ID,booking.booking_date,Spacecraft_Type.model_name,Spacecraft_Type.variant,Route.origin,Route.Destination,Flight_Schedule.departure_date,Flight_Schedule.departure_time,Flight_Schedule.arrival_date,Flight_Schedule.arrival_time FROM booking left join passenger_seat on booking.booking_id=Passenger_seat.booking_id LEFT JOIN Spacecraft_Type ON Spacecraft_Type.model_id=booking.model_id LEFT JOIN Flight_Schedule ON Flight_Schedule.Journey_ID=booking.Journey_ID LEFT JOIN Route ON FLight_Schedule.route_id=Route.route_id WHERE booking.booking_id=$1", [booking_id]);
    console.log("Booking details : ", query.rows);
    return query.rows;
}

Booking.successbooking = async function (booking_id) {
    let query = await pool.query("UPDATE Booking SET booking_status = 'Paid' WHERE booking_id=$1", [booking_id]);
}

Booking.cancelbooking = async function (booking_id) {
    let query = await pool.query("DELETE FROM Booking WHERE booking_id=$1 and booking_status = 'Not paid'", [booking_id]);
}

module.exports = Booking;