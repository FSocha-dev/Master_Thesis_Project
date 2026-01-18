--Testy wydajnościowe zapytania INSERT w MSSQL - tabela Orders i OrdersPartitioned
INSERT INTO dbo.Orders
(
    CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
    ShipVia, Freight, ShipName, ShipAddress, ShipCity, 
    ShipRegion, ShipPostalCode, ShipCountry
)
SELECT TOP (50000)
    CustomerID, EmployeeID, OrderDate,
    RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress,
    ShipCity, ShipRegion, ShipPostalCode, ShipCountry
FROM dbo.Orders;

INSERT INTO dbo.OrdersPartitioned
(
    CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
    ShipVia, Freight, ShipName, ShipAddress, ShipCity, 
    ShipRegion, ShipPostalCode, ShipCountry
)
SELECT TOP (50000)
    CustomerID, EmployeeID, OrderDate,
    RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress,
    ShipCity, ShipRegion, ShipPostalCode, ShipCountry
FROM dbo.OrdersPartitioned;
