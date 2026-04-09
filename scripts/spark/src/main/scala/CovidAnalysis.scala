import org.apache.spark.sql.SparkSession

object CovidAnalysis {
  def main(args: Array[String]): Unit = {

    val spark = SparkSession.builder()
      .appName("COVID Data Analysis")
      .master("local[*]")
      .getOrCreate()

    // TODO: Load dataset
    // TODO: Perform transformations
    // TODO: Compute insights

    spark.stop()
  }
}
