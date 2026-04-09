# Problem Statement

## Overview

The COVID-19 pandemic significantly impacted global health systems, generating large volumes of data related to infections, deaths, vaccinations, and patient health conditions.

Analyzing this data helps healthcare organizations understand:

* Infection spread patterns
* Mortality trends
* Vaccination progress
* Impact of pre-existing conditions (e.g., diabetes, cardiac diseases)

This project focuses on building a data engineering pipeline using the Hadoop ecosystem to process and analyze COVID-19 data and generate meaningful insights.

---

## Dataset Description

The dataset contains daily COVID-19 statistics collected from multiple locations worldwide.

Key attributes include:

* Date (`date_current` in MM/DD/YYYY format)
* Location / Country
* Continent
* Total cases
* Total deaths
* Vaccination data
* Health indicators (e.g., diabetes prevalence)

---

## Technology Requirements

The following tools are used in this project:

* MySQL (Data storage)
* Hadoop HDFS (Distributed storage)
* Hive (Data warehousing)
* Sqoop (Data ingestion)
* Apache Spark (Data processing using Scala)
* Java (JDK 1.8+)

---

## Task 1: Data Ingestion using Sqoop and HDFS

### Data Preparation

* Create a MySQL database: `CovidDB`
* Create table: `CovidData`
* Load CSV data into MySQL using `LOAD DATA` command

### Data Ingestion & HDFS Operations

* Import data from MySQL to HDFS using Sqoop (single mapper)
* Create HDFS directory: `CovidHDFS`
* Backup data to `CovidData_Backup`
* Display first and last 1 KB of data using HDFS commands

### Filtered Data Ingestion

* Import Asia-specific data into `SqoopCovidAsiaData`
* Import non-vaccinated data into `SqoopNonVaccinated`

---

## Task 2: Data Analysis using Hive

* Create Hive internal table: `CovidDatawarehouse`
* Load dataset into Hive table
* Perform analysis using Hive queries:

### Required Analysis

* Count vaccinations per location
* Filter locations starting with "United"
* Partition table by `continent`
* Bucket data into 4 partitions
* Compute:
  * Maximum infections
  * Minimum infections
  * Average infections
* Count deaths per continent
* Calculate average diabetes prevalence for Israel

---

## Task 3: Data Processing using Spark (Scala)

### Data Processing Tasks

* Compute total cases per continent
* Compute total deaths per location
* Identify maximum deaths in Europe and Asia
* Calculate total vaccinations per continent
* Count vaccinations by country for January 2021
* Compute average total cases across all locations

### Data Transformation

* Extract:
  * Year
  * Month
  * Day
    from the `date_current` column

---

## Expected Outcome

* A structured data pipeline using Hadoop ecosystem tools
* Processed datasets stored in HDFS and Hive
* Analytical insights derived using Hive and Spark
* Scalable data processing workflow suitable for large datasets

---
