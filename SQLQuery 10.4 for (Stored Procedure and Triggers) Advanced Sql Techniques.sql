
-- Stored Procedure

1st method

-- Step 1: Write a Query
-- For US Customers Find the total number of Customers and the average score

Select
	COUNT(*) as TotalCustomers,
	Avg(score) as AvgScore
from sales.Customers
Where Country = 'USA';



-- Step 2: Turning the query INTO a stored procedure

CREATE PROCEDURE GetCustomerSummary As
Begin
Select
	COUNT(*) as TotalCustomers,
	Avg(score) as AvgScore
from sales.Customers
Where Country = 'USA'
End


-- Step 3: Execute the stored Procedure

Exec GetCustomerSummary


-- 2nd method

Alter PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
As
Begin
Select
	COUNT(*) as TotalCustomers,
	Avg(score) as AvgScore
from sales.Customers
Where Country = @Country;

-- Find the Total Nr. of orders and total sales

Select
	Count(*) As totalorders,
	Sum(sales) as Totalsales
from sales.Orders as o
Join sales.Customers as c
ON c.CustomerID = o.CustomerID
Where Country = @Country;

End


Exec GetCustomerSummary



-- For Germany Customers Find the total number of Customers and the average score

-- 1st method


CREATE PROCEDURE GetCustomerSummaryGermany As
Begin
Select
	COUNT(*) as TotalCustomers,
	Avg(score) as AvgScore
from sales.Customers
Where Country = 'Germany'
End


Exec GetCustomerSummaryGermany


Drop Procedure GetCustomerSummaryGermany



-- 2nd Method


Exec GetCustomerSummary @country = 'Germany'

Exec GetCustomerSummary @country = 'USA'




-- Total customers from Germany : 2
-- Average score from Germany : 425


Alter PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
As
Begin
DECLARE @TotalCustomers INT, @AvgScore FLOAT;
Select
	@TotalCustomers = COUNT(*),
	@AvgScore = Avg(score)
from sales.Customers
Where Country = @Country;

Print 'Total customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
Print 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

Select
	Count(*) As totalorders,
	Sum(sales) as Totalsales
from sales.Orders as o
Join sales.Customers as c
ON c.CustomerID = o.CustomerID
Where Country = @Country;

End


Exec GetCustomerSummary

Exec GetCustomerSummary @country = 'Germany'





-- IF Else NUll values



Alter PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
As
BEGIN
DECLARE @TotalCustomers INT, @AvgScore FLOAT;

-- Prepare and Cleanup Data
IF EXISTS ( Select 1 from sales.Customers Where Score IS NULL And Country = @Country)
BEGIN
	Print('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	Where Score IS NULL AND Country = @Country;
END

ELSE 
BEGIN 
	Print('No NULL Scores Found')
END;

-- Generating Reports
Select
	@TotalCustomers = COUNT(*),
	@AvgScore = Avg(score)
from sales.Customers
Where Country = @Country;

Print 'Total customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
Print 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

Select
	Count(*) As totalorders,
	Sum(sales) as Totalsales
from sales.Orders as o
Join sales.Customers as c
ON c.CustomerID = o.CustomerID
Where Country = @Country;
END


EXEC GetCustomerSummary

EXEC GetCustomerSummary @country = 'Germany'




-- Error handling


Alter PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
As
BEGIN
BEGIN TRY
DECLARE @TotalCustomers INT, @AvgScore FLOAT;

-- Prepare and Cleanup Data
IF EXISTS ( Select 1 from sales.Customers Where Score IS NULL And Country = @Country)
BEGIN
	Print('Updating NULL Scores to 0');
	UPDATE Sales.Customers
	SET Score = 0
	Where Score IS NULL AND Country = @Country;
END

ELSE 
BEGIN 
	Print('No NULL Scores Found')
END;

-- Generating Reports
Select
	@TotalCustomers = COUNT(*),
	@AvgScore = Avg(score)
from sales.Customers
Where Country = @Country;

Print 'Total customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
Print 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

Select
	Count(*) As totalorders,
	Sum(sales) as Totalsales,
	1/0
from sales.Orders as o
Join sales.Customers as c
ON c.CustomerID = o.CustomerID
Where Country = @Country;
END TRY
BEGIN CATCH
	Print('An Error occured.');
	Print('Error Message: ' + ERROR_MESSAGE());
	Print('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
	Print('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
	Print('Error Procedure: ' + ERROR_PROCEDURE());
END CATCH
END



EXEC GetCustomerSummary

EXEC GetCustomerSummary @country = 'Germany'




-- How to style the Data to see and understand


Alter PROCEDURE GetCustomerSummary @Country NVARCHAR(50) = 'USA'
As
BEGIN
	BEGIN TRY
		DECLARE @TotalCustomers INT, @AvgScore FLOAT;

		-- Step 1 : Prepare and Cleanup Data

		IF EXISTS ( Select 1 from sales.Customers Where Score IS NULL And Country = @Country)
		BEGIN
			Print('Updating NULL Scores to 0');
			UPDATE Sales.Customers
			SET Score = 0
			Where Score IS NULL AND Country = @Country;
		END

		ELSE 
		BEGIN 
			Print('No NULL Scores Found')
		END;

		--  Step 2 : Generating Summary Reports
		
		-- Calculate total customers and average score for specific country
		Select
			@TotalCustomers = COUNT(*),
			@AvgScore = Avg(score)
		from sales.Customers
		Where Country = @Country;

		Print 'Total customers from ' + @Country + ':' + CAST(@TotalCustomers AS NVARCHAR);
		Print 'Average score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR);

		-- Calculate total number of orders and total sales for specific country

		Select
			Count(*) As totalorders,
			Sum(sales) as Totalsales
		from sales.Orders as o
		Join sales.Customers as c
		ON c.CustomerID = o.CustomerID
		Where Country = @Country;
	END TRY
			-- ERROR HANDLING

	BEGIN CATCH
		Print('An Error occured.');
		Print('Error Message: ' + ERROR_MESSAGE());
		Print('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		Print('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
		Print('Error Procedure: ' + ERROR_PROCEDURE());
	END CATCH
END



EXEC GetCustomerSummary

EXEC GetCustomerSummary @country = 'Germany'





-- TRIGGERS

CREATE TABLE Sales.EmployeeLogs
(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)


CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
After Insert
AS
BEGIN
	Insert Into Sales.employeeLogs (EmployeeID, LogMessage, LogDate)
	Select
		EmployeeID,
		'New Employee Added =' + CAST(EmployeeID AS VARCHAR),
		Getdate()
	From inserted
END



select * From sales.Employeelogs

INSERT INTO Sales.Employees
Values
(7, 'Teja', 'Teja', 'HR', '2002-09-30', 'M', 90000, 3)


select
*
from Sales.Employees