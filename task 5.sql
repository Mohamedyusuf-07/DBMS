CREATE DATABASE TransactionManagementDB;
USE TransactionManagementDB;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE PaymentTransaction (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_type VARCHAR(30) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    transaction_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id)
    REFERENCES Customer(customer_id)
);

INSERT INTO Customer VALUES
(101, 'Rahul Kumar', 'rahul@gmail.com', '9876501001', 'Chennai'),
(102, 'Priya Sharma', 'priya@gmail.com', '9876501002', 'Madurai'),
(103, 'Vignesh Raj', 'vignesh@gmail.com', '9876501003', 'Coimbatore'),
(104, 'Anjali Devi', 'anjali@gmail.com', '9876501004', 'Salem'),
(105, 'Sanjay Kumar', 'sanjay@gmail.com', '9876501005', 'Trichy');

INSERT INTO PaymentTransaction VALUES
(701, 101, 'Purchase', 'UPI', '2026-09-01', 8500.00, 'Successful'),
(702, 102, 'Purchase', 'Debit Card', '2026-09-02', 6200.00, 'Successful'),
(703, 103, 'Refund', 'UPI', '2026-09-03', 2500.00, 'Completed'),
(704, 104, 'Purchase', 'Net Banking', '2026-09-04', 11500.00, 'Failed'),
(705, 105, 'Purchase', 'Credit Card', '2026-09-05', 9300.00, 'Successful'),
(706, 101, 'Purchase', 'Cash', '2026-09-06', 4500.00, 'Successful'),
(707, 103, 'Purchase', 'UPI', '2026-09-07', 12800.00, 'Pending'),
(708, 102, 'Purchase', 'Credit Card', '2026-09-08', 7600.00, 'Successful');




SELECT *
FROM PaymentTransaction
WHERE transaction_status = 'Pending';


UPDATE PaymentTransaction
SET transaction_status = 'Successful'
WHERE transaction_id = 707;

SELECT
    t.transaction_id,
    c.customer_name,
    t.transaction_type,
    t.payment_method,
    t.transaction_date,
    t.amount,
    t.transaction_status
FROM PaymentTransaction t
JOIN Customer c
    ON t.customer_id = c.customer_id
ORDER BY t.transaction_date;

SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM PaymentTransaction
GROUP BY payment_method
ORDER BY total_transactions DESC;


SELECT
    payment_method,
    SUM(amount) AS total_amount
FROM PaymentTransaction
WHERE transaction_status = 'Successful'
GROUP BY payment_method
ORDER BY total_amount DESC;

SELECT
    transaction_status,
    COUNT(*) AS total_transactions
FROM PaymentTransaction
GROUP BY transaction_status;

SELECT
    SUM(amount) AS total_successful_amount
FROM PaymentTransaction
WHERE transaction_status = 'Successful';

SELECT
    SUM(amount) AS total_failed_amount
FROM PaymentTransaction
WHERE transaction_status = 'Failed';


SELECT
    c.customer_id,
    c.customer_name,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(
        CASE
            WHEN t.transaction_status = 'Successful'
            THEN t.amount
            ELSE 0
        END
    ) AS successful_amount
FROM Customer c
LEFT JOIN PaymentTransaction t
    ON c.customer_id = t.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY successful_amount DESC;

SELECT
    transaction_date,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM PaymentTransaction
GROUP BY transaction_date
ORDER BY transaction_date;

SELECT
    t.transaction_id,
    c.customer_name,
    t.transaction_type,
    t.payment_method,
    t.transaction_date,
    t.amount,
    t.transaction_status
FROM PaymentTransaction t
JOIN Customer c
    ON t.customer_id = c.customer_id
ORDER BY t.transaction_id;



