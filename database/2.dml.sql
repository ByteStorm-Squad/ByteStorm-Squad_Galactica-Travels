/*
  ___  _  _  ___  ___  ___  _____   ___  _____  _  _____  ___  __  __  ___  _  _  _____  ___ 
 |_ _|| \| |/ __|| __|| _ \|_   _| / __||_   _|/_\|_   _|| __||  \/  || __|| \| ||_   _|/ __|
  | | | .` |\__ \| _| |   /  | |   \__ \  | | / _ \ | |  | _| | |\/| || _| | .` |  | |  \__ \
 |___||_|\_||___/|___||_|_\  |_|   |___/  |_|/_/ \_\|_|  |___||_|  |_||___||_|\_|  |_|  |___/
                                                                                                                                                                                     
*/



-- Inserting spaceport data
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('ALP', 'Andromeda', 'Andromeda System', 'Xenoria', 'Major hub for intergalactic trade and diplomacy.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('MIL', 'Milky Way', 'Sol System', 'Terra Nova', 'Gateway to various star clusters in the Milky Way.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('CEN', 'Centaurus A', 'Centaurus System', 'Alpha Centauri Prime', 'Closest spaceport to Earth, facilitating human-alien interactions.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('ORI', 'Orion', 'Betelgeuse System', 'New Tarsus', 'Known for its breathtaking views of the Orion Nebula.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('TRI', 'Triangulum', 'Triangulum System', 'Celestia', 'Famous for its advanced warp drive refueling technology.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('VEG', 'Vega', 'Vega System', 'Astralon', 'A central hub connecting the outer rim planets to the inner core galaxies.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('LEO', 'Leo I', 'Leo System', 'Regulus VII', 'Facilitating cultural exchange between species from various galaxies.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('SCU', 'Scutum-Crux Arm', 'Eta Carinae System', 'Nebulaar', 'Located near the breathtaking Great Carina Nebula.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('PIN', 'Pinwheel', 'M101 System', 'Eclipsion', 'Known for its cutting-edge zero-gravity recreational facilities.');
INSERT INTO Spaceport (Code, Galaxy, Solar_System, Planet, Description)
VALUES ('HYD', 'Hydra', 'Hydra Cluster', 'Aquatica', 'Promotes research on aquatic life from various water-based planets.');



-----------------------USER CATEGORY-----------------------


INSERT INTO User_Category(User_Type,Minimum_Bookings,Discount) VALUES ('General',0,0);
INSERT INTO User_Category(User_Type,Minimum_Bookings,Discount)VALUES ('Frequent',5,5);
INSERT INTO User_Category(User_Type,Minimum_Bookings,Discount) VALUES ('Gold',10,9);


-----------------------TRAVELLER CLASS-----------------------


INSERT INTO Traveller_Class(class_name) VALUES ('Platinum');
INSERT INTO Traveller_Class(class_name) VALUES ('Business');
INSERT INTO Traveller_Class(class_name) VALUES ( 'Economy');



-- Inserting spacecraft type data
INSERT INTO Spacecraft_Type (Model_Name, Variant, Manufacturer, Economy_Pod_Capacity, Business_Pod_Capacity, Platinum_Pod_Capacity, E_Pods_Per_Row, B_Pods_Per_Row, P_Pods_Per_Row, Max_Load, Fuel_Capacity)
VALUES ('Stellar Voyager', 'Mk I', 'Galactic Industries', 150, 20, 8, 5, 4, 2, 120000, 75000.00);
INSERT INTO Spacecraft_Type (Model_Name, Variant, Manufacturer, Economy_Pod_Capacity, Business_Pod_Capacity, Platinum_Pod_Capacity, E_Pods_Per_Row, B_Pods_Per_Row, P_Pods_Per_Row, Max_Load, Fuel_Capacity)
VALUES ('Cosmic Explorer', 'XG-2', 'Celestial Systems', 80, 16, 6, 4, 4, 2, 85000, 58000.00);
INSERT INTO Spacecraft_Type (Model_Name, Variant, Manufacturer, Economy_Pod_Capacity, Business_Pod_Capacity, Platinum_Pod_Capacity, E_Pods_Per_Row, B_Pods_Per_Row, P_Pods_Per_Row, Max_Load, Fuel_Capacity)
VALUES ('AstroLux Liner', 'LX-5', 'Starways Consortium', 220, 32, 12, 6, 4, 3, 150000, 98000.00);



-- Inserting spacecraft instance data
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S001', 1, 'In-Orbit', '2023-06-15', '2022-06-15');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S002', 2, 'On-Ground', '2023-03-10', '2020-03-10');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S003', 3, 'In-Orbit', '2023-04-25', '2021-04-25');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S004', 1, 'On-Ground', '2023-02-24', '2020-05-16');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S005', 1, 'In-Orbit', '2023-08-21', '2021-07-22');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S006', 2, 'On-Ground', '2023-05-02', '2021-01-02');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S007', 3, 'In-Orbit', '2023-02-12', '2020-04-09');
INSERT INTO Spacecraft_Instance (Spacecraft_ID, Model_ID, Spacecraft_Status, Maintenance_Date, Purchase_Date)
VALUES ('S008', 1, 'On-Ground', '2023-12-23', '2021-12-31');

-- Inserting intergalactic route data
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G001', 'ALP', 'VEG', INTERVAL '04:30');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G002', 'MIL', 'TRI', INTERVAL '03:55');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G003', 'CEN', 'ORI', INTERVAL '02:45');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G004', 'VEG', 'ALP', INTERVAL '04:15');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G005', 'TRI', 'MIL', INTERVAL '03:45');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G006', 'ORI', 'CEN', INTERVAL '03:20');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G007', 'LEO', 'SCU', INTERVAL '05:10');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G008', 'SCU', 'LEO', INTERVAL '05:20');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G009', 'PIN', 'HYD', INTERVAL '04:50');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G010', 'HYD', 'PIN', INTERVAL '05:00');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G011', 'ALP', 'TRI', INTERVAL '06:20');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G012', 'MIL', 'ORI', INTERVAL '05:40');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G013', 'CEN', 'SCU', INTERVAL '04:30');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G014', 'VEG', 'LEO', INTERVAL '03:55');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G015', 'TRI', 'PIN', INTERVAL '04:25');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G016', 'ORI', 'HYD', INTERVAL '05:10');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G017', 'LEO', 'ALP', INTERVAL '06:40');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G018', 'SCU', 'MIL', INTERVAL '05:50');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G019', 'PIN', 'CEN', INTERVAL '04:15');
INSERT INTO Route(Route_ID, Origin, Destination, Duration)
VALUES ('G020', 'HYD', 'VEG', INTERVAL '03:30');


