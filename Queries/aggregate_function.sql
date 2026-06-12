#Aggregate_Functions.sql

## COUNT() Functions
#1. Find repeat users
SELECT user_id,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY user_id
HAVING COUNT(*) > 1;
#2. Find users who only booked one movie

SELECT user_id,
       COUNT(*) AS total_movies
FROM booking
GROUP BY user_id
HAVING COUNT(*) = 1;

#3. Top 5 most watched movies

SELECT m.title,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.title
ORDER BY total_bookings DESC
LIMIT 5;

#4. Movie with maximum completed bookings

SELECT movie_id,
       COUNT(*) AS completed_bookings
FROM booking
WHERE booking_status = 'Completed'
GROUP BY movie_id
ORDER BY completed_bookings DESC;

#5. Total bookings genre-wise

SELECT m.genre,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.genre;

#6. Count cancelled bookings

SELECT COUNT(*) AS total_cancelled_bookings
FROM booking
WHERE booking_status = 'Cancelled';

#7. Total bookings month-wise

SELECT MONTHNAME(booking_date) AS month_name,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY month_name;

#8. Busiest booking day

SELECT DAYNAME(booking_date) AS day_name,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY day_name
ORDER BY total_bookings DESC;

#9. Peak show timings

SELECT show_time,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY show_time
ORDER BY total_bookings DESC;

#10. Shows with low bookings

SELECT show_id,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY show_id
HAVING COUNT(*) < 5;

#11. Users who watched same show multiple times

SELECT user_id,
       show_id,
       COUNT(*) AS watch_count
FROM booking
GROUP BY user_id, show_id
HAVING COUNT(*) > 1;

#12. Screens with highest shows
SELECT screen_id,
       COUNT(show_id) AS total_shows
FROM shows
GROUP BY screen_id
ORDER BY total_shows DESC;

#13. Successful vs Failed Payments

SELECT transaction_status,
       COUNT(*) AS total_transactions,
       SUM(amounts) AS total_amount
FROM payment
GROUP BY transaction_status;

#14. Most Preferred Payment Method

SELECT payment_method,
       COUNT(*) AS total_transactions
FROM payment
GROUP BY payment_method
ORDER BY total_transactions DESC;

# SUM() Functions
#15. Users spending above average

SELECT u.name,
       SUM(p.amounts) AS total_spending
FROM users u
JOIN booking b
ON u.user_id = b.user_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY u.name;

#16. Top 5 highest spending users
SELECT u.name,
       SUM(p.amounts) AS total_spending
FROM users u
JOIN booking b
ON u.user_id = b.user_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY u.name
ORDER BY total_spending DESC
LIMIT 5;

#17. Movies generating highest revenue

SELECT m.title,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title
ORDER BY total_revenue DESC;

#18. Movie generating least revenue

SELECT m.title,
       SUM(p.amounts) AS revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title
ORDER BY revenue ASC;

#19. Top revenue generating genre

SELECT m.genre,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.genre
ORDER BY total_revenue DESC;

#20. Weekend vs Weekday Revenue

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

#21. Total revenue in last 6 months
SELECT SUM(p.amounts) AS total_revenue
FROM payment p
JOIN booking b
ON p.booking_id = b.booking_id
WHERE p.transaction_status = 'Success'
AND b.booking_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

#22. Total seats booked theatre-wise

SELECT theatre_name,
       SUM(seats_booked) AS total_seats_booked
FROM booking
GROUP BY theatre_name;

# AVG() Functions

#23. Average movie duration by genre
SELECT genre,
       AVG(duration) AS avg_duration
FROM movies
GROUP BY genre;

#24. Average ticket price
SELECT AVG(ticket_price) AS avg_ticket_price FROM booking;

#25. Average seats booked per booking
SELECT AVG(seats_booked) AS avg_seats FROM booking;

# MAX() Functions

#26. Highest rated movie

SELECT *
FROM movies
WHERE rating =
(
SELECT MAX(rating)
FROM movies
);

#27. Highest booking amount

SELECT *
FROM booking
WHERE ticket_price =
(
SELECT MAX(ticket_price)
FROM booking
);

#28. Users who gave highest feedback ratings
SELECT DISTINCT user_id
FROM review
WHERE rating =
(
SELECT MAX(rating)
FROM review
);

# MIN() Functions
#29. Lowest rated movie

SELECT *
FROM movies
WHERE rating =
(
SELECT MIN(rating)
FROM movies
);
