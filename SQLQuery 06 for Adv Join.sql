/* Get all customers who haven't placed any order. */

select *
from customers
LEFT JOIN orders
ON id = customer_id
where customer_id IS NULL;

select *
from customers
LEFT JOIN orders
ON customers.id = orders.customer_id
where orders.customer_id IS NULL;

select *
from customers As c
LEFT JOIN orders As o
ON c.id = o.customer_id
where o.customer_id IS NULL;


/* Get all oreders without matching customers. */

select *
from customers
RIGHT JOIN orders
ON id = customer_id
where id IS NULL;

select *
from customers As c
RIGHT JOIN orders As o
ON c.id = o.customer_id
where c.id IS NULL;

select *
from orders
LEFT JOIN customers
ON id = customer_id
where id IS NULL;

select *
from orders As o
LEFT JOIN customers As c
ON o.customer_id = c.id
where c.id IS NULL;


/* Find customers without orders and orders without customers. */

select *
from customers
FULL JOIN orders
ON id = customer_id
where id IS NULL
or customer_id IS NULL;

select *
from customers As c
FULL JOIN orders As o
ON c.id = o.customer_id
where c.id IS NULL
or o.customer_id IS NULL;


/* Gerenate all possible combinations of customers and orders. */

select *
from customers
CROSS JOIN orders;

select *
from orders
CROSS JOIN customers;