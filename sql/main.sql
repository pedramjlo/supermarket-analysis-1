SELECT * FROM market_sales_analysis;


-- SALES RANKING BY GENDER
/*
 
1- FEMALE         182578.1135   
2- MALE           168920.658

*/
SELECT 
    GENDER,
    SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Total_Sales,
    RANK() OVER (ORDER BY Quantity * Unit_Price DESC) as Rank
FROM market_sales_analysis
GROUP BY GENDER
ORDER BY Rank ASC;



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




-- TOTAL SALES BY CUSTOMER TYPE
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


-- REVENUE BY PRODUCT LINES
/*

1- Fashion accessories          62055.877
2- Sports and travel            59979.222
3- Home and lifestyle           58948.2765
4- Food and beverages           58818.43
5- Electronic accessories       57953.664
6- Health and beauty            53743.302

*/
WITH PRODUCT_LINE_SALES AS (
    SELECT 
        Product_line,
        SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Product_Line_Sales
    FROM market_sales_analysis
    GROUP BY Product_line
),
PRODUCT_LINE_RANKED AS (
    SELECT 
        Product_line,
        Product_Line_Sales,
        RANK() OVER (ORDER BY Product_Line_Sales DESC) AS Rank
    FROM PRODUCT_LINE_SALES
)
SELECT 
    Product_line,
    Product_Line_Sales
FROM PRODUCT_LINE_RANKED
ORDER BY Product_Line_Sales DESC;
