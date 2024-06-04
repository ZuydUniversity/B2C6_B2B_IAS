--  Sample employee database
--  See changelog table for details
--  Copyright (C) 2007,2008, MySQL AB
--
--  Original data created by Fusheng Wang and Carlo Zaniolo
--  http://www.cs.aau.dk/TimeCenter/software.htm
--  http://www.cs.aau.dk/TimeCenter/Data/employeeTemporalDataSet.zip
--
--  Current schema by Giuseppe Maxia
--  Data conversion from XML to relational by Patrick Crews
--
-- This work is licensed under the
-- Creative Commons Attribution-Share Alike 3.0 Unported License.
-- To view a copy of this license, visit
-- http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to
-- Creative Commons, 171 Second Street, Suite 300, San Francisco,
-- California, 94105, USA.
--
--  DISCLAIMER
--  To the best of our knowledge, this data is fabricated, and
--  it does not correspond to real people.
--  Any similarity to existing people is purely coincidental.
--

DROP DATABASE IF EXISTS casusdb;
CREATE DATABASE IF NOT EXISTS casusdb;
USE casusdb;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS patient,
                     results,
                     radiology_results,
                     blood_chemistry_results,
                     myometry_results;

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE patient (
    id INT NOT NULL,
    birth_date  DATE            NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    gender      ENUM ('M','F')  NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE results (
    id     INT         NOT NULL,
    patient_id INT NOT NULL,
    type   VARCHAR(40)     NOT NULL,
    DATA   VARCHAR(120) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);

CREATE TABLE radiology_results (
    id     INT         NOT NULL,
    patient_id INT NOT NULL,
    type     VARCHAR(40)     NOT NULL,
    aspect   VARCHAR(120) NOT NULL,
    comments VARCHAR(120) NOT NULL,
    image    VARCHAR(120) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);


CREATE TABLE blood_chemistry_results (
        id     INT         NOT NULL,
    patient_id INT NOT NULL,
    parameter   VARCHAR(40)     NOT NULL,
    value   VARCHAR(120) NOT NULL,
    unit   VARCHAR(40)     NOT NULL,
    reference_range   VARCHAR(120) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);


CREATE TABLE myometry_results (
       id     INT         NOT NULL,
    patient_id INT NOT NULL,
    type     VARCHAR(40)     NOT NULL,
    aspect   VARCHAR(120) NOT NULL,
    score    VARCHAR(120) NOT NULL,
    average_score    VARCHAR(120) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
)
;