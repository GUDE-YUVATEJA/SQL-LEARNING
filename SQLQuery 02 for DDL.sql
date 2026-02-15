/* Create a new table called persons
with columns: id, person_name, birth_date and phone */

Create table persons (
	id int NOT NULL,
	person_name varchar(50) NOT NULL,
	birth_date date,
	phone varchar(15) NOT NULL,
	constraint PK_persons PRIMARY KEY (id)
	);

	select * from persons;


-- Add a new column called email to the persons table

Alter table persons
add email varchar(50) NOT NULL;

select * from persons;


-- Remove the column phone from the persons table

Alter table persons
drop column phone;

select * from persons;


-- Delete the table persons from the database

drop table persons;