-- Investigate which pizzas are popular

SELECT Name, SUM(Quantity) AS TotalQuantity
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity) DESC;

-- Investigate which type of pizzas are popular

SELECT Type, SUM(Quantity) AS TotalQuantity
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Type
ORDER BY SUM(Quantity) DESC;

-- Average amount of pizzas sold per month for each pizza across the year
SELECT Name, ROUND(SUM(Quantity)/12, 0) AS TotalQuantity
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity) DESC;


-- Which category pizza generated the least amount of revenue
SELECT Type, ROUND(SUM(Quantity*Price),0) AS TotalRevenue
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Type
ORDER BY SUM(Quantity*Price) DESC;


-- How many pizzas do customers usually order? (CTE)
WITH OrderQuant AS (
SELECT OrderID, SUM(Quantity) AS TotalQuant
FROM OrderDetails
NATURAL JOIN Orders
GROUP BY OrderID)
SELECT AVG(TotalQuant) AS AverageQuant
FROM OrderQuant;

-- What's the average size of pizzas ordered?

SELECT AVG(TotalSize) AS AvgSize
FROM(
SELECT OrderID,
CASE 
	WHEN RIGHT(PizzaID, 1) = 's' THEN 1
    WHEN RIGHT(PizzaID, 1) = 'm' THEN 2
    WHEN RIGHT(PizzaID, 1) = 'l' THEN 3
    END AS TotalSize
FROM OrderDetails) AS Sizing;


-- Which pizza generated the least amount of revenue
SELECT Name, ROUND(SUM(Quantity*Price),0) AS TotalRevenue
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity*Price) DESC;


-- Find Total Revenue for 2015
SELECT SUM(TotalRevenue)
FROM (SELECT Name, ROUND(SUM(Quantity*Price),0) AS TotalRevenue
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity*Price) DESC) AS a;

