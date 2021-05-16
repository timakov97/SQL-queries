WITH flights_duration AS (
                            SELECT flight_id,
                                   aircraft_code,
                                   actual_arrival - actual_departure AS DURATION
                              FROM flights
                             WHERE actual_arrival IS NOT NULL AND
                                   actual_departure IS NOT NULL

                         )

, duration_avg AS        (  SELECT aircraft_code, 
                                   AVG(duration) AS duration_avg
                              FROM flights_duration
                          GROUP BY aircraft_code,
                                   aircraft_code
                          ORDER BY duration_avg DESC
                         )

SELECT aircraft_code
 FROM duration_avg
LIMIT 3