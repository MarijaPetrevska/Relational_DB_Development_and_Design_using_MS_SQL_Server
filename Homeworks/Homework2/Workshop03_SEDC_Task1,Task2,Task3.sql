-- MS SQL Server Database Design & Development 
-- => Homeworks
-- Homework 2 - Workshop03 (SEDC)
-- Task1, Task2, Task3

-- 1) Create new view (vv_CustomerOrders) that will List all CustomerIds
-- and sum of total Orders per customer

CREATE VIEW vv_CustomerOrders AS
SELECT o.CustomerId, SUM(o.TotalPrice) AS TotalOrderPrice
FROM Orders o
GROUP BY o.CustomerId;

-- 2) Change the view to show Customer Names instead of CustomerId

CREATE OR ALTER VIEW vv_CustomerOrders AS
SELECT c.Name AS CustomerName, SUM(o.TotalPrice) AS TotalOrderAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerId = c.Id
GROUP BY c.Name; 
GO
	
-- 3) Change the view to show the results ordered by the customer with
-- biggest total price

-- Creating the view: 
CREATE OR ALTER VIEW vv_CustomerOrders AS
SELECT c.Name AS CustomerName, SUM(o.TotalPrice) AS TotalOrderPrice
FROM Orders o
INNER JOIN Customers c ON o.CustomerId = c.Id
GROUP BY c.Name;
GO 
-- Query the view to sort the results:
SELECT * 
FROM vv_CustomerOrders
ORDER BY TotalOrderPrice DESC;



