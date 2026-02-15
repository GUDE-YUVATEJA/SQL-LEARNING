use SalesDB;


-- COALESCE()  and  ISNULL()


select
	CustomerID,
	Score,
	coalesce(Score, 0) as score2
from sales.customers;



select
	CustomerID,
	Score,
	avg(coalesce(Score, 0)) over() as avgscore
from sales.customers;




-- Display the full name of customers in a single field 
-- by merging the first and last names,
-- and add 10 bonus points to each customer's score.


select
	FirstName,
	LastName,
	FirstName + coalesce(LastName,'') as fullname,
	Score,
	coalesce(Score,0) + 10 as scorewithbonus
from sales.Customers;



-- Sort the customers from lowest to highest scores,
-- with nulls appearing last

select
	CustomerID,
	Score
from sales.Customers
order by case when score IS NULL then 1 else 0 end, Score asc;



-- NULLIF()

-- Find the sales price for each order by dividing sales by quantity.


select 
	OrderID,
	Sales,
	Quantity,
	Sales / nullif(Quantity,0) as price
from sales.Orders;



-- IS NULL()   and IS NOT NULL()

-- Identify the customers who have no score


select*
from sales.Customers
where score IS NULL;

-- List of all customers who have scores

select 
*
from sales.Customers
where Score IS NOT NULL;



-- List all details for customers who have not placed any orders


select
	c.*,
	o.OrderID
from sales.Customers as c
left join sales.Orders as o
ON c.CustomerID = o.CustomerID
where o.CustomerID IS NULL


select
	c.*,
	o.OrderID
from sales.Customers as c
left join sales.Orders as o
ON c.CustomerID = o.CustomerID
where o.CustomerID IS NOT NULL;



-- NULL VS EMPTY VS SPACE


with orders as ( 
select 1 Id, 'AB' category UNION
select 2, NULL UNION
select 3, '' UNION
select 4, '    ' 
)
select 
*,
DATALENGTH(category) as categorylen
from orders;



-- Handling NULLS data Policy1


with orders as ( 
select 1 Id, 'AB' category UNION
select 2, NULL UNION
select 3, '' UNION
select 4, '    ' 
)
select 
*,
Trim(category) as policy1
from orders;



with orders as ( 
select 1 Id, 'AB' category UNION
select 2, NULL UNION
select 3, '' UNION
select 4, '    ' 
)
select 
*,
DATALENGTH(category) as categorylen,
DATALENGTH(Trim(category)) as policy1
from orders;


-- policy2

with orders as ( 
select 1 Id, 'AB' category UNION
select 2, NULL UNION
select 3, '' UNION
select 4, '    ' 
)
select 
*,
NULLIF(Trim(category), '') as policy2
from orders;


-- Policy3


with orders as ( 
select 1 Id, 'AB' category UNION
select 2, NULL UNION
select 3, '' UNION
select 4, '    ' 
)
select 
*,
coalesce(NULLIF(Trim(category), ''),'unkown') as policy3
from orders;



with orders as ( 
select 1 Id, 'AB' category UNION
select 2, NULL UNION
select 3, '' UNION
select 4, '    ' 
)
select 
*,
Trim(category) as policy1,
NULLIF(Trim(category), '') as policy2,
coalesce(NULLIF(TRIM(category), ''), 'Unkown') as policy3
from orders




-- Case statements 

/* Create report showing total sales for each of the following categories:
	High (sales over 50), Medium (sales 21-50), and Low (sales 20 or less)
	sort the categories from highest sales to lowest */

select
	Category,
	SUM(sales) as totalsales
from(select
		OrderID,
		Sales,
		Case
			when sales >50 then 'High'
			when sales between 21 and 50 then 'Medium'
			else 'Low'
		End as Category
		from sales.orders) as t
group by Category
order by totalsales desc;


/* Create report showing average sales for each of the following categories:
	High (sales over 50), Medium (sales 21-50), and Low (sales 20 or less)
	sort the categories from highest sales to lowest */


select
	Category,
	AVG(sales) as avgsales
from(select
		OrderID,
		Sales,
		Case
			when sales >50 then 'High'
			when sales between 21 and 50 then 'Medium'
			else 'Low'
		End as Category
		from sales.orders) as t
group by Category
order by avgsales desc;



-- Retrieve employee details with gender displayed as full text


select
	EmployeeID,
	FirstName,
	LastName,
	Gender,
	Case
		when Gender = 'M' then 'Male'
		when Gender = 'F' then 'Female'
	End as Genderfullname
from sales.Employees;


-- Retrieve customers details with abbreviated country code

select
	CustomerID,
	FirstName,
	LastName,
	Country,
	Case
		when country = 'Germany' then 'DE'
		when country = 'USA' then 'US'
	End Countryabb,

	Case Country
		when 'Germany' then 'DE'
		when 'USA' then 'US'
	End Countryabb2
from sales.Customers;



-- Find the average scores of customers and treat Nulls as 0
-- Additionally provide details such customerId and LastName


select
	CustomerID,
	LastName,
	Score,
	Case
		when Score IS NULL then 0
		Else Score
	End as scoreclean,
	avg(Case
		when Score IS NULL then 0
		Else Score
	End) over()  as avgcustomerclean,
	avg(score) over() as Avgscore
from sales.Customers;




-- Count how many times each customer has made an order with sales greater tha 30


select 
	CustomerID,
	SUM(Case
		when Sales > 30 then 1
		else 0
	End) as totalorders
from sales.orders
group by CustomerID


select 
	CustomerID,
	SUM(Case
		when Sales > 30 then 1
		else 0
	End) as totalordersHighsales,
	count(*) as totalorders
from sales.orders
group by CustomerID