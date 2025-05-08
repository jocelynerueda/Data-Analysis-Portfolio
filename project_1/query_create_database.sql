CREATE TABLE `Orders` (
    `row_id` int  NOT NULL ,
    `order_id` int  NOT NULL ,
    `purchase_datetime` datetime  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `customer_id` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `address_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `customers` (
    `customer_id` int  NOT NULL ,
    `first_name` varchar(20)  NOT NULL ,
    `last_name` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `address` (
    `address_id` int  NOT NULL ,
    `delivery_street` varchar(50)  NOT NULL ,
    `delivery_region` varchar(50)  NOT NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `address_id`
    )
);

CREATE TABLE `menu` (
    `item_id` varchar(10)  NOT NULL ,
    `item_name` varchar(20)  NOT NULL ,
    `item_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `ingredient` (
    `ing_id` varchar(10)  NOT NULL ,
    `ing_name` varchar(50)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_meas` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(50)  NOT NULL ,
    `ing_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `shift` (
    `shift_id` varchar(20)  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `rota` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `staff` (
    `staff_id` varchar(20)  NOT NULL ,
    `first_name` varchar(50)  NOT NULL ,
    `last_name` varchar(50)  NOT NULL ,
    `position` varchar(50)  NOT NULL ,
    `hourly_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

ALTER TABLE `customers` ADD CONSTRAINT `fk_customers_customer_id` FOREIGN KEY(`customer_id`)
REFERENCES `Orders` (`customer_id`);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_address_id` FOREIGN KEY(`address_id`)
REFERENCES `Orders` (`address_id`);

ALTER TABLE `menu` ADD CONSTRAINT `fk_menu_item_id` FOREIGN KEY(`item_id`)
REFERENCES `Orders` (`item_id`);

ALTER TABLE `ingredient` ADD CONSTRAINT `fk_ingredient_ing_id` FOREIGN KEY(`ing_id`)
REFERENCES `recipe` (`ing_id`);

ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `menu` (`item_name`);

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_inv_id` FOREIGN KEY(`inv_id`)
REFERENCES `ingredient` (`ing_id`);

ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `rota` (`shift_id`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_date` FOREIGN KEY(`date`)
REFERENCES `Orders` (`purchase_datetime`);

ALTER TABLE `rota` ADD CONSTRAINT `fk_rota_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `staff` (`staff_id`);

