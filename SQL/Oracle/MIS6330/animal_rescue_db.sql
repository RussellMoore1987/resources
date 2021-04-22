












-- Список Дел: 
    -- add constraints
    -- add indexes, key indexes
    -- Add status table for adoptable pets???
    -- UNIQUE ???
    -- Do foreign keys automatically make them an index?
    -- Have teacher look it over with us and see what things she would suggest improving and why.

-- @ TypeOfAnimals
CREATE TABLE TypeOfAnimals (
    type_of_animal_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    type_of_animal VARCHAR2(25 CHAR) NOT NULL UNIQUE
);

-- @ Staff
CREATE TABLE Staff (
    staff_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    staff_first_name VARCHAR2(25 CHAR) NOT NULL,
    staff_last_name VARCHAR2(25 CHAR) NOT NULL,
    staff_address VARCHAR2(100 CHAR) NOT NULL,
    staff_state CHAR(2 CHAR) NOT NULL,
    staff_city VARCHAR2(50 CHAR) NOT NULL,
    staff_zip NUMBER(5) NOT NULL,
    staff_phone_number VARCHAR2(20 CHAR) NOT NULL,
    staff_email VARCHAR2(150 CHAR) NOT NULL,
    staff_is_active NUMBER(1) DEFAULT 1,
    staff_note VARCHAR2(500 CHAR),
    created_by NUMBER,
    created_date DATE NOT NULL,
    updated_by NUMBER,
    updated_date DATE,
    FOREIGN KEY(updated_by) REFERENCES Staff(staff_id)
);

-- @ Breeds
CREATE TABLE Breeds (
    breed_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    breed_name VARCHAR2(50 CHAR) NOT NULL UNIQUE,
    type_of_animal_id NUMBER NOT NULL,
    FOREIGN KEY(type_of_animal_id) REFERENCES TypeOfAnimals(type_of_animal_id)
);

-- @ Adopters
CREATE TABLE Adopters (
    adopter_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    adopters_first_name VARCHAR2(25 CHAR) NOT NULL,
    adopters_last_name VARCHAR2(25 CHAR) NOT NULL,
    adopters_address VARCHAR2(100 CHAR) NOT NULL,
    adopters_state CHAR(2 CHAR) NOT NULL,
    adopters_city VARCHAR2(50 CHAR) NOT NULL,
    adopters_zip NUMBER(5) NOT NULL,
    adopters_phone_number VARCHAR2(20 CHAR) NOT NULL,
    adopters_email VARCHAR2(150 CHAR) NOT NULL,
    adopter_is_active NUMBER(1) DEFAULT 1,
    adopters_note VARCHAR2(500 CHAR),
    created_by NUMBER NOT NULL,
    created_date DATE NOT NULL,
    updated_by NUMBER,
    updated_date DATE,
    FOREIGN KEY(created_by) REFERENCES Staff(staff_id),
    FOREIGN KEY(updated_by) REFERENCES Staff(staff_id)
);

-- @ Locations
CREATE TABLE Locations (
    location_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    location_name VARCHAR2(50 CHAR) NOT NULL,
    location_address VARCHAR2(100 CHAR) NOT NULL,
    location_state CHAR(2 CHAR) NOT NULL,
    location_city VARCHAR2(50 CHAR) NOT NULL,
    location_zip NUMBER(5) NOT NULL,
    location_phone_number VARCHAR2(20 CHAR) NOT NULL,
    location_email VARCHAR2(150 CHAR) NOT NULL,
    location_is_active NUMBER(1) DEFAULT 1,
    location_note VARCHAR2(500 CHAR),
    created_by NUMBER NOT NULL,
    created_date DATE NOT NULL,
    updated_by NUMBER,
    updated_date DATE,
    FOREIGN KEY(created_by) REFERENCES Staff(staff_id),
    FOREIGN KEY(updated_by) REFERENCES Staff(staff_id)
);

    CREATE TABLE StaffAtLocation (
        staff_id NUMBER NOT NULL,
        location_id	NUMBER NOT NULL,
        primary key (staff_id, location_id),
        FOREIGN KEY(staff_id) REFERENCES Staff(staff_id),
        FOREIGN KEY(location_id) REFERENCES Locations(location_id)
    );

