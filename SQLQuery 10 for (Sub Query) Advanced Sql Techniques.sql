
-- Advanced SQL Techniques

-- Sub Query


-- Result type Sub Queries


-- Scalar Sub Query
-- Result Single value is a scalar Sub Query.

select 
SUM(sales) as Totalsales
from sales.Orders;



-- Row Sub Query
-- Result Multiple Rows and Single column is Row Sub Query.

select	
	Sales
from sales.Orders;



-- Table Sub Query
-- Result Multiple Rows and Multiple columns is a Table Sub Query.

select
	OrderID,
	OrderDate
from Sales.Orders;




-- Loction/clauses

-- From clause Sub Query


/* Task: Find the products that have a price
		 Higher than the average price of all products. */


-- Main Query
select *
from
-- Sub Query
	(select
		ProductID,
		Price,
		Avg(Price) over() AvgPrice
	from sales.Products) As t
where Price > AvgPrice;



-- Rank Customers based on their total amount of sales

-- Main Query
select *,
		Rank() over(order by totalsales Desc) as Rankcustomer
from
-- Sub Query
(select 
	CustomerID,
	Sum(sales) as Totalsales
from sales.Orders
Group by CustomerID) as t




-- Select Clause Sub Query


-- Show the product IDs, Names, prices, and total number of orders.

-- Main Query
select
	ProductID,
	Product,
	Price,
	-- Sub Query
	(select count(*) from sales.Orders) as TotalOrders
from sales.Products;




-- Join Clause Sub Query


-- Show all customer Details and find the total orders of each customer

-- Main Query
select
	c.*,
	o.Totalorder
from sales.Customers as c
Left Join 
-- Sub Query
		(Select 
			CustomerID,
			COUNT(*) as Totalorder
		from sales.Orders
		group by CustomerID) as o
ON c.CustomerID = o.CustomerID;




-- Where Clause Sub Query


-- Where comparison operators


-- Find the product that have a price higher than the average price of all products 

-- Main Query
select 
	ProductID,
	Price
from sales.Products
where Price > 
-- Sub Query
		(select Avg(Price) from sales.Products)




-- Where Logical operator


-- IN Operator


-- Show the Details of orders made by customers in germany 


-- Main Query
Select *
from sales.Orders
where CustomerID IN
-- Sub Query
				(select
					CustomerID
				from sales.Customers
				where Country = 'Germany')



-- Main Query
Select *
from sales.Orders
where CustomerID NOT IN
-- Sub Query
				(select
					CustomerID
				from sales.Customers
				where Country = 'Germany')




-- ANY Operator


/* Find Female employees whose salaries are greater
	than the salaries of any male employees. */


-- Main Query
select  
	EmployeeID,
	Gender,
	Salary
from Sales.Employees
where Gender = 'F'
And Salary > ANY
-- Sub Query
			(select 
				Salary
			from sales.Employees
			where Gender = 'M'); 


-- ALL Operator


/* Find Male employees whose salaries are greater
	than the salaries of any Female employees. */


-- Main Query
select  
	EmployeeID,
	Gender,
	Salary
from Sales.Employees
where Gender = 'M'
And Salary > ALL
-- Sub Query
			(select 
				Salary
			from sales.Employees
			where Gender = 'F'); 




-- Dependancy


-- Correlated / NON Correlated Sub Query 


-- Show all customers details and find the total orders of each customer


select	
	*,
	(select count(*) From sales.Orders as o where o.CustomerID = c.CustomerID) as Totalsales
from Sales.Customers as c;




-- Correlated sub Query using where clause EXIST Operator.


-- Show the details of orders made by customers in germany

-- Main Query
select
* from sales.Orders as o
where EXISTS
-- Sub Query
		(select *
		from sales.Customers as c
		where Country = 'germany'
		AND c.CustomerID = o.CustomerID);




-- Main Query
select
* from sales.Orders as o
where NOt EXISTS
-- Sub Query
			(select *
			from sales.Customers as c
			where Country = 'germany'
			AND c.CustomerID = o.CustomerID)