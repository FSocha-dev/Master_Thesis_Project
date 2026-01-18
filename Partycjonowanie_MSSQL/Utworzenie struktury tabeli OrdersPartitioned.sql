CREATE TABLE dbo.OrdersPartitioned
(
    OrderID INT IDENTITY (1, 1) NOT NULL,
    CustomerID NCHAR(5),
    EmployeeID INT,
    OrderDate DATETIME NOT NULL,
    RequiredDate DATETIME,
    ShippedDate DATETIME,
    ShipVia INT,
    Freight MONEY,
    ShipName NVARCHAR(40),
    ShipAddress NVARCHAR(60),
    ShipCity NVARCHAR(15),
    ShipRegion NVARCHAR(15),
    ShipPostalCode NVARCHAR(10),
    ShipCountry NVARCHAR(15),
     -- Klucz główny jako indeks klastrowany na PartitionKey i OrderID
    CONSTRAINT [PK_OrdersPartitioned] PRIMARY KEY CLUSTERED (PartitionKey, OrderID),

    CONSTRAINT [FK_OrdersPartitioned_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_OrdersPartitioned_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_OrdersPartitioned_Shippers] FOREIGN KEY ([ShipVia]) REFERENCES [dbo].[Shippers] ([ShipperID]),
    
    -- Kolumna obliczeniowa
    PartitionKey AS
    (
        CASE 
            WHEN ShipCountry = 'Australia' THEN 'A'
            WHEN ShipCountry IN ('USA','Canada','Mexico') THEN 'N'
            WHEN ShipCountry IN ('Brazil','Argentina','Venezuela') THEN 'S'
            WHEN ShipCountry IN ('Germany','France','Belgium','Poland','Spain',
                                 'Italy','Austria','Denmark','Finland','Sweden',
                                 'Switzerland','Ireland','Portugal','Norway') THEN 'E'
            ELSE NULL
        END
        + '_'
        + CONVERT(char(4), YEAR(OrderDate))
    )
    PERSISTED 
) 
ON PS_Orders_CompCol (PartitionKey);

GO
CREATE NONCLUSTERED INDEX [OrdersPartitioned_Date]
    ON [dbo].[OrdersPartitioned]([OrderDate] ASC);

GO
CREATE NONCLUSTERED INDEX [Shippers_OrdersPartitioned]
    ON [dbo].[OrdersPartitioned]([ShipVia] ASC);

GO
CREATE NONCLUSTERED INDEX [ShipPostalCode_OrdersPartitioned]
    ON [dbo].[OrdersPartitioned]([ShipPostalCode] ASC);

GO
CREATE NONCLUSTERED INDEX [CustomerID_OrdersPartitioned]
    ON [dbo].[OrdersPartitioned]([CustomerID] ASC);

GO
CREATE NONCLUSTERED INDEX [ShippedDate_OrdersPartitioned]
    ON [dbo].[OrdersPartitioned]([ShippedDate] ASC);

GO
CREATE NONCLUSTERED INDEX [EmployeeID_OrdersPartitioned]
    ON [dbo].[OrdersPartitioned]([EmployeeID] ASC);
GO
------------
SELECT MAX(OrderID) FROM dbo.OrdersPartitioned; --13605647

CREATE SEQUENCE dbo.Seq_OrdersPartitioned
    START WITH 13605648
    INCREMENT BY 1;
    
ALTER TABLE dbo.OrdersPartitioned
ADD CONSTRAINT DF_OrdersPartitioned_OrderID
DEFAULT (NEXT VALUE FOR dbo.Seq_OrdersPartitioned) FOR OrderID;
---------

--kopiowanie danych z Orders
INSERT INTO dbo.OrdersPartitioned
(
    CustomerID, EmployeeID, OrderDate, RequiredDate,
    ShippedDate, ShipVia, Freight, ShipName, 
    ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
)
SELECT 
    CustomerID, EmployeeID, OrderDate, RequiredDate,
    ShippedDate, ShipVia, Freight, ShipName, 
    ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
FROM dbo.Orders;


