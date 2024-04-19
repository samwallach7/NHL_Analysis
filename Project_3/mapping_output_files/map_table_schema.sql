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