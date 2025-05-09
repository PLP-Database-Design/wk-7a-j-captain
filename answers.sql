-- MWANGI JOSPHAT KARANJA SQL WEEK 7

-- Question 1: Achieving 1NF (First Normal Form)
SELECT 
  OrderID, 
  CustomerName, 
  TRIM(value) AS Products
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ','); 

-- Question 2 Achieving 2NF (Second Normal Form)
-- I created a table to remove partial dependency on OrderID
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(255)
);

-- Dumping data into the orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- I now created a table for order-specific product details
CREATE TABLE OrderProducts (
  OrderID INT,
  Product VARCHAR(255),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Dumping data into the OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
