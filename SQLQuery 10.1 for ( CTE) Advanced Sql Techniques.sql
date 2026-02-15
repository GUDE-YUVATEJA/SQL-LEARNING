
-- Common Table Expression (CTE)


-- Standalone CTE


-- Step1: Find the total sales per customer

-- CTE Query
With CTE_Total_sales As
(
select 
	CustomerID,
	SUM(sales) as Totalsales
from sales.Orders
Group by CustomerID
)
-- Main Query
select 
	c.CustomerID,
	c.FirstName,
	c.LastName, 
	Cts.Totalsales
from sales.Customers as c
Left Join CTE_Total_sales as cts
ON cts.CustomerID = c.CustomerID



-- Multi Standalone CTE


-- Step1: Find the total sales per customer (Standalone CTE)
-- CTE Query 1
With CTE_Total_sales As
(
select 
	CustomerID,
	SUM(sales) as Total_sales
from sales.Orders
Group by CustomerID
)
-- Step2: Find the last order date for each customer (Standalone CTE)
-- CTE Query 2
, CTE_Last_order as 
(
Select 
	CustomerID,
	MAX(OrderDate) as Last_order
from sales.Orders
Group by CustomerID
)
-- Main Query
select 
	c.CustomerID,
	c.FirstName,
	c.LastName, 
	Cts.Total_sales,
	clo.Last_order
from sales.Customers as c
Left Join CTE_Total_sales as cts
ON cts.CustomerID = c.CustomerID
Left join CTE_Last_order as clo
ON clo.customerid = c.CustomerID;






-- Step1: Find the total sales per customer (Standalone CTE)
-- CTE Query 1
With CTE_Total_sales As
(
select 
	CustomerID,
	SUM(sales) as Totalsales
from sales.Orders
Group by CustomerID
)
-- Step2: Find the last order date for each customer (Standalone CTE)
-- CTE Query 2
, CTE_Last_order as 
(
Select 
	CustomerID,
	MAX(OrderDate) as Lastorder
from sales.Orders
Group by CustomerID
)
-- Step3: Rank customers Based on Total sales Per customer (Nested CTE)
-- CTE Query 3
, CTE_Customer_Rank as 
(
Select
	CustomerID,
	Totalsales,
	Rank() over(order by Totalsales Desc) as CustomerRank
from CTE_Total_sales
)
-- Step4: Segment customers based on their total sales (Nested CTE)
-- CTE Query 4
, CTE_Customer_segment as 
(
Select 
	CustomerID,
	Totalsales,
	Case 
		When Totalsales > '100' then 'High'
		when Totalsales > '50' then 'Medium'
		Else 'Low'
	End as Customersegment
from CTE_Total_sales
)
-- Main Query
select 
	c.CustomerID,
	c.FirstName,
	c.LastName, 
	Cts.Totalsales,
	clo.Lastorder,
	ccr.CustomerRank,
	ccs.customersegment
from sales.Customers as c
Left Join CTE_Total_sales as cts
ON cts.CustomerID = c.CustomerID
Left join CTE_Last_order as clo
ON clo.customerid = c.CustomerID
Left Join CTE_Customer_Rank as ccr
ON ccr.customerid = c.CustomerID
Left Join CTE_Customer_segment as ccs
ON ccs.customerid = c.CustomerID;






-- Recursive CTE

-- Generate a sequence of numbers from 1 to 20

With Series as
(
-- Anchor Query
select
	1 as MyNumber
Union ALL
-- Recursive Query
Select 
	MyNumber + 1
from Series
where MyNumber < 20
)
-- Main Query
select *
from Series
-- Option (MAXRECURSIVE Value) To control how many we want





-- Task: Show the employee hierarchy by displaying each employee's level within the organization


With CTE_Emp_Hierarchy As
(
-- Anchor Query
select
	EmployeeID,
	FirstName,
	ManagerID,
	1 As Level
from Sales.Employees
where ManagerID IS NULL
UNION ALL
-- Recursive Query
select
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	Level + 1
from Sales.Employees as e
Inner Join CTE_Emp_Hierarchy as ceh
ON e.ManagerID = Ceh.employeeid
)
-- Main Query
select *
from CTE_Emp_Hierarchy;