-- @ PetStatus
CREATE TABLE PetStatus (
    pet_status_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    pet_status VARCHAR2(25 CHAR) NOT NULL UNIQUE
);

-- @ AdoptablePets
CREATE TABLE AdoptablePets (
    adoptable_pet_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    adoptable_pet_name VARCHAR2(50 CHAR) NOT NULL,
    breed_id NUMBER NOT NULL,
    weight NUMBER(6,2),
    height NUMBER(5,2),
    available_date DATE,
    pet_status_id NUMBER DEFAULT 1,
    location_id NUMBER NOT NULL,
    adoptable_pet_note VARCHAR2(500 CHAR),
    created_by NUMBER NOT NULL,
    created_date DATE NOT NULL,
    updated_by NUMBER,
    updated_date DATE,
    FOREIGN KEY(breed_id) REFERENCES Breeds(breed_id),
    FOREIGN KEY(pet_status_id) REFERENCES PetStatus(pet_status_id),
    FOREIGN KEY(location_id) REFERENCES Locations(location_id),
    FOREIGN KEY(created_by) REFERENCES Staff(staff_id),
    FOREIGN KEY(updated_by) REFERENCES Staff(staff_id)
);

    CREATE TABLE Adoptions (
        adoptable_pet_id NUMBER NOT NULL,
        adopter_id NUMBER NOT NULL,
        adoption_date DATE NOT NULL,
        adoption_cost NUMBER(6,2) NOT NULL,
        staff_id NUMBER NOT NULL,
        location_id NUMBER NOT NULL,
        primary key (adoptable_pet_id, adopter_id),
        FOREIGN KEY(adoptable_pet_id) REFERENCES AdoptablePets(adoptable_pet_id),
        FOREIGN KEY(adopter_id) REFERENCES Adopters(adopter_id),
        FOREIGN KEY(staff_id) REFERENCES Staff(staff_id),
        FOREIGN KEY(location_id) REFERENCES Locations(location_id)
    );

-- @ Vaccinations
CREATE TABLE Vaccinations (
    vaccination_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    vaccination_name VARCHAR2(75 CHAR) NOT NULL,
    type_of_animal_id NUMBER NOT NULL,
    vaccination_is_active NUMBER(1) DEFAULT 1,
    vaccination_note VARCHAR2(500 CHAR),
    created_by NUMBER NOT NULL,
    created_date DATE NOT NULL,
    updated_by NUMBER,
    updated_date DATE,
    FOREIGN KEY(created_by) REFERENCES Staff(staff_id),
    FOREIGN KEY(updated_by) REFERENCES Staff(staff_id),
    FOREIGN KEY(type_of_animal_id) REFERENCES TypeOfAnimals(type_of_animal_id)
);

    CREATE TABLE AnimalVaccinations (
        vaccination_id NUMBER NOT NULL,
        adoptable_pet_id NUMBER NOT NULL,
        date_administered DATE NOT NULL,
        staff_id NUMBER NOT NULL,
        location_id NUMBER NOT NULL,
        primary key (vaccination_id, adoptable_pet_id),
        FOREIGN KEY(vaccination_id) REFERENCES Vaccinations(vaccination_id),
        FOREIGN KEY(adoptable_pet_id) REFERENCES AdoptablePets(adoptable_pet_id),
        FOREIGN KEY(staff_id) REFERENCES Staff(staff_id),
        FOREIGN KEY(location_id) REFERENCES Locations(location_id)
    );


DROP TABLE AnimalVaccinations;
DROP TABLE Vaccinations;
DROP TABLE Adoptions;
DROP TABLE AdoptablePets;
DROP TABLE PetStatus;
DROP TABLE StaffAtLocation;		
DROP TABLE Locations;
DROP TABLE Adopters;
DROP TABLE Staff;
DROP TABLE Breeds;
DROP TABLE TypeOfAnimals;


