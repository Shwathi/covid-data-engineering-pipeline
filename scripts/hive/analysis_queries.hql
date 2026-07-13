-- ===========================================================
-- Create Database
-- ===========================================================

CREATE DATABASE IF NOT EXISTS CovidHiveDB;

USE CovidHiveDB;

-- ===========================================================
-- Create Internal Table
-- ===========================================================

CREATE TABLE CovidDataWarehouse(
    iso_code STRING,
    continent STRING,
    location STRING,
    date_current STRING,
    total_cases DOUBLE,
    total_deaths DOUBLE,
    total_vaccinations DOUBLE,
    people_vaccinated DOUBLE,
    median_age DOUBLE,
    age_65_older DOUBLE,
    age_70_older DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

-- ===========================================================
-- Load Data from HDFS
-- ===========================================================

LOAD DATA INPATH '/CovidHDFS/part-m-00000'
OVERWRITE INTO TABLE CovidDataWarehouse;

-- View Sample Data
SELECT * FROM CovidDataWarehouse LIMIT 10;

-- ===========================================================
-- 1. Count Vaccinations per Location
-- ===========================================================

SELECT
location,
SUM(total_vaccinations) AS Total_Vaccinations
FROM CovidDataWarehouse
GROUP BY location;

-- ===========================================================
-- 2. Filter Locations Starting with "United"
-- ===========================================================

SELECT *
FROM CovidDataWarehouse
WHERE location LIKE 'United%';

-- ===========================================================
-- 3. Create Partition Table by Continent
-- ===========================================================

SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

CREATE TABLE CovidPartition(
    iso_code STRING,
    location STRING,
    date_current STRING,
    total_cases DOUBLE,
    total_deaths DOUBLE,
    total_vaccinations DOUBLE,
    people_vaccinated DOUBLE,
    median_age DOUBLE,
    age_65_older DOUBLE,
    age_70_older DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE
)
PARTITIONED BY(continent STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',';

INSERT OVERWRITE TABLE CovidPartition
PARTITION(continent)
SELECT
iso_code,
location,
date_current,
total_cases,
total_deaths,
total_vaccinations,
people_vaccinated,
median_age,
age_65_older,
age_70_older,
cardiovasc_death_rate,
diabetes_prevalence,
continent
FROM CovidDataWarehouse;

-- Show Partitions
SHOW PARTITIONS CovidPartition;

-- ===========================================================
-- 4. Create Bucket Table (4 Buckets)
-- ===========================================================

SET hive.enforce.bucketing=true;

CREATE TABLE CovidBucket(
    iso_code STRING,
    continent STRING,
    location STRING,
    date_current STRING,
    total_cases DOUBLE,
    total_deaths DOUBLE,
    total_vaccinations DOUBLE,
    people_vaccinated DOUBLE,
    median_age DOUBLE,
    age_65_older DOUBLE,
    age_70_older DOUBLE,
    cardiovasc_death_rate DOUBLE,
    diabetes_prevalence DOUBLE
)
CLUSTERED BY(location)
INTO 4 BUCKETS
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

INSERT OVERWRITE TABLE CovidBucket
SELECT * FROM CovidDataWarehouse;

-- ===========================================================
-- 5. Maximum Infections
-- ===========================================================

SELECT
MAX(total_cases) AS Maximum_Infections
FROM CovidDataWarehouse;

-- ===========================================================
-- 6. Minimum Infections
-- ===========================================================

SELECT
MIN(total_cases) AS Minimum_Infections
FROM CovidDataWarehouse;

-- ===========================================================
-- 7. Average Infections
-- ===========================================================

SELECT
AVG(total_cases) AS Average_Infections
FROM CovidDataWarehouse;

-- ===========================================================
-- 8. Count Deaths per Continent
-- ===========================================================

SELECT
continent,
SUM(total_deaths) AS Total_Deaths
FROM CovidDataWarehouse
GROUP BY continent;

-- ===========================================================
-- 9. Average Diabetes Prevalence for Israel
-- ===========================================================

SELECT
AVG(diabetes_prevalence) AS Avg_Diabetes_Prevalence
FROM CovidDataWarehouse
WHERE location='Israel';
