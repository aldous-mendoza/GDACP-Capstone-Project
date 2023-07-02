# GDACP-Capstone-Project

## Introduction

I have spent the last few months completing the Google Data Analytics Professional Certificate, learning about using various tools, including spreadsheets, SQL, Tableau, and R, in gathering insights from big amounts of data. This capstone project demonstrates all the technical skills I acquired in the program and my understanding of the data analysis process – Ask, Prepare, Process, Analyze, Share, and Act. I will be assuming the position of a Jr. Data analyst in the marketing analytics team to solve a problem for a company called Cyclistic.

## Background

Cyclistic is a bike-sharing company in Chicago that was founded in 2016. They have a fleet of over 5800 bicycles and more than 600 docking stations. In the past, Cyclistic’s marketing approach was to increase public awareness and gain customers. They achieved it through their flexible payment options, including single-ride, full-day, and annual subscriptions. Currently, they have categorized their consumers into two segments. Those who purchase single-ride or full-day passes are called **casual riders**, whereas those who pay annual memberships are called **annual members**. 

## Ask
Currently, the company’s finance analysts found that annual members are much more profitable than casual riders. As such, the marketing director set a goal to convert casual riders into annual members. To answer this business task, I was tasked to answer the question, “How do annual members and casual riders use Cyclistic bikes differently?” 

