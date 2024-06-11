-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`customerAdress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customerAdress` (
  `street` VARCHAR(45) NOT NULL,
  `houseNumber` INT NOT NULL,
  `adressId` INT NOT NULL,
  PRIMARY KEY (`adressId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customers` (
  `customersId` INT NOT NULL,
  `customerSurname` VARCHAR(45) NOT NULL,
  `idAdress` INT NOT NULL,
  PRIMARY KEY (`customersId`),
  INDEX `fk_customer-adress_idx` (`idAdress` ASC) VISIBLE,
  CONSTRAINT `fk_customer-adress`
    FOREIGN KEY (`idAdress`)
    REFERENCES `mydb`.`customerAdress` (`adressId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `customerId` INT NOT NULL,
  `orderDate` DATE NOT NULL,
  `ordersNumber` INT NOT NULL,
  `ordersId` INT NOT NULL,
  INDEX `fk_orders-customer_idx` (`customerId` ASC) VISIBLE,
  PRIMARY KEY (`ordersId`),
  CONSTRAINT `fk_orders-customer`
    FOREIGN KEY (`customerId`)
    REFERENCES `mydb`.`customers` (`customersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`products` (
  `productsId` INT NOT NULL,
  `productsName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`productsId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orderItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orderItem` (
  `orderItemId` INT NOT NULL,
  `orderId` INT NOT NULL,
  `productId` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`orderItemId`),
  INDEX `fk_orderItems-products_idx` (`productId` ASC) VISIBLE,
  INDEX `fk_orderItems-orders_idx` (`orderId` ASC) VISIBLE,
  CONSTRAINT `fk_orderItems-products`
    FOREIGN KEY (`productId`)
    REFERENCES `mydb`.`products` (`productsId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderItems-orders`
    FOREIGN KEY (`orderId`)
    REFERENCES `mydb`.`orders` (`ordersId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
