
-- MS SQL Server Database Design & Development 
-- => Homeworks
-- Homework 2 - Workshop03 (SEDC)
-- Task 4, Task 5

-- 4) Create new view (vv_EmployeeOrders) that will List all Employees
-- (FirstName and LastName) , Product name and total quantity sold

SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM BusinessEntities

CREATE VIEW vv_EmployeeOrders AS
SELECT e.FirstName, e.LastName, p.Name AS ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Employees e
INNER JOIN Orders o ON e.Id = o.EmployeeId
INNER JOIN OrderDetails od ON o.Id = od.OrderId
INNER JOIN Products p ON od.ProductId = p.Id
GROUP BY e.FirstName, e.LastName, p.Name;


-- 5) Alter the view to show only sales from Business entities belonging
-- to region 'Skopski'

CREATE OR ALTER VIEW vv_EmployeeOrders AS
SELECT e.FirstName, e.LastName, p.Name AS ProductName, SUM(od.Quantity) AS TotalQuantitySold
FROM Employees e
INNER JOIN Orders o ON e.Id = o.EmployeeId
INNER JOIN OrderDetails od ON o.Id = od.OrderId
INNER JOIN Products p ON od.ProductId = p.Id
INNER JOIN BusinessEntities be ON o.BusinessEntityId = be.Id
WHERE be.Region = 'Skopski'
GROUP BY e.FirstName, e.LastName, p.Name;

