CREATE SCHEMA IF NOT EXISTS `pizza_restaurant`;

CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`pizzas` (
	`pizza_id` INT NOT NULL AUTO_INCREMENT,
	`type` VARCHAR(50) NOT NULL,
	`price` DECIMAL(5,2) NOT NULL,
	PRIMARY KEY (`pizza_id`)
);

CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`customers` (
	`customer_id` INT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(150) NOT NULL,
	`phone_num` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`transactions` (
	`transaction_id` INT NOT NULL AUTO_INCREMENT,
	`customer_id` INT NOT NULL,
	`order_datetime` DATETIME NOT NULL,
	FOREIGN KEY (`customer_id`) REFERENCES `pizza_restaurant`.`customers` (`customer_id`),
	PRIMARY KEY (`transaction_id`)
);

CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`customer_pizza` (
	`customer_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
	FOREIGN KEY (`customer_id`) REFERENCES `pizza_restaurant`.`customers` (`customer_id`),
	FOREIGN KEY (`pizza_id`) REFERENCES `pizza_restaurant`.`pizzas` (`pizza_id`)
);
  
  CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`transaction_pizza` (
	`transaction_id` INT NOT NULL,
    `pizza_id` INT NOT NULL,
	FOREIGN KEY (`transaction_id`) REFERENCES `pizza_restaurant`.`transactions` (`transaction_id`),
	FOREIGN KEY (`pizza_id`) REFERENCES `pizza_restaurant`.`pizzas` (`pizza_id`)
);

INSERT INTO `pizza_restaurant`.`pizzas` (`type`, `price`)
VALUES 
	('Pepperoni & Cheese', 7.99),
    ('Vegetarian', 9.99),
    ('Meat Lovers', 14.99),
    ('Hawaiian', 12.99);

INSERT INTO `pizza_restaurant`.`customers` (`name`, `phone_num`)
VALUES 
	('Trevor Page', '226-555-4982'),
    ('John Doe', '555-555-9498');
    
INSERT INTO `pizza_restaurant`.`transactions` (`customer_id`, `order_datetime`)
VALUES 
	(1, '2023-9-10 9:47:00'),
    (2, '2023-9-10 13:20:00'),
    (1, '2023-9-10 9:47:00'),
    (2, '2023-10-10 10:37:00');