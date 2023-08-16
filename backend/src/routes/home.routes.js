const express = require("express");
const router = express.Router();
const checkRole = require('../middleware/auth');

router.get("/", function (req, res) {

    let role = req.cookies.userRole;
    res.render("home", { docTitle: "B-Airways", userRole: role });

});


router.get("/account", function (req, res) {

    let role = req.cookies.userRole;
    if (role === "user") {
        // Redirect the user to the user dashboard
        res.redirect("/userDashboard");
    } else if (role === "Manager") {
        // Redirect the user to the manager dashboard
        res.redirect("/managerDashboard");
    } else {
        // Render the home page for guests or users with an unknown role
        res.render("home", { docTitle: "B-Airways", userRole: role });
    }
});
router.get("/contact", function (req, res) {
    let role = req.cookies.userRole;
    res.render("contact", { docTitle: "Contact Us", userRole: role });
});

module.exports = router;