# FlexiMart Database Schema Documentation
---
## Overview
The **FlexiMart** database is designed to manage an e-commerce platform. It tracks customer information, product inventory, customer orders, and individual line items within those orders.
---
## Entity-Relationship Summary

| Table | Description | Primary Key | Foreign Keys |
| :--- | :--- | :--- | :--- |
| `customers` | Personal and contact info of users | `customer_id` | None |
| `products` | Catalog of items available for sale | `product_id` | None |
| `orders` | High-level transaction records | `order_id` | `customer_id` |
| `order_items` | Specific products within an order | `order_item_id` | `order_id`, `product_id` |

---

ENTITY : customers
Purpose: Stores Individual FlexiMart's customer records. 
Attributes :
- customer_id : Unique Identifier servers as a Primary key and is Auto Incremental value and is an Integer Datatype.
- first_name : Stores customers first name is a varchar- upto 50 characters datatype and cannot be a Null value.
- last_name : stores customers last name is a varchar- upto 50 characters datatype and cannot be a Null value.
- email : stores customers email Address values is a varchar- upto 100 characters and cannot be a Null value.
- phone : Stores customer's mobile numbers is a varchar datatype - upto 20 characters.
- city: Stores customer living city value is a varchar datatype - upto 50 characters.
- registration_date : Stores the date on which customer signed up to be a customer is a Date data type.

ENTITY : products
Purpose : To store product details which are sold by FlexiMart.
Attributes :
- product_id : Unique Identifier for each product and servers as a Primary key and is Auto Incremental value and is an Integer Datatype.
- product_name : Stores the name of the product and is a varchar datatype - upto 100 characters, cannot be a Null value.
- category : Stores the Category of the product to which it belongs to, like eg, Electronics and is a varchar datatype - upto 100 characters, cannot be a Null value.
- price : Stores the selling price of the product and is a Decimal data type with 10 digit value allowed and 2 places round up, cannnot be a Null value.
- stock_quantity : Stores product quantity and is of Integer data type and default value is 0.

ENTITY : orders
Purpose: To store order details for individual orders on Fleximart.
Attributes:
- order_id : Unique Identifier for each product and servers as a Primary key and is Auto Incremental value and is a Integer Datatype.
- customer_id : Unique Identifier servers as a Foregin key and is Auto Incremental value and is an Integer Datatype.
- order_date : Stores the date on which customer ordered the product and is a Date data type, cannot be a  Null value.
- total_amount : Stores the Total amount calculated by multiplying Quantity with Unit Price and is a Decimal data type with 10 digit value allowed and 2 places round up, cannnot be a Null value.
- status : Stores the order status of individual orders, is a varchar datatype - upto 20 characters.

ENTITY : order_items
Purpose: To store order details for individual items on Fleximart.
Attributes:
- order_item_id : Unique Identifier for each order item and servers as a Primary key and is Auto Incremental value and is a Integer Datatype.
- order_id : Unique Identifier servers as a Foregin key and is Auto Incremental value and is an Integer Datatype.
- product_id : Unique Identifier servers as a Foregin key and is Auto Incremental value and is an Integer Datatype.
- quantity : Stores the Quantity of products ordered for the given order ID, is an integer data type and cannot be a Null value.
- unit_price : Stores the selling price of the product per Unit and is a Decimal data type with 10 digit value allowed and 2 places round up, cannnot be a Null value.
- subtotal : Stores the Total amount calculated by multiplying Quantity with Unit Price and is a Decimal data type with 10 digit value allowed and 2 places round up, cannnot be a Null value.

---

## Table Definitions

### 1. `customers`
Stores unique profiles for every shopper on the platform.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `customer_id` | INT | PK, AI | Unique internal identifier |
| `first_name` | VARCHAR(50) | NOT NULL | Customer's given name |
| `last_name` | VARCHAR(50) | NOT NULL | Customer's family name |
| `email` | VARCHAR(100) | UNIQUE, NOT NULL | Primary contact and login email |
| `phone` | VARCHAR(20) | - | Contact phone number |
| `city` | VARCHAR(50) | - | Geographic location |
| `registration_date` | DATE | - | Date the account was created |

### 2. `products`
The inventory catalog containing pricing and stock levels.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `product_id` | INT | PK, AI | Unique product identifier |
| `product_name` | VARCHAR(100) | NOT NULL | Name of the item |
| `category` | VARCHAR(50) | NOT NULL | Product grouping (e.g., Electronics) |
| `price` | DECIMAL(10,2) | NOT NULL | Current selling price |
| `stock_quantity` | INT | DEFAULT 0 | Units available in warehouse |

### 3. `orders`
Represents a single transaction placed by a customer.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `order_id` | INT | PK, AI | Unique order number |
| `customer_id` | INT | FK, NOT NULL | Link to the purchasing customer |
| `order_date` | DATE | NOT NULL | Date the order was placed |
| `total_amount` | DECIMAL(10,2) | NOT NULL | Final sum of the transaction |
| `status` | VARCHAR(20) | DEFAULT 'Pending' | Order state (e.g., Shipped, Paid) |

