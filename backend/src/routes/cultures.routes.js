const express = require("express");
const router = express.Router();
const culturesController = require('../controllers/cultures.controller.js');

router.get("/cultures", culturesController.getAll);
router.post("/cultures/create", culturesController.create);
router.get("/cultures/:code", culturesController.getByCode);
router.put("/cultures/:code", culturesController.update);
router.delete("/cultures/:code", culturesController.delete);

module.exports = router;