-- Inserting customer data
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I00002345', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I0048902', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I00016545', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I90005678', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I56789088', 'guest') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I00987897', 'guest') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I50045673', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I10003456', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I00004536', 'registered') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I09345262', 'guest') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I00986543', 'guest') ;
INSERT INTO Customer(Intergalactic_ID, Customer_Type) VALUES('I34509850', 'guest') ;



------------------------REGISTERED CUSTOMER ACCOUNT------------------------


INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraftt, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('$2b$10$CFbLNbM4YvkG071N4AZDWeRUuzF2N/KSLn6Kd00OBrtOmlTlDIubW', 'Zara', 'Vega', 'Female', '1995-08-27', 'zara.vega@email.com', '+1234567890', 'General', 'Starbase Alpha, Deck 5', 'Andromeda', 'Proxima Centauri', 'Stellar Cruiser 01', 'I56789088', 3, '2023-07-15 14:30:00', 'profile_zara.jpg', 4500.00, 150.00);

INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraftt, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('iBX3A8p59DBRB', 'Xander', 'Nova', 'Male', '1987-04-10', 'xander.nova@email.com', '+9876543210', 'Frequent', 'Orbit Outpost 7, Suite 42', 'Milky Way', 'Sol', 'Starship Voyager', 'I00987897', 7, '2023-07-18 09:15:00', 'profile_xander.jpg', 7500.00, 300.00);

INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraftt, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('$2b$10$CFbLNbM4YvkG071N4AZDWeRUuzF2N/KSLn6Kd00OBrtOmlTlDIubW', 'Luna', 'Stellaris', 'Female', '2000-11-03', 'luna.stellaris@email.com', '+5551234567', 'Gold', 'Cosmic Haven, Luna City', 'Andromeda', 'Sirius', 'Stellar Cruiser 05', 'I09345262', 12, '2023-07-20 17:45:00', 'profile_luna.jpg', 12000.00, 500.00);

