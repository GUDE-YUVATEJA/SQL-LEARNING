

-- Window Value Functions


-- LEAD() and LAG()

  
-- Analyze the month-over-month performance by finding the percentage change
-- In sales B/w the current and previous months


select *,
	Currentmonthsales - Previousmonthsales as MOM_change,
	round(Cast((Currentmonthsales - Previousmonthsales) as float)/ Previousmonthsales * 100, 2) as MOM_percentage
from(
select 
	Month(OrderDate) as  ordermonth,
	Sum(sales) as Currentmonthsales,
	Lag(sum(sales)) over(order by month(orderdate)) as Previousmonthsales
from sales.Orders
group by MONTH(orderdate)) as t





-- In order to analyze cutomer loyalty
-- Rank customers based on the average days b/w their orders

select 
	CustomerID,
	Avg(daysuntilnextorder) as Avgdays,
	Rank() over(order by coalesce(Avg(daysuntilnextorder),9999)) as Rankavg
from(
select
	OrderID,
	CustomerID,
	OrderDate as currentorder,
	Lead(orderdate) over(partition by customerid order by orderdate) as Nextorder,
	DATEDIFF(day,OrderDate, LEAD(orderdate) over(partition by customerid order by orderdate)) as Daysuntilnextorder
from sales.Orders) as t
group by CustomerID;




-- First_value() and Last_value()


-- Find the Lowest and highest sales for each product


select 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(sales) over(partition by Productid order by sales) As Lowestsales
from sales.Orders;



select 
	OrderID,
	ProductID,
	Sales,
	LAst_value(sales) over(partition by Productid order by sales
	rows between current row and unbounded following) As Highestsales
from sales.Orders;



select 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(sales) over(partition by Productid order by sales) As Lowestsales,
	Min(sales) over(partition by productid) as Lowestsales,
	Max(sales) over(partition by productid) As Highestsales,
	LAst_value(sales) over(partition by Productid order by sales
	rows between current row and unbounded following) As Highestsales,
	FIRST_VALUE(sales) over(partition by Productid order by sales Desc) As Hidhestsales
from sales.Orders;




-- Find the Lowest and highest sales for each product
-- Find the diference in sales b/w the current and the lowest sales


select 
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(sales) over(partition by Productid order by sales) As Lowestsales,
	LAst_value(sales) over(partition by Productid order by sales
	rows between current row and unbounded following) As Highestsales,
	sales - FIRST_VALUE(sales) over(partition by Productid order by sales) as salesdifference
from sales.Orders;


