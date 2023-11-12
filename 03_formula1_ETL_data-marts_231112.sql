USE formula1;

-- Create table for loging messages

DROP TABLE IF EXISTS AnalyticalLayerRefreshLog;
CREATE TABLE IF NOT EXISTS AnalyticalLayerRefreshLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    message VARCHAR(255)
    );
    
-- Create event for refreshing the analytical layer each week for the next year
DROP EVENT IF EXISTS AnalyticalLayerRefreshLog;

DELIMITER //

CREATE EVENT IF NOT EXISTS AnalyticalLayerRefreshLog
ON SCHEDULE EVERY 1 WEEK
STARTS TIMESTAMP(CURRENT_DATE, '03:00:00')
ENDS CURRENT_TIMESTAMP + INTERVAL 1 YEAR
DO
BEGIN
    -- Call the stored procedure to recreate the analytical table
    -- INSERT INTO AnalyticalLayerRefreshLog (message) VALUES ('Analytical layer refresh started');
    CALL CreateRaceResultsStore();
    -- INSERT INTO AnalyticalLayerRefreshLog (message) VALUES ('Analytical layer refresh completed');
END //

DELIMITER ;

SHOW EVENTS;

-- Create trigger for updating the analytical table after insertion into results
DROP TRIGGER IF EXISTS after_insert_results
DELIMITER //
CREATE TRIGGER after_insert_results
AFTER INSERT ON results
FOR EACH ROW
BEGIN
    -- Call the stored procedure to recreate the analytical table
    CALL CreateRaceResultsStore();
END;
//
DELIMITER ;

SHOW TRIGGERS;

-- Create view for answering the question "Who is the most experienced driver?"

-- Drop the view if it already exists
DROP VIEW IF EXISTS DriverExperienceView;

CREATE VIEW DriverExperienceView AS
SELECT
    driver_Id,
    driver_forename,
    driver_surename,
    -- Synthetic Experience Measure
    SUM(result_laps) / 1000 +
	SUM(result_positionsGained) / 50 +
	(COUNT(DISTINCT race_year))  AS syntheticExperience
FROM
    raceresults
GROUP BY
    driver_Id, driver_forename, driver_surename;

-- Select from the view to see the results
SELECT * FROM DriverExperienceView ORDER BY syntheticExperience DESC;


-- Create view to answer question "Which driver has the most wins in each decade?"
DROP VIEW IF EXISTS MostWinsByDecade;

CREATE VIEW MostWinsByDecade AS
WITH DriverWinsByDecade AS (
    SELECT
        driver_Id,
        driver_forename,
        driver_surename,
        -- Other columns from your original query...
        -- Total Wins
        SUM(CASE WHEN result_position = 1 THEN 1 ELSE 0 END) AS totalWins,
        -- Decade
        FLOOR(race_year / 10) * 10 AS decade
    FROM
        RaceResults
    GROUP BY
        driver_Id, driver_forename, driver_surename, decade
)

-- Select the driver with the most wins for each decade
SELECT
    driver_Id,
    driver_forename,
    driver_surename,
    totalWins,
    decade
FROM (
    SELECT
        driver_Id,
        driver_forename,
        driver_surename,
        totalWins,
        decade,
        RANK() OVER (PARTITION BY decade ORDER BY totalWins DESC) AS rankInDecade
    FROM
        DriverWinsByDecade
) AS RankedDrivers
WHERE
    rankInDecade = 1;
    
SELECT * FROM MostWinsByDecade;

-- Create view to answer question "What is the most common reason for race abandon for each track"

DROP VIEW IF EXISTS MostCommonNonFinishReasonByTrack;

CREATE VIEW MostCommonNonFinishReasonByTrack AS
WITH NonFinishReasons AS (
    SELECT
        circuit_id,
        circuit_name,
        status_status AS most_common_non_finish_reason,
        COUNT(*) AS reason_count,
        RANK() OVER (PARTITION BY circuit_name ORDER BY COUNT(*) DESC) AS rank_by_count
    FROM
        RaceResults
    WHERE
        status_status != 'Finished' AND NOT status_status LIKE '+%'
    GROUP BY
        circuit_id, circuit_name, status_status
)
SELECT
    n.circuit_name,
    n.most_common_non_finish_reason,
    n.reason_count,
    (CAST(n.reason_count AS DECIMAL) / t.total_non_finishes) * 100 AS percentage_of_non_finishes
FROM
    NonFinishReasons n
JOIN (
    SELECT
        circuit_name,
        COUNT(*) AS total_non_finishes
    FROM
        RaceResults
    WHERE
        status_status != 'Finished' AND NOT status_status LIKE '+%'
    GROUP BY
        circuit_name
) t ON n.circuit_name = t.circuit_name
WHERE
    n.rank_by_count = 1;

SELECT * FROM MostCommonNonFinishReasonByTrack ORDER BY reason_count DESC;


