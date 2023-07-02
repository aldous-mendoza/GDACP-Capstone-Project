-- Data Merging January 2022 to December 2022 tables

CREATE TABLE `2022_bike_tripdata.merged_bike_tripdata` AS 
  SELECT *
  FROM (
  SELECT * FROM `2022_bike_tripdata.2022-01_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-02_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-03_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-04_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-05_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-06_bike_tripdata`
  UNION ALL  
  SELECT * FROM `2022_bike_tripdata.2022-07_bike_tripdata`
  UNION ALL  
  SELECT * FROM `2022_bike_tripdata.2022-08_bike_tripdata`
  UNION ALL  
  SELECT * FROM `2022_bike_tripdata.2022-09_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-10_bike_tripdata`
  UNION ALL  
  SELECT * FROM `2022_bike_tripdata.2022-11_bike_tripdata`
  UNION ALL
  SELECT * FROM `2022_bike_tripdata.2022-12_bike_tripdata`
)

  SELECT *
  FROM `2022_bike_tripdata.merged_bike_tripdata`;