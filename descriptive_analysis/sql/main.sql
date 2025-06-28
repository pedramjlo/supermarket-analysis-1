-- Active: 1751106037609@@127.0.0.1@3306
SELECT * FROM market_sales;



-- TOTAL REVENUE BY CITY
SELECT 
    city,
    (unit_price * quantity) + calculated_tax as total_revenue
FROM market_sales
GROUP BY  city
ORDER BY total_revenue DESC;


-- REVENUE BY CATEGORY PER CITY