// question 3

SELECT
    COUNT(CASE WHEN trip_distance <= 1 THEN 1 END) AS "Up to 1 mile",
    COUNT(CASE WHEN trip_distance > 1 AND trip_distance <= 3 THEN 1 END) AS "1 to 3 miles",
    COUNT(CASE WHEN trip_distance > 3 AND trip_distance <= 7 THEN 1 END) AS "3 to 7 miles",
    COUNT(CASE WHEN trip_distance > 7 AND trip_distance <= 10 THEN 1 END) AS "7 to 10 miles",
    COUNT(CASE WHEN trip_distance > 10 THEN 1 END) AS "Over 10 miles"
FROM public.green_tripdata
WHERE
    lpep_dropoff_datetime >= '2019-10-01 00:00:00'
    AND lpep_dropoff_datetime < '2019-11-01 00:00:00';
    
104,802; 198,924; 109,603; 27,678; 35,189


//question 4

SELECT
    DATE(lpep_pickup_datetime) AS pickupdate,
    MAX(trip_distance) AS longest_distance
FROM
    green_tripdata
WHERE
    DATE(lpep_pickup_datetime)  IN ('2019-10-11', '2019-10-24', '2019-10-26', '2019-10-31')
GROUP BY
    DATE(lpep_pickup_datetime)
ORDER BY
    longest_distance DESC

"2019-10-31"	515.89
"2019-10-11"	95.78
"2019-10-26"	91.56
"2019-10-24"	90.75

question 5

SELECT
	sum(total_amount) as total_amount_sum,
    CONCAT(z."Borough", '/', z."Zone") AS "pickup_loc"
FROM green_tripdata t 
JOIN taxi_zone_lookup z
ON t."PULocationID" = z."LocationID"
WHERE
    DATE(lpep_pickup_datetime) = '2019-10-18'
GROUP BY
 pickup_loc
HAVING
    SUM(total_amount) > 13000
ORDER BY
    total_amount_sum DESC;

18686.68000000008	"Manhattan/East Harlem North"
16797.260000000068	"Manhattan/East Harlem South"
13029.790000000035	"Manhattan/Morningside Heights"

East Harlem North, East Harlem South, Morningside Heights

Largest tip 

SELECT
	 t.total_amount,
    z."Borough",  
    z."Zone"
FROM 
    green_tripdata t 
Left JOIN 
    taxi_zone_lookup z
ON 
    t."DOLocationID" = z."LocationID"
ORDER BY 
    t.tip_amount DESC
Limit 4	

187.57	"Manhattan"	"West Chelsea/Hudson Yards"
124.3	"EWR"	"Newark Airport"
124.3	"Queens"	"JFK Airport"
138.71	"Queens"	"Kew Gardens Hills"  