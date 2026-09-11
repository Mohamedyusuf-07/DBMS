CREATE DATABASE orderManagamentDB;

USE orderManagamentDB;

CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2)
);

CREATE TABLE ORDER_DETAILS (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (order_id)
    REFERENCES ORDERS(order_id)
);

SHOW TABLES;

-- Insert Orders
INSERT INTO ORDERS
(order_id, customer_id, order_date, total_amount)
VALUES
(201, 11, '2026-01-15', 750.00),
(202, 12, '2026-02-10', 1200.00),
(203, 13, '2026-03-05', 450.00),
(204, 14, '2026-04-12', 1800.00),
(205, 15, '2026-05-20', 950.00);

-- Insert Order Details
INSERT INTO ORDER_DETAILS
(order_details_id, order_id, product_name, quantity, price, total_amount)
VALUES
(1, 201, 'Keyboard', 1, 750.00, 750.00),
(2, 202, 'Mouse', 3, 400.00, 1200.00),
(3, 203, 'Headset', 1, 450.00, 450.00),
(4, 204, 'Monitor', 2, 900.00, 1800.00),
(5, 205, 'Webcam', 1, 950.00, 950.00);

-- Display Tables
SELECT * FROM ORDERS;

SELECT * FROM ORDER_DETAILS;

-- Display Table Structure
DESC ORDERS;

DESC ORDER_DETAILS;

-- Add New Order
INSERT INTO ORDERS
(order_id, customer_id, order_date, total_amount)
VALUES
(206, 16, '2026-06-18', 1600.00);

INSERT INTO ORDER_DETAILS
(order_details_id, order_id, product_name, quantity, price, total_amount)
VALUES
(6, 206, 'Printer', 2, 800.00, 1600.00);

-- Update Order Amount
UPDATE ORDERS
SET total_amount = 850.00
WHERE order_id = 201;

-- Update Order Details
UPDATE ORDER_DETAILS
SET quantity = 2,
    total_amount = 1500.00
WHERE order_details_id = 1;

-- Update Order Date
UPDATE ORDERS
SET order_date = '2026-01-20'
WHERE order_id = 201;

-- Find Orders of a Specific Customer
SELECT *
FROM ORDERS
WHERE customer_id = 11;

-- Find High Value Orders
SELECT *
FROM ORDERS
WHERE total_amount > 1000;

-- Find Orders Between Two Dates
SELECT *
FROM ORDERS
WHERE order_date
BETWEEN '2026-01-01' AND '2026-12-31';

-- Display Order and Product Details
SELECT
    o.customer_id,
    o.order_id,
    o.order_date,
    od.product_name,
    od.quantity,
    od.price,
    od.total_amount
FROM ORDERS o
JOIN ORDER_DETAILS od
ON o.order_id = od.order_id
ORDER BY o.customer_id;

-- Display Complete Order Information
SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_amount AS order_total,
    od.product_name,
    od.quantity,
    od.price,
    od.total_amount AS product_total
FROM ORDERS o
INNER JOIN ORDER_DETAILS od
ON o.order_id = od.order_id;

-- Calculate Total Order Amount
SELECT SUM(total_amount) AS total_sales
FROM ORDERS;

-- Calculate Average Order Amount
SELECT AVG(total_amount) AS average_order_value
FROM ORDERS;

-- Find Highest Order Amount
SELECT MAX(total_amount) AS highest_order_value
FROM ORDERS;

-- Find Lowest Order Amount
SELECT MIN(total_amount) AS lowest_order_value
FROM ORDERS;

-- Count Total Orders
SELECT COUNT(*) AS total_orders
FROM ORDERS;

-- Customer-wise Order Report
SELECT
    customer_id,
    COUNT(order_id) AS number_of_orders,
    SUM(total_amount) AS total_spent
FROM ORDERS
GROUP BY customer_id;

-- Delete Newly Added Order Details
DELETE FROM ORDER_DETAILS
WHERE order_id = 206;

-- Delete Newly Added Order
DELETE FROM ORDERS
WHERE order_id = 206;

-- Display Final Orders
SELECT * FROM ORDERS;

-- Display Final Order Details
SELECT * FROM ORDER_DETAILS;

-- Final Order Report
SELECT
    o.customer_id,
    o.order_id,
    o.order_date,
    od.product_name,
    od.quantity,
    od.price,
    od.total_amount
FROM ORDERS o
INNER JOIN ORDER_DETAILS od
ON o.order_id = od.order_id
ORDER BY o.customer_id;