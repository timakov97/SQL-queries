WITH flights_duration AS (
                            SELECT flight_id,
                                   arrival_airport,
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

, ticket_price AS        (  SELECT amount, 
                                   flight_id
                              FROM ticket_flights
                         )

, airport_price_dur AS   (  SELECT arrival_airport,
                                   AVG (amount / (EXTRACT(HOUR FROM duration) * 60 +
                                   EXTRACT(MINUTE FROM duration))) AS price_duration
                              FROM ticket_price
                        INNER JOIN flights_duration
                             USING(flight_id)
                          GROUP BY arrival_airport       
                         )

SELECT arrival_airport
FROM airport_price_dur
ORDER BY price_duration DESC
LIMIT 10