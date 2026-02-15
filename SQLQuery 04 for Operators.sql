-- Retrieve all customers from germany.

select *
from customers
where country = 'germany';


-- Retrieve all customers who are not from germany.

select *
from customers
where country <> 'germany';


select *
from customers
where country != 'germany';


-- Retrieve all customers with a score greater than 500.

select *
from customers
where score > 500;


-- Retrieve all customers with a score of 500 or more.

select *
from customers
where score >= 500;


-- Retrieve all customers with a score less than 500.

select *
from customers
where score < 500;


-- Retrieve all customers with a score of 500 or less,

select *
from customers
where score <= 500;


/* Retrieve all customers are from USA 
   AND have a score greater than 500. */

select *
from customers
where country = 'USA' AND score > 500;


/* Retrieve all customers are who either from  USA 
   OR have a score greater than 500. */

select *
from customers
where country = 'USA' OR score > 500;


-- Retrieve all customers with a score not less than 500.

select *
from customers
where NOT score < 500;

Select *
from customers
where score >= 500;


/* Retrieve all customers who score fall
	in the range BETWEEN 100 AND 500. */

select *
from customers
where score BETWEEN 100 AND 500;

select *
from customers
where score >= 100 AND score <= 500;


/* Retrieve all customers from
   Either Germany or USA. */

select *
from customers
where country IN ('Germany', 'USA');
	

/* Retrieve all customers  NOT listed from
   Either Germany or USA. */

select *
from customers
where country NOT IN ('Germany', 'USA');


-- Find all customers whose first name start with 'M'.

select *
from customers
where first_name LIKE 'M%';


-- Find all customers whose first name start with 'M'.

select *
from customers
where First_name LIKE '%N';


-- Find all customers whose first name contains 'R'.

select *
from customers
where first_name LIKE '%R%';


/* Find all customers whose first name 
	has 'R' in the third position. */

select *
from customers
where first_name LIKE '__R%';

select *
from customers
where first_name LIKE '%R__';