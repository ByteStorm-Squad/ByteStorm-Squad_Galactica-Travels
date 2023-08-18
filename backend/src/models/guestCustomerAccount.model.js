const pool = require("./db.js");

const GuestCustomerAccount = function (guestCustomerAccount) {
    this.First_Name = guestCustomerAccount.First_Name;
    this.Last_Name = guestCustomerAccount.Last_Name;
    this.Gender = guestCustomerAccount.Gender;
    this.DOB = guestCustomerAccount.DOB;
    this.Intergalactic_ID = guestCustomerAccount.Intergalactic_ID;
    this.Email = guestCustomerAccount.Email;
    this.Mobile = guestCustomerAccount.Mobile;
}

GuestCustomerAccount.create = (newGuestCustomerAccount, result) => {
    pool.query("INSERT INTO Guest_Customer_Account SET ?", newGuestCustomerAccount, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        }
        // console.log("created Guest Customer Account: ", { id: res.insertId, ...newGuestCustomerAccount });
        result(null, { id: res.insertId, ...newGuestCustomerAccount });
    });
};

GuestCustomerAccount.findById = (Intergalactic_ID, result) => {
    pool.query(`SELECT * FROM Guest_Customer_Account WHERE Intergalactic_ID = ${Intergalactic_ID}`, (err, res) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
            return;
        } else if (res.length) {
            console.log("found Guest Customer Account: ", res[0]);
            result(null, res[0]);
            return;
        }
        // not found Guest Customer Account with the id
        result({ kind: "not_found" }, null);
    });
}

module.exports = GuestCustomerAccount;