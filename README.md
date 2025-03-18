

# Introduction 
Supermarket sales analysis from <a href='https://www.kaggle.com/datasets/willianoliveiragibin/market-sales-data' >kaggle</a>. 

* Due to the limited number of columns, I didnt have many options to explore data or trends on.


# Data Cleaning (Pandas)
- 4 functions in DataCleaner to get the percentage of columns and rows with missing values or duplicates
- Since the dataset contains no duplicate rows/columns or rows/columns with missing values then further row dropping or data-imputing is unnecessary
- Added underscores to attributes containing white space for the conveniece of SQL
- Stripped white spaces from all columns
- Renamed some column names for the conveniece of SQL again (removed a symbol from Tax_5% attribute)
- 3 functions to convert specific columns to string, integer, and float data types
- saved changed and created a new file with the cleaned data in a separate path


# Data Exploratory Analysis (SQL)
- SALES RANKING BY GENDER
<table><tr><th>Gender</th><th>Total_Sales</th><th>Rank</th><tr><tr><td>Female</td><td>181158.6135</td><td>1</td></tr><tr><td>Male</td><td>167533.778</td><td>2</td></tr></table>

## SALES RANKING BY BRANCH REVENUE 
<table><tr><th>Branch</th><th>Total_Sales</th><th>Rank</th><tr><tr><td>A</td><td>115426.737</td><td>1</td></tr><tr><td>B</td><td>112880.0775</td><td>2</td></tr><tr><td>C</td><td>120385.577</td><td>3</td></tr></table>

## TOTAL SALES BY CUSTOMER TYPE
<table><tr><th>Customer_Type</th><th>Customer_Type_Sales</th><tr><tr><td>Member</td><td>177796.1345</td></tr><tr><td>Normal</td><td>170896.257</td></tr></table>

## QUANTITY OF SALES BY CUSTOMER TYPE
<table><tr><th>Customer_Type</th><th>Customer_Type_Quantity</th><tr><tr><td>Member</td><td>2785</td></tr><tr><td>Normal</td><td>2725</td></tr></table>

## REVENUE BY PRODUCT LINES
<table><tr><th>Product_line</th><th>Product_Line_Sales</th><tr><tr><td>Fashion accessories</td><td>61611.977</td></tr><tr><td>Sports and travel</td><td>59508.292</td></tr><tr><td>Home and lifestyle</td><td>58486.2165</td></tr><tr><td>Food and beverages</td><td>58351.15</td></tr><tr><td>Electronic accessories</td><td>57443.634</td></tr><tr><td>Health and beauty</td><td>53291.122</td></tr></table>
  
## PRODUCT LINE REVENUE BY GENDER
<table><tr><th>Product_line</th><th>Gender</th><th>Product_Line_Sales</th><tr><tr><td>Food and beverages</td><td>Female</td><td>34670.138</td></tr><tr><td>Fashion accessories</td><td>Female</td><td>34163.9755</td></tr><tr><td>Health and beauty</td><td>Male</td><td>32517.2845</td></tr><tr><td>Home and lifestyle</td><td>Female</td><td>32228.5435</td></tr><tr><td>Sports and travel</td><td>Female</td><td>30818.754</td></tr><tr><td>Electronic accessories</td><td>Male</td><td>28940.269</td></tr><tr><td>Sports and travel</td><td>Male</td><td>28689.538</td></tr><tr><td>Electronic accessories</td><td>Female</td><td>28503.365</td></tr><tr><td>Fashion accessories</td><td>Male</td><td>27448.0015</td></tr><tr><td>Home and lifestyle</td><td>Male</td><td>26257.673</td></tr><tr><td>Food and beverages</td><td>Male</td><td>23681.012</td></tr><tr><td>Health and beauty</td><td>Female</td><td>20773.8375</td></tr></table>
  
## PRODUCT LINE REVENUE PERCENTAGE BY GENDER
<table><tr><th>Product_line</th><th>Gender</th><th>Product_Line_Sales</th><th>Revenue_Share_Percentage</th><tr><tr><td>Electronic accessories</td><td>Female</td><td>28503.365</td><td>49.6197106889164</td></tr><tr><td>Electronic accessories</td><td>Male</td><td>28940.269</td><td>50.3802893110836</td></tr><tr><td>Fashion accessories</td><td>Female</td><td>34163.9755</td><td>55.4502179016265</td></tr><tr><td>Fashion accessories</td><td>Male</td><td>27448.0015</td><td>44.5497820983735</td></tr><tr><td>Food and beverages</td><td>Female</td><td>34670.138</td><td>59.4163748272313</td></tr><tr><td>Food and beverages</td><td>Male</td><td>23681.012</td><td>40.5836251727687</td></tr><tr><td>Health and beauty</td><td>Female</td><td>20773.8375</td><td>38.9817979437551</td></tr><tr><td>Health and beauty</td><td>Male</td><td>32517.2845</td><td>61.0182020562449</td></tr><tr><td>Home and lifestyle</td><td>Female</td><td>32228.5435</td><td>55.1045108209385</td></tr><tr><td>Home and lifestyle</td><td>Male</td><td>26257.673</td><td>44.8954891790615</td></tr><tr><td>Sports and travel</td><td>Female</td><td>30818.754</td><td>51.7890078243214</td></tr><tr><td>Sports and travel</td><td>Male</td><td>28689.538</td><td>48.2109921756786</td></tr></table>


# Summary
- The dataset was initially clean and did not require implementing doing a whole lot of data cleaning methods. The column were of expected data types and there was no sign of duplicates or missing/null values.

  ## Gender
  - Although the disparity between men and women numbers is not significant, yet women outspend men in majority of product line except Electronic accessories where
    men account for 50.38% of total revenue of the said product line
    (Electronic accessories are )
  - 
