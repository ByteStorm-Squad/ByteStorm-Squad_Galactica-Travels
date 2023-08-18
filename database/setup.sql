\c postgres
DROP DATABASE IF EXISTS spaceline_res;
CREATE DATABASE spaceline_res;
\c spaceline_res

DROP TRIGGER IF EXISTS insert_Pods_for_new_model ON Spacecraft_Type;
DROP TRIGGER IF EXISTS update_customer_bookings  ON Booking;
DROP TRIGGER IF EXISTS update_customer_category ON registered_customer_account;


DROP PROCEDURE IF EXISTS insert_Pods;

DROP TABLE IF EXISTS User_Category CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Registered_Customer_Account CASCADE;
DROP TABLE IF EXISTS Traveller_Class CASCADE;
DROP TABLE IF EXISTS Spaceport CASCADE;
DROP TABLE IF EXISTS Spacecraft_Type CASCADE;
DROP TABLE IF EXISTS Spacecraft_Pod CASCADE;
DROP TABLE IF EXISTS Spacecraft_Instance CASCADE;
DROP TABLE IF EXISTS Route CASCADE;
DROP TABLE IF EXISTS Flight_Schedule CASCADE;
DROP TABLE IF EXISTS Pod_Price CASCADE;
DROP TABLE IF EXISTS Booking CASCADE;

DROP TABLE IF EXISTS Account CASCADE;
DROP TABLE IF EXISTS session CASCADE;
DROP TABLE IF EXISTS Guest_Customer_Account CASCADE;
DROP TABLE IF EXISTS Passenger_Pod CASCADE;


DROP TYPE IF EXISTS  Booking_Status_Enum;
DROP TYPE IF EXISTS  Flight_Status_Enum;
DROP TYPE IF EXISTS  Spacecraft_status_Enum;
DROP TYPE IF EXISTS  gender_type_Enum;
DROP TYPE IF EXISTS  customer_category_Enum;
DROP TYPE IF EXISTS  registered_customer_category;
DROP TYPE IF EXISTS class_type_Enum;


DROP FUNCTION IF EXISTS insertBooking;
DROP FUNCTION IF EXISTS get_Pod_Price;


DROP DOMAIN IF EXISTS UUID4 CASCADE;

SET TIME ZONE 'Etc/UTC';


/*
  ______  _   _  _    _  __  __   _____ 
 |  ____|| \ | || |  | ||  \/  | / ____|
 | |__   |  \| || |  | || \  / || (___  
 |  __|  | . ` || |  | || |\/| | \___ \ 
 | |____ | |\  || |__| || |  | | ____) |
 |______||_| \_| \____/ |_|  |_||_____/
*/
----------ENUM----------------------------


CREATE TYPE Flight_Status_Enum AS ENUM(
'Scheduled',
'Departed-On-Time',
'Delayed-Departure',
'Landed',
'Cancelled'
);

 CREATE TYPE Spacecraft_status_Enum AS ENUM( 
 'On-Ground',
 'In-Air');  

CREATE TYPE Booking_Status_Enum AS ENUM(
'Not paid',
'Paid'); 

CREATE TYPE gender_type_Enum AS ENUM(
'Male',
'Female',
'Other'); 

CREATE TYPE customer_category_Enum AS ENUM(
'guest',
'registered'
);

CREATE TYPE registered_customer_category AS ENUM(
'General',
'Frequent',
'Gold'
);

CREATE TYPE class_type_Enum AS ENUM(
'Economy',
'Business',
'Platinum'); 






/*_____    ____   __  __            _____  _   _   _____ 
 |  __ \  / __ \ |  \/  |    /\    |_   _|| \ | | / ____|
 | |  | || |  | || \  / |   /  \     | |  |  \| || (___  
 | |  | || |  | || |\/| |  / /\ \    | |  | . ` | \___ \ 
 | |__| || |__| || |  | | / ____ \  _| |_ | |\  | ____) |
 |_____/  \____/ |_|  |_|/_/    \_\|_____||_| \_||_____/ 
                                                          */
