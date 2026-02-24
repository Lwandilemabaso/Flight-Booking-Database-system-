/*
FileName:Sp_UpdateFlyingTimes.sql
Programmer Name: Lwandile Mabaso
Date:11 Novemebr 2024
Description:
This script file creates a stored procedure called sp_UpdateFlyingTimes in the flightagency database. 
The procedure updates the flying times for existing flights in response to customer demand, allowing
 the modification of both the departure and arrival dates for a specified flight.It accepts the flight ID,
 new departure time, and new arrival time as input parameters and updates the corresponding record in the flight table.*/

 USE flightagency; 
GO

--  The stored procedure will be used to update flying times
CREATE PROCEDURE sp_UpdateFlyingTimes
    @flightID INT,
    @newDepartureDate DATETIME,
    @newArrivalDate DATETIME
AS
BEGIN
    
    UPDATE flight
    SET 
        departureDate = @newDepartureDate,
        arrivalDate = @newArrivalDate
    WHERE 
        flightID = @flightID;

    
END;
GO
 
 EXEC sp_UpdateFlyingTimes 
    @flightID = 1, 
    @newDepartureDate = '2024-12-15 14:00:00', 
    @newArrivalDate = '2024-12-15 18:00:00';
