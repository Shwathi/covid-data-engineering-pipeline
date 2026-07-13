import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.functions._

object CovidAnalysis {

  def main(args: Array[String]): Unit = {

    val spark = SparkSession.builder()
      .appName("COVID Data Analysis")
      .master("local[*]")
      .getOrCreate()

    import spark.implicits._

    // Load CSV dataset
    val covidDF = spark.read
      .option("header", "true")
      .option("inferSchema", "true")
      .csv("data/DataSheet.csv")

    // Display Schema
    covidDF.printSchema()

    // ======================================================
    // Task 1: Total Cases per Continent
    // ======================================================

    println("===== Total Cases per Continent =====")

    covidDF.groupBy("continent")
      .agg(sum("total_cases").alias("Total_Cases"))
      .show()

    // ======================================================
    // Task 2: Total Deaths per Location
    // ======================================================

    println("===== Total Deaths per Location =====")

    covidDF.groupBy("location")
      .agg(sum("total_deaths").alias("Total_Deaths"))
      .show()

    // ======================================================
    // Task 3: Maximum Deaths in Europe and Asia
    // ======================================================

    println("===== Maximum Deaths in Europe and Asia =====")

    covidDF.filter($"continent".isin("Europe","Asia"))
      .groupBy("continent")
      .agg(max("total_deaths").alias("Maximum_Deaths"))
      .show()

    // ======================================================
    // Task 4: Total Vaccinations per Continent
    // ======================================================

    println("===== Total Vaccinations per Continent =====")

    covidDF.groupBy("continent")
      .agg(sum("total_vaccinations").alias("Total_Vaccinations"))
      .show()

    // ======================================================
    // Task 5: Vaccinations by Country for January 2021
    // ======================================================

    println("===== Vaccinations - January 2021 =====")

    covidDF.filter($"date_current".startsWith("2021-01"))
      .groupBy("location")
      .agg(sum("total_vaccinations").alias("January_Vaccinations"))
      .show()

    // ======================================================
    // Task 6: Average Total Cases
    // ======================================================

    println("===== Average Total Cases =====")

    covidDF.select(avg("total_cases").alias("Average_Total_Cases"))
      .show()

    // ======================================================
    // Task 7: Data Transformation
    // Extract Year, Month and Day
    // ======================================================

    println("===== Date Transformation =====")

    val transformedDF = covidDF
      .withColumn("Year", year(to_date(col("date_current"))))
      .withColumn("Month", month(to_date(col("date_current"))))
      .withColumn("Day", dayofmonth(to_date(col("date_current"))))

    transformedDF.select(
      "date_current",
      "Year",
      "Month",
      "Day"
    ).show(20)

    spark.stop()

  }
}