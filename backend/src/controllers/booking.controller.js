'use strict';


const e = require('express');
const Booking = require('../models/booking.model');
// const Flight = require('../models/flight.model')

const responseValues = {
    seatdetail: 0, 
    customerseatdetail : 0
  }
exports.getFlights = async (req,res, cookies) => {
    try{
        
        const flightInfo = await Booking.getflightinfo(req);
          
          console.log("Flight_info",flightInfo[0]);
          console.log("Seat price",flightInfo[1]);
          res.status(200).send(JSON.stringify({"Flight_info" : flightInfo[0], "Seat price" : flightInfo[1]}));
          //res.render('booking');payment screen
          return;

    }catch(err){
        res.send("500");
    }
}
exports.getPods = async (req,res, cookies) => {
    try{        
    
        const seat_info = await Booking.getPods(req);

          console.log("Capacities : ",seat_info[0]);
          console.log("Booked seats : ",seat_info[1]);
          console.log("Model Id : ",seat_info[2]);          
               res.status(200).send(JSON.stringify({"Capacities" : seat_info[0], "Booked seats" : seat_info[1], "Model Id" : seat_info[2]}));
          //res.render('booking');payment screen
          return;

    }catch(err){
        res.send("500");
    }
}

exports.createbooking = async (req,res)=>{
    try{
        const formData = req;
        let book_id = await Booking.createbooking(req.body);
        console.log("formData.body : ",formData.body);
        console.log("booking_id : ",book_id);
        res.status(200).send(JSON.stringify({book_id, formData: formData.body}));
        // return res.redirect("/payment")

    } catch (err){
        console.log(err)
        res.status(400).send("Bad Request: The selected Pod has been taken. Please select a different Pod");
    }
}

exports.getpayment = async (req,res) => {
    try{
        console.log(req);
        const booking_status = await Booking.getpaymentstatus(req.body.booking_id);
        if(booking_status.status ==='Paid'){
            return res.status(405).send("Paid");
        }
        const prices = await Booking.getprice(req.session.booking_id);
        if(typeof prices === 'undefined'){
            return res.status(405).send("Unable to fetch prices");
        }else{
            console.log("prices :  ",prices);
            console.log('req.session.formData :',req.session.formData);
            console.log('req.session.booking_id :',req.session.booking_id);
            
            res.status(200).send(JSON.stringify({prices, formData: req.session.formData, booking_id: req.session.booking_id}));
        }
    }catch(err){
        console.log("ERROR : ",err);
        return res.redirect('/booking/payment')
    }
}


exports.getbooking = (req,res)=>{
    try{
        let Flight_ID;
        if(typeof req.body.Flight_ID !== 'undefiened'){
            Flight_ID = req.body.Flight_ID;
        }
        else{
            Flight_ID = req.query.Flight_ID;
        }

        const flightInfo = Booking.getflightinfo(Flight_ID);
        const seat_info = Booking.getseats(Flight_ID);
        responseValues.seatdetail = [
            {
              booking_id: null,
              passport_no: null,
              flight_id: null,
              seat_id:null,
              seat_price: null,
              discount: null,
              final_price: null,
              booking_status: null,
              booking_date: null
            }
          ];

        res.render('booking',{
            Flight_ID,
            user : req.session.user,
            seat_info,
            firstname : req.query.firstname,
            lastname : req.query.lastname,
            dob : req.query.dob,
            gender : req.query.gender,
            mobile : req.query.mobile,
            Passport_no : req.query.Passport_no,
            email : req.query.email,
            flightinfo : flightInfo[0],
            priceinfo: flightInfo[1],
            formData: req, 
            docTitle: "BOOKING", 
            data: responseValues, 
            content: 0,
            userRole: cookies 
        })
    }catch(err){
        console.log("Controller Error"+err);
        res.send(500);
    }
}

exports.paymentSuccess = async (req, res) => {
    try {
        await Booking.successbooking(req.session.booking_id);
        const bookingDetails = await Booking.getbookingdetails(req.session.booking_id);
        const flight_id=bookingDetails[0].flight_id;
        const flight_details = await Booking.getflightinfo(flight_id);

        res.render('payment_successful', {
            docTitle:"Eticket",
            flight_details,
            bookingDetails: bookingDetails,
            formData:req.session.formData,
            userRole: req.cookies.userRole
        });
    } catch (error) {
        console.log(error);
        return res.redirect('/booking/payment');
    }
}


exports.cancelbooking = async (req,res) => {
    try{
        await Booking.cancelbooking(req.session.booking_id);
        res.redirect('/')
    }catch{
        console.log(error);
        res.redirect('/')
    }

}
