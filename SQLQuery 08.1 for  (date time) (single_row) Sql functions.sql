use SalesDB;


select
	OrderID,
	OrderDate,
	ShipDate,
	CreationTime
from sales.Orders;



select
	OrderID,
	CreationTime,
	'2025-02-27' as hardcoded,
	GETDATE() as Today
from sales.Orders;



-- day,month,year

select
	OrderID,
	CreationTime,
	Year(creationTime) as Year,
	MONTH(creationtime) as month,
	day(creationtime) as day
from sales.Orders;




-- Datepart


select
	OrderID,
	CreationTime,
	DATEPART(Year, CreationTime) as Year_dp,
	DATEPART(month, CreationTime) as Month_dp,
	datepart(day, CreationTime) as day_dp,
	DATEPART(week,CreationTime) as week_dp,
	DATEPART(quarter, CreationTime) as quarter_dp
from sales.Orders;



-- datename


select
	OrderID,
	CreationTime,
	DATENAME(MONTH, CreationTime) as Month_dn,
	DATENAME(WEEKDAY, CreationTime) as week_dn
from sales.Orders;



-- Datetrunc

select
	OrderID,
	CreationTime,
	DATETRUNC(YEAR, CreationTime) as year_dt,
	DATETRUNC(MONTH, CreationTime) as month_dt,
	DATETRUNC(day, creationtime) as day_dt,
	DATETRUNC(HOUR, CreationTime) as hour_dt,
	DATETRUNC(MINUTE, creationtime) as minute_dt,
	DATETRUNC(second, CreationTime) as second_dt
from sales.Orders;




-- Example of datetrunc


select
	DATETRUNC(month, CreationTime) as date,
	count(*) as count
from sales.Orders
group by DATETRUNC(month, CreationTime);


select
	DATETRUNC(year, CreationTime) as date,
	count(*) as count
from sales.Orders
group by DATETRUNC(year, CreationTime);



-- EOMONTH

select
	OrderID,
	creationtime,
	EOMONTH(CreationTime) as endofmonth,
	cast(DATETRUNC(month, CreationTime) as date) as startofmonth
from sales.Orders;



-- Format()


select 
	OrderID ,
	CreationTime,
	FORMAT(CreationTime, 'dd') as dd,
	FORMAT(creationtime, 'ddd') as ddd,
	FORMAT(creationtime, 'dddd') as dddd
from sales.Orders;


select 
	OrderID ,
	CreationTime,
	FORMAT(CreationTime, 'MM') as MM,
	FORMAT(creationtime, 'MMM') as MMM,
	FORMAT(creationtime, 'MMMM') as MMMM
from sales.Orders;


select 
	OrderID ,
	CreationTime,
	FORMAT(CreationTime, 'MM-dd-yyyy') as USA_format,
	FORMAT(creationtime, 'dd-MM-yyyy') as EURO_fomat,
	FORMAT(creationtime, 'yyyy-MM-dd') as IST_format
from sales.Orders;




-- Convert()

select 
	'123' as string,
	CONVERT(Int, '123') as [string to int convert]


select 
	'2025-08-20' as string,
	CONVERT(date, '2025-08-20') as [string to date convert]


select 
	CreationTime,
	CONVERT(date, creationtime) as [datetime to date convert]
from sales.Orders;


select 
	CreationTime,
	CONVERT(varchar, creationtime, 32) as [USA std. style:32],
	CONVERT(varchar, creationtime, 34) as [EURO std. style:34]
from sales.Orders;



-- Cast()

select
	CAST('123' as int) as [string to int],
	CAST(123 as varchar) as [int to varchar],
	CAST('2025-08-20' as date) as [string to date],
	CAST('2025-08-20' as datetime) as [string to date],
	creationtime,
	CAST(CreationTime as date) as [datetime to date]
from sales.Orders;



-- dateadd()

select
	orderid,
	orderdate,
	DATEADD(year, 2, OrderDate)  as twoyearslater
from sales.Orders;



select
	orderid,
	orderdate,
	DATEADD(year, -3, OrderDate)  as twoyearsbefore
from sales.Orders;


select
	orderid,
	orderdate,
	DATEADD(MONTH, -4, OrderDate)  as fourmonthsbefore
from sales.Orders;


select
	orderid,
	orderdate,
	DATEADD(day, -5, OrderDate)  as fivedaysbefore
from sales.Orders;



-- datediff()

-- Find the average shipping duration in days for each month.


select 
	Month(OrderDate) as orderdate,
	avg(DATEDIFF(day, orderdate, ShipDate)) as avgship
from sales.Orders
group by MONTH(orderdate);



-- ISDATE()

select
ISDATE('123') Datecheck1,
ISDATE('2025-08-20') Datecheck2;