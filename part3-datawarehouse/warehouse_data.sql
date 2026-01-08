INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, FALSE),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, FALSE),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, FALSE),
(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, FALSE),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),
(20240116, '2024-01-16', 'Tuesday', 16, 1, 'January', 'Q1', 2024, FALSE),
(20240117, '2024-01-17', 'Wednesday', 17, 1, 'January', 'Q1', 2024, FALSE),
(20240118, '2024-01-18', 'Thursday', 18, 1, 'January', 'Q1', 2024, FALSE),
(20240119, '2024-01-19', 'Friday', 19, 1, 'January', 'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, TRUE),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, TRUE),
(20240122, '2024-01-22', 'Monday', 22, 1, 'January', 'Q1', 2024, FALSE),
(20240123, '2024-01-23', 'Tuesday', 23, 1, 'January', 'Q1', 2024, FALSE),
(20240124, '2024-01-24', 'Wednesday', 24, 1, 'January', 'Q1', 2024, FALSE),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, FALSE),
(20240126, '2024-01-26', 'Friday', 26, 1, 'January', 'Q1', 2024, FALSE),
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January', 'Q1', 2024, TRUE),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, TRUE),
(20240129, '2024-01-29', 'Monday', 29, 1, 'January', 'Q1', 2024, FALSE),
(20240130, '2024-01-30', 'Tuesday', 30, 1, 'January', 'Q1', 2024, FALSE);

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001', 'Samsung Galaxy S23', 'Electronics', 'Mobile', 74999.00),
('P002', 'MacBook Air M2', 'Electronics', 'Laptop', 89999.00),
('P003', 'Sony Headphones', 'Electronics', 'Audio', 15000.00),
('P004', 'Logitech Mouse', 'Electronics', 'Peripherals', 1200.00),
('P005', 'Dell Monitor', 'Electronics', 'Monitor', 25000.00),
('P006', 'Levi Jeans', 'Fashion', 'Apparel', 3500.00),
('P007', 'Nike Sneakers', 'Fashion', 'Footwear', 8000.00),
('P008', 'Adidas T-Shirt', 'Fashion', 'Apparel', 1200.00),
('P009', 'Casio Watch', 'Fashion', 'Accessories', 5500.00),
('P010', 'RayBan Sunglasses', 'Fashion', 'Accessories', 9000.00),
('P011', 'Tropicana Juice', 'Grocery', 'Beverage', 120.00),
('P012', 'Basmati Rice 5kg', 'Grocery', 'Grains', 750.00),
('P013', 'Amul Butter', 'Grocery', 'Dairy', 250.00),
('P014', 'Lindt Chocolate', 'Grocery', 'Confectionery', 450.00),
('P015', 'Nescafe Coffee', 'Grocery', 'Beverage', 600.00);

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001', 'Aarav Sharma', 'Mumbai', 'Maharashtra', 'Premium'),
('C002', 'Isha Gupta', 'Mumbai', 'Maharashtra', 'Regular'),
('C003', 'Rohan Das', 'Mumbai', 'Maharashtra', 'New'),
('C004', 'Ananya Iyer', 'Bangalore', 'Karnataka', 'Premium'),
('C005', 'Vikram Singh', 'Bangalore', 'Karnataka', 'Regular'),
('C006', 'Sanya Malhotra', 'Bangalore', 'Karnataka', 'Premium'),
('C007', 'Arjun Verma', 'Delhi', 'Delhi', 'Regular'),
('C008', 'Kriti Sanon', 'Delhi', 'Delhi', 'New'),
('C009', 'Rahul Dravid', 'Delhi', 'Delhi', 'Premium'),
('C010', 'Sneha Reddy', 'Hyderabad', 'Telangana', 'Regular'),
('C011', 'Pawan Kalyan', 'Hyderabad', 'Telangana', 'New'),
('C012', 'Mahesh Babu', 'Hyderabad', 'Telangana', 'Premium');

INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
-- Week 1
(20240101, 11, 1, 5, 120.00, 0, 600.00),
(20240102, 1, 4, 1, 74999.00, 5000.00, 69999.00),
(20240103, 6, 2, 2, 3500.00, 200.00, 6800.00),
(20240104, 13, 10, 3, 250.00, 0, 750.00),
(20240105, 4, 7, 1, 1200.00, 100.00, 1100.00),
(20240106, 2, 12, 1, 89999.00, 0, 89999.00), -- Weekend
(20240106, 7, 6, 2, 8000.00, 500.00, 15500.00), -- Weekend
(20240107, 15, 3, 10, 600.00, 600.00, 5400.00), -- Weekend
(20240107, 3, 9, 1, 15000.00, 1000.00, 14000.00), -- Weekend
-- Week 2
(20240108, 12, 11, 2, 750.00, 0, 1500.00),
(20240109, 8, 5, 4, 1200.00, 400.00, 4400.00),
(20240110, 5, 1, 1, 25000.00, 1500.00, 23500.00),
(20240111, 14, 8, 5, 450.00, 0, 2250.00),
(20240112, 10, 2, 1, 9000.00, 900.00, 8100.00),
(20240113, 1, 12, 1, 74999.00, 2000.00, 72999.00), -- Weekend
(20240113, 9, 4, 2, 5500.00, 500.00, 10500.00), -- Weekend
(20240114, 7, 6, 3, 8000.00, 1000.00, 23000.00), -- Weekend
(20240114, 2, 9, 1, 89999.00, 5000.00, 84999.00), -- Weekend
(20240114, 4, 10, 2, 1200.00, 0, 2400.00), -- Weekend
-- Week 3
(20240115, 11, 3, 2, 120.00, 0, 240.00),
(20240116, 13, 7, 1, 250.00, 0, 250.00),
(20240117, 15, 11, 1, 600.00, 50.00, 550.00),
(20240118, 6, 5, 1, 3500.00, 0, 3500.00),
(20240119, 12, 8, 1, 750.00, 75.00, 675.00),
(20240120, 3, 1, 2, 15000.00, 3000.00, 27000.00), -- Weekend
(20240120, 10, 4, 1, 9000.00, 0, 9000.00), -- Weekend
(20240121, 1, 6, 1, 74999.00, 10000.00, 64999.00), -- Weekend
(20240121, 5, 12, 1, 25000.00, 0, 25000.00), -- Weekend
(20240121, 9, 9, 1, 5500.00, 500.00, 5000.00), -- Weekend
-- Week 4
(20240122, 14, 2, 10, 450.00, 450.00, 4050.00),
(20240123, 8, 10, 2, 1200.00, 0, 2400.00),
(20240124, 7, 1, 1, 8000.00, 0, 8000.00),
(20240125, 4, 3, 1, 1200.00, 0, 1200.00),
(20240126, 11, 5, 20, 120.00, 400.00, 2000.00),
(20240127, 2, 4, 1, 89999.00, 0, 89999.00), -- Weekend
(20240127, 3, 12, 1, 15000.00, 500.00, 14500.00), -- Weekend
(20240128, 15, 6, 5, 600.00, 0, 3000.00), -- Weekend
(20240128, 1, 9, 1, 74999.00, 5000.00, 69999.00), -- Weekend
(20240129, 6, 11, 2, 3500.00, 700.00, 6300.00),
(20240130, 12, 7, 3, 750.00, 0, 2250.00);