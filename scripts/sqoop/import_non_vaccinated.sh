#!/bin/bash

sqoop import \
--connect jdbc:mysql://localhost/CovidDB \
--username your_username \
--password your_password \
--query "SELECT * FROM CovidData
WHERE CASE
WHEN people_vaccinated = 0 THEN NULL
ELSE people_vaccinated
END IS NULL
AND \$CONDITIONS" \
-m 1 \
--target-dir /SqoopNonVaccinated