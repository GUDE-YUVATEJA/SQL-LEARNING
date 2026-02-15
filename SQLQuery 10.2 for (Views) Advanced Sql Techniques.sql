
-- Views


-- Find the running total of sales for each month


With CTE_Monthly_Summary as
(
select 
	DATETRUNC(Month, OrderDate) as OrderMonth,
	Sum(sales) as Totalsales,
	Count(orderid) as Totalorders,
	Sum(Quantity) as TotalQuantities
from sales.Orders
Group by DATETRUNC(Month, OrderDate)
)
select 
	ordermonth,
	Totalsales,
	Totalorders,
	TotalQuantities,
	Sum(Totalsales) Over (order by Ordermonth) as RunningTotal
From CTE_Monthly_Summary;



-- Create View 

CREATE VIEW Sales.V_Monthly_Summary as
(
select 
	DATETRUNC(Month, OrderDate) as OrderMonth,
	Sum(sales) as Totalsales,
	Count(orderid) as Totalorders,
	Sum(Quantity) as TotalQuantities
from sales.Orders
Group by DATETRUNC(Month, OrderDate)
)




-- Drop View


DROP VIEW Sales.V_Monthly_Summary




-- Find the running total of sales for each month

select
	ordermonth,
	Totalsales,
	Totalorders,
	TotalQuantities,
	Sum(Totalsales) Over (order by Ordermonth) as RunningTotal
From sales.V_Monthly_summary;






-- Create and drop view at a time if we know it is there or not on that time


IF OBJECT_ID ('Sales.V_Monthly_Summary', 'V') IS NOT NULL
	Drop View Sales.V_Monthly_Summary;
GO
CREATE VIEW Sales.V_Monthly_Summary as
(
select 
	DATETRUNC(Month, OrderDate) as OrderMonth,
	Sum(sales) as Totalsales,
	Count(orderid) as Totalorders,
	Sum(Quantity) as TotalQuantities
from sales.Orders
Group by DATETRUNC(Month, OrderDate)
);




-- Use Case Hide Complexity

-- Task: Provide view that combines details from orders, products, customers, and Employees

CREATE VIEW Sales.V_order_details as
(
select 
	o.OrderID,
	o.OrderDate,
	p.product,
	p.Category,
	coalesce(c.FirstName, '') + ' ' + coalesce(c.LastName, '') as CustomerName,
	c.Country as CustomerCountry,
	coalesce(e.FirstName, '') + ' ' + coalesce(e.LastName, '') as SalesName,
	e.Department,
	o.Sales,
	o.Quantity
from Sales.Orders as o
Left Join sales.Products as p
ON p.ProductID = o.ProductID
Left Join sales.Customers as c
ON c.CustomerID = o.CustomerID
Left Join Sales.Employees as e
ON e.EmployeeID = o.SalesPersonID
);



select *
from Sales.V_order_details;




-- Data Security Use case


-- Provide a view for EU Sales Team
-- That combines details from all tables
-- And excludes data related to the USA


IF OBJECT_ID ('Sales.V_order_details_EU', 'V') IS NOT NULL
	Drop View Sales.V_order_details_EU;
GO
CREATE VIEW Sales.V_order_details_EU as
(
select 
	o.OrderID,
	o.OrderDate,
	p.product,
	p.Category,
	coalesce(c.FirstName, '') + ' ' + coalesce(c.LastName, '') as CustomerName,
	c.Country as CustomerCountry,
	coalesce(e.FirstName, '') + ' ' + coalesce(e.LastName, '') as SalesName,
	e.Department,
	o.Sales,
	o.Quantity
from Sales.Orders as o
Left Join sales.Products as p
ON p.ProductID = o.ProductID
Left Join sales.Customers as c
ON c.CustomerID = o.CustomerID
Left Join Sales.Employees as e
ON e.EmployeeID = o.SalesPersonID
Where c.Country != 'USA'
);


select *
from Sales.V_order_details_EU;