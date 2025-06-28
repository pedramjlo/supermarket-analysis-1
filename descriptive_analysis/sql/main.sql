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



-- WOMEN'S FAVOURITE CATEGORIES IN EACH CITY
WITH WOMEN_FAV_CATEGORY AS (
    SELECT 
        city,
        product_line,
        gender,
        SUM((unit_price * quantity) + calculated_tax) AS total_spending,
        RANK() OVER (PARTITION BY city ORDER BY SUM((unit_price * quantity) + calculated_tax) DESC) AS rank
    FROM market_sales
    WHERE gender is 'Female'
    GROUP BY city, product_line, gender
)
SELECT 
    city,
    gender,
    product_line,
    total_spending
FROM WOMEN_FAV_CATEGORY
WHERE rank = 1
ORDER BY city;


-- WOMEN'S LEAST FAVOURITE CATEGORIES IN EACH CITY
WITH WOMEN_FAV_CATEGORY AS (
    SELECT 
        city,
        product_line,
        gender,
        SUM((unit_price * quantity) + calculated_tax) AS total_spending,
        RANK() OVER (PARTITION BY city ORDER BY SUM((unit_price * quantity) + calculated_tax) ASC) AS rank
    FROM market_sales
    WHERE gender is 'Female'
    GROUP BY city, product_line, gender
)
SELECT 
    city,
    gender,
    product_line,
    total_spending
FROM WOMEN_FAV_CATEGORY
WHERE rank = 1
ORDER BY city;



-- MEN'S FAVOURITE CATEGORIES IN EACH CITY
WITH WOMEN_FAV_CATEGORY AS (
    SELECT 
        city,
        product_line,
        gender,
        SUM((unit_price * quantity) + calculated_tax) AS total_spending,
        RANK() OVER (PARTITION BY city ORDER BY SUM((unit_price * quantity) + calculated_tax) DESC) AS rank
    FROM market_sales
    WHERE gender is 'Male'
    GROUP BY city, product_line, gender
)
SELECT 
    city,
    gender,
    product_line,
    total_spending
FROM WOMEN_FAV_CATEGORY
WHERE rank = 1
ORDER BY city;



-- MEN'S LEAST FAVOURITE CATEGORIES IN EACH CITY
WITH WOMEN_FAV_CATEGORY AS (
    SELECT 
        city,
        product_line,
        gender,
        SUM((unit_price * quantity) + calculated_tax) AS total_spending,
        RANK() OVER (PARTITION BY city ORDER BY SUM((unit_price * quantity) + calculated_tax) ASC) AS rank
    FROM market_sales
    WHERE gender is 'Male'
    GROUP BY city, product_line, gender
)
SELECT 
    city,
    gender,
    product_line,
    total_spending
FROM WOMEN_FAV_CATEGORY
WHERE rank = 1
ORDER BY city;