## Prepare
In order to address this question, I will conduct an in-depth analysis of historical bike trip data from Cyclistic from January 2022 to December 2022. It can be downloaded from [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) and Motivate International Inc. made it accessible under this [license](https://ride.divvybikes.com/data-license-agreement). Due to privacy concerns, all personal customer information has been removed.

## Process
Due to the large amount of data provided, I used SQL on BigQuery platform.
### Data Merging
See SQL queries here.

1.	 Uploaded the 12 CSV files as individual tables into a dataset named ‘2022_bike_tripdata’
2.	 Merged all the 12 monthly tables into a single table and named it ‘2022_merged_bike_tripdata’. It contained 5,667,717 rows of data for the entire year of 2022.

### Data Exploration
See SQL queries here.
Before cleaning, I checked for inconsistencies in the merged table by running queries on each column.

Findings:
1.	The data contained 13 columns, with ‘ride_id’ being the **primary key**. Below is the table that shows the column names and their corresponding data types. 
[image]
2.	As shown in the following table, null values were found in the columns: _start_station_name, start_station_id, end_station_name, end_station_id, end_lat, and end_lng_. The similarities in values could be attributed to them being directly connected information (eg, station name and id refer to the same station).
[image]
3.	There are no duplicate rows in the data after checking a column without null values, which was ride_id. 
4.	**ride_id:** is the primary key. After checking the length of the ids, it did not contain invalid values as all of them had 16 characters.
5.	**rideable_type:** there are three types of bikes:  classic, electric, and docked. However, it could be assumed that the docked bikes are either classic or electric
[image]
6.	**started_at** and **ended _at:** trip start and end times were formatted in YYYY-MM-DD hh:mm: ss UTC. Calculating the trip durations in a new column called ‘ride_length’ revealed that 122283 trips had a duration of less than one minute and that 5630 trips had a duration longer than a day. This will be removed during the cleaning process, as this could mean that the bike was under maintenance or was stolen. Later on, day_of_week and month columns can be added for deeper analysis.
7. 	**start_station_name** and **start_station_id**: both are missing 833064 rows that will be removed during cleaning.
8. 	**start_station_name** and **end_station_id**: both are missing 892742 rows that will be removed during cleaning.
9. 	**end_lat** and **end_lng**: both are missing 5858 rows that will be removed during cleaning.
10.	 **member_casual**: refers to the two consumer segments: member (annual members) and casual (casual riders).
[image]
11.	Redundant columns that do not add any value to the analysis will be removed. This includes the **start_station_id** and **end_station_id**.

### Data Cleaning
See SQL queries here.
1.	Removed all rows with missing values
2.	Removed trips with less than one-minute durations and greater than 24 hours duration
3.	Removed redundant columns: start_station_id and end_station_id
4.	Removed rows totaled 1,375,912 rows
5.	Added three columns: ride_length, day_of_week, and month

### Analyze and Share

After cleaning the data, I analyzed it to answer the question, “How do annual members and casual riders use Cyclistic bikes differently?” To do this, I used SQL to organize the data and create relevant tables for analysis that I could use in Tableau. Access them here: SQL queries, [Tableau dashboard](https://public.tableau.com/app/profile/john.mendoza6408/viz/GDAPC-CapstoneDataViz/PreferencesonBikeTypein2022)

Firstly, the following bar chart compares the preferred bike types between annual members and casual riders.
[image]

Both consumer segments prefer classic bikes the most, but casual riders displayed a relatively higher proportion of electric bike usage compared to classic bikes in contrast to annual members (at 39.39% vs. 34.30%, respectively). The chart reveals that docked bikes are an outlier in terms of the number of trips and only having casual riders. This could mean that docked bikes could either be classic or electric bikes that were mislabeled for being docked. However, this hypothesis could not be proved due to the lack of identifying information. Overall, the annual members constituted most of the total trips, amounting to 59.68%, whereas casual riders represented 40.32% of the rides.

Secondly, a summary of the total bike trips in 2022 per month, day, and hour is shown below, revealing distinct patterns in the biking preferences of casual and annual members.
[image]

In terms of monthly trip patterns, both casual riders and members demonstrate similar trends, characterized by a higher number of trips during the spring (March to May) and summer (June to Aug) months and a decline during winter (Dec to Feb), which could be attributed to worse weather conditions. However, the decline in casual riders starting in autumn (Sep to Nov) is relatively steeper than for annual members. 

Upon comparing the days of the week, an interesting pattern emerges in the travel behavior of casual riders and members. Casual riders tend to undertake more journeys during the weekends, while members exhibit a decline in activity over the weekend compared to the other days of the week.

Two prominent peaks in the number of trips taken by annual members can be observed throughout the day. The first peak occurs during the early morning hours, specifically between 6 am and 8 am, while the second peak is observed in the evening from approximately 4 pm to 7 pm. In contrast, the number of trips by casual riders consistently increases throughout the day until evening, after which it gradually decreases.

Based on these observations, we can infer that members are likely utilizing the bikes for daily commuting to and from work on weekdays. In contrast, casual riders show a more consistent pattern of using the bikes throughout the day and displaying a higher frequency of trips during weekends, indicative of leisurely activities. Notably, both groups exhibit heightened activity during the summer and spring seasons.

To further investigate these patterns, I analyzed the average bike trips per month, day, and hour.
[image]

Interestingly, casual riders generally have longer average trip durations compared to members. While the average ride length remains consistent for annual members throughout the year, day, and hour, there are variations in the duration of rides for casual riders. Specifically, casual riders cover travel longer during the spring and summer seasons, on weekends, and between 10 am and 2 pm. Conversely, they tend to have shorter trips between 5 am and 8 am.

These findings suggest that casual riders, who commute less frequently than members, engage in longer trips on weekends and during daytime hours outside of typical commuting times, particularly in the spring and summer. This pattern indicates a possible inclination towards leisure purposes rather than commuting.

To gain further insights into the distinctions between casual riders and annual, I analyzed the bike trips by their starting and ending station stations. I applied filters to show only the stations with the highest number of trips.
[image]

Casual riders often initiate their bike trips from stations near touristy areas such as parks, museums, and beaches. On the other hand, annual members tend to start their journeys from stations in close proximity to business districts, residential areas, universities, and other public amenities.
[image]

As shown above, a consistent pattern where casual riders tend to end up in stations close to parks and waterfront areas, while annual members show a preference for stations located in commercial districts. Interestingly, the top five stations visited by casual riders are the same for both starting and ending points. These stations, namely Streeter Dr & Grand Ave (the pier), Millennium Park, Theater on the Lake, and Shedd Aquarium, are prominent tourist attractions and recreational spots. In contrast, none of these stations appear in the top five most frequented stations by annual members, suggesting that recreational activities and sightseeing are not of significant importance to them.

Top 5 Starting and Endings Stations for Casual Riders
[image]

Top 5 Starting and Endings Stations for Annual Members
[image]

Summary:

| **Casual Riders**            | **Annual Members**            |
|---------------------------------------------------------------|
| Bike for leisure purposes     | Bike for commuting purposes   |
|Spend time biking approximately two times longer than annual members but less frequently | Spend time biking approximately half longer than casual riders but more frequently |
| Travels more during weekends than weekdays | Travel more during weekdays than weekends |
| Go to touristy areas like parks and waterfronts | Go to residential, business, and school districts |
| Prefer biking during spring and summer | Prefer biking during spring and summer |

## Act

With a clear understanding of the distinctions between casual riders and annual members, the marketing department can now start its efforts to convert casual members into annual members. From the findings of the analysis, I conclude the following and offer relevant recommendations:
1.	 Introduce new subscription plans that are weekend or season specific. This will cater to both tourists that have no use for annual memberships and Chicago residents who only bike during specific times.
2. 	Offer a first-year annual membership discount to existing casual members. This could be the hook that will cause them to change and stay as an annual member.
3.	 Run advertising campaigns during the summer months, when casual ridership is highest, and set up informational booths near popular starting and ending stations to attract attention.
