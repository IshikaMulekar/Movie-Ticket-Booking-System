#1. Find inactive users

SELECT u.user_id,
       u.name,
       MAX(b.booking_date) AS last_booking_date
FROM users u
JOIN booking b
ON u.user_id = b.user_id
GROUP BY u.user_id, u.name
HAVING DATEDIFF(CURDATE(), MAX(b.booking_date)) > 60;

#2. Find users spending above average

SELECT u.name,
       SUM(p.amounts) AS total_spending
FROM users u
JOIN booking b
ON u.user_id = b.user_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY u.name
HAVING SUM(p.amounts) >
(
    SELECT AVG(amounts)
    FROM payment
);


#3. Find top 5 highest spending users

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

#4. Find users with failed payments

SELECT DISTINCT u.name,
       p.transaction_status
FROM users u
JOIN booking b
ON u.user_id = b.user_id
JOIN payment p
ON b.booking_id = p.booking_id
WHERE p.transaction_status = 'Failed';

#5. Find top 5 most watched movies

SELECT m.title,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.title
ORDER BY total_bookings DESC
LIMIT 5;

#6. Find movies generating highest revenue

SELECT m.title,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title
ORDER BY total_revenue DESC;

#7. Find movie generating least revenue

SELECT m.title,
       SUM(p.amounts) AS revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.title
ORDER BY revenue ASC;

#8. Find movies with high rating and high revenue

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

#9. Find total bookings genre-wise

SELECT m.genre,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.genre;

#10. Find top revenue generating genre

SELECT m.genre,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.genre
ORDER BY total_revenue DESC;

#11. Find highest cancellation percentage

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

#12. Calculate total revenue in last 6 months

SELECT SUM(p.amounts) AS total_revenue
FROM payment p
JOIN booking b
ON p.booking_id = b.booking_id
WHERE p.transaction_status = 'Success'
AND b.booking_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


#13. Find movies with both high rating and high revenue

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
