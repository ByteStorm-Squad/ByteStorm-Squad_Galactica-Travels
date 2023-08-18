const pool = require("./db.js");

const Event = function (event) {
    this.Code = event.Code;
    this.Name = event.Name;
    this.Description = event.Description;
    this.Spaceport = event.Spaceport;
    this.Popularity_Rating = event.Popularity_Rating;
}

modeul.exports = Event;