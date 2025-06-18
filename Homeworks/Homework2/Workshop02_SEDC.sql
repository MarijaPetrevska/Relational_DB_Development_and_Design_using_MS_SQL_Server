-- Homeworks => Homework 2
-- MS SQL Server Database Design & Development 
-- WORKSHOP 02 (SEDC) 

-- 1) Calculate the total amount per BusinessEntity on all orders in the
-- system and filter only total orders greater than 635558

SELECT * 
FROM BusinessEntities

SELECT * 
FROM Orders

SELECT o.BusinessEntityId, be.Name, SUM(o.TotalPrice) AS TotalOrderPrice
FROM Orders o
INNER JOIN BusinessEntities be ON o.BusinessEntityId = be.Id
GROUP BY o.BusinessEntityId, be.Name
HAVING SUM(o.TotalPrice) > 635558

-- 2) Calculate the total amount per BusinessEntity on all orders in the
-- system from Customers with ID < 20 and filter only total orders
-- less than 100000

SELECT * FROM BusinessEntities
SELECT * FROM Orders

SELECT DISTINCT CustomerId 
FROM Orders
WHERE CustomerId < 20

-- SELECT COUNT(*) AS TotalOrders
-- FROM Orders
-- WHERE CustomerId < 20

SELECT o.CustomerId, be.Name AS BusinessEntityName, SUM(o.TotalPrice) AS TotalAmount 
FROM Orders o
INNER JOIN BusinessEntities be ON o.BusinessEntityId = be.Id
WHERE o.CustomerId < 20
GROUP BY be.Name, o.CustomerId
HAVING SUM(o.TotalPrice) < 100000;

-- 3) Find the Maximal Order amount, and the Average Order amount
-- per BusinessEntity on all orders in the system. Filter only records
-- where Total order amount is more than 4x bigger than average

SELECT be.Name AS BusinessEntityName, MAX(o.TotalPrice) AS MaximalOrderAmount, AVG(o.TotalPrice) AS AverageOrderAmount
FROM Orders o
INNER JOIN BusinessEntities be ON o.BusinessEntityId = be.Id
GROUP BY be.Name
HAVING MAX(o.TotalPrice) > 4 * AVG(o.TotalPrice);

