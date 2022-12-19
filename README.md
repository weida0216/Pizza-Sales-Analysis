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
To investigate if there are any trends of seasonality of use the below query to group the number of orders by the month of the year:

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

Next, I used tableau to plot the below visualisations using the results above. 

<img width="700" alt="Screenshot 2022-12-19 at 4 03 34 PM" src="https://user-images.githubusercontent.com/79434994/208376606-dd594ea1-9caa-4e0d-8676-378d80c4b24d.png">


<img width="700" alt="Screenshot 2022-12-19 at 4 06 04 PM" src="https://user-images.githubusercontent.com/79434994/208376995-00e508c1-0f0b-4182-9b9f-52233e701f61.png">


