/*Script File Name: sp_DeleteTicket.sql
Programmer Name: Lwandile Mabaso
Date: 11 November 2024
Description:This script file creates a stored procedure called sp_DeleteTicket in the flightagency database.
The procedure is designed to delete a ticket record from the ticketing system, with specific conditions that must be met before deletion is allowed. 
A ticket can only be deleted if it has already been used or if its date has expired.*/

USE flightagency; 
GO

-- This stored procedure will be used to delete a ticket if it has been used or expired.
CREATE PROCEDURE sp_DeleteTicket
    @bookingID INT
AS
BEGIN
    
    IF EXISTS (
        SELECT 1 
        FROM bookings 
        WHERE bookingID = @bookingID 
          AND bookingDate < GETDATE()
    )
    BEGIN
        
        DELETE FROM bookings
        WHERE bookingID = @bookingID;
        
        -- Confirm deletion to the user
        PRINT 'Ticket has been successfully deleted.';
    END
    ELSE
    BEGIN
        -- Notify the user that the ticket cannot be deleted
        PRINT 'Ticket cannot be deleted. It has not expired.';
    END
END;
GO

EXEC sp_DeleteTicket @bookingID = 5;
GO

