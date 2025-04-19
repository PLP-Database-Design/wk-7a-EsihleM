--Question 1
SELECT 
    OrderID,
    CustomerName,
    LTRIM(RTRIM(value)) AS Product
FROM 
    ProductDetail
CROSS APPLY 
    STRING_SPLIT(Products, ',');

-- Question 2

SELECT DISTINCT
    OrderID,
    CustomerName
FROM 
    OrderDetails;

SELECT
    OrderID,
    Product,
    Quantity
FROM 
    OrderDetails;

