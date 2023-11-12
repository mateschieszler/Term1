-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema formula1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `formula1` ;

-- -----------------------------------------------------
-- Schema formula1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `formula1` DEFAULT CHARACTER SET utf8 ;
USE `formula1` ;

-- -----------------------------------------------------
-- Table `formula1`.`circuits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`circuits` ;

CREATE TABLE IF NOT EXISTS `formula1`.`circuits` (
  `circuitId` INT NOT NULL,
  `circuitRef` VARCHAR(45) NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `lat` FLOAT NOT NULL,
  `lng` FLOAT NOT NULL,
  `alt` FLOAT NULL,
  `url` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`circuitId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`constructors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`constructors` ;

CREATE TABLE IF NOT EXISTS `formula1`.`constructors` (
  `constructorId` INT NOT NULL,
  `constructorRef` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `url` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`constructorId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`seasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`seasons` ;

CREATE TABLE IF NOT EXISTS `formula1`.`seasons` (
  `year` INT NOT NULL,
  `url` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`year`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`races`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`races` ;

CREATE TABLE IF NOT EXISTS `formula1`.`races` (
  `raceId` INT NOT NULL,
  `year` INT NOT NULL,
  `round` INT NOT NULL,
  `circuitId` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  `time` VARCHAR(45) NULL,
  `url` VARCHAR(256) NOT NULL,
  `fp1_date` DATE NULL,
  `fp1_time` VARCHAR(45) NULL,
  `fp2_date` DATE NULL,
  `fp2_time` VARCHAR(45) NULL,
  `fp3_date` DATE NULL,
  `fp3_time` VARCHAR(45) NULL,
  `quali_date` DATE NULL,
  `quali_time` VARCHAR(45) NULL,
  `sprint_date` DATE NULL,
  `sprint_time` VARCHAR(45) NULL,
  PRIMARY KEY (`raceId`, `year`, `circuitId`),
  INDEX `circuitId_idx` (`circuitId` ASC) VISIBLE,
  INDEX `year_idx` (`year` ASC) VISIBLE,
  CONSTRAINT `fk_races_circuits1`
    FOREIGN KEY (`circuitId`)
    REFERENCES `formula1`.`circuits` (`circuitId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_races_seasons1`
    FOREIGN KEY (`year`)
    REFERENCES `formula1`.`seasons` (`year`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`constructor_results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`constructor_results` ;

