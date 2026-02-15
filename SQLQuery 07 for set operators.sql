use SalesDB;


-- Combine the data from employees and customers into one table.

select 
	FirstName,
	LastName
from sales.Customers
UNION
select 
	FirstName,
	LastName
from sales.Employees;




-- combine the data from employees and customers into one table, including duplicates.

select 
	FirstName,
	LastName
from sales.Customers
UNION ALL
select 
	FirstName,
	LastName
from sales.Employees;



-- Find the employees who are not customers at the same time.

select
	FirstName,
	LastName
from sales.Employees
EXCEPT
select 
	FirstName,
	LastName
from sales.Customers;




-- Find the employees, who are also customers.


select
	FirstName,
	LastName
from sales.Customers
INTERSECT
select
	FirstName,
	LastName
from sales.Employees;