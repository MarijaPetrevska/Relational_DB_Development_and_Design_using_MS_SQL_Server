-- Homework 8
-- WORKSHOP - PIZZA DB
-- MS SQL Server Database Design & Development

-- *** Pizza Ordering App - Database Design ***

-- EXTRA REQUIREMENTS
USE Pizza_DB
GO
-- 1) There should be a function that concatenates First and Last Name of a user

	CREATE FUNCTION GetFullName(
		@firstName nvarchar(255),
		@lastName nvarchar(255)
	)
	RETURNS nvarchar(511)
	AS
	BEGIN
		RETURN @firstName + ' ' + @lastName
	END
	GO

	SELECT dbo.GetFullName('Bob', 'Bobsky') AS FullName

-- 2) There should be a view to show all pizzas that are not delivered yet and the full names of the users waiting for them

	CREATE VIEW [Undelivered Pizzas] AS
	SELECT p.Name, p.SizeId, p.OrderId, dbo.GetFullName(u.FirstName, u.LastName) AS [UserFullName] FROM Pizzas AS p
	JOIN Orders AS o
	ON o.Id = p.OrderId
	JOIN Users AS u
	ON u.Id = o.UserId
	WHERE o.IsDelivered = 0
	GO

	SELECT * FROM [Undelivered Pizzas]

-- 3) There should be a stored procedure that when provided an Order Id, 
--    can return the full price of a whole order (Delivery + All Pizza + All Toppings)

	CREATE PROCEDURE GetFullPriceOfOrder @OrderId int
	AS 
	BEGIN
	DECLARE @pizzasPrice DECIMAL(4, 2)
	DECLARE @toppingsPrice DECIMAL(4, 2)
	DECLARE @orderPrice DECIMAL(4, 2)

	SELECT @pizzasPrice = SUM(p.Price), @toppingsPrice = SUM(t.Price) FROM Orders AS o
	JOIN Pizzas AS p
	ON o.Id = p.OrderId
	JOIN PizzaToppings AS pt
	ON p.Id = pt.PizzaId
	JOIN Toppings as t
	ON t.Id = pt.ToppingId
	WHERE o.Id = @OrderId

	SELECT @orderPrice = Price FROM Orders
	WHERE Id = @OrderId

	SELECT @OrderId AS [Order Id], @orderPrice AS [Order Price], @pizzasPrice AS [Pizzas Price], @toppingsPrice AS [Toppings Price], SUM(@pizzasPrice + @toppingsPrice + @orderPrice) AS [Full Price]
	END
	GO


	EXEC dbo.GetFullPriceOfOrder @OrderId = 1

-- 4) There should be a view that lists pizzas by the number of times ordered
--   (Call this view ordered by the most popular pizza on top)
	
	CREATE VIEW [Pizza Popularity] AS
	SELECT p.Name, COUNT(p.Name) AS [Number of times ordered] FROM Orders AS o
	JOIN Pizzas AS p
	ON o.Id = p.OrderId
	JOIN PizzaToppings AS pt
	ON p.Id = pt.PizzaId
	GROUP BY p.Name
	GO

	SELECT * FROM [Pizza Popularity]
	ORDER BY [Number of times ordered] DESC


-- 5) There should be a view that lists toppings by the number of times ordered (Call this view ordered by the most popular topping on top)

	CREATE VIEW [Topping Popularity] AS
	SELECT t.Name, COUNT(t.Name) AS [Number of times ordered] FROM Orders AS o
	JOIN Pizzas AS p
	ON o.Id = p.OrderId
	JOIN PizzaToppings AS pt
	ON p.Id = pt.PizzaId
	JOIN Toppings AS t
	ON t.Id = pt.ToppingId
	GROUP BY t.Name
	GO

	SELECT * FROM [Topping Popularity]
	ORDER BY [Number of times ordered] DESC


-- 6) There should be a view with users and the amount of pizzas they ordered

	CREATE VIEW [Pizzas Ordered By Users] AS
	SELECT dbo.GetFullName(u.FirstName, u.LastName) AS [User] ,COUNT(u.Id) AS [Pizzas Ordered] FROM Users AS u
	JOIN Orders AS o
	ON u.Id = o.UserId
	JOIN Pizzas AS p
	ON o.Id = p.OrderId
	GROUP BY dbo.GetFullName(u.FirstName, u.LastName)
	GO

	
	SELECT * FROM [Pizzas Ordered By Users]
	ORDER BY [Pizzas Ordered] DESC

