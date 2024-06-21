CREATE SCHEMA IF NOT EXISTS assignment_12;
USE assignment_12;
CREATE DATABASE IF NOT EXISTS pizza_restaurant;

CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`pizzas` (
  `pizzas_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(50) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`pizzas_id`));