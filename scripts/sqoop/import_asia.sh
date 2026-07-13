#!/bin/bash

sqoop import \
--connect jdbc:mysql://localhost/CovidDB \
--username your_username \
--password your_password \
--query "SELECT * FROM CovidData WHERE continent='Asia' AND \$CONDITIONS" \
-m 1 \
--target-dir /SqoopCovidAsiaData
