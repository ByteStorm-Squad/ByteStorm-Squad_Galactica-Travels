const express = require('express');
const router = express.Router()
const checkRole = require('../middleware/auth');
const bookingController = require('../controllers/booking.controller');
const flightController = require('../controllers/flight.controller');
const responseValues = {
    seatdetail: 0,
}

// Default Booking Page
router.get('/booking', checkRole('user'), function (req, res) {
    const flightid = req.body;
    try {
        //const flightid = flight_id;
        bookingController.run(flightid, res, req.cookies.userRole);
    } catch (err) {
        console.log(err);
        res.send("500");
    }
})

router.post('/booking/flightid', function (req, res) {
    const flightid = req.body.Flight_ID;

    try {
        console.log(req.body)
        //const flightid = flight_id;
        bookingController.run(flightid, res, req.cookies);
    } catch (err) {
        console.log(err);
        res.send("500");
    }
})

router.get('/booking/flights', checkRole("user"), function (req, res) {
    try {
        flightController.getNextFlight(req, res, req.cookies);
    } catch (err) {
        console.log(err);
        res.send("500");
    }
})

router.post('/booking/createbooking', bookingController.createbooking);

module.exports = router;