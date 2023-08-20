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
CREATE TYPE Payment_Type_Enum AS ENUM(
'Credit Card',
'PayPal',
'Cash'
);

CREATE TYPE Flight_Status_Enum AS ENUM(
'Scheduled',
'Departed-On-Time',
'Delayed-Departure',
'Landed',
'Cancelled'
);

 CREATE TYPE Spacecraft_status_Enum AS ENUM( 
 'On-Ground',
 'In-Orbit');  

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
    val_traveller_Class_ID int;
    val_Price numeric;
BEGIN
    SELECT Route_ID, Spacecraft_ID INTO val_route_id, val_Spacecraft_id FROM Flight_Schedule WHERE Journey_ID = val_Journey_ID;
    SELECT Model_ID INTO val_model_id FROM Spacecraft_instance WHERE Spacecraft_ID = val_Spacecraft_id;
    SELECT Spacecraft_Pod.traveller_Class_ID INTO val_traveller_Class_ID FROM Spacecraft_Pod WHERE Model_ID = val_model_id AND Pod_ID = val_Pod_id;
    SELECT Price into val_Price FROM Pod_Price WHERE Route_ID = val_route_id AND Class_ID = val_traveller_Class_ID;
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

    -- INSERT INTO Booking(Intergalactic_ID, Journey_ID, model_id, Pod_ids,Pod_Price,Discount ,Final_Price, Booking_Status) VALUES(val_Intergalactic_ID, val_Journey_ID, val_model_id, PodNo,tot_Price,val_discount_percentage,Final_Price, 'Not paid') RETURNING Booking_ID INTO val_booking_id;
    INSERT INTO Booking(Intergalactic_ID, Journey_ID, model_id, Pod_ids,Pod_Price,Discount ,Final_Price, Booking_Status) VALUES(val_Intergalactic_ID, val_Journey_ID, val_model_id, PodNo,1000,0.1,900, 'Not paid') RETURNING Booking_ID INTO val_booking_id;


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
  Image varchar(100),
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
  Spacecraft varchar(50)NOT NULL,
  Intergalactic_ID varchar(9)NOT NULL,
  No_Of_Journeys int NOT NULL,
  Joined TIMESTAMP NOT NULL,
  Display_Photo varchar(100),
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
  Class_Name class_type_Enum NOT NULL UNIQUE,
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
  Image varchar(100),
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
  Traveller_Class_ID int NOT NULL,
  PRIMARY KEY (Model_ID, Pod_ID),
  FOREIGN KEY (Traveller_Class_ID) REFERENCES Traveller_Class(Class_ID) ON DELETE CASCADE ON UPDATE CASCADE,
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

CREATE TABLE Payment (
  Payment_ID SERIAL,
  Booking_ID int NOT NULL,
  Payment_Method Payment_Method_Enum NOT NULL,
  PRIMARY KEY (Payment_ID),
  FOREIGN KEY (Booking_ID) REFERENCES Booking(Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Passenger_Pod(
    Booking_ID int,
    Model_ID int,
    Pod_ID varchar(10),
    Price numeric(10, 2), 
    Name varchar(100) NOT NULL,
    Intergalactic_ID varchar(20) NOT NULL,
    DOB date NOT NULL,
    PRIMARY KEY (Booking_ID, Model_ID, Pod_ID),
    FOREIGN KEY(Booking_ID) REFERENCES Booking(Booking_ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Model_ID, Pod_ID) REFERENCES Spacecraft_Pod(Model_ID, Pod_ID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Cultures (
  Code SERIAL,
  Name varchar(50),
  Description TEXT,
  Spaceport varchar(10),
  Popularity_Rating numeric(10,2),
  Image varchar(100),
  PRIMARY KEY (Code),
  FOREIGN KEY (Spaceport) REFERENCES Spaceport(Code)
);

CREATE TABLE Attractions (
  Code SERIAL,
  Name varchar(50),
  Description TEXT,
  Spaceport varchar(10),
  Popularity_Rating numeric(10,2),
  Image varchar(100),
  PRIMARY KEY (Code),
  FOREIGN KEY (Spaceport) REFERENCES Spaceport(Code)
);

CREATE TABLE Events (
  Code SERIAL,
  Name varchar(50),
  Description TEXT,
  Spaceport varchar(10),
  Popularity_Rating numeric(10,2),
  Image varchar(100),
  PRIMARY KEY (Code),
  FOREIGN KEY (Spaceport) REFERENCES Spaceport(Code)
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

CREATE ROLE admin WITH LOGIN PASSWORD '1234';

GRANT ALL ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO admin;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO admin;

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


INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraft, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('$2b$10$CFbLNbM4YvkG071N4AZDWeRUuzF2N/KSLn6Kd00OBrtOmlTlDIubW', 'Zara', 'Vega', 'Female', '1995-08-27', 'zara.vega@email.com', '+1234567890', 'General', 'Starbase Alpha, Deck 5', 'Andromeda', 'Proxima Centauri', 'Stellar Cruiser 01', 'I56789088', 3, '2023-07-15 14:30:00', 'profile_zara.jpg', 4500.00, 150.00);

INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraft, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
VALUES ('iBX3A8p59DBRB', 'Xander', 'Nova', 'Male', '1987-04-10', 'xander.nova@email.com', '+9876543210', 'Frequent', 'Orbit Outpost 7, Suite 42', 'Milky Way', 'Sol', 'Starship Voyager', 'I00987897', 7, '2023-07-18 09:15:00', 'profile_xander.jpg', 7500.00, 300.00);

INSERT INTO Registered_Customer_Account(Password, First_Name, Last_Name, Gender, DOB, Email, Mobile, User_Type, Address, Galaxy, Solar_System, Spacecraft, Intergalactic_ID, No_Of_Journeys, Joined, display_photo, Total_Payments, Total_Refunds)
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
VALUES ('F013', 'G012', 'S004', '2024-12-30', '03:45:00', 'Scheduled', 0.00);

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


INSERT INTO Events (Name, Description, Spaceport, Popularity_Rating) VALUES 
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

-- Inserting into Attractions table
INSERT INTO Attractions (Name, Description, Spaceport, Popularity_Rating)
VALUES ('Celestial Observatory', 'Observatory with telescopes offering unparalleled views of galaxies.', 'ORI', 9.7);
INSERT INTO Attractions (Name, Description, Spaceport, Popularity_Rating)
VALUES ('Luminous Gardens', 'Bioluminescent flora from across the universe in a stunning garden.', 'TRI', 8.9);
INSERT INTO Attractions (Name, Description, Spaceport, Popularity_Rating)
VALUES ('Zero-G Thrills', 'Amusement park with gravity-defying rides and experiences.', 'PIN', 9.4);

-- Inserting into Cultures table
INSERT INTO Cultures (Name, Description, Spaceport, Popularity_Rating)
VALUES ('Lumarians', 'Advanced civilization focused on harnessing energy from stars.', 'CEN', 7.6);
INSERT INTO Cultures (Name, Description, Spaceport, Popularity_Rating)
VALUES ('Nebulans', 'Nomadic spacefaring culture with a deep connection to nebulae.', 'LEO', 8.3);
INSERT INTO Cultures (Name, Description, Spaceport, Popularity_Rating)
VALUES ('Aquafarians', 'Water-based society known for their intricate underwater cities.', 'HYD', 8.1);
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