GRANT SELECT ON RMOORE.AnimalVaccinations TO CHOILAND;
GRANT SELECT ON RMOORE.Vaccinations TO CHOILAND;
GRANT SELECT ON RMOORE.Adoptions TO CHOILAND;
GRANT SELECT ON RMOORE.AdoptablePets TO CHOILAND;
GRANT SELECT ON RMOORE.PetStatus TO CHOILAND;
GRANT SELECT ON RMOORE.StaffAtLocation TO CHOILAND;
GRANT SELECT ON RMOORE.Locations TO CHOILAND;
GRANT SELECT ON RMOORE.Adopters TO CHOILAND;
GRANT SELECT ON RMOORE.Staff TO CHOILAND;
GRANT SELECT ON RMOORE.Breeds TO CHOILAND;
GRANT SELECT ON RMOORE.TypeOfAnimals TO CHOILAND;


GRANT SELECT ON RMOORE.AnimalVaccinations TO BWOODBURY;
GRANT SELECT ON RMOORE.Vaccinations TO BWOODBURY;
GRANT SELECT ON RMOORE.Adoptions TO BWOODBURY;
GRANT SELECT ON RMOORE.AdoptablePets TO BWOODBURY;
GRANT SELECT ON RMOORE.PetStatus TO BWOODBURY;
GRANT SELECT ON RMOORE.StaffAtLocation TO BWOODBURY;
GRANT SELECT ON RMOORE.Locations TO BWOODBURY;
GRANT SELECT ON RMOORE.Adopters TO BWOODBURY;
GRANT SELECT ON RMOORE.Staff TO BWOODBURY;
GRANT SELECT ON RMOORE.Breeds TO BWOODBURY;
GRANT SELECT ON RMOORE.TypeOfAnimals TO BWOODBURY;

GRANT SELECT ON RMOORE.AnimalVaccinations TO LMEYERS;
GRANT SELECT ON RMOORE.Vaccinations TO LMEYERS;
GRANT SELECT ON RMOORE.Adoptions TO LMEYERS;
GRANT SELECT ON RMOORE.AdoptablePets TO LMEYERS;
GRANT SELECT ON RMOORE.PetStatus TO LMEYERS;
GRANT SELECT ON RMOORE.StaffAtLocation TO LMEYERS;
GRANT SELECT ON RMOORE.Locations TO LMEYERS;
GRANT SELECT ON RMOORE.Adopters TO LMEYERS;
GRANT SELECT ON RMOORE.Staff TO LMEYERS;
GRANT SELECT ON RMOORE.Breeds TO LMEYERS;
GRANT SELECT ON RMOORE.TypeOfAnimals TO LMEYERS;


-- animal queries 
-- joint between adoptable pet, breed, type of animal, and at specific location.
SELECT
    ADOPTABLE_PET_ID,
    ADOPTABLE_PET_NAME,
    BREED_NAME,
    TYPE_OF_ANIMAL,
    WEIGHT,
    HEIGHT,
    AVAILABLE_DATE,
    PET_STATUS_ID,
    LOCATION_NAME,
    ADOPTABLE_PET_NOTE
FROM RMOORE.ADOPTABLEPETS ap 
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
    INNER JOIN RMOORE.TYPEOFANIMALS a
        ON b.TYPE_OF_ANIMAL_ID = a.TYPE_OF_ANIMAL_ID
    INNER JOIN RMOORE.LOCATIONS l
        ON l.LOCATION_ID = ap.LOCATION_ID
WHERE ap.PET_STATUS_ID = 1
ORDER BY ADOPTABLE_PET_ID;


-- staff that are at location 1
SELECT
    l.LOCATION_NAME,
	s.STAFF_FIRST_NAME,
    s.STAFF_LAST_NAME
