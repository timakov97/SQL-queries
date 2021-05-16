WITH delays AS           (
                            SELECT flight_id,
                                   (actual_departure - scheduled_departure) +
                                   (actual_arrival - scheduled_arrival) AS delay
                              FROM flights
                             WHERE actual_arrival IS NOT NULL AND
                                   actual_departure IS NOT NULL AND
                                   scheduled_arrival IS NOT NULL AND
                                   scheduled_departure IS NOT NULL
                          ORDER BY delay DESC
                             LIMIT 1
                         )

, ticket_passenger AS    (  SELECT passenger_name,
                                   ticket_no
                              FROM tickets
                         )    

, ticket_seat AS         (  SELECT seat_no,
                                   ticket_no
                              FROM boarding_passes
                        INNER JOIN delays
                             USING(flight_id)
                         ) 

, passenger_seat AS      (  SELECT passenger_name,
                                   seat_no,
                                   ticket_no
                              FROM ticket_passenger
                        INNER JOIN ticket_seat
                             USING(ticket_no)
                         )                                                        

, ticket_flight AS       (  SELECT ticket_no,
                                   flight_id
                              FROM ticket_flights
                         ) 

, flight_passenger AS    (  SELECT passenger_name,
                                   flight_id
                              FROM ticket_flight
                        INNER JOIN ticket_passenger
                             USING(ticket_no)
                        INNER JOIN passenger_seat
                             USING(passenger_name)


                         )                                                                                                                             

SELECT passenger_name
FROM passenger_seat
WHERE seat_no LIKE '2_E' OR seat_no LIKE '2_B'