--Testy obciązeniowe zapytania UPDATE - tabela Orders i OrdersPartitioned
UPDATE Orders
SET ShippedDate = ShippedDate + 1
WHERE OrderID BETWEEN 12345 AND 20345
AND ShipCountry = 'Australia';

UPDATE OrdersPartitioned
SET ShippedDate = ShippedDate + 1
WHERE OrderID BETWEEN 12345 AND 20345
AND ShipCountry = 'Australia';

UPDATE OrdersPartitioned
SET ShippedDate = ShippedDate + 1
WHERE OrderID BETWEEN 12345 AND 20345
AND PartitionKey LIKE 'A_%';

