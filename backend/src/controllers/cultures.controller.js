  const Culture = require("../models/cultures.model.js");

  exports.getAll = (req, res) => {
      Culture.getAll((err, data) => {
        if (err) res.status(500).send({ message: err.message });
        else res.send(data);
      });
    };
    
    exports.create = (req, res) => {
      const culture = req.body;
      Culture.create(culture, (err, data) => {
        if (err) {
          res.status(500).send({ message: err.message });
        } else {
          res.send(data);
        }
      });
    };
    

  exports.getByCode = (req, res) => {
    Culture.getByCode(req.params.code, (err, data) => {
      if (err) res.status(500).send({ message: err.message });
      else res.send(data);
    });
  };
  exports.create = (req, res) => {
    const culture = req.body;
    Culture.create(culture, (err, data) => {
      if (err) {
        res.status(500).send({ message: err.message });
      } else {
        res.send(data);
      }
    });
  };
  exports.update = (req, res) => {
    Culture.updateByCode(req.params.code, new Culture(req.body), (err, data) => {
      if (err) res.status(500).send({ message: err.message });
      else res.send(data);
    });
  };

  exports.delete = (req, res) => {
    Culture.delete(req.params.code, (err, data) => {
      if (err) res.status(500).send({ message: err.message });
      else res.send({ message: "Culture was deleted successfully!" });
    });
  };
