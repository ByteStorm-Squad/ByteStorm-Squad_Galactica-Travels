const pool = require("./db.js");

const SpacecraftType = function (spacecraftType) {
    this.Model_ID = spacecraftType.Model_ID;
    this.Model_Name = spacecraftType.Model_Name;
    this.Variant = spacecraftType.Variant;
    this.Manufacturer = spacecraftType.Manufacturer;
    this.Economy_Pod_Capacity = spacecraftType.Economy_Pod_Capacity;
    this.Business_Pod_Capacity = spacecraftType.Business_Pod_Capacity;
    this.Platinum_Pod_Capacity = spacecraftType.Platinum_Pod_Capacity;
    this.E_Pods_Per_Row = spacecraftType.E_Pods_Per_Row;
    this.B_Pods_Per_Row = spacecraftType.B_Pods_Per_Row;
    this.P_Pods_Per_Row = spacecraftType.P_Pods_Per_Row;
    this.Max_Load = spacecraftType.Max_Load;
    this.Fuel_Capacity = spacecraftType.Fuel_Capacity;
}

module.exports = SpacecraftType;