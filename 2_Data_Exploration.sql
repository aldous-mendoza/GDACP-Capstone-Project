-- Data Exploration

-- Summarizing the column names and their corresponding data types

SELECT  column_name, data_type
FROM `2022_bike_tripdata`.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'merged_bike_tripdata';

-- Checking each column for the number of their NULL values

SELECT 
  COUNT(*) - COUNT(ride_id) ride_id,
  COUNT(*) - COUNT(rideable_type) rideable_type,
  COUNT(*) - COUNT(started_at) started_at,
  COUNT(*) - COUNT(ended_at) ended_at,
  COUNT(*) - COUNT(start_station_name) start_station_name,
  COUNT(*) - COUNT(start_station_id) start_station_id,
  COUNT(*) - COUNT(end_station_name) end_station_name,
  COUNT(*) - COUNT(end_station_id) end_station_id,
  COUNT(*) - COUNT(start_lat) start_lat,
  COUNT(*) - COUNT(start_lng) start_lng,
  COUNT(*) - COUNT(end_lat) end_lat,
  COUNT(*) - COUNT(end_lng) end_lng,
  COUNT(*) - COUNT(member_casual) member_casual
FROM `2022_bike_tripdata.merged_bike_tripdata`;

-- Checking for duplicate rows

SELECT COUNT(ride_id) - COUNT(DISTINCT(ride_id)) AS duplicate_rows_number
FROM `2022_bike_tripdata.merged_bike_tripdata`;

-- ride_id: checking for invalid values for the primary key 

SELECT LENGTH(ride_id) AS length_ride_id, COUNT(ride_id) AS number_of_rows
FROM `2022_bike_tripdata.merged_bike_tripdata`
GROUP BY length_ride_id;

-- rideable_type: enumerating the types of bike

SELECT DISTINCT(rideable_type), COUNT(*) number_of_bikes
FROM `2022_bike_tripdata.merged_bike_tripdata`
GROUP BY rideable_type;

-- started_at and ended_at: checking for invalid trip durations 

#Preview Time format

SELECT started_at, ended_at
FROM `2022_bike_tripdata.merged_bike_tripdata`
LIMIT 10;
#Time format: YYY-MM-DD hh:mm:ss UTC)

#Counting < 1 minute

SELECT COUNT(*) AS less_than_1_minute
FROM `2022_bike_tripdata.merged_bike_tripdata`
WHERE TIMESTAMP_DIFF(ended_at, started_at, SECOND) <= 60;
#Number of rows with less than 1 minute = 12283

#Counting > 24 hours 

SELECT COUNT(*) AS greater_than_24_hours
FROM `2022_bike_tripdata.merged_bike_tripdata`
WHERE TIMESTAMP_DIFF(ended_at, started_at, MINUTE) >= (24 * 60);
#Number of rows with greater than 24 hours = 5360

-- start_station_name and start_station_id: Double checking for missing rows

SELECT COUNT(ride_id) AS null_start_station_rows
FROM `2022_bike_tripdata.merged_bike_tripdata`
WHERE start_station_name IS NULL OR start_station_id IS NULL;
#Number of missing rows = 833064

-- end_station_name and end_station_id: Double checking for missing rows

SELECT COUNT(ride_id) AS null_end_station_rows
FROM `2022_bike_tripdata.merged_bike_tripdata`
WHERE end_station_name IS NULL OR end_station_id IS NULL;
#Number of missing rows = 892742

-- end_lat and end_lng: Double checking for missing rows

SELECT COUNT(ride_id) AS null_end_position
FROM `2022_bike_tripdata.merged_bike_tripdata`
WHERE end_lat IS NULL OR end_lng IS NULL;
#Number of missing rows = 5858

-- member_casual: Counting the number of consumers for each segment

SELECT DISTINCT member_casual, COUNT(member_casual) AS number_of_consumers
FROM `2022_bike_tripdata.merged_bike_tripdata`
GROUP BY member_casual;

