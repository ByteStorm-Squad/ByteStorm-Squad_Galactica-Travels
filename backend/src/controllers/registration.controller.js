const bcrypt = require("bcrypt");
const saltRounds = 10;
const RegisteredUser = require("../models/registeredUser.model.js");
const userDashboard = require("../models/userDashboard.model.js");

exports.getUserByEmail = (req, res) => {
  hash1 = bcrypt.hashSync("abc123", saltRounds);
  console.log(hash1);
  // Validate request
  if (!req.body) {
    res.status(400).send({ message: "Content can not be empty!" });
    return;
  }

  const email = req.body.email;
  const password = req.body.password;

  // Check if email and password match those of a registered user
  RegisteredUser.getUserByEmail(email, (err, data) => {
    if (err) {
      // Add this code to display a popup message and redirect to the login page
      res.status(500).send('Error retrieving user!');
      return;
    }

    if (data.length === 0) {
      // Add this code to display a popup message and redirect to the login page
      res.status(400).send({ message: "Invalid email or Password!" });
      return;
    }
    // Check if password matches
    bcrypt.compare(password, data[0].password, function (err, result) {

      if (result) {
        res.status(200).send(data[0]);
        return;
      }
      else {
        res.status(500).send('Invalid Password!');
      }

    });

  });
};

exports.createRegisteredUser = (req, res) => {
  // Validate request

  if (!req.body) {
    res.status(400).send({ message: "Content cannot be empty!" });
    return;
  }
  bcrypt.hash(req.body.password, saltRounds, function (err, hash) {
    // Create a new registered user
    const registeredUser = new RegisteredUser({
      password: hash,
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      gender: req.body.gender,
      dob: req.body.date_of_birth,
      email: req.body.email,
      mobile: req.body.mobile,
      user_type: req.body.user_type,
      address: req.body.address,
      country: req.body.country,
      passport_no: req.body.passport_no,
      no_of_bookings: 0,
      display_photo: req.body.display_photo,
    });


    // Save registered user in the database
    RegisteredUser.createUser(registeredUser, (err, data) => {
      if (err) {

        res.status(500).send("<p>There was an error creating the user. Redirecting to registration page in 3 seconds...</p>" +
          "<script>setTimeout(function () { window.location.href = '/register'; }, 3000);</script>");
      }
      else {
        // Display a successful creation box
        res.send("<p>User created successfully! Redirecting to login page in 3 seconds...</p>" +
          "<script>setTimeout(function () { window.location.href = '/login'; }, 3000);</script>");
      }
    });

  });


}

exports.registerstaff = (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({ message: "Content can not be empty!" });
    return;
  }
  bcrypt.hash(req.body.Password, saltRounds, function (err, hash) {
    // Create a new registered user
    const registerstaff = new Staff({
      Category: req.body.Category,
      Password: hash,
      First_Name: req.body.First_Name,
      Last_Name: req.body.Last_Name,
      Contact: req.body.Contact,
      Email: req.body.Email,
      DOB: req.body.DOB,
      Gender: req.body.Gender,
      Assigned_Airport: req.body.Assigned_Airport,
      Country: req.body.Country
    });

    // Save registered user in the database
    Staff.registerstaff(registerstaff, (err, data) => {
      if (err) {

        res.status(500).send("<p>There was an error creating the staff. Redirecting to registration page in 3 seconds...</p>" +
          "<script>setTimeout(function () { window.location.href = '/staff_register'; }, 3000);</script>");
      }
      else {
        // Display a successful creation box
        res.send("<p>staff created successfully! Redirecting to staff login page in 3 seconds...</p>" +
          "<script>setTimeout(function () { window.location.href = '/staff_login'; }, 3000);</script>");
      }
    });

  });


}