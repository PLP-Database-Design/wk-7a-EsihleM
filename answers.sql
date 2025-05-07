--Question 1
SELECT 
    OrderID,
    CustomerName,
    TRIM(unnest(string_to_array(Products, ','))) AS Product
FROM 
    ProductDetail;

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
