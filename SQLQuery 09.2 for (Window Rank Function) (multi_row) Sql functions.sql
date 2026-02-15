
-- Windows Ranking Functions


-- Row_number()


-- Rank the order based on their sales from highest to lowest

select
	orderid,
	ProductID,
	Sales,
	Row_Number() over(order by sales Desc)  salesRownumber
from sales.Orders;




-- Rank()


-- Rank the order based on their sales from highest to lowest


select 
	OrderID,
	ProductID,
	Sales,
	Rank() over(order by sales desc) as salesrank
from sales.Orders;



-- Dense_Rank()


-- Rank the order based on their sales from highest to lowest

select 
	OrderID,
	ProductID,
	Sales,
	Dense_Rank() over(order by sales desc) as salesDense_rank
from sales.Orders;



-- USE CASES Top numbers

-- Find the top highest sales for each product


select*
from(
select
	OrderID,
	ProductID,
	sales,
	Row_number() over(partition by productid order by sales Desc)  rankbyproduct
from sales.Orders) as t 
where rankbyproduct = 1;




-- Use case Bottom numbers


-- Find the lowest two customers based on their total sales


select *
from(
	select
		CustomerID,
		SUM(sales) as Totalsales,
		Row_number() over(order by SUM(sales)) as Rankcustomer
	from sales.Orders
	Group by CustomerID) as t
where Rankcustomer <= 2;




-- Use case assign Unique IDs


-- Assign Unique IDs to the rows of the 'order Archive' tables


select
	ROW_NUMBER() over(order by orderid, orderdate) as UniqueID,
	*
from sales.OrdersArchive;



-- Use case Identify duplicates


-- Identify duplicate row in the table 'order archive'
-- and return a clean result without any duplicates.


select*
from
(select
	ROW_NUMBER() over(partition by orderid order by creationtime Desc) as RN,
	*
from sales.OrdersArchive) as t
where RN = 1;



-- NTILE()


select
	OrderID,
	sales,
	NTILE(1) over(order by sales Desc) as oneNtile,
	NTILE(2) over(order by sales Desc) as TwoNtile,
	NTILE(3) over(order by sales Desc) as ThreeNtile,
	NTILE(4) over(order by sales Desc) as FourNtile
from sales.Orders;



-- Use case ntile


-- Segment all orders into 3 categories: High, Medium, Low sales.

select
	*,
	case
		when Buckets = 1 then 'High'
		when Buckets = 2 then 'Medium'
		when Buckets = 3 then 'Low'
	End as salessegmentation
from(
select
	OrderID,
	Sales,
	NTILE(3) over(order by sales Desc) as Buckets
from Sales.Orders) as t



-- In order to export the data, divide the orders into 2 groups.


select
	NTILE(2) over(order by orderid) as Buckets,
	*
from sales.Orders;



-- CUME_DIST() and PERCENT_RANK()


-- Find the products that fall within the highest 40% of the prices.



select *,
	CONCAT(DistRANK * 100, '%') as DistRankpercentage
from
	(
	select
		ProductID,
		Product,
		Price,
		CUME_DIST() over(order by price Desc) as DistRank
	from sales.Products
	) as t
where DistRank <= 0.4;



select *,
	CONCAT(DistRANK * 100, '%') as DistRankpercentage
from
	(
	select
		ProductID,
		Product,
		Price,
		percent_rank() over(order by price Desc) as DistRank
	from sales.Products
	) as t
where DistRank <= 0.4;