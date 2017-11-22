CREATE SCHEMA IF NOT EXISTS `event_logs`;
USE `event_logs`;
CREATE TABLE IF NOT EXISTS `event_logs`.`logs` (
  `log_id` INT NOT NULL AUTO_INCREMENT,
  `entry_type` VARCHAR(45) NULL,
  `time_generated` VARCHAR(45) NULL,
  `source` VARCHAR(45) NULL,
  `event_id` VARCHAR(45) NULL,
  `machine_name` VARCHAR(45) NULL,
  PRIMARY KEY (`log_id`));

LOAD DATA INFILE 'c:/ser-logfiles/log-dump.csv' 
INTO TABLE event_logs.logs 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(entry_type,time_generated,source,event_id,machine_name);