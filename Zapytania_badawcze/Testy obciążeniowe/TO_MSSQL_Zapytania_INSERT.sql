--Testy obciązeniowe zapytania INSERT w MSSQL- tabela Orders i OrdersPartitioned
INSERT INTO Orders
(
    CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
    ShipVia, Freight, ShipName, ShipAddress, ShipCity, 
    ShipRegion, ShipPostalCode, ShipCountry
)
SELECT TOP (5000)
    CustomerID, EmployeeID, OrderDate,
    RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress,
    ShipCity, ShipRegion, ShipPostalCode, ShipCountry
FROM Orders;

INSERT INTO OrdersPartitioned
(
    CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
    ShipVia, Freight, ShipName, ShipAddress, ShipCity, 
    ShipRegion, ShipPostalCode, ShipCountry
)
SELECT TOP (5000)
    CustomerID, EmployeeID, OrderDate,
    RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress,
    ShipCity, ShipRegion, ShipPostalCode, ShipCountry
FROM OrdersPartitioned;
