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
VALUES ('jzO77wvelMYbRx', 'Zara', 'Vega', 'Female', '1995-08-27', 'zara.vega@email.com', '+1234567890', 'General', 'Starbase Alpha, Deck 5', 'Andromeda', 'Proxima Centauri', 'Stellar Cruiser 01', 'I56789088', 3, '2023-07-15 14:30:00', 'profile_zara.jpg', 4500.00, 150.00);

INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraftt, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('iBX3A8p59DBRB', 'Xander', 'Nova', 'Male', '1987-04-10', 'xander.nova@email.com', '+9876543210', 'Frequent', 'Orbit Outpost 7, Suite 42', 'Milky Way', 'Sol', 'Starship Voyager', 'I00987897', 7, '2023-07-18 09:15:00', 'profile_xander.jpg', 7500.00, 300.00);

INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraftt, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('TkVB6JAM684S', 'Luna', 'Stellaris', 'Female', '2000-11-03', 'luna.stellaris@email.com', '+5551234567', 'Gold', 'Cosmic Haven, Luna City', 'Andromeda', 'Sirius', 'Stellar Cruiser 05', 'I09345262', 12, '2023-07-20 17:45:00', 'profile_luna.jpg', 12000.00, 500.00);

-- You can continue adding more entries as needed


------------------------GUEST CUSTOMER ACCOUNT------------------------


INSERT INTO Guest_Customer_Account( First_Name, Last_Name, Gender, DOB, Passport_no, Email, Mobile) VALUES ('Ram', 'Kumar', 'Male', '1978-05-09', 'G56789088', 'ram_new@gmail.com', '(555) 555-1234');
INSERT INTO Guest_Customer_Account( First_Name, Last_Name, Gender, DOB, Passport_no, Email, Mobile) VALUES ('Millie', 'Brown', 'Female', '2000-09-05','B00987897', 'mill@yahoo.com', '(456) 675-7854');
INSERT INTO Guest_Customer_Account( First_Name, Last_Name, Gender, DOB, Passport_no, Email, Mobile) VALUES ('Olivia', 'Rodrigo', 'Female', '2006-02-12','A09345262', 'olive12@yahoo.com', '(324) 234-7778');
INSERT INTO Guest_Customer_Account( First_Name, Last_Name, Gender, DOB, Passport_no, Email, Mobile) VALUES ('Jenna', 'Ortega', 'Female', '2005-12-31','C00986543', 'jennort@yahoo.com', '(432) 675-5412');
INSERT INTO Guest_Customer_Account( First_Name, Last_Name, Gender, DOB, Passport_no, Email, Mobile) VALUES ('Shawn', 'Mendes', 'Male', '1998-11-05','D34509850', 'shawn_men@gmail.com', '(543) 342-1235');





------------------------STAFF------------------------


INSERT INTO Staff(Category,Password,First_Name,Last_Name,Contact,Email,DOB,Gender,Assigned_Airport,Country) values ('Admin','$2b$10$wmlK/FgCEsoX8m3cf.z/ruRIVXFZh8wo6TjqRvlaV9RJkUJ0lkgYG','Joseph','Andrew','(456) 675-7854','andrew@bairways.com','1968-6-17','Male','CGK','USA');
INSERT INTO Staff(Category,Password,First_Name,Last_Name,Contact,Email,DOB,Gender,Assigned_Airport,Country) values ('Manager','OxtfsvI1TCSOtc1','Kumar','Swami','(852) 675-7854','swami@bairways.com','1972-1-27','Male','CGK','India');
INSERT INTO Staff(Category,Password,First_Name,Last_Name,Contact,Email,DOB,Gender,Assigned_Airport,Country) values ('General','J42YgQyfMmlgQlH','Gavin','Anotio','(123) 675-7854','antonio@bairways.com','1980-7-29','Male','DMK','Thailand');
INSERT INTO Staff(Category,Password,First_Name,Last_Name,Contact,Email,DOB,Gender,Assigned_Airport,Country) values ('Pilot','kWyofTsJpWmkFHx','Thomas','Seamus','(65) 675-7854','seamus@bairways.com','1959-8-3','Male','SIN','Singapore');


