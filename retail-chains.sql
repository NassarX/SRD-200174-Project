DROP DATABASE IF EXISTS `retail_chains`;
CREATE DATABASE IF NOT EXISTS `retail_chains`;

USE `retail_chains`;

DROP TABLE IF EXISTS `region`;
CREATE TABLE IF NOT EXISTS `region` (
  id TINYINT AUTO_INCREMENT NOT NULL,
  region_name VARCHAR(25) NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  id VARCHAR(2) NOT NULL,
  country_name VARCHAR(40) NULL,
  region_id TINYINT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_country_region_id FOREIGN KEY (region_id) references region (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  id INT AUTO_INCREMENT NOT NULL ,
  street_address VARCHAR(40) NULL,
  postal_code VARCHAR(12) NULL,
  city VARCHAR(30) NOT NULL,
  state_province VARCHAR(25) NULL,
  country_id VARCHAR(2) NULL,
  PRIMARY KEY (id),
  CONSTRAINT location_country_id FOREIGN KEY (country_id) references country (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `retail_chain`;
CREATE TABLE IF NOT EXISTS `retail_chain` (
    id INT AUTO_INCREMENT NOT NULL ,
    retail_chain_name VARCHAR(30) NOT NULL,
    industry VARCHAR(30) NOT NULL ,
    founded_year VARCHAR(10),
    headquarter VARCHAR(10),
    revenue decimal(6,0),
    url TEXT NULL,
    country_id VARCHAR(2) NULL,
    PRIMARY KEY (id),
    CONSTRAINT retail_chain_country_id FOREIGN KEY (country_id) references country (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `store`;
CREATE TABLE IF NOT EXISTS `store` (
  id INT AUTO_INCREMENT NOT NULL,
  store_name VARCHAR(30) NOT NULL,
  retail_chain_id INT NULL,
  location_id INT NULL,
  PRIMARY KEY (id),
  CONSTRAINT store_retail_chain_id FOREIGN KEY (retail_chain_id) references retail_chain (id),
  CONSTRAINT store_location_id FOREIGN KEY (location_id) references location (id)
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
  salary decimal(8,2) NULL,
  commission_pct decimal(2,2) NULL,
  store_id INT NOT NULL,
  job_id INT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_employee_store_id FOREIGN KEY (store_id) references store (id),
  CONSTRAINT fk_employee_job_id FOREIGN KEY (job_id) references job (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier`(
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(100),
    PRIMARY KEY (id)
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
    CONSTRAINT fk_product_category_od FOREIGN KEY (category_id) REFERENCES category(id),
    CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `supply_history`;
CREATE TABLE IF NOT EXISTS `supply_history`(
    supplier_id INT NOT NULL,
	product_id INT NOT NULL,
	store_id INT NOT NULL,
	date DATETIME NOT NULL,
	quantity DOUBLE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
	PRIMARY KEY (supplier_id, product_id, store_id, date),
	CONSTRAINT fk_supply_history_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier(id),
	CONSTRAINT fk_supply_history_product_id FOREIGN KEY (product_id) REFERENCES product(id),
	CONSTRAINT fk_supply_history_store_id FOREIGN KEY (store_id) REFERENCES store(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `store_product`;
CREATE TABLE IF NOT EXISTS `store_product`(
    id INT AUTO_INCREMENT,
	store_id INT NOT NULL ,
    product_id INT NOT NULL ,
    date_of_expire DATE,
    is_expired BOOLEAN NOT NULL,
    quantity INT DEFAULT 0 NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    PRIMARY KEY (id),
    CONSTRAINT fk_store_product_store_id FOREIGN KEY (store_id) REFERENCES store(id),
    CONSTRAINT fk_store_product_product_id FOREIGN KEY (product_id) REFERENCES product(id)
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

DROP TABLE IF EXISTS `store_order`;
CREATE TABLE IF NOT EXISTS `store_order` (
  id INT AUTO_INCREMENT NOT NULL,
  customer_id INT NOT NULL,
  store_id INT NOT NULL,
  code VARCHAR(25) UNIQUE,
  time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  description VARCHAR(255) NOT NULL,
  payment_method ENUM('Cash','Net Banking','Credit Card','Debit Card') DEFAULT 'Cash' NOT NULL,
  type ENUM('Online', 'Store'),
  amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  status VARCHAR(25) NOT NULL DEFAULT 'Yet to be delivered',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME,
  PRIMARY KEY (id),
  CONSTRAINT fk_order_customer_id FOREIGN KEY (customer_id) REFERENCES customer(id),
  CONSTRAINT fk_order_store_id FOREIGN KEY (store_id) REFERENCES store(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `order_product`;
CREATE TABLE IF NOT EXISTS `order_product` (
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  amount DECIMAL(10,2) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME,
  PRIMARY KEY (order_id, product_id),
  CONSTRAINT fk_order_product_store_order_id FOREIGN KEY (order_id) references store_order (id),
  CONSTRAINT fk_order_product_store_product_id FOREIGN KEY (product_id) references store_product (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
	id INT AUTO_INCREMENT NOT NULL,
	customer_id INT NOT NULL,
	store_id INT NOT NULL,
	order_id INT NOT NULL,
	amount DECIMAL(10,2),
	date_of_purchase date not null,
	payment_method varchar(40),
	person_id int ,
	employee_person_id int ,
	PRIMARY KEY(id),
	UNIQUE (customer_id, store_id, order_id),
	CONSTRAINT FOREIGN KEY fk_transaction_customer_id(customer_id) REFERENCES customer(id),
	CONSTRAINT FOREIGN KEY fk_transaction_store_id(store_id) REFERENCES store(id),
	CONSTRAINT FOREIGN KEY fk_transaction_store_order_id(order_id) REFERENCES store_order(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `product_rate`;
CREATE TABLE IF NOT EXISTS `product_rate`(
    id INT AUTO_INCREMENT,
    product_id INT NOT NULL ,
    customer_id INT NOT NULL ,
    rate DOUBLE,
    is_expired BOOLEAN NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    PRIMARY KEY (id),
    CONSTRAINT fk_product_rate_product_id FOREIGN KEY (product_id) REFERENCES product(id),
    CONSTRAINT fk_product_rate_customer_id FOREIGN KEY (customer_id) REFERENCES customer(id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;