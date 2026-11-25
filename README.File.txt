# E-Commerce Database Management System

## Project Overview

The **E-Commerce Database Management System** is a SQL-based database project designed to manage the core operations of an online shopping platform.

It organizes customer information, product categories, products, orders, order items, payments, and customer reviews using a relational database.

## Objectives

- Manage customer information.
- Organize products into categories.
- Maintain customer orders and order details.
- Track payment methods and payment statuses.
- Store customer product reviews.
- Retrieve useful business information using SQL queries.

## Technologies Used

- **Database:** MySQL
- **Database Tool:** MySQL Workbench
- **Query Language:** SQL
- **Version Control:** Git and GitHub

## Database Structure

The project contains seven relational tables:

| Table | Description |
|---|---|
| customers | Stores customer details |
| categories | Stores product categories |
| products | Stores product information |
| orders | Stores customer orders |
| order_items | Stores products included in each order |
| payments | Stores payment information |
| reviews | Stores customer product reviews |

## Database Relationships

- One customer can place multiple orders.
- One category can contain multiple products.
- One order can contain multiple order items.
- One product can appear in multiple order items.
- Orders are associated with payment records.
- Customers can submit product reviews.

See the ER diagram: `ecommerce_er_diagram.png`

## SQL Concepts Implemented

This project demonstrates:

- CREATE, INSERT, UPDATE and DELETE
- SELECT, WHERE and ORDER BY
- Aggregate functions: COUNT, SUM and AVG
- GROUP BY and DISTINCT
- INNER JOIN
- Subqueries
- UNION and UNION ALL
- CASE statements
- Views and Indexes
- Common Table Expressions (CTEs)
- Window Functions: DENSE_RANK
- Database constraints and foreign keys

## Project Queries

The project includes 15 SQL queries covering:

1. Displaying product names and prices
2. Filtering products by price
3. Sorting products by price
4. Counting customers
5. Calculating average product price
6. Joining products with categories
7. Displaying customers and their orders
8. Retrieving order details with product names
9. Displaying customer payment information
10. Finding customers who placed orders
11. Finding the highest-priced product
12. Finding products above average price
13. Calculating successful payment totals
14. Counting orders by status
15. Ranking products by price

## How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench.
3. Connect to your MySQL server.
4. Open `ecommerce_db.sql`.
5. Execute the script to create the database, tables and sample records.
6. Execute the SQL queries and verify the results.

**Important:** The SQL script drops and recreates the project tables. Back up existing project data before running it again.

## Project Files

```text
E-commerce-Database-Management-System/
│
├── ecommerce_db.sql
├── ecommerce_er_diagram.png
├── ecommerce_database.mwb
└── README.md
```

## Future Enhancements

- Develop a frontend using React.js.
- Integrate backend services using Java Spring Boot.
- Connect the application to MySQL using JDBC.
- Implement user authentication and product management.
- Build an end-to-end e-commerce application.

## Author

**Mahaadharshni M**

BE Electronics and Communication Engineering

Aspiring Java Full Stack Developer

---

*This project was developed to practice relational database design and SQL concepts through an e-commerce use case.*