FROM RMOORE.LOCATIONS l
	INNER JOIN RMOORE.STAFFATLOCATION sal
        ON l.LOCATION_ID = sal.LOCATION_ID
	INNER JOIN RMOORE.STAFF s
        ON s.STAFF_ID = sal.STAFF_ID
WHERE l.LOCATION_ID = 1;

-- staff that are at location 2
SELECT
    l.LOCATION_NAME,
	s.STAFF_FIRST_NAME,
    s.STAFF_LAST_NAME
FROM RMOORE.LOCATIONS l
	INNER JOIN RMOORE.STAFFATLOCATION sal
        ON l.LOCATION_ID = sal.LOCATION_ID
	INNER JOIN RMOORE.STAFF s
        ON s.STAFF_ID = sal.STAFF_ID
WHERE l.LOCATION_ID = 2;

-- staff that are at location 3 and who is active
SELECT
    l.LOCATION_NAME,
	s.STAFF_FIRST_NAME,
    s.STAFF_LAST_NAME,
	s.STAFF_IS_ACTIVE
FROM RMOORE.LOCATIONS l
	INNER JOIN RMOORE.STAFFATLOCATION sal
        ON l.LOCATION_ID = sal.LOCATION_ID
	INNER JOIN RMOORE.STAFF s
        ON s.STAFF_ID = sal.STAFF_ID
WHERE l.LOCATION_ID = 3;


-- count pets that are available for adoption
SELECT
    COUNT(ADOPTABLE_PET_ID)
FROM
    RMOORE.ADOPTABLEPETS
WHERE PET_STATUS_ID = 1;


-- count pets that have been adopted
SELECT
    COUNT(ADOPTABLE_PET_ID)
FROM
    RMOORE.ADOPTABLEPETS
WHERE
    PET_STATUS_ID = 2;
-- this should mach the one above, testing to make sure that records were inserted correctly
SELECT
    COUNT(ADOPTABLE_PET_ID)
FROM
    RMOORE.ADOPTIONS;

-- count pets that have been euthanized
SELECT
    COUNT(ADOPTABLE_PET_ID)
FROM
    RMOORE.ADOPTABLEPETS
WHERE PET_STATUS_ID = 3;


-- count all adoptable pet records
SELECT
    COUNT(ADOPTABLE_PET_ID)
FROM
    RMOORE.ADOPTABLEPETS;


-- join between breed and animal type
SELECT
    BREED_ID,
    BREED_NAME,
    TYPE_OF_ANIMAL
FROM RMOORE.BREEDS b
	INNER JOIN RMOORE.TYPEOFANIMALS ta 
    	ON b.TYPE_OF_ANIMAL_ID = ta.TYPE_OF_ANIMAL_ID;


-- Testing whether or not vaccines are coming in correctly, they should match all the way across 
-- all, (where not a match, below this query)
SELECT
	toav.TYPE_OF_ANIMAL AS VACCINE_TYPE_OF_ANIMAL,
	v.VACCINATION_NAME,
	lv.LOCATION_NAME AS VACCINE_LOCATION,
	toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL,
	ap.ADOPTABLE_PET_NAME,
	lp.LOCATION_NAME AS ADOPTABLE_PET_LOCATION
FROM RMOORE.ANIMALVACCINATIONS av
	-- v.VACCINATION_NAME
	INNER JOIN RMOORE.VACCINATIONS v 
    	ON av.VACCINATION_ID = v.VACCINATION_ID
	-- toav.TYPE_OF_ANIMAL AS VACCINE_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.TYPEOFANIMALS toav 
    	ON v.TYPE_OF_ANIMAL_ID = toav.TYPE_OF_ANIMAL_ID
	-- lv.LOCATION_NAME AS VACCINE_LOCATION,
	INNER JOIN RMOORE.LOCATIONS lv
        ON lv.LOCATION_ID = av.LOCATION_ID
	-- ap.ADOPTABLE_PET_NAME,
	INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON av.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	-- toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toap 
    	ON b.TYPE_OF_ANIMAL_ID = toap.TYPE_OF_ANIMAL_ID
	-- lp.LOCATION_NAME AS ADOPTABLE_PET_LOCATION
	INNER JOIN RMOORE.LOCATIONS lp
        ON lp.LOCATION_ID = ap.LOCATION_ID
