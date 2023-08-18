const pool = require("./db.js");

const Attraction = function (attraction) {
    this.Code = attraction.Code;
    this.Name = attraction.Name;
    this.Description = attraction.Description;
    this.Spaceport = attraction.Spaceport;
    this.Popularity_Rating = attraction.Popularity_Rating;
}

module.exports = Attraction;