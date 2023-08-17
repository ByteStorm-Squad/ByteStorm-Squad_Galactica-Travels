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


GRANT ALL ON ALL TABLES IN SCHEMA public TO admin;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO admin;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO admin;

