-- Data manipulation language (DML) (Insert,Update, Delete)

Create table persons ( 
	id int NOT NULL,
	person_name varchar(50) NOT NULL,
	birth_date date,
	phone varchar(15) NOT NULL,
	constraint pk_persons primary key (id)
);


Insert into customers (id, first_name, country, score)
values 
	(12, 'USA', 'MAX', NULL);

select * from customers;


-- Insert data from 'customers' into 'persons'

Insert into persons (id, person_name, birth_date, phone)
select 
	id, 
	first_name, 
	NULL,
	'Unknown'
from customers;

select * from persons;



-- change the score of customer 8 to 0 

select * 
from customers;

Update customers
set score = 0
where id = 8;

select * 
from customers;



/* change the score of customers 9  to 200
	and update the country to USA */

update customers
set 
	score = 200,
	country = 'USA'
where id = 9;

select *
from customers;


/* Update all customers with a NULL score
	by setting their score to 0 */

update customers
set score = 0
where score is null;

select *
from customers;



-- Delete all customers with an id grather than 5 

delete from customers
where id > 5;

select *
from customers;


-- Delete all data from table persons

Truncate table persons;

select *
from persons;