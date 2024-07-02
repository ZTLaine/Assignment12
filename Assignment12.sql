-- 6/24/24
-- Zack Laine
-- Assignment 12

CREATE SCHEMA IF NOT EXISTS `pizza_restaurant`;
USE `pizza_restaurant`;

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
    `total_price` DECIMAL(6,2) ZEROFILL,
	FOREIGN KEY (`customer_id`) REFERENCES `pizza_restaurant`.`customers` (`customer_id`),
	PRIMARY KEY (`transaction_id`)
);

CREATE TABLE IF NOT EXISTS `pizza_restaurant`.`pizzas` (
	`pizza_id` INT NOT NULL AUTO_INCREMENT,
    `transaction_id` INT NOT NULL,
	`type` VARCHAR(50) NOT NULL,
	`price` DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (`transaction_id`) REFERENCES `pizza_restaurant`.`transactions` (`transaction_id`),
	PRIMARY KEY (`pizza_id`)
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

INSERT INTO `pizza_restaurant`.`customers` (`name`, `phone_num`)
VALUES 
	('Trevor Page', '226-555-4982'),
    ('John Doe', '555-555-9498');
    
INSERT INTO `pizza_restaurant`.`transactions` (`customer_id`, `order_datetime`)
VALUES 
	(1, '2023-9-10 09:47:00'),
    (2, '2023-9-10 13:20:00'),
    (1, '2023-9-10 09:47:00'),
    (2, '2023-10-10 10:37:00');
    
INSERT INTO `pizza_restaurant`.`pizzas` (`transaction_id`,`type`, `price`)
VALUES 
	(1, 'Pepperoni & Cheese', 7.99),
    (1, 'Meat Lovers', 14.99),
	(2, 'Vegetarian', 9.99),
    (2, 'Meat Lovers', 14.99),
    (2, 'Meat Lovers', 14.99),
    (3, 'Meat Lovers', 14.99),
    (3, 'Hawaiian', 12.99),
    (4, 'Vegetarian', 9.99),
    (4, 'Vegetarian', 9.99),
    (4, 'Vegetarian', 9.99),
    (4, 'Hawaiian', 12.99);
    
SELECT 
    pizzas.transaction_id,
    SUM(COALESCE(pizzas.price, 0)) AS total_price
FROM pizzas
GROUP BY pizzas.transaction_id;
    
-- Get the total for each transaction
UPDATE transactions t
JOIN (
	SELECT 
		pizzas.transaction_id,
		SUM(COALESCE(pizzas.price, 0)) AS total_price
	FROM pizzas
	LEFT JOIN transactions ON pizzas.transaction_id = transactions.transaction_id
	GROUP BY pizzas.transaction_id
) AS subquery ON t.transaction_id = subquery.transaction_id
SET t.total_price = subquery.total_price;

-- Individual's total money spent
SELECT
	customer_id,
    SUM(COALESCE(total_price)) 
FROM transactions
GROUP BY transactions.customer_id;

-- Individual's total money spent by date
SELECT
	customer_id,
    DATE(order_datetime),
    SUM(COALESCE(total_price)) 
FROM transactions
GROUP BY order_datetime, customer_id;