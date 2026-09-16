/* Create the database "eahii_insurance_db" 
   and have the server use it */
   
CREATE DATABASE eahii_insurance_db;
USE eahii_insurance_db;

/* Creates the tables claim_payments, claims, 
   and industry_factors with the relevant fields */
   
CREATE TABLE claim_payments (
	payment_id BIGINT PRIMARY KEY,
    claim_id BIGINT,
    payment_amount FLOAT,
    payment_year YEAR,
    payment_month INT
);

CREATE TABLE claims (
	claim_id BIGINT PRIMARY KEY,
    claim_type VARCHAR(15),
    accident_year YEAR,
    accident_month INT,
    status VARCHAR(10)
);

CREATE TABLE industry_factors (
	claim_type VARCHAR(15),
    developmental_period VARCHAR(10),
    industry_df FLOAT
);

-- DATA UPLOAD --
/* We'll upload the respective .csv files extracted from the
   data in the Excel workbook "home insurance ratemaking".xlsm.
   The following is specific to MySQL Workbench 8.0+. */
   
/* 1. Check the value of the variable secure_file_priv 
   since the value gives the directory where we need 
   to store the .csv files. */

SELECT @@secure_file_priv;

/* 2. Turn off Strict Mode; MySQL throws an error with some INTEGER
   fields that are mainly used as id's. */

SET sql_mode = "";

/* 3. Now we upload! Note that the .csv's should be modified to 
   remove the first row with the column names. */

LOAD DATA INFILE '[secure_file_priv directory]/claim_payments.csv'
INTO TABLE claim_payments
FIELDS TERMINATED BY ',';

LOAD DATA INFILE '[secure_file_priv directory]/claims.csv'
INTO TABLE claims
FIELDS TERMINATED BY ',';

LOAD DATA INFILE '[secure_file_priv directory]/industry_benchmark_factors.csv'
INTO TABLE industry_factors
FIELDS TERMINATED BY ',';

/* Note: Some of the data may still have errors; 
   use the UPDATE statement accordingly. */