

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
