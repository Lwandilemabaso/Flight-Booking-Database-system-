 /* 
Script File Name: Database and Tables.sql
Programmer: Lwandile Mabsaso
Date: 11 November 2024

Description: 
This script creates the "flightagency" database and sets up all necessary tables 
with appropriate constraints for a flight booking system. The tables include 
`customers`, `flights`, `bookings`, `checkout`, `transactionMthd`, and `seatAccess`. 
Each table includes primary keys, foreign keys, and constraints like CHECK and UNIQUE 
to ensure data integrity. 
This script sets up the structure of the database, establishing relationships between 
tables for customer management, flight details, bookings, payment processing, 
and seat availability.
*/


USE master
GO 

CREATE DATABASE flightagency 
ON PRIMARY 
( 
  NAME = 'flightagency',
  FILENAME = 'C:\SQLServer\flightagency_data.mdf',
  SIZE = 5MB, 
  FILEGROWTH =10%
  ) 
LOG ON 
( 
  NAME = 'fightagency_log',
  FILENAME = 'C:\SQLServer\flightagency_log.ldf',
  SIZE = 5MB, 
  FILEGROWTH = 10% 
)
GO 
 
 
USE flightagency
 GO 

CREATE TABLE customers
(
  customerID INT IDENTITY PRIMARY KEY,    
  firstName VARCHAR(30) NOT NULL,             
  lastName VARCHAR(30) NOT NULL,              
  email VARCHAR(50) UNIQUE,                   
  dateOfBirth DATE CHECK (dateOfBirth <= GETDATE())  

)
GO

CREATE TABLE flight
(
    flightID INT IDENTITY(1,1) PRIMARY KEY,      
    flightNumber VARCHAR(10) NOT NULL,
    departureDate DATETIME,                      
    arrivalDate DATETIME,                        
    destination VARCHAR(100),                    
    seatsAvailable INT CHECK (SeatsAvailable >= 0)  
)
GO

CREATE TABLE bookings
( 
  bookingID INT IDENTITY PRIMARY KEY,
  customerID INT NOT NULL, 
  flightID INT NOT NULL, 
  bookingDate DATETIME DEFAULT GETDATE(),
  CONSTRAINT Customer_FK FOREIGN KEY (customerID) REFERENCES customers(customerID), -- Foreign key constraint for customerID
  CONSTRAINT Flight_FK FOREIGN KEY (flightID) REFERENCES flight(flightID)           -- Foreign key constraint for flightID
)
GO

CREATE TABLE checkout
(
    checkoutID INT IDENTITY PRIMARY KEY,  
    checkoutName VARCHAR(50) NOT NULL  --payment method name(e.g , credit card,PayPal)               
)
GO

CREATE TABLE transactionMthd
(
    paymentID INT IDENTITY (1,1) PRIMARY KEY,    
    bookingID INT,                              
    amountPaid DECIMAL(10,2),
	paymentDate DATETIME DEFAULT GETDATE(),    
    paymentMethodID INT,  
	booking_ID INT Not Null REFERENCES bookings(bookingID),  -- Link to bookings table
	checkout_ID INT Not Null REFERENCES checkout(checkoutID)   -- Link to checkout table
    
)
GO

CREATE TABLE seatAcesss
(
    seatID INT IDENTITY(1,1) PRIMARY KEY,  
    flightID INT,                            
    seatNumber VARCHAR(10) NOT NULL,      
    seatStatus VARCHAR(20) CHECK (SeatStatus IN ('Available', 'Booked')) , 
    flight_ID INT Not Null REFERENCES flight(FlightID)
)
GO












