-- How many orders were placed each year?


select
	year(OrderDate) as orderdate,
	count(OrderDate) as Nroforders
from sales.Orders
group by year(OrderDate);



-- How many orders were placed each month?

select
	month(OrderDate) as orderdate,
	count(OrderDate) as Nroforders
from sales.Orders
group by month(OrderDate);



select
	datename(month, OrderDate) as orderdate,
	count(OrderDate) as Nroforders
from sales.Orders
group by datename(month, OrderDate);



-- Show all orders that were placed during the month of february.

select *
from sales.Orders
where month(orderdate) = 2



-- Show creationtime using the following format:
-- Day wed Jan Q1 2025 12:34:56 PM

select 
	OrderID,
	CreationTime,
	'day' + FORMAT(creationtime, ' ddd MMM') +
	' Q' + DATENAME(quarter, CreationTime) + FORMAT(creationtime, ' yyyy hh:mm:ss tt') as customeformat
from sales.Orders; 



-- sales by month and year like jan 25


select
	FORMAT(OrderDate, 'MMM yy') as orderdate,
	COUNT(*)
from sales.Orders
group by format(OrderDate, 'MMM yy');




-- calculate the age of employees


select 
	EmployeeID,
	BirthDate,
	DATEDIFF(year, BirthDate, GETDATE()) as age
from sales.Employees;





-- Times gap analysis
-- Find the no of days b/w each order and the previous order


select
	OrderID,
	OrderDate as currentorderdate,
	LAG(orderdate) over ( order by orderdate) as preivousorderdate,
	DATEDIFF(day, LAG(orderdate) over ( order by orderdate), OrderDate) as noofdays
from sales.Orders;