-- You can continue adding more entries as needed


------------------------GUEST CUSTOMER ACCOUNT------------------------

INSERT INTO Guest_Customer_Account(First_Name, Last_Name, Gender, DOB, Intergalactic_ID, Email, Mobile)
VALUES ('Ram', 'Kumar', 'Male', '1978-05-09', 'I56789088', 'ram_new@gmail.com', '(555) 555-1234');

INSERT INTO Guest_Customer_Account(First_Name, Last_Name, Gender, DOB, Intergalactic_ID, Email, Mobile)
VALUES ('Millie', 'Brown', 'Female', '2000-09-05', 'I00987897', 'mill@yahoo.com', '(456) 675-7854');

INSERT INTO Guest_Customer_Account(First_Name, Last_Name, Gender, DOB, Intergalactic_ID, Email, Mobile)
VALUES ('Olivia', 'Rodrigo', 'Female', '2006-02-12', 'I09345262', 'olive12@yahoo.com', '(324) 234-7778');

INSERT INTO Guest_Customer_Account(First_Name, Last_Name, Gender, DOB, Intergalactic_ID, Email, Mobile)
VALUES ('Jenna', 'Ortega', 'Female', '2005-12-31', 'I00986543', 'jennort@yahoo.com', '(432) 675-5412');

INSERT INTO Guest_Customer_Account(First_Name, Last_Name, Gender, DOB, Intergalactic_ID, Email, Mobile)
VALUES ('Shawn', 'Mendes', 'Male', '1998-11-05', 'I34509850', 'shawn_men@gmail.com', '(543) 342-1235');

------------------------FLIGHT SCHEDULE------------------------
INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F005', 'G012', 'S004', '2022-12-30', '03:45:00', 'Scheduled', 0.00);

INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F006', 'G016', 'S007', '2023-01-05', '04:30:00', 'Departed-On-Time', 100.00);

INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F007', 'G002', 'S008', '2023-01-10', '05:15:00', 'Delayed-Departure', 30.00);

INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F008', 'G007', 'S001', '2023-01-15', '06:00:00', 'Departed-On-Time', 100.00);

-- Add more statements that make sense based on the flight status and percent correlation
INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F009', 'G004', 'S003', '2023-01-20', '07:45:00', 'Landed', 100.00);

INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F010', 'G010', 'S006', '2023-01-25', '08:30:00', 'Cancelled', 0.00);

INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F011', 'G019', 'S002', '2023-02-01', '09:15:00', 'Scheduled', 0.00);

INSERT INTO Flight_Schedule(Journey_ID, Route_ID, Spacecraft_ID, Departure_Date, Departure_Time, Flight_Status, Flight_Percent)
VALUES ('F012', 'G015', 'S005', '2023-02-05', '10:00:00', 'Delayed-Departure', 40.00);


-- ---------------------BOOKING------------------------


-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('C00002345','F002','{"1A"}',2,600.00,0.00,600.00,'Paid','2022-10-27');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('U0048902','F002','{"4A"}',2,500.00,5.00,475.00,'Paid','2022-11-05');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('G56789088','F003','{"12A","13A"}',3,900.00,0.00,900.00,'Paid','2022-11-12');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('B00987897','F002','{"1B"}',2,600.00,0.00,600.00,'Paid','2022-11-02');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('D00004536','F001','{"1A"}',1,600.00,0.00,600.00,'Paid','2022-11-04');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('R10003456','F002','{"2A"}',2,600.00,0.00,600.00,'Paid','2022-11-05');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('A09345262','F032','{"3A"}',2,600.00,0.00,600.00,'Paid','2023-01-25');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('C00986543','F035','{"11A"}',2,600.00,0.00,600.00,'Paid','2023-02-02');
-- INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('D34509850','F037','{"10B"}',2,600.00,0.00,600.00,'Paid','2023-02-03');


-- ---------------------PASSENGER SEAT------------------------


