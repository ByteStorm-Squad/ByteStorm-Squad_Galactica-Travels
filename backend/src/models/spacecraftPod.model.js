const pool = require("./db.js");

const SpacecraftPod = function (spacecraftPod) {
    this.Model_ID = spacecraftPod.Model_ID;
    this.Pod_ID = spacecraftPod.Pod_ID;
    this.Traveller_Class = spacecraftPod.Traveller_Class;
}

module.exports = SpacecraftPod;
