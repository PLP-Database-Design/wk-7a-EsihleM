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

-- Create the OrderDetails table (already in 1NF)
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

-- Insert the sample data
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
    (101, 'John Doe', 'Laptop', 2),
    (101, 'John Doe', 'Mouse', 1),
    (102, 'Jane Smith', 'Tablet', 3),
    (102, 'Jane Smith', 'Keyboard', 1),
    (102, 'Jane Smith', 'Mouse', 2),
    (103, 'Emily Clark', 'Phone', 1);

-- Create Orders table (OrderID, CustomerName)
CREATE TABLE Orders AS
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM 
    OrderDetails;

-- Add primary key to Orders table
ALTER TABLE Orders
ADD PRIMARY KEY (OrderID);

-- Create OrderItems table (OrderID, Product, Quantity)
CREATE TABLE OrderItems AS
SELECT 
    OrderID, 
    Product, 
    Quantity
FROM 
    OrderDetails;

-- Add composite primary key to OrderItems table
ALTER TABLE OrderItems
ADD PRIMARY KEY (OrderID, Product);

-- Add foreign key constraint
ALTER TABLE OrderItems
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);
