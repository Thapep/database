-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`publisher` (
  `pubName` VARCHAR(45) NOT NULL,
  `estYear` YEAR NULL,
  `pubAddress` VARCHAR(45) NULL,
  PRIMARY KEY (`pubName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Book` (
  `ISBN` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `pubYear` INT NOT NULL,
  `numpages` INT NOT NULL,
  `pubName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ISBN`),
  INDEX `fk_Book_1_idx` (`pubName` ASC),
  CONSTRAINT `fk_Book_1`
    FOREIGN KEY (`pubName`)
    REFERENCES `mydb`.`publisher` (`pubName`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`member` (
  `memberID` INT NOT NULL,
  `MFirst` VARCHAR(45) NOT NULL,
  `MLast` VARCHAR(45) NOT NULL,
  `Street` VARCHAR(45) NOT NULL,
  `st_number` INT NOT NULL,
  `postalCode` INT NOT NULL,
  PRIMARY KEY (`memberID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`author` (
  `authID` INT NOT NULL,
  `AFirst` VARCHAR(45) NOT NULL,
  `ALast` VARCHAR(45) NOT NULL,
  `Abirthdate` DATE NULL,
  PRIMARY KEY (`authID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `categoryName` VARCHAR(45) NOT NULL,
  `supercategoryName` VARCHAR(45) NULL DEFAULT 'N/A',
  PRIMARY KEY (`categoryName`),
  INDEX `fk_category_category1_idx` (`supercategoryName` ASC),
  CONSTRAINT `fk_category_category1`
    FOREIGN KEY (`supercategoryName`)
    REFERENCES `mydb`.`category` (`categoryName`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`copies` (
  `ISBN` INT NOT NULL,
  `copyNr` INT NOT NULL,
  `shelf` VARCHAR(45) NULL DEFAULT 'N/A',
  PRIMARY KEY (`ISBN`, `copyNr`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `empID` INT NOT NULL,
  `EFirst` VARCHAR(45) NOT NULL,
  `ELast` VARCHAR(45) NOT NULL,
  `salary` INT NOT NULL,
  `emp_type` ENUM('temp', 'perm') NOT NULL,
  PRIMARY KEY (`empID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`written_by`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`written_by` (
  `ISBN` INT NOT NULL,
  `authID` INT NOT NULL,
  INDEX `fk_written_by_2_idx` (`authID` ASC),
  PRIMARY KEY (`ISBN`, `authID`),
  CONSTRAINT `fk_written_by_1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_written_by_2`
    FOREIGN KEY (`authID`)
    REFERENCES `mydb`.`author` (`authID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`belongs_to`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`belongs_to` (
  `ISBN` INT NOT NULL,
  `categoryName` VARCHAR(45) NOT NULL,
  INDEX `fk_belongs_to_2_idx` (`categoryName` ASC),
  PRIMARY KEY (`ISBN`, `categoryName`),
  CONSTRAINT `fk_belongs_to_1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_belongs_to_2`
    FOREIGN KEY (`categoryName`)
    REFERENCES `mydb`.`category` (`categoryName`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`borrows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`borrows` (
  `memberID` INT NOT NULL,
  `ISBN` INT NOT NULL,
  `copyNr` INT NOT NULL,
  `date_of_borrowing` DATE NOT NULL,
  `date_of_return` DATE NOT NULL,
  PRIMARY KEY (`copyNr`, `date_of_borrowing`, `ISBN`, `memberID`),
  INDEX `fk_member_has_copies_member1_idx` (`memberID` ASC),
  INDEX `fk_borrows_ISBN_idx` (`ISBN` ASC),
  INDEX `fk_borrows_ISBN_and_copyNr_idx` (`ISBN` ASC, `copyNr` ASC),
  INDEX `test` (`memberID` ASC, `ISBN` ASC, `copyNr` ASC, `date_of_borrowing` ASC),
  CONSTRAINT `fk_borrows_member1`
    FOREIGN KEY (`memberID`)
    REFERENCES `mydb`.`member` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_borrows_ISBN`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_borrows_ISBN_and_copyNr`
    FOREIGN KEY (`ISBN` , `copyNr`)
    REFERENCES `mydb`.`copies` (`ISBN` , `copyNr`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`permanent_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`permanent_employee` (
  `empID_sub` INT NOT NULL,
  `HiringDate` DATE NOT NULL,
  PRIMARY KEY (`empID_sub`),
  CONSTRAINT `fk_permanent_employee_1`
    FOREIGN KEY (`empID_sub`)
    REFERENCES `mydb`.`employee` (`empID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`temporary_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`temporary_employee` (
  `empID_sub` INT NOT NULL,
  `ContactNr` INT NOT NULL,
  PRIMARY KEY (`empID_sub`),
  CONSTRAINT `fk_temporary_employee_1`
    FOREIGN KEY (`empID_sub`)
    REFERENCES `mydb`.`employee` (`empID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`has_copies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`has_copies` (
  `ISBN` INT NOT NULL,
  `copyNr` INT NOT NULL,
  PRIMARY KEY (`ISBN`, `copyNr`),
  CONSTRAINT `fk_has_copies_1`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_has_copies_2`
    FOREIGN KEY (`ISBN` , `copyNr`)
    REFERENCES `mydb`.`copies` (`ISBN` , `copyNr`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`reminder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reminder` (
  `empID` INT NOT NULL,
  `memberID` INT NOT NULL,
  `ISBN` INT NOT NULL,
  `copyNr` INT NOT NULL,
  `date_of_borrowing` DATE NOT NULL,
  `date_of_reminder` DATE NOT NULL,
  PRIMARY KEY (`memberID`, `ISBN`, `copyNr`, `date_of_borrowing`, `empID`, `date_of_reminder`),
  INDEX `fk_reminder_1_idx` (`empID` ASC),
  INDEX `fk_reminder_3_idx` (`ISBN` ASC),
  INDEX `fk_reminder_4_idx` (`ISBN` ASC, `copyNr` ASC),
  CONSTRAINT `fk_reminder_1`
    FOREIGN KEY (`empID`)
    REFERENCES `mydb`.`employee` (`empID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reminder_2`
    FOREIGN KEY (`memberID`)
    REFERENCES `mydb`.`member` (`memberID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reminder_3`
    FOREIGN KEY (`ISBN`)
    REFERENCES `mydb`.`Book` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reminder_4`
    FOREIGN KEY (`ISBN` , `copyNr`)
    REFERENCES `mydb`.`copies` (`ISBN` , `copyNr`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reminder_5`
    FOREIGN KEY (`memberID` , `ISBN` , `copyNr` , `date_of_borrowing`)
    REFERENCES `mydb`.`borrows` (`memberID` , `ISBN` , `copyNr` , `date_of_borrowing`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`oldest_books_10`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`oldest_books_10` (`ISBN` INT, `title` INT, `AFirst` INT, `ALast` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`member_names`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`member_names` (`memberID` INT, `MFirst` INT, `MLast` INT);

-- -----------------------------------------------------
-- View `mydb`.`oldest_books_10`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`oldest_books_10`;
USE `mydb`;
CREATE  OR REPLACE VIEW `oldest_books_10` AS
	SELECT written_by.ISBN, Book.title, author.AFirst, author.ALast
	FROM written_by LEFT JOIN Book
	ON Book.ISBN=written_by.ISBN
	LEFT JOIN author ON author.authID=written_by.authID
	ORDER BY pubYear ASC
    LIMIT 10;

-- -----------------------------------------------------
-- View `mydb`.`member_names`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`member_names`;
USE `mydb`;
CREATE  OR REPLACE VIEW `member_names` AS
	SELECT memberID, MFirst, MLast
    FROM member
    ORDER BY memberID ASC;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
