
/*
  _______         ____   _       ______   _____ 
 |__   __| /\    |  _ \ | |     |  ____| / ____|
    | |   /  \   | |_) || |     | |__   | (___  
    | |  / /\ \  |  _ < | |     |  __|   \___ \ 
    | | / ____ \ | |_) || |____ | |____  ____) |
    |_|/_/    \_\|____/ |______||______||_____/ 
                                                
*/

----------------------TABLES-------------------------------


CREATE TABLE Spaceport (
  Code varchar(10),
  Galaxy varchar(40) NOT NULL,
  Solar_System varchar(40) NOT NULL,
  Spacecraftt varchar(40) NOT NULL,
  PRIMARY KEY (Code)
);


CREATE TABLE User_Category (
  User_Type registered_customer_category NOT NULL,
  Minimum_Bookings varchar(10)NOT NULL,
  Discount numeric(4,2)NOT NULL,
  PRIMARY KEY (User_Type)
);


CREATE TABLE Customer (
  Intergalactic_ID varchar(9) ,
  Customer_Type customer_category_Enum NOT NULL ,
  PRIMARY KEY (Intergalactic_ID)
);

CREATE TABLE Registered_Customer_Account (
  Password varchar(100) NOT NULL,
  First_Name varchar(25) NOT NULL,
  Last_Name varchar(25) NOT NULL,
  Gender gender_type_Enum NOT NULL,
  DOB DATE NOT NULL,
  Email varchar(50) NOT NULL UNIQUE,
  Mobile varchar(15)NOT NULL,
  User_Type registered_customer_category NOT NULL DEFAULT 'General',
  Address varchar(80)NOT NULL,
  Galaxy varchar(50)NOT NULL,
  Solar_System varchar(50)NOT NULL,
  Spacecraftt varchar(50)NOT NULL,
  Intergalactic_ID varchar(9)NOT NULL,
  No_Of_Journeys int NOT NULL,
  Joined TIMESTAMP NOT NULL,
  display_photo varchar(100),
  PRIMARY KEY (Intergalactic_ID),
  FOREIGN KEY (Intergalactic_ID) REFERENCES customer (Intergalactic_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(User_Type) REFERENCES User_Category(User_Type) ON DELETE CASCADE ON UPDATE CASCADE
  	
);

CREATE TABLE Guest_Customer_Account (
  First_Name varchar(25) NOT NULL,
  Last_Name varchar(25) NOT NULL,
  Gender gender_type_Enum NOT NULL,
  DOB DATE NOT NULL,
  Intergalactic_ID varchar(9) ,
  Email varchar(50) NOT NULL,
  Mobile varchar(15) NOT NULL,
  PRIMARY KEY (Intergalactic_ID)
);

CREATE TABLE Traveller_Class (
  Class_ID SERIAL,
  class_name class_type_Enum NOT NULL UNIQUE,
  PRIMARY KEY (Class_ID)
);

CREATE TABLE Spacecraft_Type (
  Model_ID SERIAL,
  Model_Name varchar(30) NOT NULL,
  Variant varchar(15) NOT NULL,
  Manufacturer varchar(20) NOT NULL,
  Economy_Pod_Capacity int NOT NULL,
  Business_Pod_Capacity int NOT NULL,
  Platinum_Pod_Capacity int NOT NULL,
  E_Pods_Per_Row int NOT NULL,
  B_Pods_Per_Row int NOT NULL,
  P_Pods_Per_Row int NOT NULL,
  Max_Load numeric(12,2) NOT NULL,
  Fuel_Capacity numeric(12,2) NOT NULL,
  PRIMARY KEY (Model_ID)
);


CREATE TABLE Spacecraft_Instance (
  Spacecraft_ID VARCHAR(10),
  Model_ID int NOT NULL,
  Spacecraft_Status Spacecraft_status_enum NOT NULL,
  Maintenance_Date Date NOT NULL,
  Purchase_Date Date NOT NULL,
  PRIMARY KEY (Spacecraft_ID),
  FOREIGN KEY (Model_ID) REFERENCES Spacecraft_Type(Model_ID)ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Spacecraft_Pod (
  Model_ID int NOT NULL ,
  Pod_ID varchar(10) NOT NULL,
  Traveler_Class_ID int NOT NULL,
  PRIMARY KEY (Model_ID, Pod_ID),
  FOREIGN KEY (Traveler_Class_ID) REFERENCES Traveller_Class(Class_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Model_ID) REFERENCES Spacecraft_Type(Model_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Route (
  Route_ID VARCHAR(4),
  Origin varchar(10) NOT NULL,
  Destination varchar(10) NOT NULL,
  Duration interval NOT NULL,
  PRIMARY KEY (Route_ID),
  FOREIGN KEY (Destination) REFERENCES Spaceport(Code) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Origin) REFERENCES Spaceport(Code) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Flight_Schedule (
  Journey_ID VARCHAR(5),
  Route_ID VARCHAR(4) NOT NULL,
  Spacecraft_ID VARCHAR(10) NOT NULL,
  Arrival_Date Date generated always as (get_arrival(route_id,get_timestamp(departure_date,departure_time))::DATE) stored NOT NULL,
  Arrival_Time TIME generated always as (get_arrival(route_id,get_timestamp(departure_date,departure_time))::TIME) stored NOT NULL,
  Departure_Date Date NOT NULL,
  Departure_Time TIME NOT NULL,
  Flight_Status Flight_Status_Enum NOT NULL DEFAULT 'Scheduled',
  Flight_Percent numeric(10,2) NOT NULL,
  PRIMARY KEY (Journey_ID),
  FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(Spacecraft_ID) REFERENCES Spacecraft_Instance(Spacecraft_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Pod_Price (
  Route_ID VARCHAR(4) ,
  Class_ID INT ,
  Price numeric(10,2) NOT NULL,
  PRIMARY KEY (Route_ID, Class_ID),
  FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY(Class_ID) REFERENCES Traveller_Class(Class_ID) ON DELETE CASCADE ON UPDATE CASCADE

);

CREATE TABLE Booking  (
  Booking_ID SERIAL,
  Intergalactic_ID varchar(9) NOT NULL,
  Journey_ID VARCHAR(5) ,
  Pod_IDs VARCHAR[] ,
  Model_ID int,
  Pod_Price numeric(10,2) NOT NULL,
  Discount numeric(4,2),
  Final_Price numeric(10,2) NOT NULL,
  Booking_Status Booking_Status_Enum NOT NULL,
  Booking_Date DATE NOT NULL DEFAULT NOW()::DATE,
  PRIMARY KEY (Booking_ID) ,
  FOREIGN KEY (Intergalactic_ID) REFERENCES Customer(Intergalactic_ID)ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Journey_ID) REFERENCES Flight_Schedule(Journey_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Passenger_Pod(
    Booking_ID int,
    Model_ID int,
    Pod_ID varchar(10),
    Price numeric(10, 2), 
    name varchar(100) NOT NULL,
    Intergalactic_ID varchar(20) NOT NULL,
    dob date NOT NULL,
    PRIMARY KEY (Booking_ID, Model_ID, Pod_ID),
    FOREIGN KEY(Booking_ID) REFERENCES Booking(Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Model_ID, Pod_ID) REFERENCES Spacecraft_Pod(Model_ID, Pod_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
