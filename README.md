# COVID-19 Data Engineering Pipeline using Hadoop and Spark (Scala)

## Overview

This project builds an end-to-end data engineering pipeline to process and analyze global COVID-19 data using the Hadoop ecosystem.

The pipeline ingests raw data, stores it in a distributed file system, and performs large-scale data processing to generate insights on infection trends, mortality rates, and vaccination progress.

---

## Objectives

* Analyze global COVID-19 infection and death trends
* Compare data across continents and countries
* Evaluate vaccination progress worldwide
* Implement scalable data processing using distributed systems

---

## Tech Stack

* **Storage**: Hadoop HDFS
* **Data Warehousing**: Hive
* **Data Ingestion**: Sqoop
* **Processing Engine**: Apache Spark (Scala)
* **Database**: MySQL
* **Language**: Scala, SQL

---

## Architecture

```
CSV → MySQL → Sqoop → HDFS → Hive → Spark → Insights
```

*(A detailed architecture diagram will be added in the `architecture/` folder)*

---

## Project Workflow

### 1. Data Ingestion

* Loaded raw CSV data into MySQL
* Imported data into HDFS using Sqoop
* Extracted filtered datasets (Asia region, non-vaccinated data)

### 2. Data Warehousing (Hive)

* Created internal Hive tables
* Implemented partitioning (by continent)
* Applied bucketing for optimized querying
* Performed aggregation queries

### 3. Data Processing (Spark - Scala)

* Processed large datasets using Spark DataFrames
* Computed:

  * Total cases by continent
  * Total deaths by location
  * Vaccination trends
* Performed date transformations (year, month, day extraction)

---

## Key Insights

* Identified regions with highest infection and mortality rates
* Observed variation in vaccination distribution across continents
* Analyzed health indicators such as diabetes prevalence in specific countries

---

## Project Structure

```
covid-data-engineering-pipeline/
│
├── data/
├── docs/
│   └── problem.md
│
├── scripts/
│   ├── mysql/
│   ├── sqoop/
│   ├── hive/
│   └── spark/
│       └── src/main/scala/
│
├── architecture/
├── output/
└── README.md
```

---

## How to Run

1. Load dataset into MySQL
2. Use Sqoop to import data into HDFS
3. Execute Hive scripts to create tables and run queries
4. Run Spark (Scala) application for data processing

---

## Future Improvements

* Add automated workflow using Apache Airflow
* Optimize Spark jobs for performance
* Integrate real-time data streaming

---

## Full Problem Statement

Detailed problem description is available here:
`docs/problem.md`
