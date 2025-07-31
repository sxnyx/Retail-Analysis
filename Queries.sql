-- Calculate Customer Lifetime Value (CLV)
SELECT 
    c.Customer_ID,
    c.Name,
    SUM(s.Amount) AS Total_Spend,
    COUNT(s.Transaction_ID) AS Total_Transactions,
    AVG(s.Amount) AS Avg_Spend_Per_Transaction
FROM 
    Sales s
JOIN 
    Customers c ON s.Customer_ID = c.Customer_ID
GROUP BY 
    c.Customer_ID, c.Name
ORDER BY 
    Total_Spend DESC;


--  Analyze Sales Trends (Daily, Weekly, Seasonal Performance)
SELECT 
    Transaction_Date,
    SUM(Amount) AS Total_Sales,
    COUNT(Transaction_ID) AS Total_Transactions
FROM 
    Sales
GROUP BY 
    Transaction_Date
ORDER BY 
    Transaction_Date ASC;
    

-- weekly sales
SELECT 
    YEAR(Transaction_Date) AS Year,
    WEEK(Transaction_Date) AS Week_Number,
    SUM(Amount) AS Weekly_Sales
FROM 
    Sales
GROUP BY 
    YEAR(Transaction_Date), WEEK(Transaction_Date)
ORDER BY 
    Year, Week_Number;

-- monthly sales
SELECT 
    YEAR(Transaction_Date) AS Year,
    MONTH(Transaction_Date) AS Month,
    SUM(Amount) AS Monthly_Sales
FROM 
    Sales
GROUP BY 
    YEAR(Transaction_Date), MONTH(Transaction_Date)
ORDER BY 
    Year, Month;
    

-- Evaluate Inventory Turnover Rate
SELECT 
    p.Product_ID,
    p.Product_Name,
    SUM(s.Amount) / SUM(i.Stock_Quantity) AS Inventory_Turnover_Rate
FROM 
    Sales s
JOIN 
    Products p ON s.Product_ID = p.Product_ID
JOIN 
    Inventory i ON p.Product_ID = i.Product_ID
GROUP BY 
    p.Product_ID, p.Product_Name
ORDER BY 
    Inventory_Turnover_Rate DESC;
    
    
-- Perform Market Basket Analysis (Product Recommendations)

SELECT 
    s1.Product_ID AS Product1,
    s2.Product_ID AS Product2,
    COUNT(*) AS Frequency
FROM 
    Sales s1
JOIN 
    Sales s2 ON s1.Customer_ID = s2.Customer_ID
WHERE 
    s1.Product_ID < s2.Product_ID
GROUP BY 
    s1.Product_ID, s2.Product_ID
ORDER BY 
    Frequency DESC;




