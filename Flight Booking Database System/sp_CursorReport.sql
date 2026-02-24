/*Script File Name: sp_CursorReport_Procedure.sql
Programmer Name: Lwandile Mabaso
Date: 12 November 2024
Short Description:This script creates a stored procedure sp_Report that utilizes a cursor to generate a report. 
The procedure fetches data from specific tables in the database and processes it row by row using the cursor.
It then outputs the result for further analysis or reporting purposes.*/

USE flightagency
GO



-- Create the stored procedure sp_Report
CREATE PROCEDURE sp_CursorReport
    @flightID INT
AS
BEGIN
    -- Validate that the flightID exists
    IF NOT EXISTS (SELECT 1 
	               FROM flight WHERE flightID = @flightID)
    BEGIN
        PRINT 'Error: The specified flight ID does not exist.'
        RETURN
    END

    -- Declare variables to hold values during iteration
    DECLARE @bookID INT,
            @customerName VARCHAR(100),
            @bookingDate DATE,
            @flightNumber VARCHAR(10),
            @journeyType VARCHAR(20),
            @price DECIMAL(10, 2),
            @counter INT = 1;  -- Counter for the No. column

    -- Retrieve general booking info for the report header
    SELECT 
        @bookID = bookings.bookingID,
        @bookingDate = bookings.bookingDate,
        @flightNumber = flight.flightNumber,
        @journeyType = CASE WHEN flight.destination IS NOT NULL THEN 'One way' ELSE 'Round trip' END
    FROM bookings
          JOIN flight ON bookings.flightID = flight.flightID
    WHERE bookings.flightID = @flightID;

    -- Print the report header
    PRINT 'FLIGHT BOOKING REPORT:';
    PRINT '';
    PRINT 'Book ID: ' + CAST(@bookID AS VARCHAR);
    PRINT 'customer name: [Date: ' + CONVERT(VARCHAR, @bookingDate, 107) + ']';
    PRINT 'flight number: ' + @flightNumber + '   Journey: ' + @journeyType;
    PRINT 'No. Customer Name       Flight Price';
    PRINT ''

    -- Declare a cursor to fetch each customer's name and payment details
    DECLARE customer_cursor CURSOR FOR
        SELECT customers.firstName + ' ' + customers.lastName AS fullName,
               transactionMthd.amountPaid
        FROM bookings
             JOIN customers ON bookings.customerID = customers.customerID
             JOIN transactionMthd ON bookings.bookingID = transactionMthd.booking_ID
        WHERE bookings.flightID = @flightID;

    
    OPEN customer_cursor


    FETCH NEXT FROM customer_cursor 
	INTO @customerName, @price

    -- Loop through each customer and print their details
    WHILE @@FETCH_STATUS = 0
    BEGIN  

         SET @counter = @counter + 1;
        -- Print the customer number, name, and price in the required format
        PRINT CAST(@counter AS VARCHAR) + '. ' + @customerName + '    R' + CAST(@price AS VARCHAR)

        
         FETCH NEXT FROM customer_cursor 
		 INTO @customerName, @price
    END

    -- Close and deallocate the cursor
    CLOSE customer_cursor
    DEALLOCATE customer_cursor
END;
GO

EXEC sp_CursorReport @flightID = 3
GO

