-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (x86_64)
--
-- Host: 127.0.0.1    Database: medicalims
-- ------------------------------------------------------
-- Server version	9.6.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '72767e5c-015c-11f1-90c0-377bc56ccab0:1-152';

--
-- Table structure for table `Accounts`
--

DROP TABLE IF EXISTS `Accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Accounts` (
  `Account_ID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Pwd_Hashed` varchar(255) NOT NULL,
  PRIMARY KEY (`Account_ID`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Accounts`
--

LOCK TABLES `Accounts` WRITE;
/*!40000 ALTER TABLE `Accounts` DISABLE KEYS */;
INSERT INTO `Accounts` VALUES (1,'admin1','$2a$10$loKnNyNqAFjODxBw.Zi9guIRkx2Aw8PZqO.NtSIHjwUyaArp8oS9S'),(2,'user1','$2a$10$EtGdX6FC81ET8KIbYH3g.OpEQohG8rAaeCC6EZ75SD7pRUa9uxQbm');
/*!40000 ALTER TABLE `Accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Admins`
--

DROP TABLE IF EXISTS `Admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admins` (
  `Account_ID` int NOT NULL,
  `Department_ID` int NOT NULL,
  `Office_Number` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`Account_ID`),
  KEY `Department_ID` (`Department_ID`),
  CONSTRAINT `admins_ibfk_1` FOREIGN KEY (`Account_ID`) REFERENCES `Accounts` (`Account_ID`),
  CONSTRAINT `admins_ibfk_2` FOREIGN KEY (`Department_ID`) REFERENCES `Departments` (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admins`
--

LOCK TABLES `Admins` WRITE;
/*!40000 ALTER TABLE `Admins` DISABLE KEYS */;
INSERT INTO `Admins` VALUES (1,1,'A101');
/*!40000 ALTER TABLE `Admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categories` (
  `Category_ID` int NOT NULL AUTO_INCREMENT,
  `Category_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Category_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
INSERT INTO `Categories` VALUES (1,'Frozen'),(2,'Refrigerated'),(3,'Room Temp');
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Departments`
--

DROP TABLE IF EXISTS `Departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Departments` (
  `Department_ID` int NOT NULL AUTO_INCREMENT,
  `Department_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Department_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Departments`
--

LOCK TABLES `Departments` WRITE;
/*!40000 ALTER TABLE `Departments` DISABLE KEYS */;
INSERT INTO `Departments` VALUES (1,'Emergency'),(2,'Surgery');
/*!40000 ALTER TABLE `Departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `Location_ID` int NOT NULL,
  `Item_Reference_Number` int NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`Location_ID`,`Item_Reference_Number`),
  KEY `Item_Reference_Number` (`Item_Reference_Number`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `Locations` (`Location_ID`),
  CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`Item_Reference_Number`) REFERENCES `Items` (`Item_Reference_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES (1,1,170),(1,2,100),(1,4,100),(2,3,200),(2,5,200),(2,6,500);
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Items`
--

DROP TABLE IF EXISTS `Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Items` (
  `Item_Reference_Number` int NOT NULL AUTO_INCREMENT,
  `Category_ID` int NOT NULL,
  `Lot_Number` int NOT NULL,
  `Item_Name` varchar(50) NOT NULL,
  `Expiration_Date` date NOT NULL,
  PRIMARY KEY (`Item_Reference_Number`),
  KEY `Category_ID` (`Category_ID`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`Category_ID`) REFERENCES `Categories` (`Category_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Items`
--

LOCK TABLES `Items` WRITE;
/*!40000 ALTER TABLE `Items` DISABLE KEYS */;
INSERT INTO `Items` VALUES (1,3,1001,'Bandages','2027-12-31'),(2,2,1002,'Ibuprofen','2026-06-30'),(3,3,2001,'Gloves','2028-01-01'),(4,3,2000,'SST Tube','2026-12-31'),(5,3,1202,'Lavender Tube','2026-12-31'),(6,3,4004,'PST Tube','2026-12-31');
/*!40000 ALTER TABLE `Items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Locations`
--

DROP TABLE IF EXISTS `Locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Locations` (
  `Location_ID` int NOT NULL AUTO_INCREMENT,
  `Room_Number` int NOT NULL,
  `Building_Number` int NOT NULL,
  PRIMARY KEY (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locations`
--

LOCK TABLES `Locations` WRITE;
/*!40000 ALTER TABLE `Locations` DISABLE KEYS */;
INSERT INTO `Locations` VALUES (1,101,1),(2,202,2);
/*!40000 ALTER TABLE `Locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Make_Orders`
--

DROP TABLE IF EXISTS `Make_Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Make_Orders` (
  `Admin_ID` int NOT NULL,
  `Supplier_ID` int NOT NULL,
  PRIMARY KEY (`Admin_ID`,`Supplier_ID`),
  KEY `Supplier_ID` (`Supplier_ID`),
  CONSTRAINT `make_orders_ibfk_1` FOREIGN KEY (`Admin_ID`) REFERENCES `Admins` (`Account_ID`),
  CONSTRAINT `make_orders_ibfk_2` FOREIGN KEY (`Supplier_ID`) REFERENCES `Suppliers` (`Supplier_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Make_Orders`
--

LOCK TABLES `Make_Orders` WRITE;
/*!40000 ALTER TABLE `Make_Orders` DISABLE KEYS */;
INSERT INTO `Make_Orders` VALUES (1,1),(1,2);
/*!40000 ALTER TABLE `Make_Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Order_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Purchase_orders`
--

DROP TABLE IF EXISTS `Purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Purchase_orders` (
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Item_Reference_Number` int NOT NULL,
  `Status` enum('PENDING','APPROVED','DENIED','COMPLETED') NOT NULL,
  `Approved_By` int DEFAULT NULL,
  `Message` text NOT NULL,
  `Qty` int NOT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Item_Reference_Number` (`Item_Reference_Number`),
  KEY `Approved_By` (`Approved_By`),
  CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`Item_Reference_Number`) REFERENCES `Items` (`Item_Reference_Number`),
  CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`Approved_By`) REFERENCES `Admins` (`Account_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Purchase_orders`
--

LOCK TABLES `Purchase_orders` WRITE;
/*!40000 ALTER TABLE `Purchase_orders` DISABLE KEYS */;
INSERT INTO `Purchase_orders` VALUES (1,1,'COMPLETED',1,'Need more bandages for emergency department',25),(2,2,'COMPLETED',1,'Restock ibuprofen',40),(3,3,'DENIED',1,'Too much stock currently available',10),(4,3,'APPROVED',1,'Need restock on gloves',10),(5,3,'PENDING',NULL,'Need more gloves.',100),(6,6,'COMPLETED',1,'Order them NOW',100);
/*!40000 ALTER TABLE `Purchase_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Requests`
--

DROP TABLE IF EXISTS `Requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Requests` (
  `User_ID` int NOT NULL,
  `Order_ID` int NOT NULL,
  PRIMARY KEY (`User_ID`,`Order_ID`),
  KEY `fk_requests_purchase_orders` (`Order_ID`),
  CONSTRAINT `fk_requests_purchase_orders` FOREIGN KEY (`Order_ID`) REFERENCES `Purchase_orders` (`Order_ID`),
  CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`Account_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Requests`
--

LOCK TABLES `Requests` WRITE;
/*!40000 ALTER TABLE `Requests` DISABLE KEYS */;
INSERT INTO `Requests` VALUES (2,1),(2,2),(2,3),(2,4),(2,5),(2,6);
/*!40000 ALTER TABLE `Requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Suppliers`
--

DROP TABLE IF EXISTS `Suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Suppliers` (
  `Supplier_ID` int NOT NULL AUTO_INCREMENT,
  `Phone_Number` varchar(15) NOT NULL,
  `Url` varchar(50) NOT NULL,
  `Supplier_Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Supplier_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Suppliers`
--

LOCK TABLES `Suppliers` WRITE;
/*!40000 ALTER TABLE `Suppliers` DISABLE KEYS */;
INSERT INTO `Suppliers` VALUES (1,'4081234567','supplier1.com','Supplier 1'),(2,'4089876543','supplier2.com','Supplier 2');
/*!40000 ALTER TABLE `Suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplies`
--

DROP TABLE IF EXISTS `Supplies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supplies` (
  `Supplier_ID` int NOT NULL,
  `Item_Reference_Number` int NOT NULL,
  PRIMARY KEY (`Supplier_ID`,`Item_Reference_Number`),
  KEY `Item_Reference_Number` (`Item_Reference_Number`),
  CONSTRAINT `supplies_ibfk_1` FOREIGN KEY (`Supplier_ID`) REFERENCES `Suppliers` (`Supplier_ID`),
  CONSTRAINT `supplies_ibfk_2` FOREIGN KEY (`Item_Reference_Number`) REFERENCES `Items` (`Item_Reference_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplies`
--

LOCK TABLES `Supplies` WRITE;
/*!40000 ALTER TABLE `Supplies` DISABLE KEYS */;
INSERT INTO `Supplies` VALUES (1,1),(1,2),(2,3),(1,4),(2,5),(2,6);
/*!40000 ALTER TABLE `Supplies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Update_Log`
--

DROP TABLE IF EXISTS `Update_Log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Update_Log` (
  `Log_ID` int NOT NULL AUTO_INCREMENT,
  `Admin_ID` int NOT NULL,
  `Location_ID` int NOT NULL,
  `Item_Reference_Number` int NOT NULL,
  `Updated_At` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Log_ID`),
  KEY `Admin_ID` (`Admin_ID`),
  KEY `Location_ID` (`Location_ID`,`Item_Reference_Number`),
  CONSTRAINT `update_log_ibfk_1` FOREIGN KEY (`Admin_ID`) REFERENCES `Admins` (`Account_ID`),
  CONSTRAINT `update_log_ibfk_2` FOREIGN KEY (`Location_ID`, `Item_Reference_Number`) REFERENCES `Inventory` (`Location_ID`, `Item_Reference_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Update_Log`
--

LOCK TABLES `Update_Log` WRITE;
/*!40000 ALTER TABLE `Update_Log` DISABLE KEYS */;
/*!40000 ALTER TABLE `Update_Log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `Account_ID` int NOT NULL,
  `Department_ID` int NOT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Account_ID`),
  KEY `Department_ID` (`Department_ID`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Account_ID`) REFERENCES `Accounts` (`Account_ID`),
  CONSTRAINT `users_ibfk_2` FOREIGN KEY (`Department_ID`) REFERENCES `Departments` (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (2,2,'4085551234');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Withdraw_Items`
--

DROP TABLE IF EXISTS `Withdraw_Items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Withdraw_Items` (
  `Withdraw_ID` int NOT NULL AUTO_INCREMENT,
  `Account_ID` int NOT NULL,
  `Item_Reference_Number` int NOT NULL,
  `Location_ID` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`Withdraw_ID`),
  KEY `Account_ID` (`Account_ID`),
  KEY `Location_ID` (`Location_ID`,`Item_Reference_Number`),
  CONSTRAINT `withdraw_items_ibfk_1` FOREIGN KEY (`Account_ID`) REFERENCES `Accounts` (`Account_ID`),
  CONSTRAINT `withdraw_items_ibfk_2` FOREIGN KEY (`Location_ID`, `Item_Reference_Number`) REFERENCES `Inventory` (`Location_ID`, `Item_Reference_Number`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Withdraw_Items`
--

LOCK TABLES `Withdraw_Items` WRITE;
/*!40000 ALTER TABLE `Withdraw_Items` DISABLE KEYS */;
INSERT INTO `Withdraw_Items` VALUES (1,1,1,1,10),(2,1,1,1,20),(3,1,1,1,10);
/*!40000 ALTER TABLE `Withdraw_Items` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-15 22:41:19