CREATE TABLE IF NOT EXISTS `formula1`.`constructor_results` (
  `constructorResultsId` INT NOT NULL,
  `raceId` INT NOT NULL,
  `constructorId` INT NOT NULL,
  `points` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  PRIMARY KEY (`constructorResultsId`, `raceId`, `constructorId`),
  INDEX `constructorId_idx` (`constructorId` ASC) VISIBLE,
  INDEX `raceId_idx` (`raceId` ASC) VISIBLE,
  CONSTRAINT `fk_constructor_results_constructors1`
    FOREIGN KEY (`constructorId`)
    REFERENCES `formula1`.`constructors` (`constructorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_constructor_results_races`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`drivers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`drivers` ;

CREATE TABLE IF NOT EXISTS `formula1`.`drivers` (
  `driverId` INT NOT NULL,
  `driverRef` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NULL,
  `code` VARCHAR(45) NULL,
  `forename` VARCHAR(45) NOT NULL,
  `surename` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `url` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`driverId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`driver_standings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`driver_standings` ;

CREATE TABLE IF NOT EXISTS `formula1`.`driver_standings` (
  `driverStandingsId` INT NOT NULL,
  `raceId` INT NOT NULL,
  `driverId` INT NOT NULL,
  `points` INT NOT NULL,
  `position` INT NOT NULL,
  `positionText` VARCHAR(16) NOT NULL,
  `wins` INT NOT NULL,
  PRIMARY KEY (`driverStandingsId`, `driverId`, `raceId`),
  INDEX `raceId_idx` (`raceId` ASC) VISIBLE,
  INDEX `driverid_idx` (`driverId` ASC) VISIBLE,
  CONSTRAINT `fk_driver_standings_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_driver_standings_drivers1`
    FOREIGN KEY (`driverId`)
    REFERENCES `formula1`.`drivers` (`driverId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`constructor_standings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`constructor_standings` ;

CREATE TABLE IF NOT EXISTS `formula1`.`constructor_standings` (
  `constructorStandingsId` INT NOT NULL,
  `raceId` INT NOT NULL,
  `constructorId` INT NULL,
  `points` INT NULL,
  `position` INT NULL,
  `positionText` VARCHAR(45) NULL,
  `wins` INT NULL,
  PRIMARY KEY (`constructorStandingsId`, `raceId`),
  INDEX `constructorId_idx` (`constructorId` ASC) VISIBLE,
  INDEX `raceid_idx` (`raceId` ASC) VISIBLE,
  CONSTRAINT `fk_constructor_standings_constructors1`
    FOREIGN KEY (`constructorId`)
    REFERENCES `formula1`.`constructors` (`constructorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_constructor_standings_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`lap_times`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`lap_times` ;

CREATE TABLE IF NOT EXISTS `formula1`.`lap_times` (
  `raceId` INT NOT NULL,
  `driverId` INT NOT NULL,
  `lap` INT NOT NULL,
  `position` INT NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `milliseconds` INT NOT NULL,
  INDEX `driverId_idx` (`driverId` ASC) VISIBLE,
  CONSTRAINT `fk_lap_times_drivers1`
    FOREIGN KEY (`driverId`)
    REFERENCES `formula1`.`drivers` (`driverId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lap_times_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`pit_stops`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`pit_stops` ;

CREATE TABLE IF NOT EXISTS `formula1`.`pit_stops` (
  `raceId` INT NOT NULL,
  `driverId` INT NOT NULL,
  `stop` INT NOT NULL,
  `lap` INT NOT NULL,
  `time` VARCHAR(45) NOT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `milliseconds` INT NOT NULL,
  INDEX `driverId_idx` (`driverId` ASC) VISIBLE,
  CONSTRAINT `fk_pit_stops_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pit_stops_drivers1`
    FOREIGN KEY (`driverId`)
    REFERENCES `formula1`.`drivers` (`driverId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`qualifying`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`qualifying` ;

CREATE TABLE IF NOT EXISTS `formula1`.`qualifying` (
  `qualifyingId` INT NOT NULL,
  `raceId` INT NOT NULL,
  `driverId` INT NOT NULL,
  `constructorId` INT NOT NULL,
  `number` INT NOT NULL,
  `position` INT NOT NULL,
  `q1` VARCHAR(45) NULL,
  `q2` VARCHAR(45) NULL,
  `q3` VARCHAR(45) NULL,
  PRIMARY KEY (`qualifyingId`, `raceId`, `driverId`, `constructorId`),
  INDEX `racceId_idx` (`raceId` ASC) VISIBLE,
  INDEX `driverId_idx` (`driverId` ASC) VISIBLE,
  INDEX `constructorId_idx` (`constructorId` ASC) VISIBLE,
  CONSTRAINT `fk_qualifying_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qualifying_drivers1`
    FOREIGN KEY (`driverId`)
    REFERENCES `formula1`.`drivers` (`driverId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_qualifying_constructors1`
    FOREIGN KEY (`constructorId`)
    REFERENCES `formula1`.`constructors` (`constructorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`status` ;

CREATE TABLE IF NOT EXISTS `formula1`.`status` (
  `statusId` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`statusId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`results` ;

CREATE TABLE IF NOT EXISTS `formula1`.`results` (
  `resultId` INT NOT NULL,
  `raceId` INT NOT NULL,
  `driverId` INT NOT NULL,
  `constructorId` INT NOT NULL,
  `number` INT NULL,
  `grid` INT NOT NULL,
  `position` INT NULL,
  `positionText` VARCHAR(45) NOT NULL,
  `positionOrder` INT NOT NULL,
  `points` INT NOT NULL,
  `laps` INT NULL,
  `time` VARCHAR(45) NULL,
  `milliseconds` INT NULL,
  `fastestLap` VARCHAR(45) NULL,
  `rank` INT NULL,
  `fastestLapTime` VARCHAR(45) NULL,
  `fastestLapSpeed` VARCHAR(45) NULL,
  `statusId` INT NOT NULL,
  PRIMARY KEY (`resultId`, `statusId`, `driverId`, `raceId`, `constructorId`),
  INDEX `raceId_idx` (`raceId` ASC) VISIBLE,
  INDEX `driverId_idx` (`driverId` ASC) VISIBLE,
  INDEX `constructorId_idx` (`constructorId` ASC) VISIBLE,
  INDEX `statusId_idx` (`statusId` ASC) VISIBLE,
  CONSTRAINT `fk_results_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_drivers1`
    FOREIGN KEY (`driverId`)
    REFERENCES `formula1`.`drivers` (`driverId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_constructors1`
    FOREIGN KEY (`constructorId`)
    REFERENCES `formula1`.`constructors` (`constructorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_results_status1`
    FOREIGN KEY (`statusId`)
    REFERENCES `formula1`.`status` (`statusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `formula1`.`sprint_results`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `formula1`.`sprint_results` ;

CREATE TABLE IF NOT EXISTS `formula1`.`sprint_results` (
  `resultId` INT NOT NULL,
  `raceId` INT NOT NULL,
  `driverId` INT NOT NULL,
  `constructorId` INT NOT NULL,
  `number` INT NOT NULL,
  `grid` INT NOT NULL,
  `position` INT NULL,
  `positionText` VARCHAR(45) NOT NULL,
  `positionOrder` INT NOT NULL,
  `points` INT NOT NULL,
  `laps` INT NOT NULL,
  `time` VARCHAR(45) NULL,
  `milliseconds` INT NULL,
  `fastestLap` INT NULL,
  `fastestLapTime` VARCHAR(45) NULL,
  `statusId` INT NOT NULL,
  PRIMARY KEY (`resultId`, `statusId`, `driverId`, `raceId`, `constructorId`),
  INDEX `raceId_idx` (`raceId` ASC) VISIBLE,
  INDEX `driverId_idx` (`driverId` ASC) VISIBLE,
  INDEX `constructorId_idx` (`constructorId` ASC) VISIBLE,
  INDEX `statusId_idx` (`statusId` ASC) VISIBLE,
  CONSTRAINT `fk_sprint_results_races1`
    FOREIGN KEY (`raceId`)
    REFERENCES `formula1`.`races` (`raceId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sprint_results_drivers1`
    FOREIGN KEY (`driverId`)
    REFERENCES `formula1`.`drivers` (`driverId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sprint_results_constructors1`
    FOREIGN KEY (`constructorId`)
    REFERENCES `formula1`.`constructors` (`constructorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sprint_results_status1`
    FOREIGN KEY (`statusId`)
    REFERENCES `formula1`.`status` (`statusId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



