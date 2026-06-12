## 1. Get Movie Revenue

DELIMITER //
CREATE PROCEDURE GetMovieRevenue()
BEGIN
    SELECT m.title,
           SUM(p.amounts) AS total_revenue
    FROM movies m
    JOIN booking b
    ON m.movie_id = b.movie_id
    JOIN payment p
    ON b.booking_id = p.booking_id
    GROUP BY m.title
    ORDER BY total_revenue DESC;
END 
DELIMITER ;

## 2. Get Top 5 Most Watched Movies
DELIMITER //

CREATE PROCEDURE GetTopMovies()
BEGIN
    SELECT m.title,
           COUNT(b.booking_id) AS total_bookings
    FROM movies m
    JOIN booking b
    ON m.movie_id = b.movie_id
    GROUP BY m.title
    ORDER BY total_bookings DESC
    LIMIT 5;
END //
DELIMITER ;

## 3. Get Genre Revenue
DELIMITER //
CREATE PROCEDURE GetGenreRevenue()
BEGIN
    SELECT m.genre,
           SUM(p.amounts) AS total_revenue
    FROM movies m
    JOIN booking b
    ON m.movie_id = b.movie_id
    JOIN payment p
    ON b.booking_id = p.booking_id
    GROUP BY m.genre
    ORDER BY total_revenue DESC;
END //
DELIMITER ;

## 4. Get Booking Trends
DELIMITER //
CREATE PROCEDURE GetMonthlyBookings()
BEGIN
    SELECT MONTHNAME(booking_date) AS month_name,
           COUNT(*) AS total_bookings
    FROM booking
    GROUP BY MONTHNAME(booking_date);
END //
DELIMITER ;

## 5. Get Payment Summary
DELIMITER //
CREATE PROCEDURE GetPaymentSummary()
BEGIN
    SELECT transaction_status,
           COUNT(*) AS total_transactions,
           SUM(amounts) AS total_amount
    FROM payment
    GROUP BY transaction_status;
END //
DELIMITER ;

## 6. Get Theatre Seat Utilization
DELIMITER //
CREATE PROCEDURE GetTheatreSeatUtilization()
BEGIN
    SELECT theatre_name,
           SUM(seats_booked) AS total_seats_booked
    FROM booking
    GROUP BY theatre_name
    ORDER BY total_seats_booked DESC;
END //
DELIMITER ;

## 7. Parameterized Procedure – Movie Details
DELIMITER //
CREATE PROCEDURE GetMovieDetails(IN movieid INT)
BEGIN
    SELECT *
    FROM movies
    WHERE movie_id = movieid;
END //
DELIMITER ;

## 8. Parameterized Procedure – User Booking History
DELIMITER //
CREATE PROCEDURE GetUserBookings(IN userid INT)
BEGIN
    SELECT *
    FROM booking
    WHERE user_id = userid;
END //
DELIMITER ;
