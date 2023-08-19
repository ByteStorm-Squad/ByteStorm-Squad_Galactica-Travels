const pool = require("./db.js");

const PassengerPod = function (passengerPod) {
    this.Booking_ID = passengerPod.Booking_ID;
    this.Model_ID = passengerPod.Model_ID;
    this.Pod_ID = passengerPod.Pod_ID;
    this.Price = passengerPod.Price;
    this.Name = passengerPod.Name;
    this.Intergalactic_ID = passengerPod.Intergalactic_ID;
    this.DOB = passengerPod.DOB;
}

module.exports = PassengerPod;