-- Create Teams table
CREATE TABLE IF NOT EXISTS "Teams" (
  "TeamID" serial PRIMARY KEY,
  "Name" varchar,
  "Location" varchar,
  "Stadium_ID" int,
  "Year" int,
  "LeagueID" varchar,
  "ConferenceID" int,
  "DivisionID" int,
  "Rank" int
);

-- Create Players table
CREATE TABLE IF NOT EXISTS "Players" (
  "PlayerID" varchar PRIMARY KEY,
  "TeamID" int,
  "Name" varchar,
  "Position" varchar,
  "Birthdate" date,
  FOREIGN KEY ("TeamID") REFERENCES "Teams" ("TeamID")
);

-- Create PlayerTeams table
CREATE TABLE IF NOT EXISTS "PlayerTeams" (
  "PlayerID" varchar,
  "TeamID" int,
  PRIMARY KEY ("PlayerID", "TeamID"),
  FOREIGN KEY ("PlayerID") REFERENCES "Players" ("PlayerID"),
  FOREIGN KEY ("TeamID") REFERENCES "Teams" ("TeamID")
);

-- Create Stadiums table
CREATE TABLE IF NOT EXISTS "Stadiums" (
  "StadiumID" serial PRIMARY KEY,
  "Name" varchar,
  "Location" varchar,
  "Active" bool,
  "Capacity" int,
  "Latitude" float,
  "Longitude" float
);

-- Create League_Averages table
CREATE TABLE IF NOT EXISTS "League_Averages" (
  "Rank" int PRIMARY KEY,
  "Season" varchar,
  "LeagueID" varchar,
  "GP" int,
  "G" float,
  "PP" int,
  "PPP" float,
  "PKP" float,
  "SA" float,
  "SV" float,
  "SVP" float,
  "GAA" float
);

-- Create Awards table
CREATE TABLE IF NOT EXISTS "Awards" (
  "UniqueID" SERIAL PRIMARY KEY,
  "PlayerID" varchar,
  "Award" varchar,
  "Year" int,
  "lgID" varchar,
  "pos" varchar
);

-- Create Goalies table
CREATE TABLE IF NOT EXISTS "Goalies" (
  "PlayerID" varchar PRIMARY KEY,
  "Year" int,
  "TmID" varchar UNIQUE,
  "LeagueID" varchar,
  "GP" int,
  "Min" int,
  "W" int,
  "L" int
);

-- Add column to Awards table
ALTER TABLE IF EXISTS "Awards" ADD COLUMN IF NOT EXISTS "LeagueID" varchar;

-- Drop existing foreign key constraint in Players table
ALTER TABLE IF EXISTS "Players" DROP CONSTRAINT IF EXISTS "Players_PlayerID_fkey" CASCADE;

-- Drop existing primary key constraint in Awards table
ALTER TABLE IF EXISTS "Awards" DROP CONSTRAINT IF EXISTS "Awards_pkey";

-- Remove unique constraint on PlayerID, Year, and Award in Awards table
ALTER TABLE IF EXISTS "Awards" DROP CONSTRAINT IF EXISTS "unique_award_per_player_per_year";

-- Add UniqueID column to Awards table
ALTER TABLE IF EXISTS "Awards" ADD COLUMN IF NOT EXISTS "UniqueID" SERIAL;

-- Make UniqueID the primary key
ALTER TABLE IF EXISTS "Awards" ADD PRIMARY KEY ("UniqueID");


-- Remake the Awards table
-- Drop the existing "Awards" table if needed
DROP TABLE IF EXISTS "Awards";

-- Recreate the "Awards" table with columns in the desired order
CREATE TABLE "Awards" (
  "UniqueID" SERIAL PRIMARY KEY,
  "playerID" VARCHAR,
  "award" VARCHAR,
  "year" INT,
  "lgID" VARCHAR,
  "pos" VARCHAR
);


SELECT EXISTS (
    SELECT 1
    FROM information_schema.tables
    WHERE table_name = 'Awards'
);

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'Awards';

SELECT sequence_name 
FROM information_schema.sequences 
WHERE sequence_schema = 'public' AND sequence_name LIKE 'awards_uniqueid_seq';

SELECT sequence_name 
FROM information_schema.sequences 
WHERE sequence_schema = 'public' AND sequence_name = 'name';

-- Find the maximum UniqueID
SELECT MAX("UniqueID") + 1 FROM public."Awards";

-- Remake the Goalies table
-- Drop the existing "Goalies" table if needed
DROP TABLE IF EXISTS "Goalies";

-- Recreate the "Goalies" table with columns in the desired order
CREATE TABLE "Goalies" (
  "UniqueID" VARCHAR PRIMARY KEY,
  "PlayerID" VARCHAR,
  "TeamID" VARCHAR,
  "LeagueID" VARCHAR,
  "Games_Played" FLOAT,
  "Minutes_Played" FLOAT, -- Changed data type to FLOAT
  "Wins" FLOAT, -- Changed data type to FLOAT
  "Losses" FLOAT, -- Changed data type to FLOAT
  "Year" INT
);


