const pool = require("./db.js");

const Attraction = function(attraction) {
  this.Code = attraction.Code;
  this.Name = attraction.Name;
  this.Description = attraction.Description;
  this.Spaceport = attraction.Spaceport;
  this.Popularity_Rating = attraction.Popularity_Rating;
};

Attraction.create = (newAttraction, result) => {
    const values = [
      newAttraction.Name,
      newAttraction.Description,
      newAttraction.Spaceport,
      newAttraction.Popularity_Rating
    ];
    const sql = "INSERT INTO attractions (\"Name\", \"Description\", \"Spaceport\", \"Popularity_Rating\") VALUES ($1, $2, $3, $4)";
    pool.query(sql, values, (err, res) => {
      if (err) {
        result(err, null);
        return;
      }
      result(null, { Code: res.insertId, ...newAttraction });
    });
  };
  

Attraction.getAll = result => {
  pool.query("SELECT * FROM attractions", (err, res) => {
    if (err) {
      result(null, err);
      return;
    }
    result(null, res);
  });
};

Attraction.getByCode = (attractionCode, result) => {
  pool.query(`SELECT * FROM attractions WHERE "Code" = ${attractionCode}`, (err, res) => {
    if (err) {
      result(err, null);
      return;
    }
    result(null, res);
  });
};

Attraction.updateByCode = (code, attraction, result) => {
  pool.query(
    `UPDATE attractions SET "Name" = $1, "Description" = $2, "Spaceport" = $3, "Popularity_Rating" = $4 WHERE "Code" = $5`,
    [attraction.Name, attraction.Description, attraction.Spaceport, attraction.Popularity_Rating, code],
    (err, res) => {
      if (err) {
        result(null, err);
        return;
      }
      result(null, { Code: code, ...attraction });
    }
  );
};

Attraction.delete = (code, result) => {
  pool.query(`DELETE FROM attractions WHERE "Code" = ?`, code, (err, res) => {
    if (err) {
      result(null, err);
      return;
    }
    result(null, res);
  });
};

module.exports = Attraction;
