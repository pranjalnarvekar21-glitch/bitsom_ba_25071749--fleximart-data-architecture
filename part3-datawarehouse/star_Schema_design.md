# Schema Overview :

FACT TABLE: fact_sales
Grain: One row per product per order line item
Business Process: Sales transactions

Measures (Numeric Facts):
- quantity_sold: Number of units sold
- unit_price: Price per unit at time of sale
- discount_amount: Discount applied
- total_amount: Final amount (quantity × unit_price - discount)

Foreign Keys:
- date_key → dim_date
- product_key → dim_product
- customer_key → dim_customer


DIMENSION TABLE: dim_date
Purpose: Date dimension for time-based analysis
Type: Conformed dimension
Attributes:
- date_key (PK): Surrogate key (integer, format: YYYYMMDD)
- full_date: Actual date
- day_of_week: Monday, Tuesday, etc.
- month: 1-12
- month_name: January, February, etc.
- quarter: Q1, Q2, Q3, Q4
- year: 2023, 2024, etc.
- is_weekend: Boolean

DIMENSION TABLE: dim_product
Purpose: Stores product metadata and hierarchies.

Type: Conformed dimension.
Attributes:
- product_key (PK): Surrogate key (Integer, Auto-increment).
- product_id: Natural key from source system.
- product_name: Full Product name.
- category: Broad product classification (e.g., Electronics, Fashion).
- subcategory: Specific/actual product grouping (e.g., Smartphones, Footwear).
- unit_price: Retail price of a single unit.

DIMENSION TABLE: dim_customer
urpose: Stores customer demographics and geographic data.

Type:Conformed dimension.
Attributes:
- customer_key (PK): Surrogate key (Integer, Auto-increment).
- customer_id: Natural key from source system.
- customer_name: Customer Full name.
- city: The city of residence.
- state: The state or province.
- customer_segment: Classification based on value or behavior.

---
---

### **Key Design Characteristics**

* **Surrogate Keys (SK):** Both tables use integer-based keys (`product_key`, `customer_key`) to optimize join performance with the `fact_sales` table.
* **Descriptive Attributes:** Unlike the operational database, these tables are "flat" and contain redundant text (like category names) to make reporting queries faster and easier to write without deep nesting.
* **Hierarchies:** * **Product:** `Category`  `Subcategory`  `Product Name`
* **Customer:** `State`  `City`  `Customer Name`

# Design Decisions 

# Why you chose this granularity (transaction line-item level)
Granularity refers to the level of detail stored in the fact tables. Choosing the transaction line-item level is the most efficient approach for following points:

Maximum Flexibility: Storing the "atomic" level of data allows you to answer any business question. 
Precisise Calculations: Line-item granularity ensures that quantity_sold, unit_price, and discount_amount are exactly as they occurred at the point of sale.
Support for vareity of Analysis: This level of detail is necessary to calculate metrics like "Average Items Per Basket" or "Total Discounts per Product Category" which would be impossible with higher-level summaries.

# Why surrogate keys instead of natural keys
Surrogate Keys vs. Natural Keys
In the  schema, tables use surrogate keys as PRIMARY KEYs instead of natural keys.
Natural keys (like a Product ID) can change if a company rebrands or changes its SKU system. Surrogate keys are managed internally by the warehouse, ensuring that historical records remain stable even if the source system changes. Surrogate keys are typically integers (INT). Joining two tables on integers is much faster for a database engine than joining on long strings (varchars) like ELEC001 or C001.

# How this design supports drill-down and roll-up operations
The star schema is specifically designed to allow users to navigate through different levels of data aggregation effortlessly.

Roll-Up  : Roll-up is the process of moving from detailed data to a overall summary.
Because your dim_product and dim_date tables have hierarchies (Product → Subcategory → Category and Date → Month → Quarter), you can "roll up" sales from individual items to see the total revenue of the entire "Electronics" category for the year 2024.

Drill-Down : Drill-down is the reverse—moving from a summary to the details.
Star schema design supports this by maintaining the atomic line-item in fact_sales.

---
---

# Sample Data Flow 
Show an example of how one transaction flows from source to data warehouse:

let's consider and follow the sale of a **Samsung Galaxy S23** to **Aarav Sharma**.

### First step is the Source (Raw CSV/Transaction)

The data originates in a line in a CSV or a record in a relational database.

Transaction Record: `Order_ID: 1001`, `Customer_ID: C001`, `Product_ID: P001`, `Qty: 1`, `Date: 2024-01-02`.
---
### Second step is the Extraction & Transformation (ETL)

During this stage, data is cleaned and preared to be stored in the DB to match and follow all formats:

* **ID Mapping:** The system looks up the **Natural Keys** (`C001`, `P001`) and finds their corresponding **Surrogate Keys** in the warehouse.
* **Calculation:** The `total_amount` is calculated: .
---

### Third Step is the Data Loading into the Star Schema.

The data is now split into the **Dimensions** i.e. the "Who, What, When" and the **Fact** i.e. the "How Much".

#### **The Dimension Tables**

Tables store the descriptive attributes.

| Table | Surrogate Key | Attribute Example |
| --- | --- | --- |
| **dim_customer** | `4` | `customer_name: 'Aarav Sharma'`, `city: 'Mumbai'` |
| **dim_product** | `1` | `product_name: 'Samsung Galaxy S23'`, `category: 'Electronics'` |
| **dim_date** | `20240102` | `full_date: '2024-01-02'`, `is_weekend: FALSE` |

#### **The Fact Table (The Metric)**

The `fact_sales` table captures the event by linking the keys and storing the numbers.

* **Fact Entry:** * `date_key`: 20240102
* `product_key`: 1
* `customer_key`: 4
* `quantity_sold`: 1
* `total_amount`: 69999.00

---

### Fourth Step is the Data Warehouse Output.

When query are run to get the bussiness question answers, the warehouse doesn't have to look through millions of names or product descriptions. It simply joins the integers:

1. It sees `fact_sales.date_key = 20240102`.
2. It joins with `dim_date` to see that this was **January**, **Q1**, **2024**.
3. It adds the `69,999.00` to the "January 2024" total.

---
---
