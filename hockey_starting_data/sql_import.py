import pandas as pd
import psycopg2

# Connect to the PostgreSQL database
conn = psycopg2.connect(
    dbname="hockey_ml_db",
    user="",
    password="",
    host="localhost",
    port="5433"
)

# SQL query to select data from a table
sql_query = "SELECT * FROM NHL_ML"  # Change 'your_table' to your table name

# Read the data into a pandas DataFrame
df = pd.read_sql(sql_query, conn)

# Close the database connection
conn.close()

# Save the DataFrame to a CSV file
df.to_csv('nhl_analysis_79-11.csv', index=False)  # Change 'output.csv' to your desired output file name
