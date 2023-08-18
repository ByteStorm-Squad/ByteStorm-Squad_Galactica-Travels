const pool = require("./db.js");

const SpacecraftInstance = function (spacecraftInstance) {
    this.Spacecraft_ID = spacecraftInstance.Spacecraft_ID;
    this.Model_ID = spacecraftInstance.Model_ID;
    this.Spacecraft_Status = spacecraftInstance.Spacecraft_Status;
    this.Maintenance_Date = spacecraftInstance.Maintenance_Date;
    this.Purchase_Date = spacecraftInstance.Purchase_Date;
}

module.exports = SpacecraftInstance;