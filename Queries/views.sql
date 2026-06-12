For your **07_Views.sql**, don't create just one view. Add 5–6 meaningful views based on your existing project queries.

# 07_Views.sql

## 1. Movie Revenue View

```sql
CREATE VIEW movie_revenue_view AS
SELECT m.movie_id,
       m.title,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.movie_id, m.title;
```

Usage:

```sql
SELECT * FROM movie_revenue_view;
```

---

## 2. Customer Spending View

```sql
CREATE VIEW customer_spending_view AS
SELECT u.user_id,
       u.name,
       SUM(p.amounts) AS total_spending
FROM users u
JOIN booking b
ON u.user_id = b.user_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY u.user_id, u.name;
```

Usage:

```sql
SELECT * FROM customer_spending_view;
```

---

## 3. Top Movies Booking View

```sql
CREATE VIEW movie_booking_view AS
SELECT m.movie_id,
       m.title,
       COUNT(b.booking_id) AS total_bookings
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
GROUP BY m.movie_id, m.title;
```

Usage:

```sql
SELECT * FROM movie_booking_view
ORDER BY total_bookings DESC;
```

---

## 4. Genre Revenue View

```sql
CREATE VIEW genre_revenue_view AS
SELECT m.genre,
       SUM(p.amounts) AS total_revenue
FROM movies m
JOIN booking b
ON m.movie_id = b.movie_id
JOIN payment p
ON b.booking_id = p.booking_id
GROUP BY m.genre;
```

Usage:

```sql
SELECT * FROM genre_revenue_view;
```

---

## 5. Payment Summary View

```sql
CREATE VIEW payment_summary_view AS
SELECT transaction_status,
       COUNT(*) AS total_transactions,
       SUM(amounts) AS total_amount
FROM payment
GROUP BY transaction_status;
```

Usage:

```sql
SELECT * FROM payment_summary_view;
```

---

## 6. Theatre Seat Booking View

```sql
CREATE VIEW theatre_booking_view AS
SELECT theatre_name,
       SUM(seats_booked) AS total_seats_booked
FROM booking
GROUP BY theatre_name;
```

Usage:

```sql
SELECT * FROM theatre_booking_view;
```

---

## 7. Booking Trend View

```sql
CREATE VIEW booking_trend_view AS
SELECT MONTHNAME(booking_date) AS month_name,
       COUNT(*) AS total_bookings
FROM booking
GROUP BY MONTHNAME(booking_date);
```

Usage:

```sql
SELECT * FROM booking_trend_view;
```

---

## 8. High Rated Movies View

```sql
CREATE VIEW high_rated_movies_view AS
SELECT movie_id,
       title,
       genre,
       rating
FROM movies
WHERE rating > 8;
```

Usage:

```sql
SELECT * FROM high_rated_movies_view;
```

---

### Best Practice for GitHub

Keep all 8 views in:

```text
Queries/
│
├── 07_Views.sql
```

These views cover:

* Revenue Analysis
* Customer Analysis
* Movie Analysis
* Genre Analysis
* Payment Analysis
* Theatre Analysis
* Trend Analysis
* Rating Analysis

This looks much stronger on a resume than having only a single view.
