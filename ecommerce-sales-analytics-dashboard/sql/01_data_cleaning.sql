-- Data Cleaning Steps

-- Remove null customers
DELETE FROM online_retail_raw
WHERE CustomerID IS NULL;

-- Remove cancelled invoices
DELETE FROM online_retail_raw
WHERE InvoiceNo LIKE 'C%';

-- Remove invalid quantities
DELETE FROM online_retail_raw
WHERE Quantity <= 0;

-- Remove invalid prices
DELETE FROM online_retail_raw
WHERE UnitPrice <= 0;

-- Create revenue column
ALTER TABLE online_retail_raw
ADD COLUMN sales_amount DECIMAL(10,2);

UPDATE online_retail_raw
SET sales_amount = Quantity * UnitPrice;
