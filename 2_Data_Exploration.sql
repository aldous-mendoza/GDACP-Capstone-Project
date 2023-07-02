-- Data analysis

-- Number of riders per bike type 

SELECT member_casual, rideable_type, COUNT(*) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, number_of_trips;

-- Number of trips per month

SELECT month, member_casual, COUNT(ride_id) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY month, member_casual;

-- Number of trips per day of the week

SELECT day_of_week, member_casual, COUNT(ride_id) AS number_of_trips 
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY day_of_week, member_casual;

-- Number of trips per hour

SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual,
  COUNT(ride_id) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY hour_of_day, member_casual
ORDER BY hour_of_day;

-- Average ride length per month

SELECT month, member_casual, AVG(ride_length) AS avg_ride_length
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY month, member_casual;

-- Average ride length per day of week

SELECT day_of_week, member_casual, AVG(ride_length) AS avg_ride_length
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY day_of_week, member_casual;

-- Average ride_length per hour

SELECT EXTRACT(HOUR FROM started_at) AS hour_of_day, member_casual, AVG(ride_length) AS avg_ride_length
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY hour_of_day, member_casual;

-- Starting station locations

SELECT start_station_name, member_casual,
  AVG(start_lat) AS start_lat, AVG(start_lng) AS start_lng,
  COUNT(ride_id) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY start_station_name, member_casual;

-- Ending station locations

SELECT end_station_name, member_casual,
  AVG(end_lat) AS end_lat, AVG(end_lng) AS end_lng,
  COUNT(ride_id) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
GROUP BY end_station_name, member_casual;

-- Top 5 starting station locations 

SELECT start_station_name, 
  COUNT(ride_id) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
WHERE member_casual = 'member'
GROUP BY start_station_name
ORDER BY number_of_trips DESC
LIMIT 5

-- Top 5 ending station locations

SELECT end_station_name, 
  COUNT(ride_id) AS number_of_trips
FROM `2022_bike_tripdata.cleaned_merged_data`
WHERE member_casual = 'member'
GROUP BY end_station_name
ORDER BY number_of_trips DESC
LIMIT 5


