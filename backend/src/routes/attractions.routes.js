const express = require("express");
const attractions = require("../controllers/attractions.controller.js");

const router = express.Router();

router.post("/attractions/create", attractions.create);
router.get("/attractions/", attractions.getAll);
router.get("/attractions/:code", attractions.getByCode);
router.put("/attractions/:code", attractions.update);
router.delete("/attractions/:code", attractions.delete);

module.exports = router;