ORDER BY av.ADOPTABLE_PET_ID;


-- Testing whether or not vaccines are coming in correctly, they should match all the way across
-- where not a match
SELECT
	toav.TYPE_OF_ANIMAL AS VACCINE_TYPE_OF_ANIMAL,
	v.VACCINATION_NAME,
	lv.LOCATION_NAME AS VACCINE_LOCATION,
	toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL,
	ap.ADOPTABLE_PET_NAME,
	lp.LOCATION_NAME AS ADOPTABLE_PET_LOCATION
FROM RMOORE.ANIMALVACCINATIONS av
	-- v.VACCINATION_NAME
	INNER JOIN RMOORE.VACCINATIONS v 
    	ON av.VACCINATION_ID = v.VACCINATION_ID
	-- toav.TYPE_OF_ANIMAL AS VACCINE_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.TYPEOFANIMALS toav 
    	ON v.TYPE_OF_ANIMAL_ID = toav.TYPE_OF_ANIMAL_ID
	-- lv.LOCATION_NAME AS VACCINE_LOCATION,
	INNER JOIN RMOORE.LOCATIONS lv
        ON lv.LOCATION_ID = av.LOCATION_ID
	-- ap.ADOPTABLE_PET_NAME,
	INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON av.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	-- toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toap 
    	ON b.TYPE_OF_ANIMAL_ID = toap.TYPE_OF_ANIMAL_ID
	-- lp.LOCATION_NAME AS ADOPTABLE_PET_LOCATION
	INNER JOIN RMOORE.LOCATIONS lp
        ON lp.LOCATION_ID = ap.LOCATION_ID
WHERE toav.TYPE_OF_ANIMAL <> toap.TYPE_OF_ANIMAL
ORDER BY av.ADOPTABLE_PET_ID;

-- First analytical query
SELECT
    ap.ADOPTABLE_PET_NAME,
    ADOPTERS_FIRST_NAME || ' ' || ADOPTERS_LAST_NAME AS ADOPTERS_NAME,
    TYPE_OF_ANIMAL,
    BREED_NAME
FROM RMOORE.ADOPTIONS a
    INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
    INNER JOIN RMOORE.ADOPTERS ad
        ON a.ADOPTER_ID = ad.ADOPTER_ID
    INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
    INNER JOIN RMOORE.TYPEOFANIMALS toa
        ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
ORDER BY TYPE_OF_ANIMAL, BREED_NAME, ADOPTION_DATE;

-- how many vaccinations has an animal had
SELECT
	av.ADOPTABLE_PET_ID AS ADOPTABLE_PET_ID,
	ap.ADOPTABLE_PET_NAME,
	toa.TYPE_OF_ANIMAL,
    COUNT(av.VACCINATION_ID) AS VACCINATION_COUNT
FROM RMOORE.ANIMALVACCINATIONS av
	INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON av.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toa
        ON b.TYPE_OF_ANIMAL_ID = toa.TYPE_OF_ANIMAL_ID
GROUP BY av.ADOPTABLE_PET_ID, ap.ADOPTABLE_PET_NAME, toa.TYPE_OF_ANIMAL;

-- find cost per type and average cost
SELECT *
FROM (
    SELECT
        a.ADOPTION_COST,
    	toap.TYPE_OF_ANIMAL
    FROM
        RMOORE.ADOPTIONS a
    	-- ap.ADOPTABLE_PET_NAME,
	INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	-- toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toap 
    	ON b.TYPE_OF_ANIMAL_ID = toap.TYPE_OF_ANIMAL_ID
)
PIVOT (
    SUM(ADOPTION_COST) AS total_cost_animal_type,
    AVG(ADOPTION_COST) AS avg_cost_animal_type 
    FOR (TYPE_OF_ANIMAL) IN (
    	'Horse' AS Horse, 
        'Bird' AS Bird, 
        'Dog' AS Dog, 
        'Cat' AS Cat
    )
);

