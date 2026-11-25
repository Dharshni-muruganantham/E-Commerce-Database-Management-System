-- =========================================================
-- E-COMMERCE DATABASE MANAGEMENT SYSTEM
-- Database: ecommerce_db
-- DBMS: MySQL
--
-- IMPORTANT:
-- This is a complete rebuild script. It drops the existing
-- project tables before recreating them and inserting sample data.
-- Back up any important data before running this script.
-- =========================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Drop tables in reverse dependency order
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;
SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
-- 1. TABLE CREATION
-- =========================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(30) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(30) DEFAULT 'Pending',
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT,
    review_comment VARCHAR(255),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- =========================================================
-- 2. SAMPLE DATA
-- =========================================================

INSERT INTO customers
    (customer_name, email, phone, city)
VALUES
    ('Arun', 'arun@gmail.com', '9876543210', 'Chennai'),
    ('Priya', 'priya@gmail.com', '9876543211', 'Bangalore'),
    ('Kumar', 'kumar@gmail.com', '9876543212', 'Trichy'),
    ('Divya', 'divya@gmail.com', '9876543213', 'Thanjavur'),
    ('Rahul', 'rahul@gmail.com', '9876543214', 'Chennai');

INSERT INTO categories (category_name, description)
VALUES
    ('Electronics', 'Electronic devices and accessories'),
    ('Fashion', 'Clothing and fashion products'),
    ('Books', 'Educational and reference books'),
    ('Home Appliances', 'Appliances for home use'),
    ('Sports', 'Sports equipment and accessories');

INSERT INTO products (product_name, category_id, price, stock)
VALUES
    ('Laptop', 1, 55000.00, 10),
    ('Smartphone', 1, 25000.00, 15),
    ('Headphones', 1, 2000.00, 30),
    ('T-Shirt', 2, 800.00, 50),
    ('Jeans', 2, 1500.00, 25),
    ('SQL Book', 3, 500.00, 40),
    ('Java Book', 3, 650.00, 35),
    ('Mixer Grinder', 4, 3000.00, 12),
    ('Cricket Bat', 5, 1200.00, 20),
    ('Football', 5, 900.00, 18);

INSERT INTO orders (customer_id, total_amount, order_status)
VALUES
    (1, 57000.00, 'Delivered'),
    (2, 27000.00, 'Shipped'),
    (3, 1150.00, 'Pending'),
    (4, 3000.00, 'Delivered'),
    (5, 2100.00, 'Pending');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
    (1, 1, 1, 55000.00),
    (1, 3, 1, 2000.00),
    (2, 2, 1, 25000.00),
    (2, 3, 1, 2000.00),
    (3, 6, 1, 500.00),
    (3, 7, 1, 650.00),
    (4, 8, 1, 3000.00),
    (5, 9, 1, 1200.00),
    (5, 10, 1, 900.00);

INSERT INTO payments (order_id, payment_method, payment_status, amount)
VALUES
    (1, 'UPI', 'Success', 57000.00),
    (2, 'Credit Card', 'Success', 27000.00),
    (3, 'UPI', 'Pending', 1150.00),
    (4, 'Debit Card', 'Success', 3000.00),
    (5, 'Net Banking', 'Pending', 2100.00);

INSERT INTO reviews (customer_id, product_id, rating, review_comment)
VALUES
    (1, 1, 5, 'Excellent laptop'),
    (2, 2, 4, 'Good smartphone'),
    (3, 6, 5, 'Very useful book'),
    (4, 8, 4, 'Works perfectly'),
    (5, 9, 3, 'Average quality');

-- =========================================================
-- 3. PROJECT QUERIES (15)
-- =========================================================

-- 1. Display all product names and prices
SELECT product_name, price
FROM products;

-- 2. Display products costing more than 2000
SELECT *
FROM products
WHERE price > 2000;

-- 3. Display products from highest to lowest price
SELECT *
FROM products
ORDER BY price DESC;

-- 4. Count total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 5. Find the average product price
SELECT AVG(price) AS average_price
FROM products;

-- 6. Display product names with category names
SELECT p.product_name, c.category_name
FROM products p
JOIN categories c
    ON p.category_id = c.category_id;

-- 7. Display customer names with their orders
SELECT c.customer_name, o.order_id, o.total_amount, o.order_status
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

-- 8. Display order details with product names
SELECT o.order_id, p.product_name, oi.quantity, oi.price
FROM order_items oi
JOIN orders o
    ON oi.order_id = o.order_id
JOIN products p
    ON oi.product_id = p.product_id;

-- 9. Display customer names with payment details
SELECT c.customer_name, p.payment_method, p.payment_status, p.amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN payments p
    ON o.order_id = p.order_id;

-- 10. Find customers who placed orders
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

-- 11. Find the highest-priced product
SELECT product_name, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- 12. Find products above average price
SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- 13. Calculate total successful payments
SELECT SUM(amount) AS total_sales
FROM payments
WHERE payment_status = 'Success';

-- 14. Count orders based on order status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

-- 15. Rank products based on price
SELECT
    product_name,
    price,
    DENSE_RANK() OVER (ORDER BY price DESC) AS price_rank
FROM products;

-- =========================================================
-- 4. FINAL VALIDATION QUERIES
-- =========================================================

-- Verify expected row counts
SELECT 'customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'payments', COUNT(*) FROM payments
UNION ALL
SELECT 'reviews', COUNT(*) FROM reviews;

-- Verify order totals against order item totals
SELECT
    o.order_id,
    o.total_amount AS order_total,
    SUM(oi.quantity * oi.price) AS calculated_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount;
