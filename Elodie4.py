#Import Dependencies 
import psycopg
import pandas as pd
from dash import Dash, html, dcc, Input, Output
import plotly.express as px
from config import username, password
import plotly.express as px

# Database connection parameters
db_host = '127.0.0.1'
db_name = 'Hockey_Data_Project_3' 

# Establish a database connection using psycopg
conn = psycopg.connect(
    host="localhost",
    dbname="Hockey_Data_Project 3",
    user=username,
    password=password
)
# SQL query to retrieve data
query = "SELECT * FROM nhldraft_complete"
nhl_complete_df = pd.read_sql_query(query, conn)

# Unique years for dropdown
unique_years = sorted(nhl_complete_df['year'].unique())

# Mapping of nationality codes to full names
nationality_code =  {
    'SK': 'SVK',
    'US': 'USA',
    'CA': 'CAN',
    'SE': 'SWE',
    'CZ': 'CZE',
    'AT': 'AUT',
    'RU': 'RUS',
    'FI': 'FIN',
    'CH': 'CHE',
    'DE': 'DEU',
    'LV': 'LVA',
    'PL': 'POL',
    'BY': 'BLR',
    'GB': 'GBR',
    'KZ': 'KAZ',
    'NO': 'NOR',
    'UA': 'UKR',
    'UZ': 'UZB',
    'DK': 'DNK',
    'AU': 'AUS',
    'TH': 'THA',
    'JM': 'JAM',
    'FR': 'FRA',
    'SI': 'SVN',
    'BE': 'BEL',
    'NL': 'NLD',
    'CN': 'CHN',
    'LT': 'LTU',
    'IT': 'ITA',
    'NG': 'NGA',
    'EE': 'EST',
    'JP': 'JPN',
    'ME': 'MNE',
    'HU': 'HUN',
    'BS': 'BHS',
    'BR': 'BRA',
    'TZ': 'TZA',
    'BN': 'BRN',
    'KR': 'KOR',
    'ZA': 'ZAF',
    'HT': 'HTI',
    'TW': 'TWN',
    'PY': 'PRY',
    'VE': 'VEN'
}
# Turn it into a dataframe

nationality_code_df = pd.DataFrame.from_dict(nationality_code, orient='index', columns=['name']).reset_index()
nationality_code_df.columns = ['code', 'iso3']

# Calculate average age by country and year
nhl_complete_df['age'] = pd.to_numeric(nhl_complete_df['age'], errors='coerce')
age_mean_by_country_year = nhl_complete_df.groupby(['year', 'nationality'])['age'].mean().reset_index().round()

# Merge for full country names
merged_data2 = pd.merge(age_mean_by_country_year, nationality_code_df, left_on='nationality', right_on='code', how='left')

# Initialize Dash app
app = Dash(__name__)

app.layout = html.Div([
    dcc.Dropdown(
        id='year-dropdown',
        options=[{'label': str(year), 'value': year} for year in unique_years],
        value=unique_years[0],  
        style={'width': '50%'}
    ),
    html.Div([  
        dcc.Graph(id='graph1'),
        dcc.Graph(id='graph2')
    ], style={'display': 'flex', 'flex-direction': 'column'}),  # Style applies to the div above
    dcc.Graph(id='graph3')  
], style={'display': 'flex', 'flex-direction': 'column'})  # This style applies to the outermost div


@app.callback(
    Output('graph1', 'figure'),
    Input('year-dropdown', 'value'))
def update_graph1(selected_year):
    filtered_data = merged_data2[merged_data2['year'] == selected_year]
    fig = px.bar(
        filtered_data,
        x='iso3',
        y='age',
        title=f'Average Age of NHL Drafted Players by Nationality in {selected_year}',
        labels={'age': 'Average Age', 'iso3': 'Country'},
        text='age'
    )
    return fig

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

    # Use px.choropleth with the 'locations' parameter set to 'iso3' (ISO alpha-3 country codes)
    fig = px.choropleth(merged_data,
                        locations='iso3',  # Use ISO alpha-3 country codes for locations
                        color='count',
                        hover_name='nationality',
                        title=f"NHL Drafted Player Count by Nationality in {selected_year}",
                        color_continuous_scale='Viridis')
    
    fig.update_geos(projection_type="natural earth") 

    return fig
@app.callback(
    Output('graph3', 'figure'),
    Input('year-dropdown', 'value'))
def update_graph3(selected_year):
    filtered_data = nhl_complete_df[nhl_complete_df['year'] == selected_year]
    counts = filtered_data.groupby('team').size().reset_index(name='count')
    fig = px.funnel(
        counts,
        x='count',
        y='team',
        title=f"NHL Drafted Recruits by Team in {selected_year}",
        labels={'count': 'Count of Recruits', 'team': 'Team'},
    )
    
    return fig

if __name__ == '__main__':
    app.run_server(debug=True)
