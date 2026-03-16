-- Total Revenue
SELECT 
    SUM(sales_amount) AS total_revenue
FROM fact_sales;


-- Total Orders
SELECT 
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM fact_sales;


-- Total Customers
SELECT 
    COUNT(DISTINCT CustomerID) AS total_customers
FROM fact_sales;


-- Average Order Value (AOV)
SELECT 
    SUM(sales_amount) / COUNT(DISTINCT InvoiceNo) AS average_order_value
FROM fact_sales;


-- Revenue by Customer Segment
SELECT
    cs.Segment,
    COUNT(DISTINCT fs.CustomerID) AS customers,
    SUM(fs.sales_amount) AS revenue
FROM fact_sales fs
JOIN customer_segments cs
ON fs.CustomerID = cs.CustomerID
GROUP BY cs.Segment
ORDER BY revenue DESC;


-- Top 10 Products by Revenue
SELECT
    dp.Description,
    SUM(fs.sales_amount) AS revenue
FROM fact_sales fs
JOIN dim_product dp
ON fs.StockCode = dp.StockCode
GROUP BY dp.Description
ORDER BY revenue DESC
LIMIT 10;


-- Revenue by Country
SELECT
    dc.Country,
    SUM(fs.sales_amount) AS revenue
FROM fact_sales fs
JOIN dim_customer dc
ON fs.CustomerID = dc.CustomerID
GROUP BY dc.Country
ORDER BY revenue DESC;