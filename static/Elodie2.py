import psycopg
import pandas as pd
from dash import Dash, html, dcc, Input, Output
import plotly.express as px


# Assuming psycopg.connect and pd.read_sql_query are correctly fetching your data


# Your database connection details should ideally be stored securely
# Your database connection details
conn = psycopg.connect(
    host="localhost",
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
        dcc.Graph(id='output-graph')
    ])
])


# Define callback to update the graph based on selected year
@app.callback(
    Output('output-graph', 'figure'),
    [Input('year-dropdown', 'value')]
)
def update_graph(selected_year):
    # Filter data based on the selected year
    filtered_data = nhl_complete_df[nhl_complete_df['year'] == selected_year]


    # If 'count' needs to be calculated dynamically
    counts = filtered_data.groupby('nationality').size().reset_index(name='count')


    # Now use 'counts' for plotting
    merged_data = pd.merge(counts, nationality_code_df, left_on='nationality', right_on='code', how='left')


    # Use px.treemap with the 'labels' parameter to show the full names in the treemap
    fig = px.treemap(merged_data, path=['name'], values='count',
                     title=f"NHL Draft Count by Nationality for {selected_year}",
                     labels={'name': 'name', 'count': 'Count'},
                     color='count',
                     color_continuous_scale='Viridis')


    return fig


if __name__ == '__main__':
    app.run_server(debug=True)