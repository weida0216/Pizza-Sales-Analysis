-- Investigate how many orders we have each day

SELECT COUNT(OrderID) as num_orders, date
FROM Orders
GROUP BY date
ORDER BY COUNT(OrderID) DESC;

-- Investigate which month of the year generated the most amount of orders

SELECT COUNT(OrderID) as num_orders, MONTH(date) AS month
FROM Orders
GROUP BY MONTH(date)
ORDER BY COUNT(OrderID) DESC;

-- Investigate which day of the week has the most amount of orders

SELECT COUNT(OrderID) as num_orders, DAYOFWEEK(date) as Day
FROM Orders
GROUP BY DAYOFWEEK(date)
ORDER BY COUNT(OrderID) DESC;

-- Investigate which hour of the day receives the most amount of orders

SELECT COUNT(OrderID) as num_orders, HOUR(Time) as Hour
FROM Orders
GROUP BY HOUR(Time)
ORDER BY COUNT(OrderID) DESC;

