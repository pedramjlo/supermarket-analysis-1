-- Active: 1751106037609@@127.0.0.1@3306
SELECT * FROM market_sales;



-- TOTAL REVENUE BY CITY
SELECT 
    city,
    SUM((unit_price * quantity) + calculated_tax) AS total_revenue
FROM market_sales
GROUP BY  city
ORDER BY total_revenue DESC;



-- AVERAGE PRICES PER CATEGORY IN EACH CITY
WITH CATEGORY_PRICE AS (
    SELECT
        city, 
        product_line,
        AVG((unit_price * quantity) + calculated_tax) AS avg_price,
        RANK() OVER (ORDER BY  AVG((unit_price * quantity) + calculated_tax) DESC) AS rank
    FROM market_sales
    GROUP BY city, product_line
    ORDER by rank
)
SELECT 
    city,
    product_line,
    ROUND(avg_price, 3),
    rank
FROM CATEGORY_PRICE
ORDER BY city;




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
ORDER BY total_revenue DESC;


-- MALE AND FEMALE TOTAL SPENDING BY CITY
WITH REVENUE_BY_GENDER AS (
    SELECT
        city,
        gender,
        SUM((unit_price * quantity) + calculated_tax) AS total_spending,
        AVG((unit_price * quantity) + calculated_tax) AS avg_spending
    FROM market_sales
    GROUP BY city, gender
)
SELECT 
    city,
    gender,
    total_spending,
    ROUND(avg_spending, 3) as avg_spending
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



-- TOTAL QUANTITY SOLD PER CATEGORY 
SELECT 
    product_line,
    SUM(quantity) as quantity_sold
FROM market_sales
GROUP BY product_line
ORDER BY quantity_sold DESC;







-- TOP SELLING BRANCH IN EACH CITY
WITH BRANCH_REVENUE AS (
    SELECT
        city,
        branch,
        SUM((unit_price * quantity) + calculated_tax) AS total_revenue
    FROM market_sales
    GROUP BY city, branch
)
SELECT
    city,
    branch,
    MAX(total_revenue) as total_revenue
FROM BRANCH_REVENUE
GROUP BY city;



-- MEMBERS' VS NORMAL CUSTOMERS' AVERAGE SPENDINGS IN EACH CITY
WITH MEMBERS_SPENDING AS (
    SELECT 
        city,
        customer_type,
        AVG((unit_price * quantity) + calculated_tax) AS avg_spending
    FROM market_sales
    WHERE customer_type = 'Member'
    GROUP BY city, customer_type
),
NORMAL_SPENDING AS (
    SELECT 
        city,
        customer_type,
        AVG((unit_price * quantity) + calculated_tax) AS avg_spending
    FROM market_sales
    WHERE customer_type = 'Normal'
    GROUP BY city, customer_type
)
SELECT 
    city,
    customer_type,
    avg_spending
FROM MEMBERS_SPENDING  
UNION ALL
SELECT 
    city,
    customer_type,
    avg_spending
FROM NORMAL_SPENDING;



-- MEMBERS' VS NORMAL CUSTOMERS' AVERAGE SPENDINGS IN EACH BRANCH IN EACH CITY

WITH MEMBERS_SPENDING AS (
    SELECT 
        city,
        customer_type,
        branch,
        AVG((unit_price * quantity) + calculated_tax) AS avg_spending
    FROM market_sales
    WHERE customer_type = 'Member'
    GROUP BY city, customer_type, branch
    ORDER BY avg_spending DESC
),
NORMAL_SPENDING AS (
    SELECT 
        city,
        customer_type,
        branch,
        AVG((unit_price * quantity) + calculated_tax) AS avg_spending
    FROM market_sales
    WHERE customer_type = 'Normal'
    GROUP BY city, customer_type, branch
    ORDER BY avg_spending DESC
)
SELECT 
    city,
    customer_type,
    branch,
    avg_spending
FROM MEMBERS_SPENDING  
UNION ALL
SELECT 
    city,
    customer_type,
    branch,
    avg_spending
FROM NORMAL_SPENDING;


-- MEMBERS' FAVOURITE CATEGORY IN EACH CITY
WITH MEMBERS_FAV_CATEGORY AS (
    SELECT 
        city,
        product_line,
        SUM((unit_price * quantity) + calculated_tax) AS members_spending
    FROM market_sales
    WHERE customer_type = 'Member'
    GROUP BY city, product_line
    ORDER BY members_spending DESC
)
SELECT 
    city,
    product_line,
    members_spending
FROM MEMBERS_FAV_CATEGORY
ORDER by city;


-- NORMAL CUSTOMERS' FAVOURITE CATEGORY IN EACH CITY
WITH CUSTOMERS_FAV_CATEGORY AS (
    SELECT 
        city,
        product_line,
        SUM((unit_price * quantity) + calculated_tax) AS customer_spending
    FROM market_sales
    WHERE customer_type = 'Normal'
    GROUP BY city, product_line
    ORDER BY customer_spending DESC
)
SELECT 
    city,
    product_line,
    customer_spending
FROM CUSTOMERS_FAV_CATEGORY
ORDER by city;

