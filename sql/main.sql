SELECT * FROM market_sales_analysis;


-- TOTAL SALES ->    348692.3915

SELECT 
    SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Total_Sales
FROM market_sales_analysis;





-- TAXES BY CITY IN CORRELATION TO AVERAGE PRICE AND REVENUE RANK OF THE CITIES
/*

The average prices seem to not be directly correlated with the tax rate

*/
WITH TAX_PER_CITY AS (
    SELECT 
        City,
        ROUND(AVG(Unit_price), 2) AS Average_Price, 
        ROUND(AVG(Tax_five_percent), 2) AS Average_Tax_Rate,           
        AVG(Quantity) as Average_Quantity_Sold,
        RANK() OVER (ORDER BY SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) DESC) AS Revenue_Rank
    FROM market_sales_analysis
    GROUP BY City
)
SELECT 
    City,
    Average_Tax_Rate, 
    Average_Price,
    Average_Quantity_Sold,
    Revenue_Rank
FROM TAX_PER_CITY
ORDER BY Revenue_Rank;





-- QUANTITY SOLD BY GENDER
WITH QUANTITY_SOLD_BY_GENDER AS (
    SELECT 
        Gender,
        SUM(Quantity) AS Quantity_Sold
    FROM market_sales_analysis
    WHERE Gender IN ('Female', 'Male')
    GROUP BY Gender
)
SELECT 
    Gender, 
    Quantity_Sold
FROM QUANTITY_SOLD_BY_GENDER;





-- SALES RANKING BY GENDER
/*
 
1- FEMALE         182578.1135   
2- MALE           168920.658

*/
WITH Aggregated_Sales AS (
    SELECT 
        GENDER,
        SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Total_Sales
    FROM market_sales_analysis
    GROUP BY GENDER
),
Ranked_Sales AS (
    SELECT 
        GENDER,
        Total_Sales,
        RANK() OVER (ORDER BY Total_Sales DESC) AS Rank
    FROM Aggregated_Sales
)
SELECT 
    GENDER,
    Total_Sales,
    Rank
FROM Ranked_Sales
ORDER BY Rank ASC;




-- SALES RANKING BY BRANCH
/*
 
1- A         116366.947   
2- B         113780.7175
3- C         113780.7175

*/
SELECT 
    Branch,
    City,
    SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Total_Sales,
    RANK() OVER (ORDER BY Quantity * Unit_Price DESC) as Rank
FROM market_sales_analysis
GROUP BY Branch, City
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



-- PRODUCT LINE REVENUE BY GENDER
/*

(add percentage of sales by gender)

Product Line                    Female                  Male

1- Fashion accessories          34430.9755              27624.9015
2- Sports and travel            31059.774               28919.448
3- Home and lifestyle           32458.0935              26490.183
4- Food and beverages           34919.488               23898.942
5- Electronic accessories       28753.815               29199.849
6- Health and beauty            20955.9675              32787.3345

*/


WITH PRODUCT_LINE_SALES_BY_GENDER AS (
    SELECT 
        Product_line,
        Gender,
        SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Product_Line_Sales
    FROM market_sales_analysis
    WHERE Gender IN ('Female', 'Male')
    GROUP BY Product_line, Gender
),
PRODUCT_LINE_RANKED AS (
    SELECT 
        Product_line,
        Gender,
        Product_Line_Sales,
        RANK() OVER (ORDER BY Product_Line_Sales DESC) AS Rank
    FROM PRODUCT_LINE_SALES_BY_GENDER
)
SELECT 
    Product_line,
    Gender,
    Product_Line_Sales
FROM PRODUCT_LINE_SALES_BY_GENDER
ORDER BY Product_Line_Sales DESC;








-- PRODUCT LINE REVENUE PERCENTAGE BY GENDER
/*

Product Line                    Female                  Male

1- Fashion accessories          55.45%                  44.54%
2- Sports and travel            51.78%                  48.21%
3- Home and lifestyle           55.1%                   44.89%
4- Food and beverages           59.41%              	40.58%
5- Electronic accessories       49.61%                  50.38%
6- Health and beauty            38.98%             	    61.01%

*/
WITH PRODUCT_LINE_SALES_BY_GENDER AS (
    SELECT 
        Product_line,
        Gender,
        SUM(Quantity * Unit_Price) + SUM(Tax_five_percent) AS Product_Line_Sales
    FROM market_sales_analysis
    WHERE Gender IN ('Female', 'Male')
    GROUP BY Product_line, Gender
),
PRODUCT_LINE_TOTALS AS (
    SELECT
        Product_line,
        SUM(Product_Line_Sales) AS Total_Product_Line_Sales
    FROM PRODUCT_LINE_SALES_BY_GENDER
    GROUP BY Product_line
),
PRODUCT_LINE_SALES_WITH_PERCENTAGE AS (
    SELECT 
        plsg.Product_line,
        plsg.Gender,
        plsg.Product_Line_Sales,
        plt.Total_Product_Line_Sales,
        (plsg.Product_Line_Sales / plt.Total_Product_Line_Sales) * 100 AS Revenue_Share_Percentage
    FROM PRODUCT_LINE_SALES_BY_GENDER plsg
    JOIN PRODUCT_LINE_TOTALS plt
    ON plsg.Product_line = plt.Product_line
)
SELECT 
    Product_line,
    Gender,
    Product_Line_Sales,
    Revenue_Share_Percentage
FROM PRODUCT_LINE_SALES_WITH_PERCENTAGE
ORDER BY Product_line, Gender;



-- Average sales per product line (including quantity and tax)
WITH AVERAGE_SALES_BY_PRODUCT_LINE AS (
    SELECT 
        Product_line,
        AVG(Unit_Price) AS Average_Sales
    FROM market_sales_analysis
    GROUP BY Product_line
)
SELECT 
    Product_line,
    Average_Sales
FROM AVERAGE_SALES_BY_PRODUCT_LINE
ORDER BY Average_Sales DESC;