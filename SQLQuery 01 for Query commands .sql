use MyDatabase;



-- Retieve all order data

select*
from Orders;



-- Retieve all customers data

select *
from customers;



-- Retreive each customer's first name, country, and score.

select 
	first_name,
	country,
	score 
from  customers;



-- Retrieve customers with a score not equal to 0.

select *
from customers
where score != 0;



-- Retrieve customers from germany.

select 
	first_name,
	country
from customers
where country = 'germany';



/* Retrieve all customers from country and
	sort them results by the highest score first. */

select *
from customers
order by score desc;



/* Retrieve all customers and
	sort them results by the lowest score first. */

select *
from customers
order by score asc;



/* Retrieve all customers and
	sort the results by the country and by the highest score. */

select *
from customers
order by 
	country asc,
	score desc;



-- Find the total score for each country 

select
	country,
	sum(score) as total_score
from customers
group by country;


-- Find the average score for each country --

select
	country,
	avg(score) as average_score
from customers
group by country;


-- Find the total score and total number of customers for each country

select 
	country,
	sum(score) as total_score,
	count(id) as total_customers
from customers
group by country;



/* Find the average score for each country
	consider only customers with score not equal to 0
	and return only those countries with an average score greater than 440. */

select
	country,
	avg(score) as average_score
from customers
where score != 0
group by country
having avg(score) > 440;


-- Return unique list of all countries

select distinct country
from customers;


-- Retrieve only top 3 customers.

select top 3 *
from customers;


-- Retrieve only top 3 customers with the highest scores.

select top 3 *
from customers
order by score desc;


-- Retrieve only top 3 customers with the lowest scores.

select top 3 *
from customers
order by score asc;


-- Get the two most recent orders.

select top 2 *
from orders
order by order_date Desc;


-- Get the two oldest orders.

select top 2 *
from orders
order by order_date asc;



