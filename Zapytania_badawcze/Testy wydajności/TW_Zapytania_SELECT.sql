
--Testy wydajnościowe zapytania SELECT - tabela Orders i OrdersPartitioned

---- 1 zestaw zapytań
SELECT * FROM Orders 
WHERE OrderDate 
BETWEEN '2016-01-01' AND '2016-12-31' AND ShipCountry = 'Australia';

SELECT * FROM OrdersPartitioned
WHERE OrderDate 
BETWEEN '2016-01-01' AND '2016-12-31' AND ShipCountry = 'Australia';

SELECT * FROM OrdersPartitioned 
WHERE PartitionKey = 'A_2016';

---- 2 zestaw zapytań agregacja
--mssql
SELECT YEAR(OrderDate) AS Rok, COUNT(*) AS LiczbaZamowien
FROM Orders
WHERE OrderDate BETWEEN '2017-01-01' AND '2019-12-31'
AND ShipCountry = 'Australia'
GROUP BY YEAR(OrderDate);

SELECT YEAR(OrderDate) AS Rok, COUNT(*) AS LiczbaZamowien
FROM OrdersPartitioned
WHERE PartitionKey IN ('A_2017', 'A_2018', 'A_2019')
GROUP BY YEAR(OrderDate);

--postgres, oracle
SELECT 
EXTRACT(YEAR FROM OrderDate) AS Rok,
COUNT(*) AS LiczbaZamowien
FROM Orders
WHERE OrderDate BETWEEN '2017-01-01' AND '2019-12-31'
AND ShipCountry = 'Australia'
GROUP BY Rok;

SELECT 
EXTRACT(YEAR FROM OrderDate) AS Rok,
COUNT(*) AS LiczbaZamowien
FROM OrdersPartitioned
WHERE OrderDate BETWEEN '2017-01-01' AND '2019-12-31'
AND ShipCountry = 'Australia'
GROUP BY Rok;


---- 3 zestaw zapytań bez zakresu dat
SELECT *
FROM Orders
WHERE ShipCountry = 'Australia';

SELECT *
FROM OrdersPartitioned
WHERE ShipCountry = 'Australia';

SELECT *
FROM OrdersPartitioned
WHERE PartitionKey LIKE 'A_%';

---- 4 zestaw zapytań - dodatkowa filtracja po freight
SELECT *
FROM Orders
WHERE Freight > 100
AND OrderDate BETWEEN '2020-01-01' AND '2020-12-31'
AND ShipCountry = 'Brazil';

SELECT *
FROM OrdersPartitioned
WHERE Freight > 100
AND OrderDate BETWEEN '2020-01-01' AND '2020-12-31'
AND ShipCountry = 'Brazil';

SELECT *
FROM OrdersPartitioned
WHERE Freight > 100
AND PartitionKey = 'S_2020'
AND ShipCountry = 'Brazil';

---- 5 zestaw zapytań JOIN
--tabela Orders, mssql postgres
SELECT o.OrderID, o.OrderDate, c.CompanyName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '2021-01-01' AND '2021-12-31'
AND o.ShipCountry = 'Australia';
  
--oracle
SELECT o.OrderID, o.OrderDate, c.Company_Name
FROM Orders o
JOIN Customers c ON o.CustomerID = c.Customer_ID
WHERE o.OrderDate BETWEEN '2021-01-01' AND '2021-12-31'
AND o.ShipCountry = 'Australia';

SELECT o.OrderID, o.OrderDate, c.Company_Name
FROM OrdersPartitioned o
JOIN Customers c ON o.CustomerID = c.Customer_ID
WHERE o.OrderDate BETWEEN '2021-01-01' AND '2021-12-31'
AND o.ShipCountry = 'Australia';

--OrdersPartitioned, mssql
SELECT o.OrderID, o.OrderDate, c.CompanyName
FROM OrdersPartitioned o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.PartitionKey = 'A_2021';

--OrdersPartitioned, postgres
SELECT o.OrderID, o.OrderDate, c.CompanyName
FROM OrdersPartitioned o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '2021-01-01' AND '2021-12-31'
AND o.ShipCountry = 'Australia';
