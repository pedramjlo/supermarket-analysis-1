-- Active: 1751106037609@@127.0.0.1@3306
SELECT * FROM market_sales;



-- TOTAL REVENUE BY CITY
SELECT 
    city,
    SUM((unit_price * quantity) + calculated_tax) AS total_revenue
FROM market_sales
GROUP BY  city
ORDER BY total_revenue DESC;



-- REVENUE BY CATEGORY PER CITY
WITH REVENUE_PER_CATEGORY AS (
    SELECT
        city,
        product_line,
        SUM((unit_price * quantity) + calculated_tax) AS total_revenue
    FROM market_sales
    GROUP BY city, product_line
)
SELECT 
    city,
    product_line,
    total_revenue
FROM REVENUE_PER_CATEGORY
ORDER BY city, product_line, total_revenue DESC;


-- MALE AND FEMALE TOTAL SPENDING BY CITY
WITH REVENUE_BY_GENDER AS (
    SELECT
        city,
        gender,
        SUM((unit_price * quantity) + calculated_tax) AS total_spending
    FROM market_sales
    GROUP BY city, gender
)
SELECT 
    city,
    gender,
    total_spending
FROM REVENUE_BY_GENDER
ORDER BY city, gender, total_spending;