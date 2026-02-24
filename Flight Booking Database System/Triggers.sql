/*Script File Name: Triggers.sql
Programmer Name: Lwandile Mabaso
Date:12 November 2024
Description:This file creates a trigger for the Flightagency*/

USE flightagency
GO 

---This trigger is designed to run automatically after a new record is added to the bookings table

CREATE TRIGGER trg_AfterBookingInsert
ON bookings
AFTER INSERT
AS
BEGIN
 
    PRINT 'A new booking has been added.';

    UPDATE flight
    SET seatsAvailable = seatsAvailable - 1
    FROM flight f
    INNER JOIN inserted i ON f.flightID = i.flightID
    WHERE f.flightID = i.flightID;
END


---This trigger is designed to run automatically after a record is deleted from the transactionMthd table.
CREATE TRIGGER trg_AfterPaymentDelete
ON transactionMthd
AFTER DELETE
AS
BEGIN
   
    PRINT 'A payment transaction has been deleted.';

    
END;
