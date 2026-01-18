--Testy wydajnościowe zapytania INSERT w Oracle - tabela Orders i OrdersPartitioned
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
FETCH FIRST 50000 ROWS ONLY;


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
FETCH FIRST 50000 ROWS ONLY;

