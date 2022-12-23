# Pizza Shop Analysis
## Introduction
In this project, I set out to investigate the performance of a fictitious pizza chain using mySQL and Tableau. Analysis was performed on a year's worth of sales data as well as  products data, to answer the following business questions: 

  1. How many customers do we have each day? Are there any peak hours?
  2. How many pizzas are typically in an order? Do we have any bestsellers?
  3. How much money did we make this year? Can we indentify any seasonality in the sales?
  4. Are there any pizzas we should take of the menu, or any promotions we could leverage?

## Customer Analysis
Understanding the number of customers a business serves on a daily basis and identifying any peak hours can be important for several reasons. It can help with staffing and resource allocation, allow for better planning and forecasting, and provide insight into the overall health and success of the business. In this section, we will explore ways to measure and analyze the number of customers a business serves on a daily basis, as well as identify any peak hours that may exist. By understanding these metrics, businesses can make informed decisions about how to best serve their customers and optimize their operations.


I first investigated the amount of orders received each day throughout the year using the following query: 

```
SELECT COUNT(OrderID) as num_orders, date
FROM Orders
GROUP BY date
ORDER BY COUNT(OrderID) DESC;
```
However, due to the narrow scope of the above query, limited business insights can be obtained from it. Therefore, I decided to disect my analysis into the following dimensions: 

  1. Seasonality
  2. Weekly trend
  3. Peak hour identification

### Seasonality
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

### Weekly trend
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

### Peak hour identification
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

## Product Analysis

The next section of this report will be dedicated to the analysis of the various products offered by the shop. Specifically, I will look to answer the following questions: 

  1. How many pizzas are there typically in an order?
  2. Which size of pizza is the most popular? 
  3. Which pizza is the most popular and which pizza is the least popular?

By understanding the patterns and preferences of customers when it comes to pizza orders, we can make informed decisions on menu planning, pricing, and marketing strategies to better serve our customers and improve the financial performance of our business.

### Typical Order of Pizza

Identifying how many pizzas customers typically order and what size of pizzas they typically order is important for a pizza business because it allows the business to understand the demand for their products and make informed decisions on pricing, inventory management, and marketing strategies. For example, if the business sees that customers typically order one large pizza per transaction, they may consider adjusting their pricing to reflect this demand and potentially increase their profit margins. On the other hand, if they see that customers typically order multiple small pizzas, they may consider offering discounts or promotions to encourage larger orders. Understanding these patterns can also inform the business's production and staffing needs, as they will have a better understanding of how many pizzas they need to prepare on a daily basis. Additionally, understanding the size of pizzas that are most popular can inform the business's menu planning decisions, as they can prioritize offering a range of sizes that meet customer demand.

The following query was used to investigate how many pizzas do a customer typically order:

```
WITH OrderQuant AS (
SELECT OrderID, SUM(Quantity) AS TotalQuant
FROM OrderDetails
NATURAL JOIN Orders
GROUP BY OrderID)
SELECT AVG(TotalQuant) AS AverageQuant
FROM OrderQuant;
```
Result obatained: 

<img width="86" alt="Screenshot 2022-12-21 at 9 08 21 PM" src="https://user-images.githubusercontent.com/79434994/208912718-2b723f35-0a9b-4e06-9e14-e5b42ac4df2d.png">

Based on the result, a customer typically orders around 2 pizzas. 

Next, I used the following query to investigate which size of pizza do customers usually order:

```
SELECT AVG(TotalSize) AS AvgSize
FROM(
SELECT OrderID,
CASE
  WHEN RIGHT(PizzaID, 1) = 's' THEN 1
  WHEN RIGHT(PizzaID, 1) = 'm' THEN 2
  WHEN RIGHT(PizzaID, 1) = 'l' THEN 3
  END AS TotalSize
FROM OrderDetails) AS Sizing;
```
In the query above, I identified the sizes of the pizzas from the suffix of the PizzaID and assigned a number to each category. I then found the average  of the all the sizes to attain the result below: 

<img width="83" alt="Screenshot 2022-12-21 at 9 18 03 PM" src="https://user-images.githubusercontent.com/79434994/208914394-55e91fb2-1ab0-4945-95c7-0f03021d1f3a.png">

An average size of 2.102 means that on average, customers typically order medium pizzas. 


### Pizza Popularity

