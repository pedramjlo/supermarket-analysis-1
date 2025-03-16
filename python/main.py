import pandas as pd
import sqlite3

# Step 1: Create a connection to the SQLite database
conn = sqlite3.connect('market_sales.db')  

# Step 2: Create a cursor object
cur = conn.cursor()

# Step 3: Execute SQL commands
# Create a table
cur.execute('''
CREATE TABLE IF NOT EXISTS uae_cars (
    id INTEGER PRIMARY KEY,
    Gender TEXT NOT NULL,
    Invoice_ID VARCHAR(50),
    Branch TEXT NOT NULL,
    City TEXT NOT NULL,
    Customer_Type TEXT NOT NULL,
    Product_Line TEXT NOT NULL,
    Unit_Price NUMERIC(10, 2),
    Quantity INTEGER,
    Tax_5_PERCENT FLOAT
);
''')

# Step 4: Commit changes
conn.commit()

# Step 5: Read the CSV file using Pandas
df = pd.read_csv('/Users/pedramjalali/Documents/data_analysis/E-commerce-analysis/dataset/cleaned/cleaned_market_sales.csv')

# Step 6: Load data into the SQLite database table
df.to_sql('uae_cars', conn, if_exists='append', index=False)

# Step 7: Close the connection
conn.close()
