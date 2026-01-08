-- Query 1: Monthly Sales Drill-Down
-- Business Scenario: [Copy scenario]
-- Demonstrates: Drill-down from Year to Quarter to Month

SELECT 
    d.year, 
    d.quarter, 
    d.month_name, 
    SUM(f.total_amount) AS total_sales, 
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY d.year, d.quarter, d.month, d.month_name
ORDER BY d.year, d.month;

-- Query 2: Top 10 Products by Revenue
-- Business Scenario: [Copy scenario]
-- Includes: Revenue percentage calculation

SELECT 
    p.product_name, 
    p.category, 
    SUM(f.quantity_sold) AS units_sold, 
    SUM(f.total_amount) AS revenue,
    ROUND(
        (SUM(f.total_amount) * 100.0 / SUM(SUM(f.total_amount)) OVER ()), 
        2
    ) || '%' AS revenue_percentage
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Query 3: Customer Segmentation
-- Business Scenario: [Copy scenario]
-- Segments: High/Medium/Low value customers

WITH CustomerSpending AS (
    SELECT 
        customer_key, 
        SUM(total_amount) AS total_spent
    FROM fact_sales
    GROUP BY customer_key
),
Segments AS (
    SELECT 
        customer_key,
        total_spent,
        CASE 
            WHEN total_spent > 50000 THEN 'High Value'
            WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_val_segment
    FROM CustomerSpending
)
SELECT 
    s.customer_val_segment AS customer_segment,
    COUNT(s.customer_key) AS customer_count,
    SUM(s.total_spent) AS total_revenue,
    ROUND(AVG(s.total_spent), 2) AS avg_revenue
FROM Segments s
GROUP BY s.customer_val_segment
ORDER BY total_revenue DESC;