---------------------------DOMAINS---------------------------


CREATE DOMAIN UUID4 AS char(36)
CHECK (VALUE ~ '[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}');



/*______  _    _  _   _   _____  _______  _____  ____   _   _   _____ 
 |  ____|| |  | || \ | | / ____||__   __||_   _|/ __ \ | \ | | / ____|
 | |__   | |  | ||  \| || |        | |     | | | |  | ||  \| || (___  
 |  __|  | |  | || . ` || |        | |     | | | |  | || . ` | \___ \ 
 | |     | |__| || |\  || |____    | |    _| |_| |__| || |\  | ____) |
 |_|      \____/ |_| \_| \_____|   |_|   |_____|\____/ |_| \_||_____/ 
                                                                      */
---------------------------FUNCTIONS----------------------------------


--https://stackoverflow.com/questions/12505158/generating-a-uuid-in-postgres-for-insert-statement
CREATE OR REPLACE FUNCTION generate_uuid4 ()
    RETURNS char( 36
)
AS $$
DECLARE
    var_uuid char(36);
BEGIN
    SELECT
        uuid_in(overlay(overlay(md5(random()::text || ':' || clock_timestamp()::text)
            PLACING '4' FROM 13)
        PLACING to_hex(floor(random() * (11 - 8 + 1) + 8)::int)::text FROM 17)::cstring) INTO var_uuid;
    RETURN var_uuid;
END
$$
LANGUAGE PLpgSQL;


------------------------function to calculate age--------------------------------------

CREATE OR REPLACE FUNCTION get_age( dob date )
RETURNS int
AS $CODE$
BEGIN
    RETURN date_part('year', age(dob))::int;
END
$CODE$
LANGUAGE plpgsql IMMUTABLE;



--------------------------inserting Pods to Pod table----------------------------------

