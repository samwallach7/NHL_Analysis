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