------------------------FLIGHT SCHEDULE------------------------

 
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F001','B021','A001','2022-11-15','00:00:00','Landed');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F002','B004','A002','2022-11-27','01:30:00','Landed');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F003','B009','A003','2022-12-20','02:20:00','Landed');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F004','B014','A006','2022-12-25','02:15:00','Landed');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F005','B021','A005','2022-12-27','01:00:00','Cancelled');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F006','B004','A004','2022-12-30','01:45:00','Landed');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F007','B009','A007','2022-01-06','20:20:00','Cancelled');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time,Flight_Status) VALUES ('F008','B014','A008','2022-01-07','03:15:00','Landed');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F009','B035','A002','2023-01-11','19:00:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F010','B039','A001','2023-01-11','21:10:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F011','B014','A003','2023-01-12','15:30:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F012','B034','A004','2023-01-12','16:15:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F013','B038','A006','2023-01-12','18:50:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F014','B039','A005','2023-01-13','10:55:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F015','B011','A007','2023-01-13','12:10:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F016','B034','A008','2023-01-13','13:05:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F017','B033','A003','2023-01-13','15:20:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F018','B004','A002','2023-01-14','17:25:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F019','B021','A001','2023-01-14','18:30:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F020','B039','A005','2023-01-15','19:45:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F021','B014','A006','2023-01-15','23:00:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F022','B009','A007','2023-01-15','23:10:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F023','B027','A004','2023-01-15','23:15:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F024','B043','A001','2023-01-16','07:20:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F025','B021','A005','2023-01-16','08:35:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F026','B019','A003','2023-01-20','15:50:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F027','B011','A007','2023-01-21','11:10:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F028','B027','A008','2023-01-22','02:15:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F029','B038','A002','2023-02-23','03:00:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F030','B038','A006','2023-01-25','19:40:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F031','B034','A008','2023-01-25','21:45:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F032','B009','A007','2023-01-25','22:00:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F033','B021','A005','2023-01-26','04:05:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F034','B034','A004','2023-01-31','17:40:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F035','B001','A003','2023-02-02','00:15:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F036','B011','A002','2023-02-03','01:10:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F037','B062','A001','2023-02-03','11:05:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F038','B009','A002','2023-02-10','17:30:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F039','B039','A005','2023-02-11','05:00:00');
INSERT into flight_schedule(Flight_ID,Route_ID,Aircraft_ID,Departure_Date,Departure_Time) VALUES ('F040','B014','A006','2023-02-13','06:10:00');


---------------------BOOKING------------------------


INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('C00002345','F002','{"1A"}',2,600.00,0.00,600.00,'Paid','2022-10-27');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('U0048902','F002','{"4A"}',2,500.00,5.00,475.00,'Paid','2022-11-05');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('G56789088','F003','{"12A","13A"}',3,900.00,0.00,900.00,'Paid','2022-11-12');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('B00987897','F002','{"1B"}',2,600.00,0.00,600.00,'Paid','2022-11-02');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('D00004536','F001','{"1A"}',1,600.00,0.00,600.00,'Paid','2022-11-04');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('R10003456','F002','{"2A"}',2,600.00,0.00,600.00,'Paid','2022-11-05');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('A09345262','F032','{"3A"}',2,600.00,0.00,600.00,'Paid','2023-01-25');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('C00986543','F035','{"11A"}',2,600.00,0.00,600.00,'Paid','2023-02-02');
INSERT into booking (Passport_no,Flight_ID ,Seat_IDs,Model_ID,Seat_Price,Discount ,Final_Price,Booking_Status,Booking_Date) values ('D34509850','F037','{"10B"}',2,600.00,0.00,600.00,'Paid','2023-02-03');


---------------------PASSENGER SEAT------------------------


INSERT INTO Passenger_Seat VALUES(1, 2, '1A', 600.00, 'Emily Tina','C00002345','1989-12-12');
INSERT INTO Passenger_Seat VALUES (2, 2, '4A', 475.00, 'Adam Peter','U0048902','1976-02-18');
INSERT INTO Passenger_Seat VALUES (3, 3, '12A', 450.00, 'Ram Kumar','G56789088','1978-05-09');
INSERT INTO Passenger_Seat VALUES (4, 2, '1B', 600.00, 'Millie Brown','B00987897','2000-09-05');
INSERT INTO Passenger_Seat VALUES (4, 3, '13A', 450.00, 'Ram Kumar', 'G56789088','1978-05-09');
INSERT INTO Passenger_Seat VALUES (5, 1, '1A', 600.00, 'Sheldon George', 'D00004536','2006-02-18');
INSERT INTO Passenger_Seat VALUES (6, 2, '2A', 600.00, 'Albert Einstein', 'R10003456','2006-10-12');
INSERT INTO Passenger_Seat VALUES (7, 2, '2A', 600.00, 'Olivia Rodrigo', 'A09345262','2006-02-12');
INSERT INTO Passenger_Seat VALUES (8, 2, '2A', 600.00, 'Jenna Ortega', 'C00986543','2005-12-31');
INSERT INTO Passenger_Seat VALUES (9, 2, '2A', 600.00, 'Shawn Mendes', 'D34509850','1998-11-05');


