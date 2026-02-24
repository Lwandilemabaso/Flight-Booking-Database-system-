/*Script File Name: sp_Report_Iteration.sql
Programmer Name: Lwandile Mabaso
Date: 12 Novemeber 2024
Description:
This script creates a stored procedure named sp_Report that is used to generate report data based on specific criteria. 
The procedure iterates through the data and performs the necessary calculations or formatting to produce the report output.
The stored procedure is designed to handle various input parameters and return the report in a structured format, making it easy to analyze and present the results.*/

USE flightagency;  
GO

CREATE PROCEDURE sp_IterationReport
    @flightID INT
AS
BEGIN
    -- Validate input to ensure the flightID exists in the database
    IF NOT EXISTS (SELECT 1 
	              FROM flight 
				  WHERE flightID = @flightID)
    BEGIN
        PRINT 'Error: The specified flightID does not exist.';
        RETURN;
    END

    DECLARE @bookingID INT;
    DECLARE @flightNumber VARCHAR(10);
    DECLARE @bookingDate DATETIME;
    DECLARE @journeyType VARCHAR(20);
    DECLARE @counter INT = 1;

    -- Retrieve flight booking and flight details
    SELECT @bookingID = b.bookingID,
           @flightNumber = f.flightNumber,
           @bookingDate = b.bookingDate,
           @journeyType = 'One way' 
    FROM bookings AS b
          JOIN flight AS f ON b.flightID = f.flightID
    WHERE f.flightID = @flightID

    -- Print the header information
    PRINT 'FLIGHT BOOKING REPORT:';
    PRINT ''
    PRINT 'Book ID: ' + CAST(@bookingID AS VARCHAR(10));
    PRINT 'customer name: [' + 'Date: ' + CONVERT(VARCHAR(20), @bookingDate, 100) + ']'
	PRINT 'flight number: ' + @flightNumber + '   Journey: ' + @journeyType;
    PRINT 'No. Customer Name       Flight Price'
    PRINT ''

    -- Use a cursor to iterate over each customer on this flight and print their details
    DECLARE customer_cursor CURSOR FOR
    SELECT 
        c.firstName + ' ' + c.lastName AS CustomerName,
        tm.amountPaid
    FROM bookings AS b
          JOIN customers AS c ON b.customerID = c.customerID
          JOIN transactionMthd AS tm ON tm.booking_ID = b.bookingID
    WHERE b.flightID = @flightID;

    -- Declare variables to store data fetched from the cursor
    DECLARE @customerName VARCHAR(60)
    DECLARE @flightPrice DECIMAL(10, 2)

    OPEN customer_cursor
    FETCH NEXT FROM customer_cursor 
	INTO @customerName, @flightPrice

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Print each customer with their number, name, and flight price
        PRINT CAST(@counter AS VARCHAR(5)) + '. ' + @customerName + SPACE(20 - LEN(@customerName)) + 'R' + CAST(@flightPrice AS VARCHAR(10))
        SET @counter = @counter + 1

        FETCH NEXT FROM customer_cursor 
		INTO @customerName, @flightPrice
    END

    CLOSE customer_cursor
    DEALLOCATE customer_cursor
END
GO

---Testing our newly created procedure 
EXEC sp_IterationReport @flightID = 1
GO
