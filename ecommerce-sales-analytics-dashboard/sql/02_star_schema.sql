-- Create Customer Dimension Table
CREATE TABLE dim_customer AS
SELECT DISTINCT
    CustomerID,
    Country
FROM online_retail_raw;


-- Create Product Dimension Table
CREATE TABLE dim_product AS
SELECT DISTINCT
    StockCode,
    Description
FROM online_retail_raw;


-- Create Date Dimension Table
CREATE TABLE dim_date AS
SELECT DISTINCT
    DATE(InvoiceDate) AS full_date,
    YEAR(InvoiceDate) AS year,
    MONTH(InvoiceDate) AS month,
    MONTHNAME(InvoiceDate) AS month_name,
    QUARTER(InvoiceDate) AS quarter
FROM online_retail_raw;


-- Create Fact Table
CREATE TABLE fact_sales AS
SELECT
    InvoiceNo,
    StockCode,
    CustomerID,
    InvoiceDate,
    Quantity,
    UnitPrice,
    (Quantity * UnitPrice) AS sales_amount
FROM online_retail_raw;