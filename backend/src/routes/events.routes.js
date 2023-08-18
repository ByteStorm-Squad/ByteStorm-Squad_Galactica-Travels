const express = require("express");
const events = require("../controllers/events.controller.js");

const router = express.Router();

router.get("/events/", events.getAll);
router.get("/events/:code", events.getByCode);
router.post("/events/", events.create);
router.put("/events/:code", events.update);
router.delete("/events/:code", events.delete);

module.exports = router;
