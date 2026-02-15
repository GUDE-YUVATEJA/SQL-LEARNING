use SalesDB;

-- orders data are stored in separate table (orders and ordersarchive).
-- combine all orders data into one report without duplicates


select 
    'order' as sourcetable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
from sales.Orders
UNION
select 
    'orderarchive' as sourcetable,
    OrderID,
    ProductID,
    CustomerID,
    SalesPersonID,
    OrderDate,
    ShipDate,
    OrderStatus,
    ShipAddress,
    BillAddress,
    Quantity,
    Sales,
    CreationTime
from sales.OrdersArchive
order by OrderID;

