DECLARE @targetCount INT = 12000000;
DECLARE @currentCount INT;

-- Sprawdź bieżącą liczbę rekordów
SELECT @currentCount = COUNT(*) FROM Orders;

-- Pętla dopóki liczba rekordów nie osiągnie celu
WHILE @currentCount < @targetCount
BEGIN
    INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipVia, Freight, 
    ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
    SELECT 
        CustomerID,
        EmployeeID,
        DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 9131), '1996-01-01') AS OrderDate, -- Losowa data od 2000-01-01
        ShipVia,
        Freight,
        ShipName,
        ShipAddress,
        ShipCity,
        ShipRegion,
        ShipPostalCode,
        ShipCountry
    FROM Orders;

    -- Aktualizacja liczby rekordów
    SELECT @currentCount = COUNT(*) FROM Orders;
END;


---------- wypełnienie pustych pól ShippedDate > OrderDate
WHILE EXISTS (SELECT 1 FROM Orders WHERE ShippedDate IS NULL)
BEGIN
    UPDATE TOP (50000) Orders
    SET ShippedDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 10) + 1, OrderDate)
    WHERE ShippedDate IS NULL;
END;

---------- wypełnienie pustych pól RequiredDate > ShippedDate
WHILE EXISTS (SELECT 1 FROM Orders WHERE RequiredDate IS NULL)
BEGIN
    UPDATE TOP (50000) Orders
    SET RequiredDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 40) + 1, ShippedDate)
    WHERE RequiredDate IS NULL;
END;