CREATE OR REPLACE FUNCTION insert_Pods_func() RETURNS TRIGGER AS $$
DECLARE
    temp_Model_ID int;
    current_Pod int;
    row_num int;
    col char;
    platinum int;
    business int;
    economy int;
    economy_row int;
    business_row int;
    platinum_row int;
    cols char[] DEFAULT array['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
    columns_economy char[];
    columns_business char[];
    columns_platinum char[];
BEGIN
    temp_model_id = new.Model_ID;
    SELECT Economy_Pod_Capacity, Business_Pod_Capacity, Platinum_Pod_Capacity, E_Pods_per_row, B_Pods_per_row, P_Pods_per_row INTO economy, business, platinum, economy_row, business_row, platinum_row
    FROM Spacecraft_Type WHERE Model_ID=temp_model_id;

    columns_platinum = cols[: platinum_row];

    current_Pod = 1;
    row_num = 1;
    while current_Pod <= platinum loop
            foreach col in array columns_platinum loop
                    INSERT INTO Spacecraft_Pod VALUES(temp_model_id, CONCAT(row_num, col), 1);
                    current_Pod = current_Pod + 1;
                end loop;
            row_num = row_num + 1;
        end loop;

    columns_business = cols[: business_row];
    current_Pod = 1;

    while current_Pod <= business loop
            foreach col in array columns_business loop
                    INSERT INTO Spacecraft_Pod VALUES(temp_model_id, CONCAT(row_num, col), 2);
                    current_Pod = current_Pod + 1;
                end loop;
            row_num = row_num + 1;
        end loop;
    columns_economy = cols[: economy_row];
    current_Pod = 1;

    while current_Pod <= economy loop
            foreach col in array columns_economy loop
                    INSERT INTO Spacecraft_Pod VALUES(temp_model_id, CONCAT(row_num, col), 3);
                    current_Pod = current_Pod + 1;
                end loop;
            row_num = row_num + 1;
        end loop;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-------------------------Function to get a time stamp from date and time-------------------------------------

CREATE OR REPLACE FUNCTION get_timestamp(val_date DATE, val_time TIME)
RETURNS timestamp
AS $CODE$
DECLARE
val_datetime timestamp;
BEGIN
  val_datetime := (val_date||' '||val_time)::timestamp ;
  RETURN val_datetime;
END
$CODE$
LANGUAGE plpgsql IMMUTABLE;


-------------------------Function to calculate arrival time for a flight------------------------------------

CREATE OR REPLACE FUNCTION get_arrival(val_route_id VARCHAR(4), val_departure_datetime timestamp)
RETURNS timestamp
AS $CODE$
DECLARE
  val_duration interval;
  val_arrival_datetime timestamp;
BEGIN
  SELECT Duration INTO val_duration FROM route WHERE Route_ID=val_route_id;
  val_arrival_datetime = val_departure_datetime + val_duration;
  RETURN val_arrival_datetime;
END
$CODE$
LANGUAGE plpgsql IMMUTABLE;

--------------------------Function to get the Price of a Pod---------------------------------------------

CREATE OR REPLACE FUNCTION get_Pod_Price(val_Journey_ID varchar(4), val_Pod_id text)
RETURNS numeric
AS $CODE$
DECLARE
    val_route_id VARCHAR(4);
    val_model_id int;
    val_Spacecraft_id VARCHAR(4);
    val_traveler_Class_ID int;
    val_Price numeric;
BEGIN
    SELECT Route_ID, Spacecraft_ID INTO val_route_id, val_Spacecraft_id FROM Flight_Schedule WHERE Journey_ID = val_Journey_ID;
    SELECT Model_ID INTO val_model_id FROM Spacecraft_instance WHERE Spacecraft_ID = val_Spacecraft_id;
    SELECT Spacecraft_Pod.traveler_Class_ID INTO val_traveler_Class_ID FROM Spacecraft_Pod WHERE Model_ID = val_model_id AND Pod_ID = val_Pod_id;
    SELECT Price into val_Price FROM Pod_Price WHERE Route_ID = val_route_id AND Class_ID = val_traveler_Class_ID;
    RETURN val_Price;
END
$CODE$
LANGUAGE plpgsql IMMUTABLE;

----------------------Function to check for Pod overlaps---------------------------------------------------

CREATE OR REPLACE FUNCTION check_Pod_overlaps(val_Journey_ID varchar(4), PodNo varchar(10)[])
RETURNS bool
LANGUAGE plpgsql
AS $$
DECLARE
	bookingIDs int[];
	bookedPods varchar(10)[];
	bookingID int;
BEGIN
	bookingIDs := ARRAY (SELECT Booking_ID FROM Booking WHERE Journey_ID=val_Journey_ID);

	FOREACH bookingID in ARRAY bookingIDs
	LOOP
		bookedPods := bookedPods || ARRAY (SELECT Pod_ID FROM passenger_Pod WHERE Booking_ID = bookingID);
	END LOOP;

	IF (PodNo && bookedPods) THEN
		RETURN true;
	ELSE
	    RETURN false;
	END IF;
END;
$$;

-------------------------Function to create a booking ---------------------------------------------

CREATE OR REPLACE FUNCTION insertBooking(
  	val_Intergalactic_ID varchar(10),
    val_Journey_ID varchar(4),
    passName text[],
    passPassport text[],
    passDob date[],
    PodNo varchar(10)[],
    val_First_Name VARCHAR(25),
  	val_Last_Name VARCHAR(25),
  	val_gender gender_type_enum,
    val_dob DATE,
  	val_email VARCHAR(50),
  	val_mobile VARCHAR(15),
    val_type VARCHAR(20)
)
RETURNS int
LANGUAGE plpgsql
AS $$
DECLARE
    pass_count int := array_length(PodNo, 1);
    i int = 1;
    j int = 1;
    tot_Price numeric(10,2) = 0;
    Pod_Price numeric(10,2)[];
    temp_Price numeric(10,2);
    val_booking_id int;
    val_model_id int;
    Final_Price numeric(10,2);
    val_discount_percentage numeric(10,2);
    cust_type customer_category_Enum;
    var_x varchar(10) := (SELECT customer_type FROM Customer WHERE Intergalactic_ID = val_Intergalactic_ID);
BEGIN

    IF (check_Pod_overlaps(val_Journey_ID, PodNo) = true) THEN
        RAISE EXCEPTION 'The selected Pod has been taken. Please select a different Pod';
    END IF;
	
    SELECT customer_type INTO cust_type FROM Customer WHERE Intergalactic_ID = val_Intergalactic_ID;
    
    

    IF (val_type = 'guest' AND var_x is null) THEN
	INSERT INTO customer values (val_Intergalactic_ID,'guest');
        INSERT INTO guest_customer_account(First_Name,Last_name,Gender,DOB,Intergalactic_ID,Email,Mobile)
        values (val_First_Name, val_Last_Name, val_gender, val_dob, val_Intergalactic_ID, val_email, val_mobile);
    END IF;

    WHILE i < pass_count+1 LOOP
            temp_Price = get_Pod_Price(val_Journey_ID, PodNo[i]);
            tot_Price = tot_Price + temp_Price;
            Pod_Price = array_append(Pod_Price, temp_Price);
            i = i + 1;
    END LOOP;

    Final_Price = tot_Price;

    IF (val_type = 'registered') THEN
        SELECT Discount INTO val_discount_percentage FROM registered_customer_account JOIN User_Category ON registered_customer_account.user_type = User_Category.user_type WHERE Intergalactic_ID = val_Intergalactic_ID;
        Final_Price = tot_Price * (1 - val_discount_percentage/100);
    END IF;

    

    SELECT Model_ID INTO val_model_id FROM Spacecraft_Instance NATURAL JOIN Flight_Schedule WHERE Flight_Schedule.Journey_ID=val_Journey_ID;

    INSERT INTO Booking(Intergalactic_ID, Journey_ID, model_id, Pod_ids,Pod_Price,Discount ,Final_Price, Booking_Status) VALUES(val_Intergalactic_ID, val_Journey_ID, val_model_id, PodNo,tot_Price,val_discount_percentage,Final_Price, 'Not paid') RETURNING Booking_ID INTO val_booking_id;


    WHILE j < pass_count+1 LOOP
            INSERT INTO Passenger_Pod VALUES(val_booking_id, val_model_id, PodNo[j], Pod_Price[j], passName[j], passPassport[j], passDob[j]);
            j = j + 1;
    END LOOP;
    RETURN val_booking_id;
END;
$$;


-----------------------FUNCTION TO INCREMENT BOOKINGS WITH TRIGGER--------------------------------

CREATE OR REPLACE FUNCTION increment_customer_bookings() RETURNS TRIGGER AS $$
DECLARE
   cust_type customer_category_Enum;
BEGIN
    IF (NEW.Booking_Status = 'Paid') THEN
        SELECT customer_type INTO cust_type FROM Customer WHERE Intergalactic_ID = NEW.Intergalactic_ID;
           IF (cust_type = 'registered') THEN
               UPDATE Registered_Customer_Account SET No_Of_Journeys = No_Of_Journeys + 1 WHERE Intergalactic_ID = NEW.Intergalactic_ID;
           END IF;
    END IF;
    RETURN NULL; -- result is ignored since this is an AFTER trigger
END;
$$ LANGUAGE plpgsql;


---------------------------FUNCTION TO INCREMENT BOOKINGS WITH TRIGGER-----------------------------------

CREATE OR REPLACE FUNCTION change_customer_category() RETURNS TRIGGER AS $$
DECLARE
   frequent_min INT;
   gold_min INT;
BEGIN

    SELECT minimum_bookings INTO frequent_min FROM user_category WHERE user_type='Frequent';
    SELECT minimum_bookings INTO gold_min FROM user_category WHERE user_type='Gold';

    IF (NEW.No_Of_Journeys >= gold_min) THEN
        UPDATE registered_customer_account SET user_type = 'Gold' WHERE Intergalactic_ID = NEW.Intergalactic_ID;
        RETURN NULL;
    ELSIF (NEW.No_Of_Journeys >= frequent_min) THEN
        UPDATE registered_customer_account SET user_type = 'Frequent' WHERE Intergalactic_ID = NEW.Intergalactic_ID;
        RETURN NULL;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;



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
  Planet varchar(40) NOT NULL,
  Description TEXT,
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
  Total_Payments numeric(10,2),
  Total_Refunds numeric(10,2),
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

CREATE TABLE Cultures (
  "Code" SERIAL,
  "Name" varchar(50),
  "Description" TEXT,
  "Spaceport" varchar(10),
  "Popularity_Rating" numeric(10,2),
  PRIMARY KEY ("Code"),
  FOREIGN KEY ("Spaceport") REFERENCES "Spaceport"("Code")
);

CREATE TABLE Attractions (
  "Code" SERIAL,
  "Name" varchar(50),
  "Description" TEXT,
  "Spaceport" varchar(10),
  "Popularity_Rating" numeric(10,2),
  PRIMARY KEY ("Code"),
  FOREIGN KEY ("Spaceport") REFERENCES "Spaceport"("Code")
);

CREATE TABLE Events (
  "Code" SERIAL,
  "Name" varchar(50),
  "Description" TEXT,
  "Spaceport" varchar(10),
  "Popularity_Rating" numeric(10,2),
  PRIMARY KEY ("Code"),
  FOREIGN KEY ("Spaceport") REFERENCES "Spaceport"("Code")
);

-------------------------SESSION TABLE-------------------------------------

CREATE TABLE "session" (
  "sid" varchar NOT NULL COLLATE "default",
  "sess" json NOT NULL,
  "expire" timestamp(6) NOT NULL
)
WITH (OIDS=FALSE);

ALTER TABLE "session" ADD CONSTRAINT "session_pkey" PRIMARY KEY ("sid") NOT DEFERRABLE INITIALLY IMMEDIATE;

CREATE INDEX "IDX_session_expire" ON "session" ("expire");



/*_______  _____   _____  _____   _____  ______  _____    _____ 
 |__   __||  __ \ |_   _|/ ____| / ____||  ____||  __ \  / ____|
    | |   | |__) |  | | | |  __ | |  __ | |__   | |__) || (___  
    | |   |  _  /   | | | | |_ || | |_ ||  __|  |  _  /  \___ \ 
    | |   | | \ \  _| |_| |__| || |__| || |____ | | \ \  ____) |
    |_|   |_|  \_\|_____|\_____| \_____||______||_|  \_\|_____/ 
                                                                 */
---------------------------TRIGGERS--------------------------------


CREATE TRIGGER update_customer_bookings
AFTER UPDATE OF booking_status ON Booking
    FOR EACH ROW EXECUTE PROCEDURE increment_customer_bookings();
    
CREATE TRIGGER update_customer_category
AFTER UPDATE OF No_Of_Journeys ON registered_customer_account
    FOR EACH ROW EXECUTE PROCEDURE change_customer_category();
    
CREATE TRIGGER insert_Pods_for_new_model AFTER INSERT ON Spacecraft_Type
    FOR EACH ROW EXECUTE PROCEDURE insert_Pods_func();


    
/*_____   _____    ____    _____  ______  _____   _    _  _____   ______   _____ 
 |  __ \ |  __ \  / __ \  / ____||  ____||  __ \ | |  | ||  __ \ |  ____| / ____|
 | |__) || |__) || |  | || |     | |__   | |  | || |  | || |__) || |__   | (___  
 |  ___/ |  _  / | |  | || |     |  __|  | |  | || |  | ||  _  / |  __|   \___ \ 
 | |     | | \ \ | |__| || |____ | |____ | |__| || |__| || | \ \ | |____  ____) |
 |_|     |_|  \_\ \____/  \_____||______||_____/  \____/ |_|  \_\|______||_____/ 
*/    
----------------------------------PROCEDURES--------------------------------------

 
---------------------PROCEDURE FOR ADDING Pod PriceS---------------------------

CREATE OR REPLACE PROCEDURE insert_route_Price(varchar,numeric,numeric,numeric)
LANGUAGE plpgsql
AS $$

BEGIN
	INSERT INTO Pod_Price VALUES ($1,1,$2);
	INSERT INTO Pod_Price VALUES ($1,2,$3);
	INSERT INTO Pod_Price VALUES ($1,3,$4);

END;
$$;

/*_____  _   _  _____   ______ __   __
 |_   _|| \ | ||  __ \ |  ____|\ \ / /
   | |  |  \| || |  | || |__    \ V / 
   | |  | . ` || |  | ||  __|    > <  
  _| |_ | |\  || |__| || |____  / . \ 
 |_____||_| \_||_____/ |______|/_/ \_\
                                       */
--------------------INDEX------------------------------

CREATE INDEX INDEX_Schedule_Route_ID ON Flight_Schedule (Route_ID);
CREATE INDEX INDEX_Booking_Schedule_ID ON Booking (Journey_ID);

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


INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ('jzO77wvelMYbRx', 'Emily','Tina' ,'Female', '1989-12-12', 'emily123@gmail.com', '(555) 555-1234', 'General', '148, Hilltop Ave.Far Rockaway, New York' , 'USA' , 'C00002345' , 2 ,'2022-12-24 10:10:53');
INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ( 'iBX3A8p59DBRB', 'Adam','Peter' ,'Male', '1976-02-18', 'adammnb@yahoo.com', '(78) 555-1234', 'Frequent', '56B, Victoria Street, Melbourne' , 'Australia' , 'U0048902' , 6 ,'2022-12-24 11:12:34');
INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ( 'TkVB6JAM684S', 'Chris','Evans', 'Male', '1999-02-22', 'chrisnew@gmail.com', '(202) 588-6500', 'Gold', '148, 45A, Cobblestone Ave.Deland, FL' , 'USA' , 'E00016545' , 12 ,'2022-12-25 08:40:43');
INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ( 'Yhgrt56l@der', 'David', 'Warner', 'Male',  '1976-11-08', 'warn30@gmail.com', '(345) 789-6788', 'General', '234, Victoria Street, Sydney' , 'Australia' , 'J90005678' , 3 ,'2022-12-25 09:12:21');
INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ( '2jHO4KTQQfTnVQt', 'Emma', 'Watson', 'Female',  '2005-12-03', 'emma@yahoo.com', '(234) 234-4532', 'General', '342, Cherry Court, SOUTHAMPTON' , 'UK' , 'E50045673' , 1 ,'2023-01-01 03:15:09');
INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ( 'adFTG54@3JH', 'Albert', 'Einstein', 'Male',  '2006-10-12', 'albeins@gmail.com', '(345) 986-4567', 'General', '813, Howard Street , Chicago' , 'USA' , 'R10003456' , 2 ,'2023-01-02 15:43:11');
INSERT INTO Registered_Customer_Account( Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Country, Passport_no, No_of_Bookings, Joined) VALUES ( '9GHJ*HJSBad', 'Sheldon', 'George', 'Male',  '2006-02-18', 'sheldon18@gmail.com', '(234) 134-8964', 'General', '45, Shirley Street , Canberra' , 'Australia' , 'D00004536' , 1 ,'2023-01-03 02:34:51');


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




