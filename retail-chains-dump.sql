DROP DATABASE IF EXISTS `retail_chains`;
CREATE DATABASE  IF NOT EXISTS `retail_chains` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `retail_chains`;
-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: retail_chains
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `code` char(4) DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(25) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `hire_date` date NOT NULL,
  `store_id` int NOT NULL,
  `job_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_store_id` (`store_id`),
  KEY `fk_employee_job_id` (`job_id`),
  CONSTRAINT `fk_employee_job_id` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`),
  CONSTRAINT `fk_employee_store_id` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(35) NOT NULL,
  `min_salary` decimal(6,0) DEFAULT NULL,
  `max_salary` decimal(6,0) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `street_address` varchar(255) DEFAULT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `city` varchar(30) NOT NULL,
  `region` varchar(25) DEFAULT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `location_country_id` (`country_id`),
  CONSTRAINT `location_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `l_table` varchar(250) DEFAULT NULL,
  `l_action` varchar(250) DEFAULT NULL,
  `row_identifier` varchar(250) DEFAULT NULL,
  `new_value` text,
  `logged_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_products` (
  `order_id` int NOT NULL,
  `store_product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`,`store_product_id`),
  KEY `fk_order_products_store_products_id` (`store_product_id`),
  CONSTRAINT `fk_order_products_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_order_products_store_products_id` FOREIGN KEY (`store_product_id`) REFERENCES `store_products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_order_products_BINSERT` BEFORE INSERT ON `order_products` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_order_products_AINSERT` AFTER INSERT ON `order_products` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `store_id` int NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(255) NOT NULL,
  `payment_method` enum('Cash','Net Banking','Credit Card','Debit Card') NOT NULL DEFAULT 'Cash',
  `type` enum('Online','Store') DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('Pending','InProgress','Done') DEFAULT 'Pending',
  `employee_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `fk_order_customer_id` (`customer_id`),
  KEY `fk_order_store_id` (`store_id`),
  KEY `fk_order_employee_id` (`employee_id`),
  CONSTRAINT `fk_order_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_order_store_id` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_orders_BINSERT` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('orders', 'INSERT', concat('customer_id=', NEW.customer_id,', store_id=', NEW.store_id), 'New Order Been Added');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_orders_AUPDATE` AFTER UPDATE ON `orders` FOR EACH ROW BEGIN
    DECLARE tTotal INT DEFAULT 0;
    DECLARE tDiscount INT DEFAULT 0;
    DECLARE tTaxRate INT DEFAULT 5;
    DECLARE tTax INT DEFAULT 0;
    IF NEW.status IN ('Done') THEN
        SET tTax = (tTaxRate/100) * OLD.amount;
        SET tTotal = OLD.amount + tTax;
        SET tDiscount = 0;
        INSERT INTO transaction (
         customer_id, store_id, order_id, sub_total, total,
         discount,tax_rate, tax, date_of_purchase, payment_method,
         employee_id) VALUES
              (OLD.customer_id, OLD.store_id, OLD.id, OLD.amount, tTotal,
              tDiscount, tTaxRate, tTax, OLD.time, OLD.payment_method, OLD.employee_id);
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('transaction', 'INSERT', concat('order_id=', OLD.id,', customer_id=', OLD.customer_id, ', store_id=', OLD.store_id), 'New Transaction Been Added');
        INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('orders', 'UPDATE', concat('order_id=', OLD.id), concat('status updated to: ', 'Done'));
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `picture` varchar(250) NOT NULL DEFAULT 'No_image_available.svg',
  `weight` double NOT NULL,
  `category_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `supplier_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_category_od` (`category_id`),
  KEY `fk_product_supplier_id` (`supplier_id`),
  CONSTRAINT `fk_product_category_od` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_product_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_rate`
--

