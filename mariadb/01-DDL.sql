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
                     myometry_results,
                     user;

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
    type   ENUM('Radiologie', 'Myometrie') NOT NULL,
    date DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);

CREATE TABLE radiology_results (
    id     INT         NOT NULL,
    patient_id INT NOT NULL,
    type     VARCHAR(40)     NOT NULL,
    aspect   VARCHAR(255) NOT NULL,
    comments VARCHAR(255) NOT NULL,
    image    VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);


CREATE TABLE blood_chemistry_results (
        id INT NOT NULL AUTO_INCREMENT,
    patient_id INT NOT NULL,
    parameter   VARCHAR(255)     NOT NULL,
    value   VARCHAR(255) NOT NULL,
    unit   VARCHAR(255)     NOT NULL,
    reference_range   VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);


CREATE TABLE myometry_results (
       id     INT         NOT NULL,
    patient_id INT NOT NULL,
    type     VARCHAR(255)     NOT NULL,
    aspect   VARCHAR(255) NOT NULL,
    score    int NOT NULL,
    average_score    int NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id)    ON DELETE CASCADE
);

CREATE TABLE user (
    id INT NOT NULL,
    password VARCHAR(255) Not NULL,
    employeeNumber VARCHAR(255) Not NULL Unique,
    email varchar(255) Not NULL Unique
    PRIMARY KEY (id)
);

Insert into user(id, password, employeeNumber, email) Values ( 1, '$2a$12$oYr5vPvrOGtin/H8T3pc1OmmqIMVp5OqIvQnCzC38N//ShBaX82Sm', 'nep1','dokterUno@gmail.com') /* password is B-crypted, to login use "w8w"*/

CREATE TABLE appointments (
    id INT NOT NULL,
    datetime DATETIME NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    duration VARCHAR(8), -- Formaat 'HH:MM:SS' 
    PRIMARY KEY (id),
    FOREIGN KEY (patient_id)  REFERENCES patient (id),
    FOREIGN KEY (doctor_id)  REFERENCES user (id)
);

CREATE TABLE notes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

CREATE TABLE images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    file_path VARCHAR(255),
    description TEXT,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);
