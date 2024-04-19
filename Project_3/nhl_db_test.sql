-- Drop the existing "awards" table if needed
DROP TABLE IF EXISTS "awards";

-- Recreate the "awards" table with columns in the desired order
CREATE TABLE "awards" (
  "UniqueID" SERIAL PRIMARY KEY,
  "playerID" VARCHAR,
  "award" VARCHAR,
  "year" INT,
  "lgID" VARCHAR,
  "pos" VARCHAR
);

-- Drop the existing "goalies" table if needed
DROP TABLE IF EXISTS "goalies";

-- Recreate the "goalies" table with columns in the desired order
CREATE TABLE "goalies" (
  "UniqueID" VARCHAR PRIMARY KEY,
  "PlayerID" VARCHAR,
  "TeamID" VARCHAR,
  "LeagueID" VARCHAR,
  "Games_Played" FLOAT,
  "Minutes_Played" FLOAT,
  "Wins" FLOAT,
  "Losses" FLOAT,
  "Year" INT
);

-- Drop the original league_averages table if it exists
DROP TABLE IF EXISTS "league_averages";

-- Create a new league_averages table
CREATE TABLE "league_averages" (
    "Rk" INT,
    "Season" VARCHAR(255),
    "Lg" VARCHAR(255),
    "GP" INT,
    "Goals" FLOAT,
    "PP" FLOAT,
    "PPO" FLOAT,
    "PP_percent" FLOAT,
    "PK_percent" FLOAT,
    "SA" FLOAT,
    "SV" FLOAT,
    "SV_percent" FLOAT,
    "GAA" FLOAT
);

-- Drop the "player_stats_2024" table if it exists
DROP TABLE IF EXISTS "player_stats_2024";

CREATE TABLE "player_stats_2024" (
    "StatID" INT PRIMARY KEY,
    TeamID INT,
    PlayerID INT,
    SeasonType INT,
    Season INT,
    Name VARCHAR,
    Team VARCHAR,
    Position VARCHAR,
    GlobalTeamID INT,
    Updated TIMESTAMP,  -- Assuming 'Updated' column is in timestamp format
    Games INT,
    FantasyPoints FLOAT,
    FantasyPointsFanDuel FLOAT,
    FantasyPointsDraftKings FLOAT,
    FantasyPointsYahoo FLOAT,
    Minutes INT,
    Seconds INT,
    Goals FLOAT,
    Assists FLOAT,
    ShotsOnGoal FLOAT,
    PowerPlayGoals FLOAT,
    ShortHandedGoals FLOAT,
    EmptyNetGoals FLOAT,
    PowerPlayAssists FLOAT,
    ShortHandedAssists FLOAT,
    HatTricks FLOAT,
    ShootoutGoals FLOAT,
    PlusMinus FLOAT,
    PenaltyMinutes FLOAT,
    Blocks FLOAT,
    Hits FLOAT,
    Takeaways FLOAT,
    Giveaways FLOAT,
    FaceoffsWon FLOAT,
    FaceoffsLost FLOAT,
    Shifts FLOAT,
    GoaltendingMinutes INT,
    GoaltendingSeconds INT,
    GoaltendingShotsAgainst FLOAT,
    GoaltendingGoalsAgainst FLOAT,
    GoaltendingSaves FLOAT,
    GoaltendingWins FLOAT,
    GoaltendingLosses FLOAT,
    GoaltendingShutouts FLOAT,
    Started INT,
    BenchPenaltyMinutes FLOAT,  -- This column has NULL values
    GoaltendingOvertimeLosses FLOAT,
    FantasyPointsFantasyDraft FLOAT
);

-- Drop the "nhl_mapping" table if it exists
DROP TABLE IF EXISTS "nhl_mapping";

