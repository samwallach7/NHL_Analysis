import psycopg
import pandas as pd
from dash import Dash, html, dcc, Input, Output
import plotly.express as px
from config import username, password

db_host = '127.0.0.1'  
db_name = 'Hockey_Data_Project 3'


# Use Psycopg2 to connect to Postgres SQL
conn = psycopg.connect(
    host="localhost",
    dbname="Hockey_Data_Project 3",
    user=username,
    password=password)


# Replace the placeholder values with your actual database connection details
#db_uri = 'postgresql://username:{@localhost:5432/{dbname}'
#engine = create_engine(db_uri)


# Make sure the engine is connected to the database
#connection = engine.connect()


query= "SELECT * FROM nhldraft_complete"
nhl_complete_df=pd.read_sql_query(query,conn)
nhl_complete_df.head()


# Your SQL query
#query = "SELECT * FROM nhldraft_complete"


# Use the engine to execute the query and read the result into a DataFrame
#nhl_complete_df = pd.read_sql_query(query, connection)


# Close the connection
#connection.close()


# Display the DataFrame
print(nhl_complete_df.head())




unique_year= sorted(nhl_complete_df['year'].unique())
nhl_complete_df['age'] = pd.to_numeric(nhl_complete_df['age'])
age_mean_by_country_year = nhl_complete_df.groupby(['year', 'nationality'])['age'].mean().reset_index()
age_mean_by_country_year= age_mean_by_country_year.round()
age_mean_by_country_year = nhl_complete_df.groupby(['year', 'nationality'])['age'].mean().reset_index()
age_mean_by_country_year= age_mean_by_country_year.round()


conn = psycopg.connect(
    host=db_host,
    dbname="Hockey_Data_Project 3",
    user="postgres",
    password="Bright100$"
)

# SQL query to retrieve data
query = "SELECT * FROM nhldraft_complete"
nhl_complete_df = pd.read_sql_query(query, conn)

# Unique years for dropdown
unique_years = sorted(nhl_complete_df['year'].unique())


nationality_code = {
    'SK': 'Slovakia',
    'US': 'United States',
    'CA': 'Canada',
    'SE': 'Sweden',
    'CZ': 'Czech Republic',
    'AT': 'Austria',
    'RU': 'Russia',
    'FI': 'Finland',
    'CH': 'Switzerland',
    'DE': 'Germany',
    'LV': 'Latvia',
    'PL': 'Poland',
    'BY': 'Belarus',
    'GB': 'United Kingdom',
    'KZ': 'Kazakhstan',
    'NO': 'Norway',
    'UA': 'Ukraine',
    'UZ': 'Uzbekistan',
    'DK': 'Denmark',
    'AU': 'Australia',
    'TH': 'Thailand',
    'JM': 'Jamaica',
    'FR': 'France',
    'SI': 'Slovenia',
    'BE': 'Belgium',
    'NL': 'Netherlands',
    'CN': 'China',
    'LT': 'Lithuania',
    'IT': 'Italy',
    'NG': 'Nigeria',
    'EE': 'Estonia',
    'JP': 'Japan',
    'ME': 'Montenegro',
    'HU': 'Hungary',
    'BS': 'Bahamas',
    'BR': 'Brazil',
    'TZ': 'Tanzania',
    'BN': 'Brunei',
    'KR': 'South Korea',
    'ZA': 'South Africa',
    'HT': 'Haiti',
    'TW': 'Taiwan',
    'PY': 'Paraguay',
    'VE': 'Venezuela'
}
nationality_code_df = pd.DataFrame.from_dict(nationality_code, orient='index', columns=['name']).reset_index()
nationality_code_df.columns = ['code', 'name']
merged_data2 = pd.merge(age_mean_by_country_year, nationality_code_df, left_on='nationality', right_on='code', how='left')


# Initialize the Dash app
app = Dash(__name__)

# Define the layout of the app
app.layout = html.Div([
    dcc.Dropdown(
        id='year-dropdown',
        options=[{'label': str(year), 'value': year} for year in unique_years],
        value=unique_years[0],  # Default value is the first year
        style={'width': '50%'}
    ),
    html.Div([
        dcc.Graph(id='graph1'),
        dcc.Graph(id='graph2'),
    ], style={'display': 'flex', 'flex-direction': 'column'}),
])

# Define callback to update the graphs based on the selected year
@app.callback(
    Output('graph1', 'figure'),
    [Input('year-dropdown', 'value')]
)
def update_graph1(selected_year):
    # Filter data based on the selected year
    data_for_selected_year = merged_data2[merged_data2['year'] == selected_year]


    # Replace None values in the 'age' column with 0
    data_for_selected_year['age'] = data_for_selected_year['age'].fillna(0)


    figure = px.bar(
        data_for_selected_year,
        x='name',
        y='age',
        title=f'Average Age of NHL Drafted Players by Drafted Nationality in {selected_year}',
        labels={'age': 'Average Age', 'name': 'Country of Origin'},
         text='age'
    )
   
    return figure

# Define another callback for the second graph
@app.callback(
    Output('graph2', 'figure'),
    [Input('year-dropdown', 'value')]
)
def update_graph2(selected_year):
   # Filter data based on the selected year
    filtered_data = nhl_complete_df[nhl_complete_df['year'] == selected_year]


    # If 'count' needs to be calculated dynamically
    counts = filtered_data.groupby('nationality').size().reset_index(name='count')


    # Now use 'counts' for plotting
    merged_data = pd.merge(counts, nationality_code_df, left_on='nationality', right_on='code', how='left')


    # Use px.treemap with the 'labels' parameter to show the full names in the treemap
    fig = px.treemap(merged_data, path=['name'], values='count',
                     title=f"NHL Drafted Player Count by Nationality in {selected_year}",
                     labels={'name': 'name', 'count': 'Count'},
                     color='count',
                     color_continuous_scale='Viridis')


    return fig

if __name__ == '__main__':
    app.run_server(debug=True)
