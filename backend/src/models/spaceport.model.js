const pool = require("./db.js");

const Spaceport = function (spaceport) {
    this.Code = spaceport.Code;
    this.Galaxy = spaceport.Galaxy;
    this.Solar_System = spaceport.Solar_System;
    this.Planet = spaceport.Planet;
    this.Description = spaceport.Description;
}

module.exports = Spaceport;