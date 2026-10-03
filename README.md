# Olist E-Commerce Business Analysis

##  Project Overview

This project analyzes the **Olist Brazilian E-Commerce dataset** using **PostgreSQL** to understand the key business drivers behind e-commerce performance.

The analysis focuses on real-world business questions across:

* Revenue and sales
* Customer behavior
* Repeat purchases
* Product performance
* Seller performance
* Delivery operations
* Customer satisfaction
* Payment behavior
* Cancellation rates

Instead of focusing only on SQL syntax, this project follows a business-oriented approach:

**Business Question → SQL Analysis → Finding → Business Action**

---

##  Business Objective

The objective of this project is to use transactional e-commerce data to identify patterns that can help answer questions such as:

* Which categories generate the most revenue?
* Which states contribute the most sales?
* How many customers purchase only once?
* What factors are associated with repeat purchases?
* Does late delivery affect customer reviews?
* Which sellers generate high revenue but have operational issues?
* Which products have high sales but poor ratings?
* What payment methods do customers prefer?
* How significant are freight costs?
* Which customer segments generate the highest lifetime revenue?

---

## 🛠️ Tools & Technologies

| Tool       | Purpose                                      |
| ---------- | -------------------------------------------- |
| PostgreSQL | Data storage and SQL analysis                |
| pgAdmin    | Database management and query execution      |
| SQL        | Data extraction, transformation and analysis |
| GitHub     | Version control and project documentation    |


---

##  Dataset

The project uses the **Olist Brazilian E-Commerce Public Dataset**.

The dataset contains approximately 100k orders from a Brazilian e-commerce marketplace and includes information about:

* Customers
* Orders
* Order items
* Products
* Sellers
* Payments
* Reviews
* Geolocation
* Product categories

### Main tables

```text
customers
    ↓
orders
    ├── order_items ──→ products
    │             └──→ sellers
    │
    ├── order_payments
    │
    └── order_reviews
```

---

#  Key Analytical Approach

The project follows a three-step business analysis framework.

### 1. What?

Identify the business pattern using SQL.

Example:

> Which sellers have the highest revenue?

### 2. Why?

Break down the pattern using additional business dimensions.

Example:

> Are high-revenue sellers also receiving good reviews and delivering orders on time?

### 3. Action

Identify areas that deserve further investigation.

Example:

> High-revenue sellers with high delay rates can be investigated for fulfillment or logistics issues.

The project does **not** assume that correlation automatically means causation.

---

#  SQL Concepts Demonstrated

This project demonstrates practical PostgreSQL skills including:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* `CASE`
* `JOIN`
* `LEFT JOIN`
* `COUNT`
* `SUM`
* `AVG`
* `FILTER`
* `CTE`
* Subqueries
* Window functions
* `LAG()`
* `ROW_NUMBER()`
* Date arithmetic
* Conditional aggregation
* `NULLIF()`
* `ROUND()`

---

#  Project Structure

```text
olist-ecommerce-business-analysis/
│
├── README.md
│
├── data/
│   └── README.md
│
├── sql/
│   ├── 01_revenue_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_delivery_analysis.sql
│   ├── 04_seller_analysis.sql
│   ├── 05_product_analysis.sql
│   ├── 06_payment_analysis.sql
│   └── 07_final_business_analysis.sql
│
├── analysis/
│   └── business_questions.md
│
├── dashboard/
│   └── README.md
│
└── screenshots/
```

---

#  How to Run the Project

### 1. Download the dataset

Download the Olist Brazilian E-Commerce dataset and extract the CSV files.

### 2. Create a PostgreSQL database

Example:

```sql
CREATE DATABASE olist_ecommerce;
```

### 3. Create the required tables

Import the CSV files into their corresponding PostgreSQL tables using pgAdmin.

### 4. Verify the data

```sql
SELECT COUNT(*)
FROM orders;
```

```sql
SELECT *
FROM orders
LIMIT 10;
```

### 5. Run the SQL analysis

Execute the SQL files inside the `/sql` folder.

---

##  Author

**Anurag Singh**

B.Tech — Computer Science & Engineering
Machine Learning Specialization