-- find cost per type
SELECT *
FROM (
    SELECT
        a.ADOPTION_COST,
    	toap.TYPE_OF_ANIMAL
    FROM
        RMOORE.ADOPTIONS a
    	-- ap.ADOPTABLE_PET_NAME,
	INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	-- toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toap 
    	ON b.TYPE_OF_ANIMAL_ID = toap.TYPE_OF_ANIMAL_ID
)
PIVOT (
    SUM(ADOPTION_COST) FOR (TYPE_OF_ANIMAL) IN (
    	'Horse' AS Horse, 
        'Bird' AS Bird, 
        'Dog' AS Dog, 
        'Cat' AS Cat
    )
);


-- find cost per type for time
SELECT *
FROM (
    SELECT
        a.ADOPTION_COST,
    	toap.TYPE_OF_ANIMAL,
    	TO_CHAR(ADOPTION_DATE, 'YYYY') AS ADOPTION_DATE
    FROM
        RMOORE.ADOPTIONS a
    	-- ap.ADOPTABLE_PET_NAME,
	INNER JOIN RMOORE.ADOPTABLEPETS ap
        ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	-- toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.BREEDS b
        ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toap 
    	ON b.TYPE_OF_ANIMAL_ID = toap.TYPE_OF_ANIMAL_ID
)
PIVOT (
    SUM(ADOPTION_COST) FOR (ADOPTION_DATE) IN (
    	2000 AS "2000",
        2001 AS "2001",
        2002 AS "2002",
        2003
    )
);

-- verifying the query above
SELECT
    SUM(ADOPTION_COST),
    toap.TYPE_OF_ANIMAL,
    TO_CHAR(ADOPTION_DATE, 'YYYY') AS ADOPTION_DATE
FROM
	RMOORE.ADOPTIONS a
	-- ap.ADOPTABLE_PET_NAME,
	INNER JOIN RMOORE.ADOPTABLEPETS ap
		ON a.ADOPTABLE_PET_ID = ap.ADOPTABLE_PET_ID
	-- toap.TYPE_OF_ANIMAL AS ADOPTABLE_PET_TYPE_OF_ANIMAL
	INNER JOIN RMOORE.BREEDS b
		ON ap.BREED_ID = b.BREED_ID
	INNER JOIN RMOORE.TYPEOFANIMALS toap 
		ON b.TYPE_OF_ANIMAL_ID = toap.TYPE_OF_ANIMAL_ID
WHERE TO_CHAR(ADOPTION_DATE, 'YYYY') IN (2000,2001,2002,2003)
GROUP BY TYPE_OF_ANIMAL, TO_CHAR(ADOPTION_DATE, 'YYYY')
ORDER BY TYPE_OF_ANIMAL, ADOPTION_DATE;
-- 219.06 (2000, bird)
-- 3295.86 (2000, cat)
-- 3100.88 (2000, dog)
-- 3560.89 (2000, horse)

SELECT
    SUM(ADOPTION_COST)
FROM
    RMOORE.ADOPTIONS
WHERE TO_CHAR(ADOPTION_DATE, 'YYYY') = 2000;
-- 10176.69

SELECT
    SUM(ADOPTION_COST)
FROM
    RMOORE.ADOPTIONS
WHERE TO_CHAR(ADOPTION_DATE, 'YYYY') = 2001;
-- 9731.86










-- other generic queries

SELECT
    LOCATION_ID,
    LOCATION_NAME,
    LOCATION_ADDRESS,
    LOCATION_STATE,
    LOCATION_CITY,
    LOCATION_ZIP,
    LOCATION_PHONE_NUMBER,
    LOCATION_EMAIL,
    LOCATION_IS_ACTIVE,
    LOCATION_NOTE,
    CREATED_BY,
    CREATED_DATE,
    UPDATED_BY,
    UPDATED_DATE
