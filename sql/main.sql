SELECT * FROM market_sales_analysis;



-- SALES RANKING BY BRANCH
/*
 
1- A         116366.947   
2- B         113780.7175
3- C         113780.7175

*/
SELECT 
    Branch,
    SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Total_Sales,
    RANK() OVER (ORDER BY Quantity * Unit_Price DESC) as Rank
FROM market_sales_analysis
GROUP BY Branch
ORDER BY Rank ASC;




-- SALES BY CUSTOMER TYPE
/*

1- Member       179208.4145
2- Normal       172290.357  

*/
WITH CUSTOMER_TYPE_SALES AS (
    SELECT 
        Customer_Type,
        SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Customer_Type_Sales
    FROM market_sales_analysis
    GROUP BY Customer_Type
)
SELECT 
    Customer_Type,
    Customer_Type_Sales
FROM CUSTOMER_TYPE_SALES
ORDER BY Customer_Type_Sales DESC;



-- QUANTITY OF SALES BY CUSTOMER TYPE
/*

1- Member       2785
2- Normal       2725

*/

WITH CUSTOMER_TYPE_QUANTITY AS (
    SELECT 
        Customer_Type,
        SUM(Quantity) AS Customer_Type_Quantity
    FROM market_sales_analysis
    GROUP BY Customer_Type
)
SELECT 
    Customer_Type,
    Customer_Type_Quantity
FROM CUSTOMER_TYPE_QUANTITY
ORDER BY Customer_Type_Quantity DESC;

