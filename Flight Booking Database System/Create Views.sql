/*Script File Name: Create View.sql
Programmer: Lwandile Mabaso
Date: 11 November 2024 
Description:The script file for creating views in the flightagency database
defines virtual tables to simplify data retrieval and present information from multiple tables in a structured format. 
Each view has a specific purpose, designed to meet different reporting and data analysis needs within the system.
*/

USE flightagency
GO

CREATE VIEW vw_flight 
AS
     SELECT f.flightID, f.flightNumber,f.departureDate,f.arrivalDate, f.destination, f.seatsAvailable,tm.amountPaid AS PricePerReservation
     FROM flight f
     LEFT JOIN transactionMthd tm 
	 ON f.flightID = tm.booking_ID
GO
---Testing view
SELECT * FROM vw_Flight;
GO

CREATE VIEW vw_AffordableFlight 
AS
     SELECT TOP 3 f.flightID,f.flightNumber, f.departureDate,f.destination, tm.amountPaid AS Price
     FROM  flight f
     JOIN transactionMthd tm 
	 ON f.flightID = tm.booking_ID
WHERE 
    tm.amountPaid IS NOT NULL
ORDER BY 
    tm.amountPaid ASC
GO
---Testing view
SELECT * FROM vw_AffordableFlight
GO


CREATE VIEW vw_seniorUsers
AS
   SELECT c.customerID, c.firstName,c.lastName,c.email,c.dateOfBirth,
    DATEDIFF(YEAR, c.dateOfBirth, GETDATE()) AS age
FROM 
    customers AS c
WHERE 
    DATEDIFF(YEAR, c.dateOfBirth, GETDATE()) >= 60
GO
---Testing view
SELECT * FROM vw_SeniorUsers
GO

CREATE VIEW vw_OnboardCustomers
AS
SELECT   c.customerID,c.firstName, c.lastName, COUNT(b.bookingID) AS totalClassesAttended
FROM 
    customers AS c
JOIN 
    bookings AS b ON c.customerID = b.customerID
GROUP BY 
    c.customerID,
    c.firstName,
    c.lastName;
GO
---Testing our view 
SELECT * FROM vw_OnboardCustomers
GO





