CREATE DATABASE ProductReviewDB;
USE ProductReviewDB;

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2)
);

CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL
);

CREATE TABLE Review (
    Review_ID INT PRIMARY KEY,
    Product_ID INT,
    Customer_ID INT,
    Review_Text VARCHAR(500),
    Review_Date DATE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Rating (
    Rating_ID INT PRIMARY KEY,
    Review_ID INT,
    Product_ID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    FOREIGN KEY (Review_ID) REFERENCES Review(Review_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

INSERT INTO Product VALUES
(101, 'Laptop', 55000.00),
(102, 'Smartphone', 25000.00),
(103, 'Headphones', 3000.00),
(104, 'Smart Watch', 5000.00);

INSERT INTO Customer VALUES
(1, 'Arun'),
(2, 'Kumar'),
(3, 'Priya'),
(4, 'Divya');

INSERT INTO Review VALUES
(201, 101, 1, 'Excellent laptop with good performance', '2026-09-01'),
(202, 102, 2, 'Good smartphone and camera', '2026-09-02'),
(203, 103, 3, 'Very good sound quality', '2026-09-03'),
(204, 101, 4, 'Good battery life', '2026-09-04'),
(205, 104, 1, 'Nice design and useful features', '2026-09-05');

INSERT INTO Rating VALUES
(301, 201, 101, 5),
(302, 202, 102, 4),
(303, 203, 103, 5),
(304, 204, 101, 4),
(305, 205, 104, 5);

SELECT 
    p.Product_ID,
    p.Product_Name,
    AVG(rt.Rating) AS Average_Rating
FROM Product p
JOIN Rating rt ON p.Product_ID = rt.Product_ID
GROUP BY p.Product_ID, p.Product_Name;

SELECT 
    p.Product_ID,
    p.Product_Name,
    AVG(rt.Rating) AS Average_Rating
FROM Product p
JOIN Rating rt ON p.Product_ID = rt.Product_ID
GROUP BY p.Product_ID, p.Product_Name
HAVING AVG(rt.Rating) >= 4.5
ORDER BY Average_Rating DESC;

