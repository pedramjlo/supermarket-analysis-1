import pyodbc

# Define the connection parameters
server = 'your_server_name'
database = 'your_database_name'
username = 'your_username'
password = 'your_password'

# Create a connection string
conn_str = (
    'DRIVER={ODBC Driver 17 for SQL Server};'
    f'SERVER={server};'
    f'DATABASE={database};'
    f'UID={username};'
    f'PWD={password}'
)

# Establish a connection
conn = pyodbc.connect(conn_str)

# Create a cursor object
cursor = conn.cursor()

# Execute a query
cursor.execute("SELECT * FROM your_table_name")

# Fetch all the rows
rows = cursor.fetchall()

for row in rows:
    print(row)

# Close the connection
conn.close()
