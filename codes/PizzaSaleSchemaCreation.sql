-- MySQL Script generated by MySQL Workbench
-- Mon Dec 12 22:19:48 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Orders` (
  `OrderID` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Time` TIME NOT NULL,
  PRIMARY KEY (`OrderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PizzaTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PizzaTypes` (
  `PizzaTypeID` VARCHAR(50) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Type` ENUM("Veggie", "Chicken", "Supreme", "Classic") NOT NULL,
  `Ingredients` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`PizzaTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzas` (
  `PizzaID` VARCHAR(50) NOT NULL,
  `Size` ENUM("S", "M", "L") NOT NULL,
  `Price` FLOAT NOT NULL,
  `PizzaTypeID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`PizzaID`),
  INDEX `fk_Pizzas_PizzaTypes1_idx` (`PizzaTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_Pizzas_PizzaTypes1`
    FOREIGN KEY (`PizzaTypeID`)
    REFERENCES `PizzaTypes` (`PizzaTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrderDetails` (
  `OrderDetailsID` INT NOT NULL,
  `Quantity` TINYINT(100) NOT NULL,
  `OrderID` INT NOT NULL,
  `PizzaID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`OrderDetailsID`),
  INDEX `fk_OrderDetails_Orders_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_OrderDetails_Pizzas1_idx` (`PizzaID` ASC) VISIBLE,
  CONSTRAINT `fk_OrderDetails_Orders`
    FOREIGN KEY (`OrderID`)
    REFERENCES `Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderDetails_Pizzas1`
    FOREIGN KEY (`PizzaID`)
    REFERENCES `Pizzas` (`PizzaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
