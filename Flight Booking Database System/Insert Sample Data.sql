/* 
Script File Name: Insert Sample Data.sql
Programmer: Lwandile Mabaso
Date: 11 November 2024

Description: 
This script inserts sample data into the "flightagency" database to populate the tables with initial records. 
It includes at least four records for each table without foreign keys and seven records for each table that 
contains foreign key references. This sample data represents customers, flights, bookings, payment transactions, 
and seat availability within the flight booking system, enabling testing and validation of database functionality.
*/

Use  flightagency
GO 

INSERT INTO customers (firstName, lastName, email, dateOfBirth)
VALUES ('Lwandle', 'Zwane', 'lwanndle.zwane@gmail.com', '1997-09-09'),
       ('Khurla', 'Nxumalo', 'khurla.nxumalo@gmail.com', '1991-06-20'),
       ('Mbali', 'Thulo', 'mbali.thulo@gmail.com', '1994-11-18'),
       ('Sandi', 'Mabanga', 'sandi.mbanga@gamil.com', '1992-03-16')
GO

INSERT INTO flight (flightNumber, departureDate, arrivalDate, destination, seatsAvailable)
VALUES ('AFC1020', '2024-09-01 08:20', '2024-09-01 10:30', 'CPT', 33),
       ('AFC1002', '2024-09-09 12:35', '2024-09-09 14:45', 'DBN', 20),
       ('AFC1015', '2024-11-03 16:40', '2024-11-03 18:45', 'JHB', 66),
       ('AFC1045', '2024-11-18 18:05', '2024-11-18 20:35', 'ELS', 17)
GO

INSERT INTO bookings (customerID, flightID)
VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(1, 3), 
(2, 4), 
(3, 1); --- the booking table has foreign keys
GO


INSERT INTO checkout (checkoutName)
VALUES 
('Credit Card'),
('PayPal'),
('Bank Transfer'),
('Cash');
GO

INSERT INTO transactionMthd (bookingID, amountPaid, paymentMethodID, booking_ID, checkout_ID) 
VALUES 
(1, 350.00, 1, 1, 1),
(2, 400.00, 2, 2, 2),
(3, 450.00, 3, 3, 3),
(4, 500.00, 4, 4, 4),
(5, 375.00, 2, 5, 1),
(6, 425.00, 1, 6, 2),
(7, 300.00, 3, 7, 3); ---the transactionMthd table has foreign keys
GO

INSERT INTO seatAcesss (flightID, seatNumber, seatStatus, flight_ID) 
VALUES 
(1, 'A1', 'Available', 1),
(1, 'A12', 'Booked', 1),
(2, 'B20', 'Available', 2),
(2, 'B21', 'Booked', 2),
(3, 'C1', 'Available', 3),
(3, 'C20', 'Booked', 3),
(4, 'D16', 'Available', 4);  ---the seatAcesss table has foreign keys 
GO




