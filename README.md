# Pizza Shop Analysis
## Introduction
In this project, I set out to investigate the performance of a fictitious pizza chain using mySQL and Tableau. Analysis is performed on a year's worth of sales data as well as  products data, to answer the following business questions: 

  1. How many customers do we have each day? Are there any peak hours?
  2. How many pizzas are typically in an order? Do we have any bestsellers?
  3. How much money did we make this year? Can we indentify any seasonality in the sales?
  4. Are there any pizzas we should take of the menu, or any promotions we could leverage?

## Customer Analysis
Understanding the number of customers a business serves on a daily basis and identifying any peak hours can be important for several reasons. It can help with staffing and resource allocation, allow for better planning and forecasting, and provide insight into the overall health and success of the business. In this section, we will explore ways to measure and analyze the number of customers a business serves on a daily basis, as well as identify any peak hours that may exist. By understanding these metrics, businesses can make informed decisions about how to best serve their customers and optimize their operations.


I first investigated the amount of orders received each day through the year using the following query: 

```
SELECT COUNT(OrderID) as num_orders, date
FROM Orders
GROUP BY date
ORDER BY COUNT(OrderID) DESC;
```
However, due to the narrow scope of the above query, not much business insights can be obtained from it. There, I decided to disect my analysis into the following dimensions: 

  1. Monthly data
  2. Day of the week data
  3. Hours of the day data

### Monthly data
To investigate if there are any trends of seasonality the below query was used: 

```
SELECT COUNT(OrderID) as num_orders, MONTH(date) AS month
FROM Orders
GROUP BY MONTH(date)
ORDER BY COUNT(OrderID) DESC;
```
Results obtained: 

<img width="115" alt="Result for number of orders per month" src="https://user-images.githubusercontent.com/79434994/208373424-c4f125ce-18aa-45c2-87f9-0caa7abdaeb5.png">


I then did the same thing but this time, I was more interested in the revenue gained per month: 

```
SELECT MONTH(o.Date) AS Month, ROUND(SUM(p.Price * (od.Quantity)),0) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY MONTH(o.Date)
ORDER BY SUM(p.Price * (od.Quantity)) DESC;
```
Results obtained: 

<img width="100" alt="Result for revenue per month" src="https://user-images.githubusercontent.com/79434994/208374309-77221641-721a-482a-b381-faf98084b201.png">

Next, I used Tableau to plot the below visualisations using the results above. 

<img width="500" alt="Screenshot 2022-12-19 at 4 03 34 PM" src="https://user-images.githubusercontent.com/79434994/208376606-dd594ea1-9caa-4e0d-8676-378d80c4b24d.png">


<img width="500" alt="Screenshot 2022-12-19 at 4 06 04 PM" src="https://user-images.githubusercontent.com/79434994/208376995-00e508c1-0f0b-4182-9b9f-52233e701f61.png">

As seen from the above visualisations, the month of July generated both the highest amount of orders as well as the highest revenue in the year, and the month October generated the lowest for both. However, despite the disparity in sales throughout the year, the difference between the month with the highest amount of order/revenue and the month with the lowest is only less than 2% of the total order/revenue. Therefore, I can draw the conclusion that there is insignificant/weak seasonality throughout the year. 

### Day of the week data
To investigate which particular day of the week generated the highest sales, the below query was used: 

```
SELECT DAYOFWEEK(date) as Day, COUNT(OrderID) as num_orders
FROM Orders
GROUP BY DAYOFWEEK(date)
ORDER BY COUNT(OrderID) DESC;
```
Results obtained: 

<img width="115" alt="Screenshot 2022-12-20 at 3 31 17 PM" src="https://user-images.githubusercontent.com/79434994/208608822-313b3d56-8e43-432d-8343-f8d5bd2d119c.png">

Note: Based on the documentation of the DAYOFWEEK() function, the numbers under the column 'Day' means the following: 
1=Sunday, 2=Monday, 3=Tuesday, 4=Wednesday, 5=Thursday, 6=Friday, 7=Saturday.

The same thing was done for revenue: 

```
SELECT DAYOFWEEK(o.Date) AS Day, ROUND(SUM(p.Price * (od.Quantity)),0) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY DAYOFWEEK(o.Date)
ORDER BY SUM(p.Price * (od.Quantity)) DESC;
```
Results obtained: 

<img width="102" alt="Screenshot 2022-12-20 at 3 27 19 PM" src="https://user-images.githubusercontent.com/79434994/208608027-b7a1a5a5-5423-41cf-95a5-c433df9a3497.png">

To better identify possible trends, Tableau was used to plot the following visualisations: 

<img width="500" alt="Screenshot 2022-12-20 at 4 16 01 PM" src="https://user-images.githubusercontent.com/79434994/208617023-e7780ee5-512a-4ef2-910e-8840eb3fbebb.png">


<img width="500" alt="Screenshot 2022-12-20 at 4 16 21 PM" src="https://user-images.githubusercontent.com/79434994/208617085-975ae26d-8597-4aef-a841-c123aef2df82.png">

As observed above, there are clear trends in consumption patterns throughout the week, with sales ramping up steadily from Sundays and peaking on Fridays. 
The days of the week with the highest amount of sales are Thursday, Friday and Saturday. Therefore, the business can perhaps hold promotional events during those days as footflow would be the highest. Furthermore, more manpower should also be allocated on those days to ensure that staff are not overwhelmed. 

### Hourly Data
To identify peak hours of the day, the following query was used: 

```
SELECT  HOUR(Time) as Hour, COUNT(OrderID) as num_orders
FROM Orders
GROUP BY HOUR(Time)
ORDER BY COUNT(OrderID) DESC;
```

Results obtained:

<img width="115" alt="Screenshot 2022-12-20 at 4 32 58 PM" src="https://user-images.githubusercontent.com/79434994/208620344-74ede58b-5ef3-4d7a-aa13-b2a606a13343.png">

The same thing was done for revenue: 

```
SELECT HOUR(Time) AS Hour, SUM(p.Price * (od.Quantity)) as Revenue
FROM OrderDetails AS od
INNER JOIN Pizzas as p 
ON od.PizzaID = P.PizzaID
INNER JOIN Orders AS o
ON od.OrderID = o.OrderID
GROUP BY HOUR(Time)
ORDER BY SUM(p.Price * (od.Quantity)) DESC;
```

Results obtained: 

<img width="103" alt="Screenshot 2022-12-20 at 4 34 55 PM" src="https://user-images.githubusercontent.com/79434994/208620837-54ba28a2-a6fc-4925-88a9-053f1bbb6c47.png">

To better identify peak hours, Tableau was used to plot the following visualisations: 

<img width="500" alt="Screenshot 2022-12-20 at 4 44 32 PM" src="https://user-images.githubusercontent.com/79434994/208622931-f2edf3ee-0d11-46e6-abe9-daae86aeb832.png">

<img width="500" alt="Screenshot 2022-12-20 at 4 44 45 PM" src="https://user-images.githubusercontent.com/79434994/208622980-291d466b-279e-4247-8478-bb39202a793e.png">

As observed above, there are two distinct cluster of peak hours, the lunch peak and the dinner peak. The lunch peak starts at around 12pm and ends at around 2pm whereas the dinner peak starts at around 4pm and 8pm. Identifying peak hours is important for a F&B business because it allows the business to properly staff and prepare for high levels of customer demand during those times. This can help ensure that customers receive efficient service and the business is able to maximize profits.

