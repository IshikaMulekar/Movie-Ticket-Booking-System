## 1. Auto Update Booking Status After Successful Payment

DELIMITER //
CREATE TRIGGER trg_update_booking_status
AFTER INSERT ON payment
FOR EACH ROW
BEGIN
    IF NEW.transaction_status = 'Success' THEN
        UPDATE booking
        SET booking_status = 'Completed'
        WHERE booking_id = NEW.booking_id;
    END IF;
END //
DELIMITER ;

## 2. Prevent Negative Ticket Price
DELIMITER //
CREATE TRIGGER trg_check_ticket_price
BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
    IF NEW.ticket_price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ticket Price Cannot Be Negative';
    END IF;
END //
DELIMITER ;

## 3. Auto Set Review Date
DELIMITER //
CREATE TRIGGER trg_review_date
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
    SET NEW.review_date = CURDATE();
END //
DELIMITER ;

## 4. Prevent Invalid Ratings
DELIMITER //
CREATE TRIGGER trg_check_rating
BEFORE INSERT ON review
FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating must be between 1 and 10';
    END IF;
END //
DELIMITER ;

## 5. Prevent Booking More Than Available Seats
DELIMITER //
CREATE TRIGGER trg_check_available_seats
BEFORE INSERT ON booking
FOR EACH ROW
BEGIN
    DECLARE available INT;
    SELECT available_seats
    INTO available
    FROM shows
    WHERE show_id = NEW.show_id;

    IF NEW.seats_booked > available THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not Enough Seats Available';
    END IF;
END //
DELIMITER ;
