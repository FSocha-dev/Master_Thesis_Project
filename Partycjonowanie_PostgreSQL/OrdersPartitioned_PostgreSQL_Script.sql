DROP TABLE IF EXISTS OrdersPartitioned CASCADE;

CREATE TABLE OrdersPartitioned (
    OrderID        INT GENERATED ALWAYS AS IDENTITY,
    CustomerID     VARCHAR(10),
    EmployeeID     INT,
    OrderDate      DATE     NOT NULL,
    RequiredDate   DATE,
    ShippedDate    DATE,
    ShipVia        INT,
    Freight        NUMERIC,
    ShipName       VARCHAR(100),
    ShipAddress    VARCHAR(255),
    ShipCity       VARCHAR(100),
    ShipRegion     VARCHAR(100),
    ShipPostalCode VARCHAR(20),
    ShipCountry    VARCHAR(100) NOT NULL,
	PRIMARY KEY (OrderID, ShipCountry, OrderDate)
) PARTITION BY LIST (ShipCountry);

DO $$
DECLARE
    country  TEXT;
    yr       INT;
	start_d   DATE;  
    end_d     DATE; 
    countries CONSTANT TEXT[] := ARRAY[
        'Argentina','Australia','Austria','Belgium','Brazil','Canada',
        'Denmark','Finland','France','Germany','Ireland','Italy','Mexico',
        'Norway','Poland','Portugal','Spain','Sweden','Switzerland',
        'USA','Venezuela'
    ];
BEGIN
    FOREACH country IN ARRAY countries LOOP 
        EXECUTE format(
            'CREATE TABLE IF NOT EXISTS %I
               PARTITION OF OrdersPartitioned
               FOR VALUES IN (%L)
               PARTITION BY RANGE (OrderDate);',
            'orders_' || country, country);

        FOR yr IN 1996..2025 LOOP
			start_d := make_date(yr, 1, 1);   
    		end_d   := make_date(yr + 1, 1, 1); 
			
            EXECUTE format(
                'CREATE TABLE IF NOT EXISTS %I
                   PARTITION OF %I
                   FOR VALUES FROM (%L) TO (%L);',
                'orders_' || country || '_' || yr, 'orders_' || country, start_d, end_d);
        END LOOP;
    END LOOP;
END $$;

DROP INDEX IF EXISTS "ShippedDate";
DROP INDEX IF EXISTS "EmployeeID";
DROP INDEX IF EXISTS "ShippersOrders";
DROP INDEX IF EXISTS "ShipPostalCode";
DROP INDEX IF EXISTS "CustomerID";
DROP INDEX IF EXISTS "OrderDate";
 
CREATE INDEX IF NOT EXISTS "ShippedDate" ON OrdersPartitioned (ShippedDate);
CREATE INDEX IF NOT EXISTS "EmployeeID" ON OrdersPartitioned (EmployeeID);
CREATE INDEX IF NOT EXISTS "ShippersOrders" ON OrdersPartitioned (ShipVia);
CREATE INDEX IF NOT EXISTS "ShipPostalCode" ON OrdersPartitioned (ShipPostalCode);
CREATE INDEX IF NOT EXISTS "CustomerID" ON OrdersPartitioned (CustomerID);
CREATE INDEX IF NOT EXISTS "OrderDate" ON OrdersPartitioned (OrderDate);


ALTER TABLE OrdersPartitioned
    ADD CONSTRAINT fk_orders_shippers
        FOREIGN KEY (ShipVia)
        REFERENCES shippers (shipperid);

ALTER TABLE OrdersPartitioned
    ADD CONSTRAINT fk_orders_employees
        FOREIGN KEY (EmployeeID)
        REFERENCES employees (employeeid);

ALTER TABLE OrdersPartitioned
    ADD CONSTRAINT fk_orders_customers
        FOREIGN KEY (CustomerID)
        REFERENCES customers (customerid);