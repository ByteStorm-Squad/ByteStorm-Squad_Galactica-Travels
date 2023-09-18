

CREATE OR REPLACE VIEW Search_View AS 
SELECT 
    fs.Journey_ID AS flight_id,
    r.Origin AS origin,
    fs.Departure_Date AS departure_date,
    fs.Departure_Time AS departure_time,
    r.Destination AS destination,
    fs.Arrival_Date AS arrival_date,
    fs.Arrival_Time AS arrival_time
FROM Flight_Schedule fs
JOIN Route r ON fs.Route_ID = r.Route_ID;
