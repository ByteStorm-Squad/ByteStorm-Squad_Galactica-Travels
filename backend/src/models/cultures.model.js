const pool = require("./db.js");

const Culture = function (culture) {
    this.Code = culture.Code;
    this.Name = culture.Name;
    this.Description = culture.Description;
    this.Spaceport = culture.Spaceport;
    this.Popularity_Rating = culture.Popularity_Rating;
}

module.exports = Culture;
