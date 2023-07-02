-- Data Cleaning

CREATE TABLE `2022_bike_tripdata.cleaned_merged_data` AS (
  SELECT
    a.ride_id, rideable_type, started_at, ended_at, 
    ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUE'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THU'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'
    END AS day_of_week, 
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
    END AS month,
    start_station_name, end_station_name,
    start_lat, start_lng, end_lat, end_lng, 
    member_casual
  FROM `2022_bike_tripdata.merged_bike_tripdata` AS a
  JOIN (
    SELECT ride_id, 
      TIMESTAMP_DIFF(ended_at, started_at, SECOND) AS ride_length
    FROM `2022_bike_tripdata.merged_bike_tripdata`
    ) AS b
  ON a.ride_id = b.ride_id
  WHERE
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 60 AND ride_length < (24 * 60 * 60)
  );

-- Counting the number of rows left after cleaning

SELECT COUNT(ride_id) AS number_of_rows
FROM `2022_bike_tripdata.cleaned_merged_data`;
/*
Number of rows left = 4,291,805
Total number of rows removed  
  5,667,717 - 4,291,805 = 1,375,912 
*/
