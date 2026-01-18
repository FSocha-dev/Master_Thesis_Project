--Testy wydajnościowe zapytania UPDATE - tabela Orders i OrdersPartitioned
UPDATE Orders SET Freight = Freight + 1 
WHERE ShipCountry = 'Australia' AND OrderDate BETWEEN '2020-01-01' AND '2020-12-31';

UPDATE OrdersPartitioned SET Freight = Freight + 1 
WHERE ShipCountry = 'Australia' AND OrderDate BETWEEN '2020-01-01' AND '2020-12-31';

UPDATE OrdersPartitioned SET Freight = Freight + 1 
WHERE PartitionKey = 'A_2021';
