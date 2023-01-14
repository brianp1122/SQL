CREATE TABLE nba_players(
Rk INT PRIMARY KEY NOT NULL,
Player VARCHAR(40) NOT NULL,
Pos VARCHAR(5) NOT NULL,
Age INT NOT NULL,
Tm VARCHAR(5) NOT NULL,
G INT NOT NULL,
GS INT NOT NULL,
MP DECIMAL (4,2) NOT NULL,
FG DECIMAL (4,2) NOT NULL,
FGA DECIMAL (4,2) NOT NULL,
FG_percent DECIMAL (4,2) NOT NULL,
three_pointers DECIMAL (4,2) NOT NULL,
three_point_attempts DECIMAL (4,2) NOT NULL,
three_point_percent DECIMAL (4,2) NOT NULL,
two_pointers DECIMAL (4,2) NOT NULL,
two_point_attempts DECIMAL (4,2) NOT NULL,
two_point_percent DECIMAL (4,2) NOT NULL,
efficient_FG_percent DECIMAL (4,3) NOT NULL,
FT DECIMAL (4,2) NOT NULL,
FT_attempts DECIMAL (4,2) NOT NULL,
FT_percent DECIMAL (4,2) NOT NULL,
ORB DECIMAL (4,2) NOT NULL,
DRB DECIMAL (4,2) NOT NULL,
TRB DECIMAL (4,2) NOT NULL,
AST DECIMAL (4,2) NOT NULL,
STL DECIMAL (4,2) NOT NULL,
BLK DECIMAL (4,2) NOT NULL,
TOV DECIMAL (4,2) NOT NULL,
PF DECIMAL (4,2) NOT NULL,
PTS DECIMAL (4,2) NOT NULL
);

CREATE TABLE nineties_nba_players(
Rk INT PRIMARY KEY NOT NULL,
Player VARCHAR(40) NOT NULL,
Pos VARCHAR(5) NOT NULL,
Age INT NOT NULL,
Tm VARCHAR(5) NOT NULL,
G INT NOT NULL,
GS INT NOT NULL,
MP DECIMAL (4,2) NOT NULL,
FG DECIMAL (4,2) NOT NULL,
FGA DECIMAL (4,2) NOT NULL,
FG_percent DECIMAL (4,2) NOT NULL,
three_pointers DECIMAL (4,2) NOT NULL,
three_point_attempts DECIMAL (4,2) NOT NULL,
three_point_percent DECIMAL (4,2) NOT NULL,
two_pointers DECIMAL (4,2) NOT NULL,
two_point_attempts DECIMAL (4,2) NOT NULL,
two_point_percent DECIMAL (4,2) NOT NULL,
efficient_FG_percent DECIMAL (4,3) NOT NULL,
FT DECIMAL (4,2) NOT NULL,
FT_attempts DECIMAL (4,2) NOT NULL,
FT_percent DECIMAL (4,2) NOT NULL,
ORB DECIMAL (4,2) NOT NULL,
DRB DECIMAL (4,2) NOT NULL,
TRB DECIMAL (4,2) NOT NULL,
AST DECIMAL (4,2) NOT NULL,
STL DECIMAL (4,2) NOT NULL,
BLK DECIMAL (4,2) NOT NULL,
TOV DECIMAL (4,2) NOT NULL,
PF DECIMAL (4,2) NOT NULL,
PTS DECIMAL (4,2) NOT NULL
);

ALTER TABLE nba_players
ADD COLUMN Year INT NOT NULL;

ALTER TABLE nineties_nba_players
ADD COLUMN Year INT NOT NULL;

ALTER TABLE nba_players 
DROP COLUMN Year;

ALTER TABLE nineties_nba_players 
DROP COLUMN Year;
 
UPDATE nba_players
SET Year = 2122
WHERE Year = 0;

UPDATE nineties_nba_players
SET Year = 9596
WHERE Year = 0;

UPDATE nba_players
SET year = 21-22;

ALTER TABLE nineties_nba_players
ADD COLUMN Year INT NOT NULL;

SELECT * 
FROM nineties_nba_players;

SELECT *
FROM nba_players;

DELETE 
FROM nineties_nba_players
WHERE G <=5; 

DELETE 
FROM nba_players
WHERE G <=5; 

SELECT * 
FROM nba_players
UNION 
SELECT * 
FROM nineties_nba_players

SELECT * 
FROM nba_players
WHERE PTS >20
UNION 
SELECT * 
FROM nineties_nba_players
WHERE PTS >20
ORDER BY PTS DESC
LIMIT 20;

SELECT * 
FROM nba_players
WHERE BLK >1.5 AND STL > 1 AND DRB >5
UNION 
SELECT * 
FROM nineties_nba_players
WHERE BLK >1.5 AND STL > 1 AND DRB >5
ORDER BY BLK DESC
LIMIT 20;

SELECT * 
FROM nba_players

SELECT AVG(MP)
FROM nba_players
WHERE Tm = 'PHI'; 

SELECT AVG(MP)
FROM nineties_nba_players
WHERE PTS >20; 

SELECT player, Year, PTS, tm, MP
FROM nba_players
WHERE PTS >20
UNION 
SELECT player, Year, PTS, tm, MP
FROM nineties_nba_players
WHERE PTS >20;

SELECT Player, year, MP, Tm, three_pointers
FROM nba_players
WHERE three_pointers > 1 AND MP >20
UNION
SELECT Player, year, MP, Tm, three_pointers
FROM nineties_nba_players
WHERE three_pointers > 1 AND MP >20
ORDER BY three_pointers DESC
LIMIT 10;

SELECT Player, year, MP, Tm, three_pointers, three_point_attempts
FROM nba_players
WHERE three_point_attempts > 1 AND MP >20
UNION
SELECT Player, year, MP, Tm, three_pointers, three_point_attempts
FROM nineties_nba_players
WHERE three_point_attempts > 1 AND MP >20
ORDER BY three_pointers DESC
LIMIT 10;

