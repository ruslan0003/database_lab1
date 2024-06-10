-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: bank
-- Source Schemata: bankdb
-- Created: Sun May 26 20:32:43 2024
-- Workbench Version: 8.0.36
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema bank
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `bank` ;
CREATE SCHEMA IF NOT EXISTS `bank` ;

-- ----------------------------------------------------------------------------
-- Table bank.businessloans
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`businessloans` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `company_id` INT(10) NULL DEFAULT NULL,
  `individual_id` INT(10) NULL DEFAULT NULL,
  `amount` INT(10) NOT NULL,
  `percentage` INT(3) NULL DEFAULT NULL,
  `term` INT(2) NOT NULL,
  `conditions` TEXT NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `individual_id` (`individual_id` ASC),
  CONSTRAINT `businessloans_ibfk_1`
    FOREIGN KEY (`individual_id`)
    REFERENCES `bank`.`individuals` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table bank.individuals
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`individuals` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(100) NOT NULL,
  `familyname` VARCHAR(100) NULL DEFAULT NULL,
  `passport` VARCHAR(10) NOT NULL,
  `itn` VARCHAR(12) NULL DEFAULT NULL,
  `insurance` VARCHAR(11) NULL DEFAULT NULL,
  `driverslicense` VARCHAR(10) NULL DEFAULT NULL,
  `otherdocs` VARCHAR(255) NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  `loaner_id` INT(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `passport` (`passport` ASC),
  UNIQUE INDEX `itn` (`itn` ASC),
  UNIQUE INDEX `insurance` (`insurance` ASC),
  INDEX `loaner_id` (`loaner_id` ASC),
  CONSTRAINT `individuals_ibfk_1`
    FOREIGN KEY (`loaner_id`)
    REFERENCES `bank`.`loaners` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table bank.loaners
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`loaners` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `itn` VARCHAR(10) NULL DEFAULT NULL,
  `loanertype` INT(1) NULL DEFAULT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `conditions` TEXT NULL DEFAULT NULL,
  `contractlist` VARCHAR(255) NULL DEFAULT NULL,
  `legalnotes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- ----------------------------------------------------------------------------
-- Table bank.loans
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `bank`.`loans` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `individual_id` INT(10) NULL DEFAULT NULL,
  `amount` DECIMAL(15,2) NOT NULL,
  `percentage` DECIMAL(3,2) NULL DEFAULT NULL,
  `rate` INT(3) NULL DEFAULT NULL,
  `term` INT(2) NOT NULL,
  `conditions` TEXT NULL DEFAULT NULL,
  `notes` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `individual_id` (`individual_id` ASC),
  CONSTRAINT `loans_ibfk_1`
    FOREIGN KEY (`individual_id`)
    REFERENCES `bank`.`individuals` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
SET FOREIGN_KEY_CHECKS = 1;
