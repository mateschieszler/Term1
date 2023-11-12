set global local_infile = 'on';

SHOW VARIABLES LIKE "secure_file_priv";

SHOW VARIABLES LIKE "local_infile";

-- loading table 'circuits'
USE formula1;

SET FOREIGN_KEY_CHECKS = 0;
truncate circuits;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\circuits_cleaned.csv'
INTO TABLE circuits
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

select * from circuits;

-- loading table 'drivers'
USE formula1;

SET FOREIGN_KEY_CHECKS = 0;
truncate drivers;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\drivers.csv'
INTO TABLE drivers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from drivers;

-- loading table 'seasons'

SET FOREIGN_KEY_CHECKS = 0;
truncate seasons;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\seasons.csv'
INTO TABLE seasons
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from seasons;

-- loading table 'constructors'

SET FOREIGN_KEY_CHECKS = 0;
truncate constructors;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\constructors.csv'
INTO TABLE constructors
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from constructors;

-- loading table 'races'

SET FOREIGN_KEY_CHECKS = 0;
truncate races;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\races.csv'
INTO TABLE races
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from races;

-- loading table 'constructor_results'

SET FOREIGN_KEY_CHECKS = 0;
truncate constructor_results;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\constructor_results.csv'
INTO TABLE constructor_results
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from constructor_results;

-- loading table 'constructor_results'

SET FOREIGN_KEY_CHECKS = 0;
truncate constructor_results;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\constructor_results.csv'
INTO TABLE constructor_results
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from constructor_results;

-- loading table 'constructor_standings'

SET FOREIGN_KEY_CHECKS = 0;
truncate constructor_standings;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\constructor_standings.csv'
INTO TABLE constructor_standings
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from constructor_standings;

-- loading table `driver_standings`

SET FOREIGN_KEY_CHECKS = 0;
truncate driver_standings;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\driver_standings.csv'
INTO TABLE driver_standings
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from driver_standings;

-- loading table `lap_times`

SET FOREIGN_KEY_CHECKS = 0;
truncate lap_times;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\lap_times.csv'
INTO TABLE lap_times
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from lap_times;

-- loading table `pit_stops`

SET FOREIGN_KEY_CHECKS = 0;
truncate pit_stops;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pit_stops.csv'
INTO TABLE pit_stops
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from pit_stops;

-- loading table `qualifying`

SET FOREIGN_KEY_CHECKS = 0;
truncate qualifying;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\qualifying.csv'
INTO TABLE qualifying
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from qualifying;

-- loading table `status`

SET FOREIGN_KEY_CHECKS = 0;
truncate status;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\status.csv'
INTO TABLE status
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from status;

-- loading table `results`

SET FOREIGN_KEY_CHECKS = 0;
truncate results;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\results.csv'
INTO TABLE results
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from results;

-- loading table `sprint_results`

SET FOREIGN_KEY_CHECKS = 0;
truncate sprint_results;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\sprint_results.csv'
INTO TABLE sprint_results
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from sprint_results;
 


