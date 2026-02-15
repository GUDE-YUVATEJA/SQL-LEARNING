use MyDatabase;


-- Aggregate Functions

--  Find the total no of orders

select
count(*) as Total_no_of_orders
from Orders;



-- Find the total sales of all orders

select
	SUM(sales) as total_sales
from orders;



-- Find the average sales of all orders

select
	Avg(sales) as Avg_sales
from orders;



-- Find the highest sales of all orders

select
	MAX(sales) as Max_sales
from orders;



-- Find the lowest sales of all orders

select
	MIN(sales) as Min_sales
from orders;



select
	customer_id,
	count(*) as Total_no_of_orders,
	SUM(sales) as total_sales,
	Avg(sales) as Avg_sales,
	MAX(sales) as Max_sales,
	MIN(sales) as Min_sales
from orders
group by customer_id;




use SalesDB;

-- Window Functions


-- Find the total sales across all orders.

select
	SUM(Sales) as Totalsales
from sales.Orders;



-- Find the total sales for each product


select
	ProductID,
	SUM(sales) as Totalproductwisesales
from sales.Orders
group by ProductID;




/* Find the total sales for each product
Additionally provide details such orderId and orderdate */

-- Using Groupby 

select
	OrderID,
	OrderDate,
	ProductID,
	SUM(sales) as Totalproductwisesales
from sales.Orders
group by 
		OrderID,
		OrderDate,
		ProductID;


-- Using window function 

select
	OrderID,
	OrderDate,
	ProductID,
	SUM(sales) Over(partition by productid) as Totalsalesbyproducts
from sales.Orders;



-- Partition clause


/* Find the total sales across all orders
	Find the total sales for each product
	Find the total sales for each combination of product and order status
	Additionally provide details such orderId and orderdate */

select
	OrderID,
	OrderDate,
	ProductID,
	OrderStatus,
	sales,
	sum(sales) over() as Totalsales,
	SUM(sales) Over(partition by productid) as salesbyproducts,
	sum(sales) over(partition by productid, orderstatus) as salesbyproductsandstatus
from sales.Orders;




-- Order clause

-- Rank each order based on their sales from highest to lowest
-- additionally provide details such orderid, orderdate


select
	OrderID,
	OrderDate,
	sales,
	Rank() over(order by sales desc) as Ranksales
from sales.Orders;




-- Rank each order based on their sales from lowest to highest
-- additionally provide details such orderid, orderdate

select
	OrderID,
	OrderDate,
	sales,
	Rank() over(order by sales Asc) as Ranksales
from sales.Orders;




-- Frame clause


select
	OrderID,
	OrderDate,
	OrderStatus,
	Sales,
	sum(sales) over(partition by orderstatus order by orderdate 
	Rows Between current row and 2 following) Totalsales
from sales.Orders;





-- Rank customers based on their total sales

select
	CustomerID,
	sum(Sales) as Toatlsales,
	Rank() over(order by sum(sales) Desc) as Rankcustomer
from sales.orders
group by CustomerID;