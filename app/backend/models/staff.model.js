
const pool = require("./db.js");

const Staff = function(staff){
    this.Staff_ID = staff.Staff_ID;
    this.Category = staff.Category;
    this.Password = staff.Password;
    this.First_Name = staff.First_Name;
    this.Last_Name = staff.Last_Name;
    this.Contact = staff.Contact;
    this.Email = staff.Email;
    this.DOB = staff.DOB;
    this.Gender = staff.Gender;
    this.Assigned_Airport = staff.Assigned_Airport;
    this.Country = staff.Country;
}

// register new staff
Staff.registerstaff = function(newstaff,result){
    pool.connect(function (err, client, release) {
        if (err) {
            console.log("Error getting connection: ", err);
            return result(err, null);
        }
        client.query("BEGIN",function(err){
            if(err){
                console.log("Error beginning transaction: ",err);
                release();
                return result(err, null);
            }
            const sql = "INSERT INTO Staff (Category,Password,First_Name,Last_Name,Contact,Email,DOB,Gender,Assigned_Airport,Country) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)"
            const queryParams = [
              newstaff.Category,
              newstaff.Password,
              newstaff.First_Name,
              newstaff.Last_Name,
              newstaff.Contact,
              newstaff.Email,
              newstaff.DOB,
              newstaff.Gender,
              newstaff.Assigned_Airport,
              newstaff.Country
            ];
            client.query(sql,queryParams,function(err,res){
                if (err) {
                    console.log("Error executing statement : ", err);
                    client.query("ROLLBACK", function () {
                      return result(err, null);
                    });
                    return;
                }
                client.query("COMMIT",function(err){
                  if(err){
                    console.log("Error committing transaction: ", err);
                    client.query("ROLLBACK", function () {
                      return result(err, null);
                    });
                  } else{
                    console.log("Created staff: ",{ id: res.insertId, ...newstaff } );
                    return result(null, { id: res.insertId, ...newstaff });
                  }
                });
            });
        });
        release();
    });
};


Staff.getStaffByEmail = function(email,result){
  const sql = "SELECT * FROM Staff WHERE email = $1";
  const queryParams = [email];
  pool.query(sql,queryParams,function(err,res){
      if (err) {
          console.log("error: ", err);
          return result(err,null);
      } else {
          console.log("Retrieved Staff: ", res.rows[0]);
          return result(null,res.rows);
      }
  });
};


Staff.firestaff = async function(email,Category){
  const sql = "DELETE FROM Staff WHERE email = $1 and Category = $2";
  const queryParams = [email,Category];
  pool.query(sql,queryParams);
};

module.exports = Staff;