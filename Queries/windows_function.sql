## RANK()

#1. Give rank to movies by IMDB rating
SELECT movie_id,
       title AS movie_name,
       rating,
       RANK() OVER(ORDER BY rating DESC) AS movie_rank
FROM movies;

## DENSE_RANK()
#2. Dense Rank Movies
SELECT title AS movie_name,
       rating,
       DENSE_RANK() OVER(ORDER BY rating DESC) AS movie_rank
FROM movies;


##ROW_NUMBER()
SELECT title,
       rating,
       ROW_NUMBER() OVER(ORDER BY rating DESC) AS row_num
FROM movies;
#Running Revenue Total

SELECT booking_date,
       ticket_price,
       SUM(ticket_price) OVER(ORDER BY booking_date) AS running_total
FROM booking;

#Average Revenue by Movie
SELECT movie_id,
       ticket_price,
       AVG(ticket_price) OVER(PARTITION BY movie_id) AS avg_movie_revenue
FROM booking;
