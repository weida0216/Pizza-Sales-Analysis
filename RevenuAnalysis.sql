-- Revenue for each day

SELECT o.Date, SUM(p.Price * (od.Quantity)) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY o.Date
ORDER BY SUM(p.Price * (od.Quantity)) DESC;

-- Investigate which month of the year generated the highest revenue

SELECT MONTH(o.Date) AS Month, SUM(p.Price * (od.Quantity)) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY MONTH(o.Date)
ORDER BY SUM(p.Price * (od.Quantity)) DESC;

-- Investigate which day of the week generated the highest revenue

SELECT DAYOFWEEK(o.Date) AS Day, SUM(p.Price * (od.Quantity)) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY DAYOFWEEK(o.Date)
ORDER BY SUM(p.Price * (od.Quantity)) DESC;

-- Investigate which hour of the day generated the highest revenue across the year

SELECT HOUR(Time) AS Hour, SUM(p.Price * (od.Quantity)) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY HOUR(Time)
ORDER BY SUM(p.Price * (od.Quantity)) DESC;
