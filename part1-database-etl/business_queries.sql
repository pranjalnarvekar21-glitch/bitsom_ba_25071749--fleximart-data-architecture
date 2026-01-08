

-- Query 1: Customer Purchase History
-- Business Question:
-- Generate a detailed report showing each customer's name, email, total number of orders placed, and total amount spent. 
-- Include only customers who have placed at least 2 orders and spent more than ₹5,000. Order by total amount spent in descending order.
-- Expected to return customers with 2+ orders and >5000 spent

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, c.email
HAVING 
    COUNT(o.order_id) >= 2 
    AND SUM(o.total_amount) > 5000
ORDER BY 
    total_spent DESC;



-- Query 2: Product Sales Analysis
-- Business Question: 
-- "For each product category, show the category name, number of different products sold, total quantity sold, and total revenue generated. 
-- Only include categories that have generated more than ₹10,000 in revenue. Order by total revenue descending."
-- Expected to return categories with >10000 revenue

SELECT 
    p.category,
    COUNT(DISTINCT p.product_id) AS unique_products_sold,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.subtotal) AS total_revenue
FROM 
    products p
JOIN 
    order_items oi ON p.product_id = oi.product_id
JOIN 
    orders o ON oi.order_id = o.order_id
GROUP BY 
    p.category
HAVING 
    total_revenue > 10000
ORDER BY 
    total_revenue DESC;



-- Query 3: Monthly Sales Trend
-- Business Question: 
--"Show monthly sales trends for the year 2024. For each month, display the month name, total number of orders, total revenue, and 
-- the running total of revenue (cumulative revenue from January to that month)."
-- Expected to show monthly and cumulative revenue

WITH MonthlySales AS (
    SELECT 
        strftime('%m', order_date) AS month_num,
        CASE strftime('%m', order_date)
            WHEN '01' THEN 'January' WHEN '02' THEN 'February' WHEN '03' THEN 'March'
            WHEN '04' THEN 'April'   WHEN '05' THEN 'May'      WHEN '06' THEN 'June'
            WHEN '07' THEN 'July'    WHEN '08' THEN 'August'   WHEN '09' THEN 'September'
            WHEN '10' THEN 'October' WHEN '11' THEN 'November' WHEN '12' THEN 'December'
        END AS month_name,
        COUNT(order_id) AS total_orders,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    WHERE strftime('%Y', order_date) = '2024'
    GROUP BY month_num
)
SELECT 
    month_name,
    total_orders,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month_num) AS running_total_revenue
FROM MonthlySales
ORDER BY month_num;