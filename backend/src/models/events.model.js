const pool = require("./db.js");

const Event = function(event) {
    this.Code = event.Code;
    this.Name = event.Name;
    this.Description = event.Description;
    this.Spaceport = event.Spaceport;
    this.Popularity_Rating = event.Popularity_Rating;
  };
  

  

Event.getAll = function(result) {
  const sql = "SELECT * FROM public.events";
  pool.query(sql, (err, res) => {
    if (err) return result(err, null);
    return result(null, res.rows);
  });
};

Event.getByCode = function(code, result) {
  const sql = 'SELECT * FROM public.events WHERE "Code" = $1';
  pool.query(sql, [code], (err, res) => {
    if (err) return result(err, null);
    return result(null, res.rows[0]);
  });
};

Event.create = function(event, result) {
  const sql = 'INSERT INTO public.events ("Name", "Description", "Spaceport", "Popularity_Rating") VALUES ($1, $2, $3, $4) RETURNING *';
  pool.query(sql, [event.Name, event.Description, event.Spaceport, event.Popularity_Rating], (err, res) => {
    if (err) return result(err, null);
    return result(null, res.rows[0]);
  });
};

Event.updateByCode = function(code, updateEvent, result) {
  const sql = 'UPDATE public.events SET "Name" = $1, "Description" = $2, "Spaceport" = $3, "Popularity_Rating" = $4 WHERE "Code" = $5 RETURNING *';
  pool.query(sql, [updateEvent.Name, updateEvent.Description, updateEvent.Spaceport, updateEvent.Popularity_Rating, code], (err, res) => {
    if (err) return result(err, null);
    return result(null, res.rows[0]);
  });
};

Event.delete = function(code, result) {
  const sql = 'DELETE FROM public.events WHERE "Code" = $1';
  pool.query(sql, [code], (err, res) => {
    if (err) return result(err, null);
    return result(null, res.rows);
  });
};

module.exports = Event;