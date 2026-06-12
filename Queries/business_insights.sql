#1. Top 5 Most Watched Movies
SELECT m.title,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.title
ORDER BY total_bookings DESC
LIMIT 5;

#2. Movie with Maximum Completed Bookings

SELECT movie_id,
       COUNT(*) AS completed_bookings
FROM booking
WHERE booking_status = 'Completed'
GROUP BY movie_id
ORDER BY completed_bookings DESC;

#3. Highest Revenue Generating Movies
SELECT m.title,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title
ORDER BY total_revenue DESC;

#4. Least Revenue Generating Movies
SELECT m.title,
       SUM(p.amounts) AS revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title
ORDER BY revenue ASC;

#5. Movies with High Rating and High Revenue
SELECT m.title,
       m.rating,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title, m.rating
HAVING m.rating > 8
ORDER BY total_revenue DESC;

#6. Total Bookings Genre Wise
SELECT m.genre,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.genre;

#7. Top Revenue Generating Genre
SELECT m.genre,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.genre
ORDER BY total_revenue DESC;

#8. Cancellation Percentage by Movie
SELECT m.title,
       COUNT(CASE
             WHEN b.booking_status = 'Cancelled'
             THEN 1
       END) AS cancelled_bookings,
       COUNT(*) AS total_bookings,
       ROUND(
             COUNT(CASE
                   WHEN b.booking_status = 'Cancelled'
                   THEN 1
             END) * 100.0 / COUNT(*),2
       ) AS cancellation_percentage
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.title
ORDER BY cancellation_percentage DESC;

#9. Monthly Booking Trends
SELECT MONTHNAME(booking_date) AS month_name,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY month_name;

#10. Busiest Booking Day
SELECT DAYNAME(booking_date) AS day_name,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY day_name
ORDER BY total_bookings DESC;

#11. Weekend vs Weekday Analysis
SELECT
CASE
WHEN DAYNAME(booking_date) IN ('Saturday','Sunday')
THEN 'Weekend'
ELSE 'Weekday'
END AS booking_type,
COUNT(*) AS total_bookings,
SUM(ticket_price) AS total_revenue
FROM booking
GROUP BY booking_type;

#12. Peak Show Timings

SELECT show_time,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY show_time
ORDER BY total_bookings DESC;

#13. Shows with Low Bookings
SELECT show_id,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY show_id
HAVING COUNT(*) < 5;

#14. Screens with Highest Shows
SELECT screen_id,
       COUNT(show_id) AS total_shows
FROM shows
GROUP BY screen_id
ORDER BY total_shows DESC;

#15. Successful vs Failed Payments
SELECT transaction_status,
       COUNT(*) AS total_transactions,
       SUM(amounts) AS total_amount
FROM payment
GROUP BY transaction_status;

#16. Most Preferred Payment Method
SELECT payment_method,
       COUNT(*) AS total_transactions
FROM payment
GROUP BY payment_method
ORDER BY total_transactions DESC;

#17. Total Revenue in Last 6 Months
SELECT SUM(p.amounts) AS total_revenue
FROM payment p
JOIN booking b
ON p.booking_id = b.booking_id
WHERE p.transaction_status = 'Success'
AND b.booking_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

#18. Total Seats Booked Theatre Wise
SELECT theatre_name,
       SUM(seats_booked) AS total_seats_booked
FROM booking
GROUP BY theatre_name;
