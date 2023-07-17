-- MySQL Script generated by MySQL Workbench
-- Mon Jul 17 10:49:44 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_dampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cul_dampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_dampolla` DEFAULT CHARACTER SET utf8 ;
USE `cul_dampolla` ;

-- -----------------------------------------------------
-- Table `cul_dampolla`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_dampolla`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(50) NOT NULL,
  `number` INT NOT NULL,
  `door` TINYINT(3) NOT NULL,
  `floor` TINYINT(3) NULL,
  `city` VARCHAR(50) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `cul_dampolla`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NULL,
  `phone` VARCHAR(12) NULL,
  `registered` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_customer_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `cul_dampolla`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `cul_dampolla`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`glasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `make` VARCHAR(255) NOT NULL,
  `prescription` VARCHAR(45) NULL,
  `type` VARCHAR(45) NOT NULL DEFAULT 'Floating, paste or metallic',
  `color_frame` VARCHAR(45) NOT NULL,
  `color_glass` VARCHAR(45) NOT NULL,
  `unit_price` DECIMAL ZEROFILL NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `cul_dampolla`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`sales` (
  `sales_id` INT NOT NULL AUTO_INCREMENT,
  `total_price` DECIMAL ZEROFILL NULL DEFAULT 0.0,
  `customer_id` INT NOT NULL,
  `customer_address_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `date_sales` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sales_id`, `customer_id`, `customer_address_id`, `glasses_id`, `employee_id`),
  INDEX `fk_sales_customer1_idx` (`customer_id` ASC, `customer_address_id` ASC) VISIBLE,
  INDEX `fk_sales_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  INDEX `fk_sales_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_sales_customer1`
    FOREIGN KEY (`customer_id` , `customer_address_id`)
    REFERENCES `cul_dampolla`.`customer` (`id` , `address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `cul_dampolla`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `cul_dampolla`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_dampolla`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`supplier` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(12) NULL,
  `fax` VARCHAR(12) NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `nif` VARCHAR(45) NOT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  INDEX `fk_supplier_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `cul_dampolla`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `cul_dampolla`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cul_dampolla`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `units` INT ZEROFILL NOT NULL DEFAULT 0,
  `total_price` DECIMAL NOT NULL DEFAULT 0,
  `supplier_id` INT NOT NULL,
  `glasses_id` INT NOT NULL,
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `supplier_id`, `glasses_id`),
  INDEX `fk_orders_supplier1_idx` (`supplier_id` ASC) VISIBLE,
  INDEX `fk_orders_glasses1_idx` (`glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_supplier1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `cul_dampolla`.`supplier` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_glasses1`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `cul_dampolla`.`glasses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