### 4. `order_items`
A junction table that connects orders to products, supporting multiple items per order.

| Column | Data Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `order_item_id` | INT | PK, AI | Unique line item identifier |
| `order_id` | INT | FK, NOT NULL | Link to parent order |
| `product_id` | INT | FK, NOT NULL | Link to the product purchased |
| `quantity` | INT | NOT NULL | Number of units purchased |
| `unit_price` | DECIMAL(10,2) | NOT NULL | Price per unit at time of sale |
| `subtotal` | DECIMAL(10,2) | NOT NULL | `quantity` * `unit_price` |

---

## Key Relationships

1.  **One-to-Many (`customers` → `orders`)**: One customer can place many orders over time, but each order belongs to only one customer.
2.  **One-to-Many (`orders` → `order_items`)**: Every order can contain multiple line items (products).
3.  **One-to-Many (`products` → `order_items`)**: A single product can appear in many different customer orders.

---

# Normalization Explanation.

## Q1 Explain why this design is in 3NF
A database is in 3NF if it meets these three criteria:
- 1NF: Data is in a table, values are atomic (no lists in a cell), and there's a Primary Key.
- 2NF: It is in 1NF and all non-key columns depend on the entire Primary Key.
- 3NF: It is in 2NF and there are no transitive dependencies (non-key columns shouldn't depend on other non-key columns).
First Normal Form (1NF): AtomicityYour design satisfies 1NF because:Each column contains a single value (e.g., one email, one price).Each record is unique via an AUTO_INCREMENT Primary Key (customer_id, product_id, etc.). 
Second Normal Form (2NF): No Partial Dependencies2NF is mostly about tables with "Composite Keys" (keys made of two columns).In order_items table, the Primary Key is order_item_id.Every other column (quantity, unit_price) relates specifically to that one row ID. We don't have a situation where a column only depends on "half" of the key.
Third Normal Form (3NF): No Transitive Dependencies. 3NF states that "Non-key attributes must provide a fact about the key, the whole key, and nothing but the key.
If we kept customer_name and city inside the orders table, we would violate 3NF. Because city depends on the customer_id, and customer_id depends on the order_id.The violation: order_id ---> customer_id ---> city.The 3NF Fix: We moved customer_name and city to their own customers table. Now, the orders table only knows the customer_id.
order_items and products split is 3NF:If we  kept product_name inside order_items, it would be a transitive dependency.The violation: order_item_id ---> product_id ---> product_name.
The 3NF Fix: By having a separate products table, the order_items table only stores the product_id. If a product name changes, you update it in one place (Products) instead of 1,000 places (Order Items).

## Q2 Identify functional dependencies.
It describes the relationship between attributes, where one attribute uniquely determines another. Functional dependencies are the "rules" that tell you when to split a large spreadsheet into multiple tables:

1. To Avoid Redundancy: If product_name is dependent on product_id, we store that relationship in one table (products). We don't repeat the name in the sales table every time that product is sold.

2. To Maintain Integrity: If we update a product's price in the products table, the dependency ensures that the "fact" about that product is updated everywhere in system instantly.

3. To Define Keys: The column that determines all other columns in a table is chosen as the  Primary Key.


## Q3 Explain how the design avoids update, insert, and delete anomalies.
Storing all data in a single table causes several anomalies:
- Update anomaly: Changing data requires updating multiple rows, which risks inconsistency.
- Insert anomaly: Inability to add data (e.g., new supplier) without related data (e.g., orders).
- Deletion anomaly: Deleting a record might accidentally remove important data (e.g., product details).
Since we haved used 3NF, it uses "one fact in one place" to prevent these issues. Havibng separate product and Sales table help us avoid insert Anomaly.
Update anomaly is avoided using suppose customer ID in other tables as a foriegn key, in this way any change made to customer will alawys be pointed to it using the ID.
Delete anomanly is avoided by having separate orders table so any cancelled transcation is removed from ordered without impacting customer data in customers table.

---

# Sample Data Representation

Show 2-3 sample records from each table in table format.

| customer_id |first_name | last_name | email | phone |city |registration_date |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | Rahul | Sharma | rahul.sharma@gmail.com | +919876543210 | Bangalore | 2023-01-15 |
| 2 | Priya | Patel | priya.patel@yahoo.com |  +919988776655 | Mumbai | 2023-02-20 |
| 3 | Amit | Kumar | Unkown | +919765432109 | Delhi | 2023-03-10 |

| product_id | product_name | category | price | stock_quantity |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Samsung Galaxy S21 | Electronics | 45999 |150 |
| 2 | Nike Running Shoes | Fashion | 3499 | 80 |
| 3 | Apple MacBook Pro | Electronics | 31213.29 | 45 |

| order_id | customer_id | order_date | total_amount | status |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 1 | 2024-01-15 | 45999 | Completed |
| 2 | 1 | 2024-01-16 | 5998| Completed |
| 3 | 3 | 2024-01-15 | 52999 | Completed |

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 1 | 1 | 1 | 45999 | 45999 |
| 2 | 2 | 4 | 2 | 2999 | 5998 |
| 3 | 3 | 7 | 1 | 52999 | 52999 |