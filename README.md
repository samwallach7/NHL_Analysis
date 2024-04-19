# NHL_Analysis

## Table of Contents
- [Background](#background)
- [Project Overview](#project-overview)
  - [Sections & Approach](#sections-&-approach)
  - [Questions We Hope to Answer with Data](#questions-we-hope-to-answer-with-data)
  - [Approach](#approach)
- [Data Exploration](#data-exploration)
  - [Data Retrieval](#data-retrieval)
  - [Database Design](#database-design)
  - [Preprocessing of Data](#preprocessing-of-data)
- [Visualizations & Analysis](#visualizations-&-analysis)
- [Machine Learning](#machine-learning)
  - [Models Used for Prediction](#models-used-for-prediction)
- [Visualization](#visualization)
- [Communication](#communication)
- [Technologies](#technologies)
- [Resources](#resources)

## Background
Hockey is one of the most popular sports in North America. The National Hockey League (NHL) was founded in 1917 and has experienced significant growth and transformation over the years. As a professional league develops, teams improve every facet of their organizations, from arenas and fan engagement to coaching, player acquisition and development. There is also an improvement over time in the players themselves. Professional athletes in general have become bigger, faster, stronger and more specialized as compared to their predecessors.
In each NHL game, teams earn 2 points for a win, 1 point for an overtime loss, and 0 points for a regulation loss. These points are kept over the course of a season and used for the league standings and to determine the playoff teams and seeds at the end of the season.

## Project Overview

We set out to analyze the progression of the National Hockey League (NHL) over the last 100 years through team performance, player statistics and fan engagement data. The project was broken up into three distinct sections throughout the Data Analysis & Visualization program, with each utilizing the different skills that we acquired during the cohort. 

### Sections & Approach
#### Section I (Python)
We started with determining a topic for the project and finding relevant datasets to utilize. We found a folder of hockey-related data on Kaggle that featured files on team performance, player performance, coaches, awards and more. We utilized Python to clean, manipulate and visualize the data and then develop conclusions based on these inital findings.

#### Section II (JavaScript, HTML, Leaflet)
We developed a webpage with multiple tabs that utilized JavaScript, HTML and CSS formatting. The first page featured a player selector tool that allows a user to choose a player from a list and see their stats for the most recent season. The second page featured a Leaflet map of each NHL team and their minor league affiliates (locations were marked on the map with their team logos), and map layers to sort out certain performance metrics (playoff percentage, Stanley Cup titles, etc.). The final page featured a selector tool realted to the NHL draft where the user can select a year from the list and see the nationality breakdown from that draft.

#### Section III (Machine Learning)
We developed mutiple machine learning models based on the NHL data. The first item was a KMeans model that would build clusters based on team metrics and predict playoff participation. We built plots to highlight Goals For vs. Points, Goals Against vs. Points, and Goal Spread vs. Points. The second item was a Logistic Regression for playoff participation that we tried to optimize the accuracy on by utilizing team goal, penalty and efficiency metrics. Finally, we built a Linear Regression to predict player perfomance for an upcoming season based on historical data.
 
### Questions We Hope to Answer with Data:

- On a per game basis, did noticeable shifts occur over time in relation to team performance? How can these fluctuations be explained when considering the evolution of offensive and defensive philosophies?
- Most professional sports leagues have developed a goal of achieving a competitive balance (evidenced by the introduction of salary caps, player drafts, among others…). This in theory improves the product league-wide and gives teams a better chance to win any given game. Is this competitive balance exhibited when assessing a team’s point output in a given season?
- How did the league evolve over time in reagrds to talent acquisiton?
- Did generational players have an impact on the team and average player statistics?

## Data Exploration

### Data Retrieval
Our ETL (Extract, Transform, Load) workflow was designed to consolidate diverse data sources into a unified format. This process is crucial for ensuring data consistency and reliability. Let's walk through each phase:
#### Extract Phase
In the extract phase, we focused on retrieving data from the sportsIO API database. We developed Python scripts to handle API requests, manage rate limits, and ensure data consistency. This phase laid the foundation for our data integration process.
#### Transform Phase
The transform phase involved cleaning and standardizing the extracted data. For the players dataset, this meant addressing missing values and normalizing player statistics. We extensively used Pandas for data manipulation, reshaping the data to fit our analytical needs. We encapsulated this transformation process in a function, making it scalable and customizable.

For the teams dataset, transformation involved aggregating team-level data, standardizing team names, and ensuring uniformity across different datasets. This step was crucial for aligning team data with the rest of our integrated data.
#### Load Phase
In the load phase, we utilized psycopg2, a PostgreSQL adapter for Python, to load the transformed data into a SQL database. Psycopg2 provided a robust and efficient way to establish a connection to the database and execute SQL queries. We created tables in the database to store the player and team data, ensuring that the schema matched the format of the transformed data. Using psycopg2's functionality, we inserted the data into the respective tables, completing the ETL process and making the integrated data available for analysis and reporting.

### Database Design
Our database was designed to accommodate the specifics of the NHL data we were working with. Each dataset was given its own table, structured with carefully selected data types for each column to optimize storage and retrieval. To ensure unique identification of each entity, we implemented composite primary keys for both team and player records. This approach not only enhanced data integrity but also facilitated complex queries involving multiple tables.
### Preprocessing of Data
The preprocessing stage began with the teams dataset. Here, team_id was employed as the primary key, establishing a unique and consistent identifier across the database. The team_name served as another distinctive element, reinforcing the identification process. For relational integrity and to underscore the connections between teams and players, team_id was also used as a foreign key in the players dataset. This setup was crucial for linking team performances directly to their respective players, allowing for more nuanced analysis and insights.

## Visualizations & Analysis
<img src="image_files/pagePreview.mov" width=100% height=300px margin="auto" >

### Team Performance
#### Has team performance changed over time?
The distribution of team results tightens between the 1970’s to 2011, which we believe shows that the league’s competitive balance improved despite adding roughly 15 franchises over that time. Implementations such as salary cap restrictions, draft structure and an increase in player quality and development helped to achieve these results. In general, a more balanced league provides greater entertainment value, as more teams have realistic chances of qualifying for the playoffs.

![Fig2](https://github.com/samwallach7/NHL_Analysis/assets/148116220/a6ce75c9-e2e4-421e-8075-e1ceb5c56820=100x100)

This is also evident when looking at the results by variance, median and quartile.

![Fig14](https://github.com/samwallach7/NHL_Analysis/assets/148116220/e42e15fd-e8c5-4e73-b698-f3e730c7ef24)![Fig13](https://github.com/samwallach7/NHL_Analysis/assets/148116220/1cf290e0-aadf-4737-a034-e269b1eef4be)

![Fig3](https://github.com/samwallach7/NHL_Analysis/assets/148116220/13429a30-25ad-468c-b641-906d72b5410e)

#### Has goal scoring evolved over time?
A steady increase in goals scored per game was observed from the 1950’s to the 1980’s. Subsequently, a decrease in goals per game is observed over the following 15 years (1980’s to 2000). 

![Fig6](https://github.com/samwallach7/NHL_Analysis/assets/148116220/dec6e119-d192-4ccf-a1aa-7158217ac5f7)

We believe this can be attributed to a variety of factors, including a renewed defensive emphasis (in coaching, player development, tactics, etc.) to counteract NHL offenses and also a major rule change related to offsides (preventing players from remaining in the offside zone)

### Player Statictics
#### How have individual player statistics evolved over time?
The average goals scored (by player) and the average goals allowed (by goalie) decreased between the 1980’s to 2011. This matches up with the team-specific data above, where there was a noted decrease in goal scoring. Meanwhile, the average shots allowed increased and the average shots on goal fluctuated but remained about the same from the 1980’s to 2011. With more total shots but the same amount of shots on goal, that is a clear sign in defensive improvement of teams limiting the “quality” of shots that opponents take.

![subplot](https://github.com/samwallach7/NHL_Analysis/assets/148116220/317db7dd-a0a7-47a9-8599-4f89db1f26e2)

### Player Measurables
#### How have player measurables evolved over time?
There has been a consistent rise in attributes such as height and weight. While this should be considered along with a general trend among the human population, this also provides evidence of the league’s emphasis on acquiring larger, stronger, faster and more athletic players.

![measurables](https://github.com/samwallach7/NHL_Analysis/assets/148116220/a399bd45-bec8-44ba-8126-76099f0b5322)


### NHL Attendance
#### How has NHL fan attendance evolved over time?
Game attendance has consistently risen since the inception of the league. Specifically within the last 40 years, the in-person popularity has doubled. While some of this increase can be attributed to additional teams in the league and larger arenas, an increase of this caliber is clearly a trend.

![attendance](https://github.com/samwallach7/NHL_Analysis/assets/148116220/50897b3e-a24f-4971-ae3a-19cfc00edb32)

The three sharp spikes in the attendance data can be attributed to certain external factors. In 1994 and 2012, the league experienced player lockouts, which limited or virtually eliminated the entire season. In 2020, the NHL season was cut short and the playoffs were eliminated due to the COVID-19 pandemic.

### NHL Draft
#### How has the search for professional talent evolved over the years?
In the early years of the National Hockey League, the majority of the professional players were Canadian. Since the 1960’s however, there has been a notable surge in diversity, mainly from the United States, Russia and European countries.

![NHLDRAFTCOUNT](https://github.com/samwallach7/NHL_Analysis/assets/148116220/f2ecae95-4b1f-4d7c-b25a-3d37e80e4142)

Our analysis was robust and multi-dimensional. Utilizing the Pandas library, we cleaned and transformed the team data to prepare it for in-depth examination. For visual exploration and to present our findings in an intuitive format, we incorporated Matplotlib. This combination not only facilitated a deeper understanding of the data but also enabled us to uncover patterns and trends that were not immediately apparent. Through this comprehensive analysis, we were able to draw meaningful conclusions about team performances and their correlations with player statistics.

## Machine Learning
### Models used for Prediction
#### KMeans Clustering
The team performance dataset was condensed to build a KMeans model that predicted a team’s qualification for the playoffs. Multiple variations were created with the Points earned per game as the y value in the plot, (1) using the Goals For per game, (2) using the Goals Against per game and (3) using the Goal Spread (Goals For per game - Goals Against per game). The elbow method lead us to utilize 4 clusters for each of these models. Of these clusters, there were 2 clusters each that displayed teams that missed the playoffs and teams that made the playoffs. The clusters joined datapoints with similar point per game and goal output characteristics.

Using Goals For:

Clusters 0 and 2 made the playoffs while clusters 1 and 3 did not.

<img width="698" alt="Screenshot 2024-04-15 at 8 54 02 PM" src="https://github.com/samwallach7/NHL_Analysis/assets/148116220/5c765727-1b57-4183-aa07-e6d7a1a1b8b3">

Using Goals Against:

Clusters 0 and 3 made the playoffs while clusters 1 and 2 did not.

<img width="699" alt="Screenshot 2024-04-15 at 8 55 02 PM" src="https://github.com/samwallach7/NHL_Analysis/assets/148116220/b6df39bc-9381-42c6-9ee6-37dd0dffd95d">

Using the spread between goals for and goals against (per game):

Clusters 0 and 2 made the playoffs while clusters 1 and 3 did not.

<img width="699" alt="Screenshot 2024-04-15 at 8 51 48 PM" src="https://github.com/samwallach7/NHL_Analysis/assets/148116220/1679ced6-8ea7-401e-a1da-4dfa914f29b4">

On the Goal Spread plot, note that there are some teams with a negative goal spread that made the playoffs and conversely teams with a positive goal spread that did not make the playoffs. Of these cases, there seem to be more instances of the former than the latter.

This data also shows that a statistical threshold for guaranteeing qualification for the playoffs is a Goal Spread value of at least 0.3.

#### Logistic Regression
The team performance dataset was also utilized to construct a logistic regression to predict playoff qualification. After testing different combinations of data, the model we chose to utilize had a target value of “made_playoff” (a Bernoulli value of whether the team made the playoffs or not) and features values of goals for per game, goals allowed per game, power play goal efficiency (percent of the time a team scored when on a power play) and penalty kill efficiency (percent of the time a team did not allow a goal when short-handed).

We conducted a train_test_split, fit the model with the training data, and predicted the Bernoulli outputs for making the playoffs. We arrived at a model with 90% overall accuracy and for the predictions of making the playoffs, a 0.89 precision and a 0.97 recall.

A sample of the datapoints used to build the model:

<img width="359" alt="Screenshot 2024-04-11 at 9 39 34 PM" src="https://github.com/samwallach7/NHL_Analysis/assets/148116220/f3d74b5f-a963-4927-834f-d8e173924c9f">

The Classification Report for the model:

<img width="500" alt="Screenshot 2024-04-11 at 9 39 15 PM" src="https://github.com/samwallach7/NHL_Analysis/assets/148116220/a0e85bdb-257e-41cb-85f8-85c87bac9256">


#### Linear Regression
- Points Prediction:
  - Mean Squared Error (MSE): 1404.51
  - R-squared (R²): 0.972
  - The model performs exceptionally well in predicting points, with a high R² value indicating that it explains 97.2% of the variance in points based on the features in the dataset. The relatively low MSE suggests that the model's predictions are close to the actual points scored by players.

- Goals Prediction:
  - Mean Squared Error (MSE): 359.67
  - R-squared (R²): 0.956
  - For goals prediction, the model also demonstrates strong performance, with an R² value of 0.956. This indicates that 95.6% of the variance in goals can be explained by the model. The MSE for goals is relatively low, indicating accurate predictions.

- Assists Prediction:
  - Mean Squared Error (MSE): 643.97
  - R-squared (R²): 0.967
  - Similarly, the model performs well in predicting assists, with an R² value of 0.967, indicating that 96.7% of the variance in assists is explained by the model. The MSE for assists is also relatively low, suggesting accurate predictions.

- Overall, the model demonstrates strong predictive capabilities for player performance metrics, but further validation and consideration of recent trends and factors are advised when using the model for predictions in the present day.

## Communication Protocols
We communicated and developed our project over virtual meetings through Zoom and Google Meet, chat through Slack, and repository branch commits through GitHub.

## Technologies

Here's a list of technologies used in the project:

### Python libraries
   - Matplotlib
   - Pandas
   - Numpy
   - Scipy
   - HvPlot

### Data manipulation
  - JSON files
  - CSV files
  - GeoJSON files

### API integration
   - API key management
   - Requests library

### Web development
   - Dash 
   - JupyterDash
   - Plotly Express
   - Leaflet
   - Flask

### Database interaction
   - SQLAlchemy
   - PostgreSQL
   - psycopg
   - SQL connection

### Frontend technologies
   - HTML
   - Anime.js
   - D3.js

### Miscellaneous
   - Time module
   - OS module
   - Pathlib
   - Random module

## Members

[<img src="https://github.com/samwallach7.png" width="50" height="50"> Sam Wallach](https://github.com/samwallach7)

[<img src="https://github.com/Lena-Hill.png" width="50" height="50"> Lena Hill](https://github.com/Lena-Hill)

[<img src="https://github.com/derekjohnson7.png" width="50" height="50"> Derek Johnson](https://github.com/derekjohnson7)

[<img src="https://github.com/Elodie0712.png" width="50" height="50"> Elodie Mwamba](https://github.com/Elodie0712)

## Resources
https://www.kaggle.com/datasets/open-source-sports/professional-hockey-database?resource=download
https://www.kaggle.com/datasets/mattop/nhl-draft-hockey-player-data-1963-2022?select=nhldraft.csv
https://sportsdata.io/developers/api-documentation/nhl

