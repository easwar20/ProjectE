CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    Year INT,
    dailyRate DECIMAL(10, 2),
    available BOOLEAN,
    passengerCapacity INT,
    engineCapacity INT
);


-- Customer Table
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phoneNumber VARCHAR(20)
);

-- Lease Table

CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- Payment Table

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);


INSERT INTO Vehicle (vehicleID, make, model, Year, dailyRate, available, passengerCapacity, engineCapacity) 
VALUES 
    (1, 'Toyota', 'Camry', 2022, 50.00, 1, 4, 1450),
    (2, 'Honda', 'Civic', 2023, 45.00, 1, 7, 1500),
    (3, 'Ford', 'Focus', 2022, 48.00, 0, 4, 1400),
    (4, 'Nissan', 'Altima', 2023, 52.00, 1, 7, 1200),
    (5, 'Chevrolet', 'Malibu', 2022, 47.00, 1, 4, 1800),
    (6, 'Hyundai', 'Sonata', 2023, 49.00, 0, 7, 1400),
    (7, 'BMW', '3 Series', 2023, 60.00, 1, 7, 2499);

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES 
    (1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
    (2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
    (3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
    (4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
    (5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
    (6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
    (7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
    (8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
    (9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
    (10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES 
    (1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
    (2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
    (3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
    (4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
    (5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
    (6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
    (7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
    (8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
    (9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
    (10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES 
    (1, 1, '2023-01-03', 200.00),
    (2, 2, '2023-02-20', 1000.00),
    (3, 3, '2023-03-12', 75.00),
    (4, 4, '2023-04-25', 900.00),
    (5, 5, '2023-05-07', 60.00),
    (6, 6, '2023-06-18', 1200.00),
    (7, 7, '2023-07-03', 40.00),
    (8, 8, '2023-08-14', 1100.00),
    (9, 9, '2023-09-09', 80.00),
    (10, 10, '2023-10-25', 1500.00);

1: Update the daily rate for a Mercedes car to 68

	UPDATE Vehicle SET dailyRate = 68 
	WHERE make = 'Mercedes';

2. Delete a specific customer and all associated leases and payments. 
	
DELETE FROM Customer
WHERE customerID = 1;

3.Rename the "paymentDate" column in the Payment table to "transactionDate". 
	
ALTER TABLE Payment
RENAME COLUMN paymentDate To transactionDate;


4.Find a specific customer by email. 
	SELECT * FROM Customer WHERE email = 'johndoe@example.com';

5.Get active leases for a specific customer. 
SELECT  * FROM Lease WHERE customerID = 2
AND endDate >= CURRENT_DATE;


6.Find all payments made by a customer with a specific phone number. 
	SELECT Payment.*, Customer.firstName, Customer.lastName
FROM Payment
JOIN Customer ON Payment.customerID = Customer.customerID
WHERE Customer.phoneNumber = '555-555-5555';

7.Calculate the average daily rate of all available cars. 
	SELECT AVG(dailyRate) AS average_daily_rate
FROM Vehicle WHERE available = 1;

8.Find the car with the highest daily rate. 
	SELECT * FROM Vehicle ORDER BY dailyRate 
DESCLIMIT 1;

9.Retrieve all cars leased by a specific customer.
	 SELECT * FROM Vehicle WHERE vehicleID IN (
   	 SELECT vehicleID  FROM Lease
   	 WHERE customerID = 4 );

10.Find the details of the most recent lease. 
SELECT * FROM Lease
ORDER BY startDate DESC LIMIT 1;

11.List all payments made in the year 2023. 
	SELECT *FROM Payment
WHERE YEAR(paymentDate) = 2023;
           
12.Retrieve customers who have not made any payments. 
	SELECT Customer.* FROM Customer
LEFT JOIN Payment ON Customer.customerID = Payment.customerID
WHERE Payment.paymentID IS NULL;

13.Retrieve Car Details and Their Total Payments. 
	SELECT  Vehicle.*,   SUM(Payment.amount) AS totalPayments FROM 
  	Vehicle LEFT JOIN    Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Vehicle.vehicleID;

14.Calculate Total Payments for Each Customer. 
	SELECT   Customer.customerID,  Customer.firstName, Customer.lastName,
  	SUM(Payment.amount) AS total_payments FROM  Customer LEFT JOIN 
    	Lease ON Customer.customerID = Lease.customerID
LEFT JOIN  Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID;

15.List Car Details for Each Lease.
	SELECT   Lease.*, Vehicle.* FROM Lease
JOIN   Vehicle ON Lease.vehicleID = Vehicle.vehicleID;
 
16.Retrieve Details of Active Leases with Customer and Car Information. 
	SELECT  Lease.*, Customer.firstName, Customer.lastName,Vehicle.make,
 	Vehicle.model,Vehicle.Year,Vehicle.dailyRate,Vehicle.available
,Vehicle.passengerCapacity, Vehicle.engineCapacity
FROM Lease JOIN 
    Customer ON Lease.customerID = Customer.customerID JOIN 
    Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE  Lease.endDate >= CURRENT_DATE;

17.Find the Customer Who Has Spent the Most on Leases. 
	SELECT Customer.customerID,Customer.firstName, Customer.lastName,
  	 SUM(Payment.amount) AS totaspent
FROM  Customer JOIN 
               Lease ON Customer.customerID = Lease.customerID
JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID
ORDER BY totalspent DESC LIMIT 1;

18.List All Cars with Their Current Lease Information.
	

	SELECT  Vehicle.*,  Lease.*
FROM  Vehicle LEFT JOIN 
   	 Lease ON Vehicle.vehicleID = Lease.vehicleID
WHERE  Lease.endDate >= CURRENT_DATE OR Lease.endDate IS NULL;