-- Remake the Goalies table
-- Drop the existing "Goalies" table if needed
--DROP TABLE IF EXISTS "Player_Stats_2024";

-- Recreate the "Goalies" table with columns in the desired order
CREATE TABLE Player_Stats_2024 (
    StatID INT PRIMARY KEY,
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

-- Remake the Goalies table
-- Drop the existing "Goalies" table if needed
--DROP TABLE IF EXISTS "Player_Stats_2024";

CREATE TABLE Player_Details_Active (
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

-- Remake the Teams table
-- Drop the existing "Teams" table if needed
	DROP TABLE IF EXISTS "Teams_Active";
	
	CREATE TABLE "Teams_Active" (
    TeamID INT PRIMARY KEY,
    Key VARCHAR(255),
    Active BOOLEAN,
    City VARCHAR(255),
    Name VARCHAR(255),
    StadiumID INT,
    Conference VARCHAR(255),
    Division VARCHAR(255),
    PrimaryColor VARCHAR(255),
    SecondaryColor VARCHAR(255),
    TertiaryColor VARCHAR(255),
    QuaternaryColor VARCHAR(255),
    WikipediaLogoUrl VARCHAR(255),
    WikipediaWordMarkUrl FLOAT,
    GlobalTeamID INT,
    HeadCoach VARCHAR(255)
);

-- Drop the original league_averages table if it exists
DROP TABLE IF EXISTS league_averages;

-- Create a new league_averages table
CREATE TABLE league_averages (
    Rk INT,
    Season VARCHAR(255),
    Lg VARCHAR(255),
    GP INT,
    Goals FLOAT,
    PP FLOAT,
    PPO FLOAT,
    PP_percent FLOAT,
    PK_percent FLOAT,
    SA FLOAT,
    SV FLOAT,
    SV_percent FLOAT,
    GAA FLOAT
);

-- Drop the Stadiums table if it exists
DROP TABLE IF EXISTS Stadiums;

-- Create a new Stadiums table
CREATE TABLE Stadiums (
	StadiumID INT PRIMARY KEY,
	_Name VARCHAR,
	Capacity FLOAT,
	_Location VARCHAR,
	GeoLat FLOAT NOT NULL,
	GeoLong FLOAT NOT NULL,
	Active BOOLEAN
	
);

--DROP TABLE IF EXISTS "Stadiums";

--ALTER TABLE stadiums RENAME TO "Stadiums";


-- Remake players table directly from API endpoint
DROP TABLE IF EXISTS "Players";

CREATE TABLE Players (
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
-- Create Mapping table
DROP TABLE IF EXISTS "NHL_mapping";

CREATE TABLE NHL_Mapping (
    tmNo INTEGER   NOT NULL,
    year_ INTEGER   NOT NULL,
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

    CONSTRAINT pk_NHL_Mapping PRIMARY KEY (
        tmNo
     )
);

SELECT constraint_name, constraint_type, table_name
FROM information_schema.table_constraints
WHERE table_name = 'NHL_Mapping';

-- Drop the Teams_Active table if it exists
DROP TABLE IF EXISTS "Teams_Active";

-- Create a new Teams_Active table
CREATE TABLE "Teams_Active" (
    TeamID INT PRIMARY KEY,
    Name_ VARCHAR(255) NOT NULL,
    Abbreviation VARCHAR(10) NOT NULL,
    City VARCHAR(255) NOT NULL,
    StadiumID INT,
    Conference VARCHAR(50),
    Division VARCHAR(50),
	HeadCoach VARCHAR,
	ColorCode VARCHAR,
	GlobalTeamID INT NOT NULL,
	Active BOOLEAN
);

DROP TABLE IF EXISTS "teams_active";

SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = 'public';

-- Drop the nhl_draft_complete table if it exists
DROP TABLE IF EXISTS "nhl_draft_complete";

(
    country character varying(100),
    latitude numeric(10,8),
    longitude numeric(11,8),
    name character varying(100),
    id character varying(5),
    year integer,
    overall_pick integer,
    team character varying(60),
    player character varying(60),
    nationality character varying(2),
    position character varying(10),
    age integer,
    to_year integer,
    amateur_team character varying(60),
    games_played integer,
    goals integer,
    assists integer,
    points integer,
    plus_minus integer,
    penalties_minutes integer,
    goalie_games_played integer,
    goalie_wins integer,
    goalie_losses integer,
    goalie_ties_overtime integer,
    save_percentage numeric(6,2),
    goals_against_average numeric(6,2),
    point_shares numeric(6,2)

);
