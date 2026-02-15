/* Retrieve all data from customers and orders 
	in two diferent results */

select * 
from customers;

select *
from orders;


/* Get all customers along with their orders,
but only for customers who have placed an order */

select *
from customers 
INNER JOIN orders
ON id = customer_id;

select 
	id,
	first_name,
	order_id,
	sales
from customers 
INNER JOIN orders
ON id = customer_id;

select 
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales
from customers 
INNER JOIN orders
ON customers.id = orders.customer_id;

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales,
	c.score
from customers As c
INNER JOIN orders As o
ON c.id = o.customer_id;

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales,
	c.score
from orders As o
INNER JOIN customers As c
ON c.id = o.customer_id;


/* Get all customers along with their orders,
 including those without orders. */

select *
from customers
LEFT JOIN orders
ON id = Customer_id;

select 
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales,
	customers.score
from customers As customers
LEFT JOIN orders As orders
ON customers.id = orders.customer_id;

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales,
	c.score
from customers As c
LEFT JOIN orders As o
ON c.id = o.customer_id;


/* Get all customers along with their orders,
	including orders without matching customers. */

select *
from customers
RIGHT JOIN orders
ON id = customer_id;

select 
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales
from customers 
RIGHT JOIN orders
ON customers.id = orders.customer_id;

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from customers As c
RIGHT JOIN orders As o
ON c.id = o.customer_id;


/* Get all customers and all orders,
 Even if there's no match. */

select *
from customers
FULL JOIN orders
ON id = customer_id;

select 
	customers.id,
	customers.first_name,
	orders.order_id,
	orders.sales
from customers 
FULL JOIN orders
ON customers.id = orders.customer_id;

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from customers As c
FULL JOIN orders As o
ON c.id = o.customer_id;

select 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
from orders As o
FULL JOIN customers As c
ON c.id = o.customer_id;