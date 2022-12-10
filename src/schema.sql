DROP DATABASE IF EXISTS `retail_chains`;
CREATE DATABASE IF NOT EXISTS `retail_chains`;

USE `retail_chains`;

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  id int NOT NULL,
  name VARCHAR(40) NULL,
  code CHAR(4) NULL ,
  language VARCHAR(10) NULL ,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  id INT AUTO_INCREMENT NOT NULL ,
  street_address VARCHAR(255) NULL,
  postal_code VARCHAR(12) NULL,
  city VARCHAR(30) NOT NULL,
  region VARCHAR(25) NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT location_country_id FOREIGN KEY (country_id) references `country` (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `retail_chain`;
CREATE TABLE IF NOT EXISTS `retail_chain` (
    id INT AUTO_INCREMENT NOT NULL ,
    name VARCHAR(30) NOT NULL,
    industry VARCHAR(30) NOT NULL ,
    founded_year VARCHAR(10),
    headquarter VARCHAR(10),
    revenue VARCHAR(100),
    url TEXT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT retail_chain_country_id FOREIGN KEY (country_id) references `country` (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `store`;
CREATE TABLE IF NOT EXISTS `store` (
  id INT AUTO_INCREMENT NOT NULL,
  store_name VARCHAR(30) NOT NULL,
  retail_chain_id INT NULL,
  location_id INT NULL,
  PRIMARY KEY (id),
  CONSTRAINT store_retail_chain_id FOREIGN KEY (retail_chain_id) references `retail_chain` (id),
  CONSTRAINT store_location_id FOREIGN KEY (location_id) references `location` (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `job`;
CREATE TABLE IF NOT EXISTS `job` (
    id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(35) NOT NULL,
    min_salary decimal(6,0) NULL,
    max_salary decimal(6,0) NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
  id INT AUTO_INCREMENT NOT NULL,
  first_name VARCHAR(20) NULL,
  last_name VARCHAR(25) NOT NULL,
  email VARCHAR(25) NOT NULL,
  phone_number VARCHAR(20) NULL,
  hire_date date NOT NULL,
  store_id INT NOT NULL,
  job_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_employee_store_id FOREIGN KEY (store_id) references `store` (id),
  CONSTRAINT fk_employee_job_id FOREIGN KEY (job_id) references `job` (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier`(
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(100),
	contact_name VARCHAR(100),
	contact_title VARCHAR(100),
	phone VARCHAR(25),
	location_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT supplier_location_id FOREIGN KEY (location_id) references `location` (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category`(
  id INT AUTO_INCREMENT NOT NULL ,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product`(
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    picture VARCHAR(250) DEFAULT 'No_image_available.svg' NOT NULL,
    weight DOUBLE NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    supplier_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_product_category_od FOREIGN KEY (category_id) REFERENCES `category`(id),
    CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES `supplier`(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `supply_process`;
CREATE TABLE IF NOT EXISTS `supply_process`(
    supplier_id INT NOT NULL,
	product_id INT NOT NULL,
	store_id INT NOT NULL,
	date DATETIME NOT NULL,
	quantity DOUBLE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
	PRIMARY KEY (supplier_id, product_id, store_id, date),
	CONSTRAINT fk_supply_process_supplier_id FOREIGN KEY (supplier_id) REFERENCES `supplier`(id),
	CONSTRAINT fk_supply_process_product_id FOREIGN KEY (product_id) REFERENCES `product`(id),
	CONSTRAINT fk_supply_process_store_id FOREIGN KEY (store_id) REFERENCES `store`(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `store_products`;
CREATE TABLE IF NOT EXISTS `store_products`(
    id INT AUTO_INCREMENT,
	store_id INT NOT NULL ,
    product_id INT NOT NULL ,
    price DECIMAL(10,2) NOT NULL,
    quantity INT DEFAULT 0 NOT NULL,
    rate DECIMAL(2, 1) DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    PRIMARY KEY (id),
    CONSTRAINT fk_store_products_store_id FOREIGN KEY (store_id) REFERENCES `store`(id),
    CONSTRAINT fk_store_products_product_id FOREIGN KEY (product_id) REFERENCES `product`(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer`(
    id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(20) DEFAULT NULL,
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL,
    phone_number VARCHAR(20) DEFAULT NULL,
    address varchar(255),
	gender ENUM('Male', 'Female', 'Other'),
	date_of_birth date,
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  id INT AUTO_INCREMENT NOT NULL,
  customer_id INT NOT NULL,
  store_id INT NOT NULL,
  code VARCHAR(25) UNIQUE,
  time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  description VARCHAR(255) NOT NULL,
  payment_method ENUM('Cash','Net Banking','Credit Card','Debit Card') DEFAULT 'Cash' NOT NULL,
  type ENUM('Online', 'Store'),
  amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  status ENUM('Pending', 'InProgress', 'Done') DEFAULT 'Pending',
  employee_id INT NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME,
  PRIMARY KEY (id),
  CONSTRAINT fk_order_customer_id FOREIGN KEY (customer_id) REFERENCES `customer`(id),
  CONSTRAINT fk_order_store_id FOREIGN KEY (store_id) REFERENCES `store`(id),
  CONSTRAINT FOREIGN KEY fk_order_employee_id(employee_id) REFERENCES `employee`(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `order_products`;
CREATE TABLE IF NOT EXISTS `order_products` (
  order_id INT NOT NULL,
  store_product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL DEFAULT 0,
  amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME,
  PRIMARY KEY (order_id, store_product_id),
  CONSTRAINT fk_order_products_order_id FOREIGN KEY (order_id) references `orders`(id),
  CONSTRAINT fk_order_products_store_products_id FOREIGN KEY (store_product_id) references `store_products`(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
	id INT AUTO_INCREMENT NOT NULL,
	customer_id INT NOT NULL,
	store_id INT NOT NULL,
	order_id INT NOT NULL,
	amount DECIMAL(10,2),
	date_of_purchase DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	payment_method VARCHAR(40),
	employee_id INT NOT NULL,
	PRIMARY KEY(id),
	UNIQUE (customer_id, store_id, order_id),
	CONSTRAINT FOREIGN KEY fk_transaction_customer_id(customer_id) REFERENCES `customer`(id),
	CONSTRAINT FOREIGN KEY fk_transaction_store_id(store_id) REFERENCES `store`(id),
	CONSTRAINT FOREIGN KEY fk_transaction_order_id(order_id) REFERENCES `orders`(id),
	CONSTRAINT FOREIGN KEY fk_transaction_employee_id(employee_id) REFERENCES `employee`(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `product_rate`;
CREATE TABLE IF NOT EXISTS `product_rate`(
    id INT AUTO_INCREMENT,
    customer_id INT NOT NULL ,
    store_id INT NOT NULL ,
    product_id INT NOT NULL ,
    rate DECIMAL(2, 1),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    PRIMARY KEY (id),
    UNIQUE (customer_id, store_id, product_id),
    CONSTRAINT FOREIGN KEY fk_product_rate_store_id(store_id) REFERENCES `store`(id),
    CONSTRAINT fk_product_rate_products_id FOREIGN KEY (product_id) REFERENCES `product`(id),
    CONSTRAINT fk_product_rate_customer_id FOREIGN KEY (customer_id) REFERENCES `customer`(id),
    CONSTRAINT chk_Ratings CHECK (rate >= 0 AND rate <= 5)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `logs`;
CREATE TABLE IF NOT EXISTS `logs`(
    id BIGINT unsigned AUTO_INCREMENT,
    l_table VARCHAR(250) ,
    l_action VARCHAR(250) ,
    row_identifier VARCHAR(250) ,
    new_value TEXT,
    logged_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

USE retail_chains;

# `TR_supply_process_AINSERT` A Trigger run after inserting a new supply into `supply_process` to
# 1. Update target store products' quantity.
# 2. Or insert new row if its first supply of that product.
# 3. log changes on all affected tabled.
DROP TRIGGER IF EXISTS `TR_supply_process_AINSERT`;
DELIMITER $$
CREATE TRIGGER `TR_supply_process_AINSERT` AFTER INSERT ON `supply_process` FOR EACH ROW BEGIN
    DECLARE rowsCount INT DEFAULT 0;
    DECLARE price_ INT DEFAULT 0;
    SELECT COUNT(*) INTO rowsCount FROM store_products where store_products.store_id = NEW.store_id AND store_products.product_id = NEW.product_id;
    IF rowsCount > 0 THEN
        UPDATE store_products SET quantity = quantity + NEW.quantity where store_products.store_id = NEW.store_id AND store_products.product_id = NEW.product_id;
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('store_products', 'UPDATE', concat('store_id=', NEW.store_id,', product_id=', NEW.product_id), concat('quantity updated to: +', NEW.quantity));
    ELSE
        SELECT price INTO price_ from product where product.id = NEW.product_id;
        INSERT INTO store_products(`store_id`, `product_id`, `price`, `quantity`, `created_at`, `updated_at`) VALUES (NEW.store_id, NEW.product_id, price_, NEW.quantity, NOW(), NOW());
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('store_products', 'INSERT', concat('store_id=', NEW.store_id,', product_id=', NEW.product_id), concat('New product been added with quantity=', NEW.quantity));
    END IF;
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('supply_process', 'INSERT', concat('supplier_id=', NEW.supplier_id,', store_id=', NEW.store_id, ', product_id=', NEW.product_id), concat('New product been added with quantity=', NEW.quantity));
END
$$
DELIMITER ;

# `TR_orders_BINSERT` A Trigger run before inserting new order to
# 1. log changes on all affected tabled.
DROP TRIGGER IF EXISTS `TR_orders_BINSERT`;
DELIMITER $$
CREATE TRIGGER `TR_orders_BINSERT` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('orders', 'INSERT', concat('customer_id=', NEW.customer_id,', store_id=', NEW.store_id), 'New Order Been Added');
END
$$
DELIMITER ;

# `TR_order_products_BINSERT` A Trigger run before inserting a new product to order to
# 1. Checks on product quantity in stock - if still in stock and can cover asked quantity then.
# 2. Calculate total price.
# 3. Or return error msg if not enough items.
# 4. log changes on all affected tabled.
DROP TRIGGER IF EXISTS `TR_order_products_BINSERT`;
DELIMITER $$
CREATE TRIGGER `TR_order_products_BINSERT` BEFORE INSERT ON `order_products` FOR EACH ROW BEGIN
    DECLARE storeID INT DEFAULT 0;
    DECLARE pQuantity INT DEFAULT 0;
    DECLARE pPrice INT DEFAULT 0;
    SELECT `orders`.store_id INTO storeID FROM `orders` WHERE `orders`.id = NEW.order_id;
    IF storeID > 0 THEN
        SELECT store_products.quantity, store_products.price INTO pQuantity, pPrice
                     FROM store_products WHERE store_products.id= NEW.store_product_id;
        IF pQuantity > NEW.quantity THEN
            SET NEW.unit_price = pPrice;
            SET NEW.amount = pPrice * NEW.quantity;
        ELSE
            SIGNAL SQLSTATE '12345'
            SET MESSAGE_TEXT = 'Store Dose not have This Product / Product Out Of Stock / Requested Quantity Exceeded';
        END IF;
    ELSE
        SIGNAL SQLSTATE '40001'
        SET MESSAGE_TEXT = 'Invalid Store ID / Check Order ID If Exists';
    END IF;
END
$$
DELIMITER ;

# `TR_order_products_AINSERT` A Trigger run after inserting a new product to order to
# 1. Update order status to `InProgress`
# 2. Keep order amount updated with each product added.
# 3. Update store product quantity in the stock.
# 4. log changes on all affected tabled.
DROP TRIGGER IF EXISTS `TR_order_products_AINSERT`;
DELIMITER $$
CREATE TRIGGER `TR_order_products_AINSERT` AFTER INSERT ON `order_products` FOR EACH ROW BEGIN
    DECLARE storeID INT DEFAULT 0;
    SELECT orders.store_id INTO storeID FROM orders WHERE orders.id = NEW.order_id;
    IF storeID > 0 THEN
        UPDATE orders SET status = 'InProgress', amount = amount + NEW.amount, updated_at = NOW() WHERE orders.id = NEW.order_id;
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('orders', 'UPDATE', concat('order_id=', NEW.order_id), concat('status updated to: ', 'InProgress'));
        UPDATE store_products SET quantity = quantity - NEW.quantity WHERE product_id = NEW.store_product_id;
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('store_products', 'UPDATE', concat('product_id=', NEW.store_product_id), concat('quantity updated to: -', NEW.quantity));
    ELSE
        SIGNAL SQLSTATE '40001'
        SET MESSAGE_TEXT = 'Invalid Store ID / Check Order ID If Exists';
    END IF;
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('order_products', 'INSERT', concat('order_id=', NEW.order_id,', product_id=', NEW.store_product_id), 'New Order Product Been Added');
END
$$
DELIMITER ;

# `TR_orders_AUPDATE` A Trigger run After updating order to
# 1. Check if order status set to `Done` Then
# 2. Insert a new transaction for that order with all required data.
# 3. log changes on all affected tabled.
DROP TRIGGER IF EXISTS `TR_orders_AUPDATE`;
DELIMITER $$
CREATE TRIGGER `TR_orders_AUPDATE` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    IF NEW.status IN ('Done') THEN
        INSERT INTO transaction (customer_id, store_id, order_id, amount, date_of_purchase, payment_method, employee_id) VALUES
             (OLD.customer_id, OLD.store_id, OLD.id, OLD.amount, OLD.time, OLD.payment_method, OLD.employee_id);
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('transaction', 'INSERT', concat('order_id=', OLD.id,', customer_id=', OLD.customer_id, ', store_id=', OLD.store_id), 'New Transaction Been Added');
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('orders', 'UPDATE', concat('order_id=', OLD.id), concat('status updated to: ', 'Done'));
    END IF;
END
$$
DELIMITER ;

# `TR_product_rate_AINSERT` A Trigger run after customer insert a new product rate to
# 1. Update the average of product rate.
# 2. log changes on all affected tabled.
DROP TRIGGER IF EXISTS `TR_product_rate_AINSERT`;
DELIMITER $$
CREATE TRIGGER `TR_product_rate_AINSERT` AFTER INSERT ON `product_rate` FOR EACH ROW BEGIN
    DECLARE totalCount INT DEFAULT 0;
    DECLARE totalSum DECIMAL DEFAULT 0;
    SELECT count(*), SUM(rate) INTO totalCount, totalSum FROM product_rate WHERE product_id = NEW.product_id AND store_id = NEW.store_id;
    UPDATE store_products SET rate = (totalSum/totalCount) WHERE store_id=NEW.store_id AND product_id = NEW.product_id;
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('product_rate', 'INSERT', concat('storeId=',NEW.store_id, ', product_id=', NEW.product_id,', customer_id=', NEW.customer_id), 'New Product rate Been Added');
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('store_products', 'UPDATE', concat('storeId=',NEW.store_id, ', product_id=', NEW.product_id), concat('rate updated to: ', (totalSum/totalCount)));
END
$$
DELIMITER ;

# `GET_AvgSales` A Stored Procedure to
# 1. return total sales, yearly and monthly average of given store & period time
DELIMITER $$
CREATE PROCEDURE `GET_AvgSales`(IN storeId int, IN fromYear int, IN toYear int)
BEGIN
        SELECT CONCAT(fromYear, '-', toYear) as PeriodOfSales, SUM(yearlySales.TotalSales) as TotalSales,
               floor(avg(yearlySales.TotalSales)) as avgYearlySales,
               floor(avg(monthlySales.TotalSales)) as avgMonthlySales
        FROM
        (
            SELECT SUM(amount) AS TotalSales
            FROM orders o WHERE store_id = storeId AND YEAR(time) BETWEEN fromYear AND toYear
            GROUP BY store_id, YEAR(time)
        ) as yearlySales,
        (
            SELECT SUM(amount) AS TotalSales
            FROM orders WHERE store_id = storeId AND YEAR(time) BETWEEN fromYear AND toYear
            GROUP BY store_id, YEAR(time), MONTH(time)
        ) as monthlySales;
    END$$
DELIMITER ;