
-- CTAS and TEMP TABLES


-- CTAS Table


select
	DATENAME(Month, OrderDate) as OrderMonth,
	COUNT(*) as Totalorders
INTO Sales.MonthlyOrders
from sales.Orders
Group by DATENAME(Month, OrderDate)

Drop Table Sales.MonthlyOrders



IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL
	Drop Table Sales.MonthlyOrders
GO
select
	DATENAME(Month, OrderDate) as OrderMonth,
	COUNT(*) as Totalorders
INTO Sales.MonthlyOrders
from sales.Orders
Group by DATENAME(Month, OrderDate)




-- TEMP Table


Select *
INTO #Orders
from Sales.Orders


DELETE from #Orders
Where OrderStatus = 'Delivered'



select
*
from #Orders



