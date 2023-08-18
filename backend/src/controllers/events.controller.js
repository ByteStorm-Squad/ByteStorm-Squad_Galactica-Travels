const Events = require("../models/events.model.js");

exports.getAll = (req, res) => {
  Events.getAll((err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.getByCode = (req, res) => {
  Events.getByCode(req.params.code, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.create = (req, res) => {
  const event = req.body;
  Events.create(event, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.update = (req, res) => {
  Events.updateByCode(req.params.code, new Events(req.body), (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.delete = (req, res) => {
  Events.delete(req.params.code, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send({ message: "Event was deleted successfully!" });
  });
};
