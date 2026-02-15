use salesDB;

/* Task : Using SalesDB, Reterieve a list of all orders, along with 
the related customer, product and employee details. for each order, 
display : Order ID, customer's name, product name, sales, price, sales person's name */


select *
from sales.orders;

select *
from sales.Customers;

select *
from sales.Employees;

select *
from sales.Products;

select *
from sales.OrdersArchive;


select 
	o.OrderID,
	o.Sales,
	c.FirstName as customerfirstname,
	c.LastName as customerlastname,
	p.product as productname,
	e.FirstName as employeefirstname,
	e.LastName as employeelastname
from sales.orders as o
Left Join sales.Customers as c
ON o.CustomerID = c.CustomerID
Left Join sales.Products as p
ON o.ProductID = p.ProductID
Left Join sales.Employees as e
ON o.SalesPersonID = e.EmployeeID