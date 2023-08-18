const Attraction = require("../models/attractions.model.js");

exports.getAll = (req, res) => {
  Attraction.getAll((err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data.rows);
  });
};

exports.create = (req, res) => {
  const attraction = new Attraction(req.body);
  Attraction.create(attraction, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.getByCode = (req, res) => {
  Attraction.getByCode(req.params.code, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data.rows);
  });
};

exports.update = (req, res) => {
  Attraction.updateByCode(req.params.code, new Attraction(req.body), (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send(data);
  });
};

exports.delete = (req, res) => {
  Attraction.delete(req.params.code, (err, data) => {
    if (err) res.status(500).send({ message: err.message });
    else res.send({ message: "Attraction was deleted successfully!" });
  });
};
