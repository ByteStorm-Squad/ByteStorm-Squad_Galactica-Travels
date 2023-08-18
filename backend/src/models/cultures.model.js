const pool = require("./db.js");

const Culture = function(culture) {
  this.Code = culture.Code;
  this.Name = culture.Name;
  this.Description = culture.Description;
  this.Spaceport = culture.Spaceport;
  this.Popularity_Rating = culture.Popularity_Rating;
};

Culture.getAll = function(result) {
    // consolse.log("hello")
    const sql = "SELECT * FROM Cultures";
    pool.query(sql, (err, res) => {
      if (err){
         const result = result(err, null)
         return result
        };
      return result(null, res.rows);
    });
  };
  
  Culture.create = function(newCulture, result) {
    const sql = "INSERT INTO public.cultures (\"Code\", \"Name\", \"Description\", \"Spaceport\", \"Popularity_Rating\") VALUES ($1, $2, $3, $4, $5)";
    const values = [newCulture.Code, newCulture.Name, newCulture.Description, newCulture.Spaceport, newCulture.Popularity_Rating];
    pool.query(sql, values, (err, res) => {
      if (err) {
        console.log("error: ", err);
        return result(err, null);
      } else {
        console.log("Inserted culture: ", res.insertId);
        return result(null, res.insertId);
      }
    });
  };
  
  

  Culture.getByCode = function(code, result) {
    const sql = "SELECT * FROM Cultures WHERE \"Code\" = $1";
    pool.query(sql, [code], (err, res) => {
      if (err) return result(err, null);
      return result(null, res.rows[0]); // Assuming you want the first row of the result
    });
  };
  

  Culture.updateByCode = function(code, updateCulture, result) {
    const { Name, Description, Spaceport, Popularity_Rating } = updateCulture;
    const sql = `
      UPDATE Cultures
      SET "Name" = $1, "Description" = $2, "Spaceport" = $3, "Popularity_Rating" = $4
      WHERE "Code" = $5
    `;
  
    pool.query(sql, [Name, Description, Spaceport, Popularity_Rating, code], (err, res) => {
      if (err) return result(err, null);
      return result(null, { code: code, ...updateCulture });
    });
  };
  
  

  Culture.delete = function(code, result) {
    const sql = `DELETE FROM Cultures WHERE "Code" = $1`;
    pool.query(sql, [code], (err, res) => {
      if (err) return result(err, null);
      return result(null, res);
    });
  };
  

module.exports = Culture;
