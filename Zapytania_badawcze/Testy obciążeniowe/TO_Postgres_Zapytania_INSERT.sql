--Testy obciązeniowe zapytania INSERT w Postgres - tabela Orders i OrdersPartitioned
INSERT INTO Orders
(
    CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
    ShipVia, Freight, ShipName, ShipAddress, ShipCity, 
    ShipRegion, ShipPostalCode, ShipCountry
)
SELECT
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShippedDate,
    ShipVia,
    Freight,
    ShipName,
    ShipAddress,
    ShipCity,
    ShipRegion,
    ShipPostalCode,
    ShipCountry
FROM Orders
LIMIT 5000;


INSERT INTO OrdersPartitioned
(
    CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate,
    ShipVia, Freight, ShipName, ShipAddress, ShipCity, 
    ShipRegion, ShipPostalCode, ShipCountry
)
SELECT
    CustomerID,
    EmployeeID,
    OrderDate,
    RequiredDate,
    ShippedDate,
    ShipVia,
    Freight,
    ShipName,
    ShipAddress,
    ShipCity,
    ShipRegion,
    ShipPostalCode,
    ShipCountry
FROM OrdersPartitioned
LIMIT 5000;

