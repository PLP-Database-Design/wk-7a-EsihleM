--Question 1
-- Create the ProductDetail table
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert the sample data
INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES
    (101, 'John Doe', 'Laptop, Mouse'),
    (102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Transform to 1NF using string_to_array and unnest (PostgreSQL)
SELECT 
    OrderID,
    CustomerName,
    TRIM(unnest(string_to_array(Products, ','))) AS Product
FROM 
    ProductDetail;

-- Alternative for MySQL
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', numbers.n), ',', -1)) AS Product
FROM 
    ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
) AS numbers
WHERE 
    CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1;


-- Question 2

-- First table: Orders (OrderID, CustomerName)
SELECT DISTINCT
    OrderID,
    CustomerName
FROM 
    Orders;

-- Second table: Product details (OrderID, Product, Quantity)
SELECT
    OrderID,
    Product,
    Quantity
FROM 
    Product;
