WITH aircrafts_seats AS (
                            SELECT aircraft_code,
                                   COUNT(seat_no) AS aircraft_seats_total
                              FROM aircrafts
                        INNER JOIN seats
                             USING(aircraft_code)
                          GROUP BY aircraft_code
                        )

, flights_aircrafts AS  (  
                            SELECT flight_id,
                                   aircraft_code
                              FROM flights
                        )  

, tickets_flights AS    ( 
                            SELECT ticket_no, 
                                   flight_id
                              FROM ticket_flights
                        )

, flight_seats_taken AS ( 
                            SELECT COUNT (ticket_no) AS seats_taken, 
                                   flight_id
                              FROM tickets_flights
                        INNER JOIN flights_aircrafts
                             USING(flight_id)
                          GROUP BY flight_id
                        )  

, flight_seats_total AS ( 
                            SELECT flight_id, 
                                   aircraft_seats_total AS seats_total
                              FROM flights_aircrafts
                        INNER JOIN aircrafts_seats
                             USING(aircraft_code)

                        )

, seats_both AS         ( 
                            SELECT *
                              FROM flight_seats_total
                        INNER JOIN flight_seats_taken
                             USING(flight_id)
                        )


  SELECT AVG(seats_total - seats_taken)
    FROM seats_both