-- INSERT INTO Passenger_Seat VALUES(1, 2, '1A', 600.00, 'Emily Tina','C00002345','1989-12-12');
-- INSERT INTO Passenger_Seat VALUES (2, 2, '4A', 475.00, 'Adam Peter','U0048902','1976-02-18');
-- INSERT INTO Passenger_Seat VALUES (3, 3, '12A', 450.00, 'Ram Kumar','G56789088','1978-05-09');
-- INSERT INTO Passenger_Seat VALUES (4, 2, '1B', 600.00, 'Millie Brown','B00987897','2000-09-05');
-- INSERT INTO Passenger_Seat VALUES (4, 3, '13A', 450.00, 'Ram Kumar', 'G56789088','1978-05-09');
-- INSERT INTO Passenger_Seat VALUES (5, 1, '1A', 600.00, 'Sheldon George', 'D00004536','2006-02-18');
-- INSERT INTO Passenger_Seat VALUES (6, 2, '2A', 600.00, 'Albert Einstein', 'R10003456','2006-10-12');
-- INSERT INTO Passenger_Seat VALUES (7, 2, '2A', 600.00, 'Olivia Rodrigo', 'A09345262','2006-02-12');
-- INSERT INTO Passenger_Seat VALUES (8, 2, '2A', 600.00, 'Jenna Ortega', 'C00986543','2005-12-31');
-- INSERT INTO Passenger_Seat VALUES (9, 2, '2A', 600.00, 'Shawn Mendes', 'D34509850','1998-11-05');

INSERT INTO public.events ("Name", "Description", "Spaceport", "Popularity_Rating") VALUES 
('Galactic Summit', 'A meeting of representatives from various galaxies.', 'ALP', 4.5),
('Interstellar Race', 'A race featuring the fastest spaceships in the universe.', 'MIL', 5.0),
('Celestial Festival', 'A celebration of celestial art and culture.', 'CEN', 3.9),
('Nebula Expo', 'Exhibition of the latest technology in space exploration.', 'ORI', 4.7),
('Warp Drive Summit', 'A conference on the advancements in warp drive technology.', 'TRI', 4.8),
('Galactic Trade Fair', 'A fair showcasing products from various planets and galaxies.', 'VEG', 4.0),
('Intergalactic Music Fest', 'A music festival featuring artists from across the galaxies.', 'LEO', 5.0),
('Spaceport Opening Ceremony', 'Opening ceremony of the new spaceport in Nebulaar.', 'SCU', 3.8),
('Zero-Gravity Sports Tournament', 'A sports tournament held in zero-gravity conditions.', 'PIN', 4.9),
('Aquatic Research Conference', 'A conference dedicated to aquatic life research.', 'HYD', 4.6);

/*

  ___  ___   ___    ___  ___  ___   _   _  ___  ___    ___    _    _     _     ___ 
 | _ \| _ \ / _ \  / __|| __||   \ | | | || _ \| __|  / __|  /_\  | |   | |   / __|
 |  _/|   /| (_) || (__ | _| | |) || |_| ||   /| _|  | (__  / _ \ | |__ | |__ \__ \
 |_|  |_|_\ \___/  \___||___||___/  \___/ |_|_\|___|  \___|/_/ \_\|____||____||___/
                                                                                   

*/


---------------------INSERTING ROUTES-----------------------------

CALL insert_route_price('G001', 800, 500, 145);
CALL insert_route_price('G002', 700, 600, 161);
CALL insert_route_price('G003', 750, 670, 166);
CALL insert_route_price('G004', 610, 510, 147);
CALL insert_route_price('G005', 500, 430, 135);
CALL insert_route_price('G006', 680, 590, 192);
CALL insert_route_price('G007', 610, 510, 144);
CALL insert_route_price('G008', 560, 480, 139);
CALL insert_route_price('G009', 720, 620, 157);
CALL insert_route_price('G010', 550, 460, 143);
CALL insert_route_price('G011', 680, 570, 159);
CALL insert_route_price('G012', 610, 520, 141);
CALL insert_route_price('G013', 720, 650, 167);
CALL insert_route_price('G014', 530, 450, 136);
CALL insert_route_price('G015', 640, 550, 155);
CALL insert_route_price('G016', 570, 480, 149);
CALL insert_route_price('G017', 700, 600, 163);
CALL insert_route_price('G018', 630, 540, 145);
CALL insert_route_price('G019', 780, 680, 172);
CALL insert_route_price('G020', 520, 430, 133);



