use MyDatabase;


-- show a list of customers first name together with their country in one column.

select 
	first_name,
	country,
	CONCAT(first_name,' ',country) as name_country
from customers;




-- Tranform the customer's first name to Lowercase.

select 
	first_name,
	LOWER(first_name) as Lower_name
from customers;




-- Tranform the customer's first name to uppercase.

select 
	first_name,
	UPPER(first_name) as upper_name
from customers;



-- Find customers whose first name contains leading or trailing spaces.

select 
	first_name
from customers
where first_name != Trim(First_name);



-- Remove dashes (-) from phone_number.

select
'123-456-7890' as Old_phone_number,
REPLACE('123-456-7890','-','') as New_phone_number;


-- Replace file extence from txt to csv.

select
'report.txt' as Old_file_name,
REPLACE('report.txt','txt','csv') as New_file_name;



-- Calculate the Length of each customers first name.

select 
	first_name,
	LEN(first_name) as Len_value
from customers;



-- Retrieve the first two characters of each first name.

select
	first_name,
	LEFT(First_name,2) as First_2_characters
from customers;

select
	first_name,
	LEFT(Trim(First_name),2) as First_2_characters
from customers;



-- Retrieve the last two characters of each first name.

select
	first_name,
	RIGHT(first_name,2) as Last_2_characters
from customers;



-- Retrieve a list of customers first name after removing the character.

select
	first_name,
	SUBSTRING(first_name,2,3) as Substring_characters
from customers;

select
	first_name,
	SUBSTRING(Trim(first_name),2,3) as Substring_characters
from customers;

select
	first_name,
	SUBSTRING(Trim(first_name),2,len(first_name)) as Substring_characters
from customers;




-- Number function
-- Round number

select
	3.516,
	ROUND(3.516,2) as Round_2,
	ROUND(3.516,1) as Round_1,
	ROUND(3.516,0) as Round_0


-- ABS 

select
	-10,
	ABS(-10),
	abs	(10)
