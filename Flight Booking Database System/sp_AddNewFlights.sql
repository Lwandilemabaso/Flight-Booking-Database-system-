/*Script File Name: sp_AddNewFlights.sql
Programmer Name: Lwandile Mabaso
Date: 11 November 2024
Description:This script file creates a stored procedure called sp_AddNewFlights in the flightagency database. 
The procedure enables efficient insertion of new flight records into the flight table by taking key flight details as input parameters,
such as the flight number, departure date, arrival date, destination, and the number of seats available. 
*/




USE flightagency 
GO

-- This  stored procedure will used to add new flights
CREATE PROCEDURE sp_AddNewFlights
    @flightNumber VARCHAR(10),
    @departureDate DATETIME,
    @arrivalDate DATETIME,
    @destination VARCHAR(100),
    @seatsAvailable INT
AS
BEGIN
    --
    INSERT INTO flight (flightNumber, departureDate, arrivalDate, destination, seatsAvailable)
    VALUES (@flightNumber, @departureDate, @arrivalDate, @destination, @seatsAvailable);
    
    -- Notify the user that the new flight has been added
    PRINT 'New flight has been successfully added.';
END;
GO
EXEC sp_AddNewFlights 
    @flightNumber= 'FL1234', 
    @departureDate = '2024-12-01 08:00:00', 
    @arrivalDate = '2024-12-01 12:00:00', 
    @destination = 'Cape Town', 
    @seatsAvailable = 100;
GO
