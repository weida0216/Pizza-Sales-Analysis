-- Investigate how many orders we have each day

SELECT COUNT(OrderID) as num_orders, date
FROM Orders
GROUP BY date
ORDER BY COUNT(OrderID) DESC;

-- Investigate which month of the year generated the most amount of orders

SELECT MONTH(date) AS month, COUNT(OrderID) as num_orders
FROM Orders
GROUP BY MONTH(date)
ORDER BY COUNT(OrderID) DESC;

-- Investigate which day of the week has the most amount of orders

SELECT DAYOFWEEK(date) as Day, COUNT(OrderID) as num_orders
FROM Orders
GROUP BY DAYOFWEEK(date)
ORDER BY COUNT(OrderID) DESC;

-- Investigate which hour of the day receives the most amount of orders

SELECT HOUR(Time) as Hour, COUNT(OrderID) as num_orders
FROM Orders
GROUP BY HOUR(Time)
ORDER BY COUNT(OrderID) DESC;

-- Investigate how many pizzas are sold per month on average
SELECT SUM(num_orders)/12 AS MonthlyAvgQuant
FROM (
SELECT COUNT(OrderID) as num_orders, date
FROM Orders
GROUP BY date
ORDER BY COUNT(OrderID) DESC) AS Order1;