/*

  ___  ___   ___    ___  ___  ___   _   _  ___  ___    ___    _    _     _     ___ 
 | _ \| _ \ / _ \  / __|| __||   \ | | | || _ \| __|  / __|  /_\  | |   | |   / __|
 |  _/|   /| (_) || (__ | _| | |) || |_| ||   /| _|  | (__  / _ \ | |__ | |__ \__ \
 |_|  |_|_\ \___/  \___||___||___/  \___/ |_|_\|___|  \___|/_/ \_\|____||____||___/
                                                                                   

*/


---------------------INSERTING ROUTES-----------------------------


CALL insert_route_price('B001',800,500,145);
CALL insert_route_price('B002',700,600,161);
CALL insert_route_price('B003',750,670,166);
CALL insert_route_price('B004',610,510,147);
CALL insert_route_price('B005',500,430,135);
CALL insert_route_price('B006',680,590,192);
CALL insert_route_price('B007',610,510,144);
CALL insert_route_price('B008',548,400,116);
CALL insert_route_price('B009',500,350,105);
CALL insert_route_price('B010',450,330,97);
CALL insert_route_price('B011',400,300,90);
CALL insert_route_price('B012',350,245,63);
CALL insert_route_price('B013',330,220,57);
CALL insert_route_price('B014',840,670,203);
CALL insert_route_price('B015',780,625,195);
CALL insert_route_price('B016',680,500,165);
CALL insert_route_price('B017',310,200,49);
CALL insert_route_price('B018',500,350,92);
CALL insert_route_price('B019',580,450,153);
CALL insert_route_price('B020',980,720,297);
CALL insert_route_price('B021',1100,800,330);
CALL insert_route_price('B022',600,430,134);
CALL insert_route_price('B023',510,310,103);
CALL insert_route_price('B024',520,315,106);
CALL insert_route_price('B025',280,170,30);
CALL insert_route_price('B026',580,360,166);
CALL insert_route_price('B027',820,580,236);
CALL insert_route_price('B028',1100,810,330);
CALL insert_route_price('B029',1050,790,320);
CALL insert_route_price('B030',650,480,149);
CALL insert_route_price('B031',650,480,149);
CALL insert_route_price('B032',410,230,59);
CALL insert_route_price('B033',1050,820,318);
CALL insert_route_price('B034',780,520,210);
CALL insert_route_price('B035',620,410,180);
CALL insert_route_price('B036',420,280,87);
CALL insert_route_price('B037',430,290,90);
CALL insert_route_price('B038',512,370,128);
CALL insert_route_price('B039',730,520,200);
CALL insert_route_price('B040',880,620,300);
CALL insert_route_price('B041',730,520,200);
CALL insert_route_price('B042',480,300,85);
CALL insert_route_price('B043',500,310,90);
CALL insert_route_price('B044',680,420,150);
CALL insert_route_price('B045',580,320,121);
CALL insert_route_price('B046',590,350,140);
CALL insert_route_price('B047',480,280,110);
CALL insert_route_price('B048',480,320,80);
CALL insert_route_price('B049',470,310,130);
CALL insert_route_price('B050',480,320,80);
CALL insert_route_price('B051',580,300,116);
CALL insert_route_price('B052',520,340,148);
CALL insert_route_price('B053',510,320,144);
CALL insert_route_price('B054',650,420,238);
CALL insert_route_price('B055',420,290,105);
CALL insert_route_price('B056',610,310,86);
CALL insert_route_price('B057',380,200,46);
CALL insert_route_price('B058',430,280,100);
CALL insert_route_price('B059',620,470,226);
CALL insert_route_price('B060',530,340,144);
CALL insert_route_price('B061',640,470,180);
CALL insert_route_price('B062',660,490,200);
CALL insert_route_price('B063',560,430,170);
CALL insert_route_price('B064',390,220,83);




