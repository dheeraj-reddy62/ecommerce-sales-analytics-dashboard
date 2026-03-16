-- Step 1: Calculate Recency, Frequency, Monetary

CREATE TABLE customer_rfm AS
SELECT
    CustomerID,
    DATEDIFF('2011-12-09', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    SUM(sales_amount) AS Monetary
FROM fact_sales
GROUP BY CustomerID;


-- Step 2: Assign RFM Scores using NTILE

CREATE TABLE customer_rfm_scored AS
SELECT
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(5) OVER (ORDER BY Frequency) AS F_Score,
    NTILE(5) OVER (ORDER BY Monetary) AS M_Score
FROM customer_rfm;


-- Step 3: Create Customer Segments

CREATE TABLE customer_segments AS
SELECT
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score,
    
    CASE
        WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4 THEN 'Champions'
        WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal Customers'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        WHEN R_Score = 1 THEN 'Lost Customers'
        ELSE 'Others'
    END AS Segment
FROM customer_rfm_scored;