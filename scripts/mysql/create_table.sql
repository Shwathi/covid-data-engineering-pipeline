CREATE DATABASE IF NOT EXISTS CovidDB;

USE CovidDB;

CREATE TABLE CovidData(
    iso_code VARCHAR(10),
    continent VARCHAR(100),
    location VARCHAR(100),
    date_current VARCHAR(100),
    total_cases DOUBLE,
    total_deaths DOUBLE,
    total_vaccinations DOUBLE,
    people_vaccinated DOUBLE,
    median_age DOUBLE,
    age_65_older DOUBLE,
    age_70_older DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE
);

LOAD DATA LOCAL INFILE '/home/cloudera/DataSheet.csv'
INTO TABLE CovidData
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM CovidData;
SELECT * FROM CovidData LIMIT 5;
