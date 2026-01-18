--Testy obciązeniowe zapytania SELECT - tabela Orders i OrdersPartitioned

--1 zestaw zapytań
SELECT OrderID, OrderDate, Freight
FROM Orders
WHERE ShipCountry = 'Australia'
  AND OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

SELECT OrderID, OrderDate, Freight
FROM OrdersPartitioned
WHERE ShipCountry = 'Australia'
  AND OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

SELECT OrderID, OrderDate, Freight
FROM OrdersPartitioned
WHERE PartitionKey = 'A_2020';

--2 zestaw zapytań bez ShipCountry
SELECT OrderID, OrderDate, Freight, ShipCity
FROM Orders
WHERE OrderDate BETWEEN '2008-01-01' AND '2008-12-31';

SELECT OrderID, OrderDate, Freight, ShipCity
FROM OrdersPartitioned
WHERE OrderDate BETWEEN '2008-01-01' AND '2008-12-31';

SELECT OrderID, OrderDate, Freight, ShipCity
FROM OrdersPartitioned
WHERE PartitionKey IN ('A_2008','N_2008', 'S_2008', 'E_2008');