DROP TABLE IF EXISTS `product_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_rate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `store_id` int NOT NULL,
  `product_id` int NOT NULL,
  `rate` decimal(2,1) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`,`store_id`,`product_id`),
  KEY `fk_product_rate_store_id` (`store_id`),
  KEY `fk_product_rate_products_id` (`product_id`),
  CONSTRAINT `fk_product_rate_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `fk_product_rate_products_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `product_rate_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`),
  CONSTRAINT `chk_Ratings` CHECK (((`rate` >= 0) and (`rate` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_rate`
--

LOCK TABLES `product_rate` WRITE;
/*!40000 ALTER TABLE `product_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_rate` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_product_rate_AINSERT` AFTER INSERT ON `product_rate` FOR EACH ROW BEGIN
    DECLARE totalCount INT DEFAULT 0;
    DECLARE totalSum DECIMAL DEFAULT 0;
    SELECT count(*), SUM(rate) INTO totalCount, totalSum FROM product_rate WHERE product_id = NEW.product_id AND store_id = NEW.store_id;
    UPDATE store_products SET rate = (totalSum/totalCount) WHERE store_id=NEW.store_id AND product_id = NEW.product_id;
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('product_rate', 'INSERT', concat('storeId=',NEW.store_id, ', product_id=', NEW.product_id,', customer_id=', NEW.customer_id), 'New Product rate Been Added');
    INSERT INTO `logs` (`l_table`, `l_action`, `row_identifier`, `new_value`) VALUES ('store_products', 'UPDATE', concat('storeId=',NEW.store_id, ', product_id=', NEW.product_id), concat('rate updated to: ', (totalSum/totalCount)));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `retail_chain`
--

DROP TABLE IF EXISTS `retail_chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retail_chain` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `industry` varchar(30) NOT NULL,
  `founded_year` varchar(10) DEFAULT NULL,
  `headquarter` varchar(10) DEFAULT NULL,
  `revenue` varchar(100) DEFAULT NULL,
  `url` text,
  `country_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `retail_chain_country_id` (`country_id`),
  CONSTRAINT `retail_chain_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retail_chain`
--

LOCK TABLES `retail_chain` WRITE;
/*!40000 ALTER TABLE `retail_chain` DISABLE KEYS */;
/*!40000 ALTER TABLE `retail_chain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `id` int NOT NULL AUTO_INCREMENT,
  `store_name` varchar(30) NOT NULL,
  `retail_chain_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `store_retail_chain_id` (`retail_chain_id`),
  KEY `store_location_id` (`location_id`),
  CONSTRAINT `store_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `store_retail_chain_id` FOREIGN KEY (`retail_chain_id`) REFERENCES `retail_chain` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_products`
--

DROP TABLE IF EXISTS `store_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `store_id` int NOT NULL,
  `product_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `rate` decimal(2,1) DEFAULT '0.0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_store_products_store_id` (`store_id`),
  KEY `fk_store_products_product_id` (`product_id`),
  CONSTRAINT `fk_store_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_store_products_store_id` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_products`
--

LOCK TABLES `store_products` WRITE;
/*!40000 ALTER TABLE `store_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_title` varchar(100) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `location_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `supplier_location_id` (`location_id`),
  CONSTRAINT `supplier_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supply_process`
--

DROP TABLE IF EXISTS `supply_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supply_process` (
  `supplier_id` int NOT NULL,
  `product_id` int NOT NULL,
  `store_id` int NOT NULL,
  `date` datetime NOT NULL,
  `quantity` double DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`supplier_id`,`product_id`,`store_id`,`date`),
  KEY `fk_supply_process_product_id` (`product_id`),
  KEY `fk_supply_process_store_id` (`store_id`),
  CONSTRAINT `fk_supply_process_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_supply_process_store_id` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`),
  CONSTRAINT `fk_supply_process_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supply_process`
--

LOCK TABLES `supply_process` WRITE;
/*!40000 ALTER TABLE `supply_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `supply_process` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TR_supply_process_AINSERT` AFTER INSERT ON `supply_process` FOR EACH ROW BEGIN
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
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `store_id` int NOT NULL,
  `order_id` int NOT NULL,
  `discount` decimal(10,2) DEFAULT '0.00',
  `tax_rate` decimal(10,2) DEFAULT '5.00',
  `tax` decimal(10,2) DEFAULT '0.00',
  `sub_total` decimal(10,2) DEFAULT '0.00',
  `total` decimal(10,2) DEFAULT '0.00',
  `date_of_purchase` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` varchar(40) DEFAULT NULL,
  `employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`,`store_id`,`order_id`),
  KEY `fk_transaction_store_id` (`store_id`),
  KEY `fk_transaction_order_id` (`order_id`),
  KEY `fk_transaction_employee_id` (`employee_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`),
  CONSTRAINT `transaction_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `transaction_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_invoice_details`
--

DROP TABLE IF EXISTS `vw_invoice_details`;
/*!50001 DROP VIEW IF EXISTS `vw_invoice_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_invoice_details` AS SELECT
 1 AS `invoiceId`,
 1 AS `ProductName`,
 1 AS `unitCost`,
 1 AS `QTY`,
 1 AS `AMOUNT`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_invoice_summary`
--

DROP TABLE IF EXISTS `vw_invoice_summary`;
/*!50001 DROP VIEW IF EXISTS `vw_invoice_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_invoice_summary` AS SELECT
 1 AS `invoiceId`,
 1 AS `invoiceNumber`,
 1 AS `dateOfIssue`,
 1 AS `subTotal`,
 1 AS `Discount`,
 1 AS `taxRate`,
 1 AS `Tax`,
 1 AS `Total`,
 1 AS `clientName`,
 1 AS `clientAddress`,
 1 AS `storeName`,
 1 AS `storeCity`,
 1 AS `storeAddress`,
 1 AS `storePostalCode`,
 1 AS `employeeName`,
 1 AS `employeeEmail`,
 1 AS `employeeJobtitle`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'retail_chains'
--

--
-- Dumping routines for database 'retail_chains'
--
/*!50003 DROP PROCEDURE IF EXISTS `GET_AvgSales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_AvgSales`(IN storeId int, IN fromYear int, IN toYear int)
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
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_invoice_details`
--

/*!50001 DROP VIEW IF EXISTS `vw_invoice_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_invoice_details` AS select `o`.`id` AS `invoiceId`,`p`.`name` AS `ProductName`,`op`.`unit_price` AS `unitCost`,`op`.`quantity` AS `QTY`,`op`.`amount` AS `AMOUNT` from (((`orders` `o` join `order_products` `op` on((`o`.`id` = `op`.`order_id`))) join `store_products` `sp` on((`op`.`store_product_id` = `sp`.`id`))) join `product` `p` on((`sp`.`product_id` = `p`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_invoice_summary`
--

/*!50001 DROP VIEW IF EXISTS `vw_invoice_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_invoice_summary` AS select `o`.`id` AS `invoiceId`,`o`.`code` AS `invoiceNumber`,`o`.`time` AS `dateOfIssue`,`t`.`sub_total` AS `subTotal`,`t`.`discount` AS `Discount`,`t`.`tax_rate` AS `taxRate`,`t`.`tax` AS `Tax`,`t`.`total` AS `Total`,concat(`c`.`first_name`,' ',`c`.`last_name`) AS `clientName`,`c`.`address` AS `clientAddress`,`s`.`store_name` AS `storeName`,`l`.`city` AS `storeCity`,`l`.`street_address` AS `storeAddress`,`l`.`postal_code` AS `storePostalCode`,concat(`e`.`first_name`,' ',`e`.`last_name`) AS `employeeName`,`e`.`email` AS `employeeEmail`,`j`.`title` AS `employeeJobtitle` from ((((((`orders` `o` join `transaction` `t` on((`o`.`id` = `t`.`order_id`))) join `store` `s` on((`o`.`store_id` = `s`.`id`))) join `location` `l` on((`s`.`location_id` = `l`.`id`))) join `customer` `c` on((`c`.`id` = `o`.`customer_id`))) join `employee` `e` on((`o`.`employee_id` = `e`.`id`))) join `job` `j` on((`e`.`job_id` = `j`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-11  1:45:01
