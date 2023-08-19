const express = require("express");
const router = express.Router();
//registrationController to access RegisteredUser Table
const registrationController = require('../controllers/registration.controller.js');
const checkRole = require('../middleware/auth');
const userDashboardController = require('../controllers/userDashboard.controller.js');

router.get("/login", function(req, res){
  let role = req.cookies.userRole;
  if (role === "user"||role === "Admin"||role === "Manager") {
      // Redirect the user to the user dashboard
      res.redirect("/account");
  } else {
      // Render the home page for guests or users with an unknown role
      res.render("login", {docTitle: "LOGIN", userRole: req.cookies.userRole});
  }

  });

router.post("/login", function(req, res){
    registrationController.getUserByEmail(req, res);
});

router.get("/logout", function(req, res){
    res.clearCookie('userRole');
    res.redirect('/');
});

module.exports = router;
