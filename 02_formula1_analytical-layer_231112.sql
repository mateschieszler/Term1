USE formula1;

-- Create Analytical Layer as denormalized table

DROP PROCEDURE IF EXISTS CreateRaceResultsStore;

DELIMITER //

CREATE PROCEDURE CreateRaceResultsStore()
BEGIN

DROP TABLE IF EXISTS RaceResults; 
   
CREATE TABLE RaceResults AS
SELECT
    c.circuitId AS circuit_Id,
    c.name AS circuit_name,
    c.location AS circuit_location,
    c.country AS circuit_country,
    c.alt AS circuit_alt,
    r.raceId AS race_Id,
    r.year AS race_year,
    r.name AS race_name,
    d.driverId AS driver_Id,
    d.forename AS driver_forename,
    d.surename AS driver_surename,
    d.number AS driver_number,
    d.dob AS driver_dateOfBirth,
    d.nationality AS driver_nationality,
    con.constructorId AS constructor_Id,
    con.name AS constructor_name,
    con.nationality AS constructor_nationality,
    res.resultId AS result_Id,
    res.grid AS result_grid,
    res.position AS result_position,
	CASE 
		WHEN res.grid != 0 THEN res.grid - res.position
		ELSE (SELECT COUNT(*) FROM results WHERE raceId = res.raceId) - res.position
	END AS result_positionsGained,
	res.positionOrder AS result_positionOrder,
    res.points AS result_points,
    res.laps AS result_laps,
    res.fastestLapTime AS result_fastestLapTime,
    res.fastestLapSpeed AS result_fastestLapSpeed,
    res.statusId AS status_Id,
    s.status AS status_status
FROM
    circuits c
JOIN races r ON c.circuitId = r.circuitId
JOIN results res ON r.raceId = res.raceId
JOIN drivers d ON res.driverId = d.driverId
JOIN constructors con ON res.constructorId = con.constructorId
JOIN status s ON res.statusId = s.statusId;
  
END //
DELIMITER ;

CALL CreateRaceResultsStore();

SELECT * FROM raceresults;
