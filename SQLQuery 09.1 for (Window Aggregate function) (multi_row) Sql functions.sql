
-- Window Aggregate functions

-- COUNT()

-- Find the total no of orders

select
	count(*) As TotalOrders
from sales.Orders;




-- Find the total no of orders
-- Additionally provide details such order ID and orderdate

select
	orderid,
	orderdate,
	count(*) over() As TotalOrders
from sales.Orders;




-- Find the total no of orders
-- Find the total no of orders for each customers
-- Additionally provide details such order ID and orderdate

select
	customerid,
	orderid,
	orderdate,
	count(*) over() As TotalOrders,
	count(*) over(partition by customerid) as orderbycustomers
from sales.Orders;




-- Check whether the table 'orders' contains any duplicate rows

select
	orderid,
	count(*) over(partition by orderid) as checkpk
from sales.OrdersArchive;


select*
from
(
select
	orderid,
	count(*) over(partition by orderid) as checkpk
from sales.OrdersArchive)t 
where checkpk > 1



-- SUM()


-- Find the total sales across all orders
-- And the total sales for each product 
-- Additionally provide details such orderID and orderdate


select
	OrderID,
	OrderDate,
	ProductID,
	sales,
	sum(sales) over() as Totalsalesorder,
	Sum(sales) over(partition by productid) as salesbyproduct
from sales.Orders;




-- AVG()

-- Find the average sales across all orders
-- And find the average sales for each prodct 
-- Additionally provide details Such orderID, orderdate


select
	OrderID,
	OrderDate,
	productid,
	sales,
	AVG(sales) over(partition by productid) as Avgsalesbyproduct
from sales.Orders;



-- Find the average scores of customers
-- Additionally provide details such customerid and lastname


select
	CustomerID,
	LastName,
	Score,
	coalesce(score,0) as cutomerscore,
	Avg(coalesce(score,0)) over() Avgscore
from sales.Customers;



-- Find all orders where sales are higher than the average sales across all orders


select*
from
	(
	select
		OrderID,
		ProductID,
		Sales,
		Avg(sales) over() as Avgsales
	from sales.Orders) as t
where Sales > Avgsales;




-- MIN() AND MAX()


-- Find the highest and lowest sales of all orders 
-- Find the highest and lowest sales of all product
-- Additionally provide details such orderid and orderdate


select 
	OrderID,
	OrderDate,
	ProductID,
	Sales,
	MIN(sales) over() as Lowestsales,
	MAX(sales) over() as Highestsales,
	MIN(sales) over(partition by productid) as lowestsalesbyproduct,
	Max(sales) over(partition by productid) as highestsalesbyproduct
from sales.Orders;




-- Show the employees who have the highest salaries


select *
from(
select *,
	MAX(salary) over() Highestsalary
from sales.Employees) as t
where Salary = Highestsalary;



-- Find the deviation of each sales from the minimum and maximum sales amounts


select
	OrderID,
	OrderDate,
	ProductID,
	sales,
	MIN(sales) over() as Lowestsales,
	MAX(sales) over() as Highestsales,
	sales - MIN(sales) over() as Deviationfrommin,
	MAX(sales) over() - sales as Deviationfrommax
from sales.Orders;




-- Calculate moving average of sales for each product over time


select
	OrderID,
	OrderDate,
	ProductID,
	sales,
	AVG(sales) over(partition by productid) Avgbyprduct,
	AVG(sales) over(partition by productid order by orderdate) as Movingaverage
from sales.Orders;




-- Calculate moving average of sales for each product over time, 
-- Including only next order


select
	OrderID,
	OrderDate,
	ProductID,
	sales,
	AVG(sales) over(partition by productid) Avgbyprduct,
	AVG(sales) over(partition by productid order by orderdate) as Movingaverage,
	Avg(sales) over(partition by productid order by orderdate Rows between current row and 1 following) as RollingAverage
from sales.Orders;