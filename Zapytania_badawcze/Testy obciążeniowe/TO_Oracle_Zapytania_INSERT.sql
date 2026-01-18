--Testy obciązeniowe zapytania INSERT w Oracle - tabela Orders i OrdersPartitioned
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
FETCH FIRST 5000 ROWS ONLY;


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
FETCH FIRST 5000 ROWS ONLY;

