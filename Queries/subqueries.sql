## User-Based Subqueries
#1. Find users who never booked any movie
SELECT *
FROM users
WHERE user_id NOT IN
(
    SELECT user_id
    FROM booking
);

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

## Movie-Based Subqueries

#3. Find highest rated movie
SELECT *
FROM movies
WHERE rating =
(
    SELECT MAX(rating)
    FROM movies
);

#4. Find lowest rated movie
SELECT *
FROM movies
WHERE rating =
(
    SELECT MIN(rating)
    FROM movies
);

#5. Find movies with no bookings

SELECT m.movie_id,
       m.title
FROM movies m
WHERE m.movie_id NOT IN
(
    SELECT movie_id
    FROM booking
);

## Booking-Based Subqueries
#6. Find highest booking amount

SELECT *
FROM booking
WHERE ticket_price =
(
    SELECT MAX(ticket_price)
    FROM booking
);

## Review-Based Subqueries
#7. Find users who gave highest feedback ratings

SELECT DISTINCT user_id
FROM review
WHERE rating =
(
    SELECT MAX(rating)
    FROM review
);

## Revenue-Based Subquery + Aggregate
#8. Movies with high rating and high revenue

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
