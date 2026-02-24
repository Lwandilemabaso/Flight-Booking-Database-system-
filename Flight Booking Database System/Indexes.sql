/*FileName: Indexes.sql
Programmer Name: Lwandile Mabaso
Date: 12 November2024
Description: This script creates an index on the specified table to improve query performance, 
particularly for columns frequently used in search or join operations. 
*/

USE flightagency 
GO


CREATE INDEX IDX_CustomersEmail_N
ON customers (email)
GO

CREATE INDEX IDX_Flight_FlightNumbers
ON flight (flightNumber)
GO

CREATE INDEX IDX_Flight_Destination
ON flight (destination)
GO

CREATE INDEX IDX_Bookings_CustomerID
ON bookings (customerID)
GO

CREATE INDEX IDX_Bookings_FlightID
ON bookings (flightID)
GO

CREATE INDEX IDX_Checkout_CheckoutName
ON checkout (checkoutName)
GO

-- Indexes on bookingID and checkoutID in transactionMthd
CREATE INDEX IDX_TransactionMthd_BookingID
ON transactionMthd (bookingID)
GO

CREATE INDEX IDX_TransactionMthd_CheckoutID
ON transactionMthd (checkout_ID)
GO


CREATE INDEX IDX_SeatAcesss_FlightID
ON seatAcesss (flightID)
GO