FROM
    RMOORE.LOCATIONS;


SELECT
    STAFF_ID,
    LOCATION_ID
FROM
    RMOORE.STAFFATLOCATION;


SELECT
    STAFF_ID,
    STAFF_FIRST_NAME,
    STAFF_LAST_NAME,
    STAFF_ADDRESS,
    STAFF_STATE,
    STAFF_CITY,
    STAFF_ZIP,
    STAFF_PHONE_NUMBER,
    STAFF_EMAIL,
    STAFF_IS_ACTIVE,
    STAFF_NOTE,
    CREATED_BY,
    CREATED_DATE,
    UPDATED_BY,
    UPDATED_DATE
FROM
    RMOORE.STAFF;

SELECT
    COUNT(STAFF_ID)
FROM
    RMOORE.STAFF;


SELECT
    LOCATION_ID,
    LOCATION_NAME,
    LOCATION_ADDRESS,
    LOCATION_PHONE_NUMBER,
    LOCATION_EMAIL,
    LOCATION_IS_ACTIVE,
    LOCATION_NOTE
FROM
    RMOORE.LOCATIONS;


SELECT
    BREED_ID,
    BREED_NAME,
    TYPE_OF_ANIMAL_ID
FROM
    RMOORE.BREEDS;


SELECT
    ADOPTABLE_PET_ID,
    ADOPTABLE_PET_NAME,
    BREED_ID,
    WEIGHT,
    HEIGHT,
    AVAILABLE_DATE,
    STATUS,
    LOCATION_ID,
    ADOPTABLE_PET_NOTE
FROM
    RMOORE.ADOPTABLEPETS;


SELECT
    TYPE_OF_ANIMAL_ID,
    TYPE_OF_ANIMAL
FROM
    RMOORE.TYPEOFANIMALS;


SELECT
    ADOPTABLE_PET_ID,
    ADOPTABLE_PET_NAME,
    BREED_ID,
    WEIGHT,
    HEIGHT,
    AVAILABLE_DATE,
    STATUS,
    LOCATION_ID,
    ADOPTABLE_PET_NOTE
FROM
    RMOORE.ADOPTABLEPETS
WHERE STATUS = 1
ORDER BY ADOPTABLE_PET_ID;



SELECT
    ADOPTABLE_PET_ID,
    ADOPTER_ID,
    ADOPTION_DATE,
    ADOPTION_COST,
    STAFF_ID,
    LOCATION_ID
FROM
    RMOORE.ADOPTIONS;


SELECT
    VACCINATION_ID,
    VACCINATION_NAME,
    TYPE_OF_ANIMAL_ID,
    VACCINATION_IS_ACTIVE,
    VACCINATION_NOTE,
    CREATED_BY,
    CREATED_DATE,
    UPDATED_BY,
    UPDATED_DATE
FROM
    RMOORE.VACCINATIONS;

SELECT
    COUNT(VACCINATION_ID)
FROM
    RMOORE.ANIMALVACCINATIONS;



SELECT
    ADOPTABLE_PET_ID,
    ADOPTER_ID,
    ADOPTION_DATE,
    ADOPTION_COST,
    STAFF_ID,
    LOCATION_ID
FROM
    RMOORE.ADOPTIONS;




SELECT
    ADOPTER_ID,
    ADOPTERS_FIRST_NAME,
    ADOPTERS_LAST_NAME,
    ADOPTERS_ADDRESS,
    ADOPTERS_STATE,
    ADOPTERS_CITY,
    ADOPTERS_ZIP,
    ADOPTERS_PHONE_NUMBER,
    ADOPTERS_EMAIL,
    ADOPTER_IS_ACTIVE,
    ADOPTERS_NOTE,
    CREATED_BY,
    CREATED_DATE,
    UPDATED_BY,
    UPDATED_DATE
FROM
    RMOORE.ADOPTERS;