Identifying which pizzas are the best and worst sellers is important for a pizza business for several reasons. Understanding which pizzas are the most popular among customers can help the business optimize their menu and inventory management. For example, if a particular pizza is a best seller, the business may choose to keep a larger stock of that pizza's ingredients on hand to ensure they can meet customer demand. On the other hand, if a pizza is a worst seller, the business may choose to reduce the amount of that pizza's ingredients they keep on hand or remove it from the menu altogether to reduce waste and save costs. In addition to optimizing inventory and menu management, identifying best and worst sellers can inform the business's marketing and promotional strategies. For example, if a particular pizza is a best seller, the business may choose to highlight it in their marketing efforts to drive sales and increase customer loyalty. This could involve featuring the pizza prominently on the menu, offering special deals or discounts on the pizza, or promoting it through social media and other channels.

The Pizza restaurant offers 4 different categories of pizzas (classic, chicken, supreme and vegetarian). I am first interested in finding which category is the most popular. The following query was used to rank the categories in terms of quantity sold over the year:

```
SELECT Type, SUM(Quantity) AS TotalQuantity
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Type
ORDER BY SUM(Quantity) DESC;
```

Results obtained: 

<img width="151" alt="Screenshot 2022-12-22 at 12 25 23 AM" src="https://user-images.githubusercontent.com/79434994/208954676-e5d5caf1-13f7-4753-b70b-bf62ae25f78f.png">

Based on the result, it is clear that the most popular category of pizza is Classic and the least popular is Chicken. Hence with this information, the business can perhaps release more products other the Classic category. 

After looking into the various categories of pizza, I will now into the popularity of each specific pizzas. The following query was written to rank the pizzas in terms of quantity sold over the year: 

```
SELECT Name, SUM(Quantity) AS TotalQuantity
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity) DESC;
```

Results obtained: 

<img width="336" alt="Screenshot 2022-12-22 at 12 30 19 AM" src="https://user-images.githubusercontent.com/79434994/208955720-0211c193-3a22-48d4-a2ea-46ca5310c72b.png">

Based on the result, it is clear that there is huge disparity between the most popular pizza and the least popular pizza. To put things into better persepective, the following query was written to show the average amount each pizza sold per month: 

```
SELECT Name, ROUND(SUM(Quantity)/12, 0) AS TotalQuantity
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity) DESC;
```

Results obtained: 

<img width="341" alt="Screenshot 2022-12-22 at 12 36 45 AM" src="https://user-images.githubusercontent.com/79434994/208957225-c95c02f0-1f22-4995-8b31-650a6c608a98.png">

This shows that on average, 204 of the most popular pizza, The Classic Deluxe Pizza, were sold per month whereas only 41 of the least popular pizza, The Brie Carre Pizza, were sold. That is a huge disparity of around 400%. For reference, based on the data presented in the customer analysis section, the pizza restaurant sells on average 1780 total pizzas per month. This means that the most popular pizza would make up around 11.5% of total quantity sold and the least popular pizza would only make up 2.3%. 

To confirm our findings, I performed the same investigation based on revenue. The query below ranks each pizza based on their contribution to total annual revenue: 

```
SELECT Name, ROUND(SUM(Quantity*Price),0) AS TotalRevenue
FROM OrderDetails AS od
NATURAL JOIN Pizzas
NATURAL JOIN PizzaTypes
GROUP BY Name
ORDER BY SUM(Quantity*Price) DESC;
```
Results Obtained: 

<img width="324" alt="Screenshot 2022-12-22 at 1 23 33 AM" src="https://user-images.githubusercontent.com/79434994/208966392-3135f7cb-5e30-4e52-b43d-be6cf8b337ca.png">

Based on the revenue contributon, The Thai Chicken Pizza came in first despite being only the 5th most popular pizza in terms of quantity sold and The Brie Carre Pizza remained at the bottom, contributing only $11588 out of the total revenue of $817858.

Tableau was used to better visualise the revenue contribution of different products: 

<img width="334" alt="Screenshot 2022-12-23 at 4 05 40 PM" src="https://user-images.githubusercontent.com/79434994/209297571-7bc8f540-fe5b-4a0e-a508-04e00c6fabb0.png">

The visualisation above categorises the products into different tiers based on their revenue contribution. This is useful in helping management identify which are the stronger/weaker products at one glance. 


## Interactive Dashboard

<img width="1255" alt="Screenshot 2022-12-23 at 4 09 09 PM" src="https://user-images.githubusercontent.com/79434994/209298103-10625b42-33bb-4b1a-a6e5-bbb87cde1034.png">
