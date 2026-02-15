
Select *
INTO Sales.DBCustomers
from sales.Customers;


-- Clustered


CREATE CLUSTERED INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers (CustomerID)


DROP INDEX idx_DBCustomers_CustomerID
ON Sales.DBCustomers



select *
from Sales.DBCustomers
Where LastName = 'Brown'




-- Non_Clustered


CREATE NONCLUSTERED INDEX idx_DBCustomers_LastName 
ON Sales.DBCustomers (LastName)


CREATE INDEX idx_DBCustomers_FirstName
ON Sales.DBCustomers (FirstName)



CREATE NONCLUSTERED INDEX idx_DBCustomers_CountryScore
ON Sales.DBCustomers (Country, Score)


Select *
from Sales.DBCustomers
Where Country = 'USA' AND Score > 500





-- Clustered and Non_Clustered Row and Column store Index


CREATE CLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS 
ON Sales.DBCustomers

DROP INDEX [idx_DBCustomers_CustomerID] ON Sales.DBCUSTOMERS


DROP INDEX idx_DBCustomers_CS ON Sales.DBCUSTOMERS



CREATE NONCLUSTERED COLUMNSTORE INDEX idx_DBCustomers_CS_FirstName
ON Sales.DBCustomers (FirstName)




-- UNIQUE INDEX


Select * From sales.Products;



CREATE UNIQUE NONCLUSTERED INDEX idx_Products_category
ON Sales.Products (Category)


CREATE UNIQUE NONCLUSTERED INDEX idx_Products_Product
ON Sales.Products (Product)




-- FILTERED INDEX


select * from sales.Customers
Where Country = 'USA';


CREATE NONCLUSTERED INDEX idx_Customers_Country
ON Sales.customers (Country)
Where country = 'USA'