CREATE TABLE "nhl_mapping" (
    year INTEGER   NOT NULL,
    lgID VARCHAR(10)   NOT NULL,
    tmID VARCHAR(10)   NOT NULL,
    franchID VARCHAR(10)   NOT NULL,
    teamName VARCHAR(50)   NOT NULL,
    lat NUMERIC   NOT NULL,
    long NUMERIC   NOT NULL,
    conference VARCHAR(50)   NOT NULL,
    totalSeasons INTEGER   NOT NULL,
    pointPercent NUMERIC   NOT NULL,
    playoffSeasons INTEGER   NOT NULL,
    playoffPercent NUMERIC   NOT NULL,
    SCAppearances INTEGER   NOT NULL,
    StanleyCupWins INTEGER   NOT NULL,
    active VARCHAR(10)   NOT NULL,
    lastSeason INTEGER   NOT NULL,
    teamChange VARCHAR(50)   NOT NULL,
    teamChangeLat NUMERIC   NOT NULL,
    teamChangeLong NUMERIC   NOT NULL,
    nhlAffiliate VARCHAR(50)   NOT NULL,
    ahlAffiliate VARCHAR(50)   NOT NULL,
    echlAffiliate VARCHAR(50)   NOT NULL,
	UniqueID INT NOT NULL,
	
	CONSTRAINT pk_NHL_Mapping PRIMARY KEY (
		UniqueID
	)

);

-- Drop the "stadiums" table if it exists
DROP TABLE IF EXISTS "stadiums";

CREATE TABLE "stadiums" (
    "StadiumID" INT PRIMARY KEY,
    "_Name" VARCHAR,
    "Capacity" FLOAT,
    "_Location" VARCHAR,
    "GeoLat" FLOAT NOT NULL,
    "GeoLong" FLOAT NOT NULL,
    "Active" BOOLEAN
);

-- Drop the "player_details_active" table if it exists
DROP TABLE IF EXISTS "player_details_active";

CREATE TABLE "player_details_active" (
    PlayerID INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Status VARCHAR(255),
    TeamID INT,
    Team VARCHAR(255),
    Position VARCHAR(255),
    Jersey FLOAT,
    Catches VARCHAR(255),
    Shoots VARCHAR(255),
    Height INT,
    Weight INT,
    BirthDate DATE,
    BirthCity VARCHAR(255),
    BirthState VARCHAR(255),
    PhotoUrl VARCHAR(255),
    SportRadarPlayerID VARCHAR(255),
    RotoworldPlayerID FLOAT,
    RotoWirePlayerID FLOAT,
    FantasyAlarmPlayerID FLOAT,
    StatsPlayerID FLOAT,
    SportsDirectPlayerID FLOAT,
    XmlTeamPlayerID FLOAT,
    InjuryStatus VARCHAR(255),
    InjuryBodyPart VARCHAR(255),
    InjuryStartDate DATE,
    InjuryNotes VARCHAR(255),
    FanDuelPlayerID FLOAT,
    DraftKingsPlayerID FLOAT,
    YahooPlayerID FLOAT,
    FanDuelName VARCHAR(255),
    DraftKingsName VARCHAR(255),
    YahooName VARCHAR(255),
    DepthChartPosition VARCHAR(255),
    DepthChartOrder FLOAT,
    GlobalTeamID INT,
    FantasyDraftName VARCHAR(255),
    FantasyDraftPlayerID FLOAT,
    UsaTodayPlayerID FLOAT,
    UsaTodayHeadshotUrl VARCHAR(255),
    UsaTodayHeadshotNoBackgroundUrl VARCHAR(255),
    UsaTodayHeadshotUpdated DATE,
    UsaTodayHeadshotNoBackgroundUpdated DATE
);


-- Drop the "players" table if it exists
DROP TABLE IF EXISTS "Players";

CREATE TABLE "players" (
	PlayerID INT NOT NULL PRIMARY KEY,
	FirstName VARCHAR,
	LastName VARCHAR,
	Status VARCHAR,
	TeamID INT,
	Team VARCHAR,
	Position VARCHAR,
	Height INT,
	Weight INT,
	BirthDate VARCHAR,
	BirthPlace VARCHAR

);

-- Drop the "teams_active" table if it exists
DROP TABLE IF EXISTS "teams_active";

CREATE TABLE "teams_active" (
    TeamID INT PRIMARY KEY,
    Name_ VARCHAR(255) NOT NULL,
    Abbreviation VARCHAR(10) NOT NULL,
    City VARCHAR(255) NOT NULL,
    StadiumID FLOAT,
    Conference VARCHAR(50),
    Division VARCHAR(50),
	HeadCoach VARCHAR,
	ColorCode VARCHAR,
	GlobalTeamID BIGINT NOT NULL,
	Active BOOLEAN
);

