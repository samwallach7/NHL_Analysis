import pandas as pd
import psycopg2

# Connect to the PostgreSQL database
conn = psycopg2.connect(
    dbname="hockey_db",
    user="postgres",
    password="##Password not supplied for push to repo##",
    host="localhost",
    port="5433"
)

# SQL query to select data from a table
sql_query = "SELECT * FROM nhl_mapping"  # Change 'your_table' to your table name

# Read the data into a pandas DataFrame
df = pd.read_sql(sql_query, conn)

# Close the database connection
conn.close()

# Save the DataFrame to a CSV file
df.to_csv('../mapping_output_files/NHL_team_file_save.csv', index=False)  # Change 'output.csv' to your desired output file name