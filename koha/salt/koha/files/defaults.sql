-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: koha___KOHASITE__
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.13.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `koha___KOHASITE__`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `koha___KOHASITE__` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `koha___KOHASITE__`;

--
-- Table structure for table `accountlines`
--

DROP TABLE IF EXISTS `accountlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountlines` (
  `accountlines_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `accountno` smallint(6) NOT NULL DEFAULT '0',
  `itemnumber` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` decimal(28,6) DEFAULT NULL,
  `description` mediumtext,
  `dispute` mediumtext,
  `accounttype` varchar(5) DEFAULT NULL,
  `amountoutstanding` decimal(28,6) DEFAULT NULL,
  `lastincrement` decimal(28,6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notify_id` int(11) NOT NULL DEFAULT '0',
  `notify_level` int(2) NOT NULL DEFAULT '0',
  `note` text,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`accountlines_id`),
  KEY `acctsborridx` (`borrowernumber`),
  KEY `timeidx` (`timestamp`),
  KEY `itemnumber` (`itemnumber`),
  CONSTRAINT `accountlines_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `accountlines_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountlines`
--

LOCK TABLES `accountlines` WRITE;
/*!40000 ALTER TABLE `accountlines` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accountoffsets`
--

DROP TABLE IF EXISTS `accountoffsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accountoffsets` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `accountno` smallint(6) NOT NULL DEFAULT '0',
  `offsetaccount` smallint(6) NOT NULL DEFAULT '0',
  `offsetamount` decimal(28,6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `accountoffsets_ibfk_1` (`borrowernumber`),
  CONSTRAINT `accountoffsets_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accountoffsets`
--

LOCK TABLES `accountoffsets` WRITE;
/*!40000 ALTER TABLE `accountoffsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `accountoffsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `action_logs`
--

DROP TABLE IF EXISTS `action_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `action_logs` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL DEFAULT '0',
  `module` text,
  `action` text,
  `object` int(11) DEFAULT NULL,
  `info` text,
  PRIMARY KEY (`action_id`),
  KEY `timestamp` (`timestamp`,`user`)
) ENGINE=InnoDB AUTO_INCREMENT=10975 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action_logs`
--

LOCK TABLES `action_logs` WRITE;
/*!40000 ALTER TABLE `action_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `action_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alert` (
  `alertid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `type` varchar(10) NOT NULL DEFAULT '',
  `externalid` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`alertid`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `type` (`type`,`externalid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbasket`
--

DROP TABLE IF EXISTS `aqbasket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbasket` (
  `basketno` int(11) NOT NULL AUTO_INCREMENT,
  `basketname` varchar(50) DEFAULT NULL,
  `note` mediumtext,
  `booksellernote` mediumtext,
  `contractnumber` int(11) DEFAULT NULL,
  `creationdate` date DEFAULT NULL,
  `closedate` date DEFAULT NULL,
  `booksellerid` int(11) NOT NULL DEFAULT '1',
  `authorisedby` varchar(10) DEFAULT NULL,
  `booksellerinvoicenumber` mediumtext,
  `basketgroupid` int(11) DEFAULT NULL,
  `deliveryplace` varchar(10) DEFAULT NULL,
  `billingplace` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`basketno`),
  KEY `booksellerid` (`booksellerid`),
  KEY `basketgroupid` (`basketgroupid`),
  KEY `contractnumber` (`contractnumber`),
  CONSTRAINT `aqbasket_ibfk_1` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `aqbasket_ibfk_2` FOREIGN KEY (`contractnumber`) REFERENCES `aqcontract` (`contractnumber`),
  CONSTRAINT `aqbasket_ibfk_3` FOREIGN KEY (`basketgroupid`) REFERENCES `aqbasketgroups` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbasket`
--

LOCK TABLES `aqbasket` WRITE;
/*!40000 ALTER TABLE `aqbasket` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbasket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbasketgroups`
--

DROP TABLE IF EXISTS `aqbasketgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbasketgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `closed` tinyint(1) DEFAULT NULL,
  `booksellerid` int(11) NOT NULL,
  `deliveryplace` varchar(10) DEFAULT NULL,
  `freedeliveryplace` text,
  `deliverycomment` varchar(255) DEFAULT NULL,
  `billingplace` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booksellerid` (`booksellerid`),
  CONSTRAINT `aqbasketgroups_ibfk_1` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbasketgroups`
--

LOCK TABLES `aqbasketgroups` WRITE;
/*!40000 ALTER TABLE `aqbasketgroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbasketgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbooksellers`
--

DROP TABLE IF EXISTS `aqbooksellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbooksellers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` mediumtext NOT NULL,
  `address1` mediumtext,
  `address2` mediumtext,
  `address3` mediumtext,
  `address4` mediumtext,
  `phone` varchar(30) DEFAULT NULL,
  `accountnumber` mediumtext,
  `othersupplier` mediumtext,
  `currency` varchar(3) NOT NULL DEFAULT '',
  `booksellerfax` mediumtext,
  `notes` mediumtext,
  `bookselleremail` mediumtext,
  `booksellerurl` mediumtext,
  `contact` varchar(100) DEFAULT NULL,
  `postal` mediumtext,
  `url` varchar(255) DEFAULT NULL,
  `contpos` varchar(100) DEFAULT NULL,
  `contphone` varchar(100) DEFAULT NULL,
  `contfax` varchar(100) DEFAULT NULL,
  `contaltphone` varchar(100) DEFAULT NULL,
  `contemail` varchar(100) DEFAULT NULL,
  `contnotes` mediumtext,
  `active` tinyint(4) DEFAULT NULL,
  `listprice` varchar(10) DEFAULT NULL,
  `invoiceprice` varchar(10) DEFAULT NULL,
  `gstreg` tinyint(4) DEFAULT NULL,
  `listincgst` tinyint(4) DEFAULT NULL,
  `invoiceincgst` tinyint(4) DEFAULT NULL,
  `gstrate` decimal(6,4) DEFAULT NULL,
  `discount` float(6,4) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `deliverytime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listprice` (`listprice`),
  KEY `invoiceprice` (`invoiceprice`),
  CONSTRAINT `aqbooksellers_ibfk_1` FOREIGN KEY (`listprice`) REFERENCES `currency` (`currency`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbooksellers_ibfk_2` FOREIGN KEY (`invoiceprice`) REFERENCES `currency` (`currency`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbooksellers`
--

LOCK TABLES `aqbooksellers` WRITE;
/*!40000 ALTER TABLE `aqbooksellers` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbooksellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgetborrowers`
--

DROP TABLE IF EXISTS `aqbudgetborrowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgetborrowers` (
  `budget_id` int(11) NOT NULL,
  `borrowernumber` int(11) NOT NULL,
  PRIMARY KEY (`budget_id`,`borrowernumber`),
  KEY `aqbudgetborrowers_ibfk_2` (`borrowernumber`),
  CONSTRAINT `aqbudgetborrowers_ibfk_1` FOREIGN KEY (`budget_id`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqbudgetborrowers_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgetborrowers`
--

LOCK TABLES `aqbudgetborrowers` WRITE;
/*!40000 ALTER TABLE `aqbudgetborrowers` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgetborrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgetperiods`
--

DROP TABLE IF EXISTS `aqbudgetperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgetperiods` (
  `budget_period_id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_period_startdate` date NOT NULL,
  `budget_period_enddate` date NOT NULL,
  `budget_period_active` tinyint(1) DEFAULT '0',
  `budget_period_description` mediumtext,
  `budget_period_total` decimal(28,6) DEFAULT NULL,
  `budget_period_locked` tinyint(1) DEFAULT NULL,
  `sort1_authcat` varchar(10) DEFAULT NULL,
  `sort2_authcat` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`budget_period_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgetperiods`
--

LOCK TABLES `aqbudgetperiods` WRITE;
/*!40000 ALTER TABLE `aqbudgetperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgetperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgets`
--

DROP TABLE IF EXISTS `aqbudgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgets` (
  `budget_id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_parent_id` int(11) DEFAULT NULL,
  `budget_code` varchar(30) DEFAULT NULL,
  `budget_name` varchar(80) DEFAULT NULL,
  `budget_branchcode` varchar(10) DEFAULT NULL,
  `budget_amount` decimal(28,6) DEFAULT '0.000000',
  `budget_encumb` decimal(28,6) DEFAULT '0.000000',
  `budget_expend` decimal(28,6) DEFAULT '0.000000',
  `budget_notes` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `budget_period_id` int(11) DEFAULT NULL,
  `sort1_authcat` varchar(80) DEFAULT NULL,
  `sort2_authcat` varchar(80) DEFAULT NULL,
  `budget_owner_id` int(11) DEFAULT NULL,
  `budget_permission` int(1) DEFAULT '0',
  PRIMARY KEY (`budget_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgets`
--

LOCK TABLES `aqbudgets` WRITE;
/*!40000 ALTER TABLE `aqbudgets` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqbudgets_planning`
--

DROP TABLE IF EXISTS `aqbudgets_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqbudgets_planning` (
  `plan_id` int(11) NOT NULL AUTO_INCREMENT,
  `budget_id` int(11) NOT NULL,
  `budget_period_id` int(11) NOT NULL,
  `estimated_amount` decimal(28,6) DEFAULT NULL,
  `authcat` varchar(30) NOT NULL,
  `authvalue` varchar(30) NOT NULL,
  `display` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`plan_id`),
  KEY `aqbudgets_planning_ifbk_1` (`budget_id`),
  CONSTRAINT `aqbudgets_planning_ifbk_1` FOREIGN KEY (`budget_id`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqbudgets_planning`
--

LOCK TABLES `aqbudgets_planning` WRITE;
/*!40000 ALTER TABLE `aqbudgets_planning` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqbudgets_planning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqcontract`
--

DROP TABLE IF EXISTS `aqcontract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqcontract` (
  `contractnumber` int(11) NOT NULL AUTO_INCREMENT,
  `contractstartdate` date DEFAULT NULL,
  `contractenddate` date DEFAULT NULL,
  `contractname` varchar(50) DEFAULT NULL,
  `contractdescription` mediumtext,
  `booksellerid` int(11) NOT NULL,
  PRIMARY KEY (`contractnumber`),
  KEY `booksellerid_fk1` (`booksellerid`),
  CONSTRAINT `booksellerid_fk1` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqcontract`
--

LOCK TABLES `aqcontract` WRITE;
/*!40000 ALTER TABLE `aqcontract` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqcontract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqinvoices`
--

DROP TABLE IF EXISTS `aqinvoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqinvoices` (
  `invoiceid` int(11) NOT NULL AUTO_INCREMENT,
  `invoicenumber` mediumtext NOT NULL,
  `booksellerid` int(11) NOT NULL,
  `shipmentdate` date DEFAULT NULL,
  `billingdate` date DEFAULT NULL,
  `closedate` date DEFAULT NULL,
  `shipmentcost` decimal(28,6) DEFAULT NULL,
  `shipmentcost_budgetid` int(11) DEFAULT NULL,
  PRIMARY KEY (`invoiceid`),
  KEY `aqinvoices_fk_aqbooksellerid` (`booksellerid`),
  KEY `aqinvoices_fk_shipmentcost_budgetid` (`shipmentcost_budgetid`),
  CONSTRAINT `aqinvoices_fk_aqbooksellerid` FOREIGN KEY (`booksellerid`) REFERENCES `aqbooksellers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqinvoices_fk_shipmentcost_budgetid` FOREIGN KEY (`shipmentcost_budgetid`) REFERENCES `aqbudgets` (`budget_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqinvoices`
--

LOCK TABLES `aqinvoices` WRITE;
/*!40000 ALTER TABLE `aqinvoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqinvoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqorderdelivery`
--

DROP TABLE IF EXISTS `aqorderdelivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqorderdelivery` (
  `ordernumber` date DEFAULT NULL,
  `deliverynumber` smallint(6) NOT NULL DEFAULT '0',
  `deliverydate` varchar(18) DEFAULT NULL,
  `qtydelivered` smallint(6) DEFAULT NULL,
  `deliverycomments` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqorderdelivery`
--

LOCK TABLES `aqorderdelivery` WRITE;
/*!40000 ALTER TABLE `aqorderdelivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqorderdelivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqorders`
--

DROP TABLE IF EXISTS `aqorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqorders` (
  `ordernumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) DEFAULT NULL,
  `entrydate` date DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `listprice` decimal(28,6) DEFAULT NULL,
  `totalamount` decimal(28,6) DEFAULT NULL,
  `datereceived` date DEFAULT NULL,
  `invoiceid` int(11) DEFAULT NULL,
  `freight` decimal(28,6) DEFAULT NULL,
  `unitprice` decimal(28,6) DEFAULT NULL,
  `quantityreceived` smallint(6) NOT NULL DEFAULT '0',
  `cancelledby` varchar(10) DEFAULT NULL,
  `datecancellationprinted` date DEFAULT NULL,
  `notes` mediumtext,
  `supplierreference` mediumtext,
  `purchaseordernumber` mediumtext,
  `basketno` int(11) DEFAULT NULL,
  `biblioitemnumber` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rrp` decimal(13,2) DEFAULT NULL,
  `ecost` decimal(13,2) DEFAULT NULL,
  `gstrate` decimal(6,4) DEFAULT NULL,
  `discount` float(6,4) DEFAULT NULL,
  `budget_id` int(11) NOT NULL,
  `budgetgroup_id` int(11) NOT NULL,
  `budgetdate` date DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `sort1_authcat` varchar(10) DEFAULT NULL,
  `sort2_authcat` varchar(10) DEFAULT NULL,
  `uncertainprice` tinyint(1) DEFAULT NULL,
  `claims_count` int(11) DEFAULT '0',
  `claimed_date` date DEFAULT NULL,
  `subscriptionid` int(11) DEFAULT NULL,
  `parent_ordernumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`ordernumber`),
  KEY `basketno` (`basketno`),
  KEY `biblionumber` (`biblionumber`),
  KEY `budget_id` (`budget_id`),
  KEY `aqorders_ibfk_3` (`invoiceid`),
  KEY `aqorders_subscriptionid` (`subscriptionid`),
  CONSTRAINT `aqorders_ibfk_1` FOREIGN KEY (`basketno`) REFERENCES `aqbasket` (`basketno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aqorders_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aqorders_ibfk_3` FOREIGN KEY (`invoiceid`) REFERENCES `aqinvoices` (`invoiceid`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `aqorders_subscriptionid` FOREIGN KEY (`subscriptionid`) REFERENCES `subscription` (`subscriptionid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqorders`
--

LOCK TABLES `aqorders` WRITE;
/*!40000 ALTER TABLE `aqorders` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aqorders_items`
--

DROP TABLE IF EXISTS `aqorders_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aqorders_items` (
  `ordernumber` int(11) NOT NULL,
  `itemnumber` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`itemnumber`),
  KEY `ordernumber` (`ordernumber`),
  CONSTRAINT `aqorders_items_ibfk_1` FOREIGN KEY (`ordernumber`) REFERENCES `aqorders` (`ordernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aqorders_items`
--

LOCK TABLES `aqorders_items` WRITE;
/*!40000 ALTER TABLE `aqorders_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `aqorders_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_header`
--

DROP TABLE IF EXISTS `auth_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_header` (
  `authid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `datecreated` date DEFAULT NULL,
  `datemodified` date DEFAULT NULL,
  `origincode` varchar(20) DEFAULT NULL,
  `authtrees` mediumtext,
  `marc` blob,
  `linkid` bigint(20) DEFAULT NULL,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`authid`),
  KEY `origincode` (`origincode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_header`
--

LOCK TABLES `auth_header` WRITE;
/*!40000 ALTER TABLE `auth_header` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_subfield_structure`
--

DROP TABLE IF EXISTS `auth_subfield_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_subfield_structure` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `tagsubfield` varchar(1) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `tab` tinyint(1) DEFAULT NULL,
  `authorised_value` varchar(10) DEFAULT NULL,
  `value_builder` varchar(80) DEFAULT NULL,
  `seealso` varchar(255) DEFAULT NULL,
  `isurl` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(3) NOT NULL DEFAULT '0',
  `linkid` tinyint(1) NOT NULL DEFAULT '0',
  `kohafield` varchar(45) DEFAULT '',
  `frameworkcode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`authtypecode`,`tagfield`,`tagsubfield`),
  KEY `tab` (`authtypecode`,`tab`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_subfield_structure`
--

LOCK TABLES `auth_subfield_structure` WRITE;
/*!40000 ALTER TABLE `auth_subfield_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_subfield_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_tag_structure`
--

DROP TABLE IF EXISTS `auth_tag_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_tag_structure` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `authorised_value` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`authtypecode`,`tagfield`),
  CONSTRAINT `auth_tag_structure_ibfk_1` FOREIGN KEY (`authtypecode`) REFERENCES `auth_types` (`authtypecode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_tag_structure`
--

LOCK TABLES `auth_tag_structure` WRITE;
/*!40000 ALTER TABLE `auth_tag_structure` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_tag_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_types`
--

DROP TABLE IF EXISTS `auth_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_types` (
  `authtypecode` varchar(10) NOT NULL DEFAULT '',
  `authtypetext` varchar(255) NOT NULL DEFAULT '',
  `auth_tag_to_report` varchar(3) NOT NULL DEFAULT '',
  `summary` mediumtext NOT NULL,
  PRIMARY KEY (`authtypecode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_types`
--

LOCK TABLES `auth_types` WRITE;
/*!40000 ALTER TABLE `auth_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorised_values`
--

DROP TABLE IF EXISTS `authorised_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorised_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(16) NOT NULL DEFAULT '',
  `authorised_value` varchar(80) NOT NULL DEFAULT '',
  `lib` varchar(200) DEFAULT NULL,
  `lib_opac` varchar(200) DEFAULT NULL,
  `imageurl` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`category`),
  KEY `lib` (`lib`),
  KEY `auth_value_idx` (`authorised_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorised_values`
--

LOCK TABLES `authorised_values` WRITE;
/*!40000 ALTER TABLE `authorised_values` DISABLE KEYS */;
INSERT INTO `authorised_values` VALUES (1,'SUGGEST','BSELL','Bestselger',NULL,NULL),(2,'SUGGEST','SCD','Bibliotekets eksemplar er skadet',NULL,NULL),(3,'SUGGEST','LCL','Bibliotekets eksemplar er tapt',NULL,NULL),(4,'SUGGEST','AVILL','Tilgjengelig via fjernlån',NULL,NULL),(5,'LOST','2','Regnes som tapt',NULL,NULL),(6,'LOST','1','Tapt',NULL,NULL),(7,'LOST','3','Tapt og erstattet',NULL,NULL),(8,'LOST','4','Savnet',NULL,NULL),(9,'DAMAGED','1','Skadet',NULL,NULL),(10,'LOC','FIC','Skjønnlitteratur',NULL,NULL),(11,'LOC','CHILD','Barneavdelingen',NULL,NULL),(12,'LOC','DISPLAY','På utstilling',NULL,NULL),(13,'LOC','NEW','Nyhetshylla',NULL,NULL),(14,'LOC','STAFF','Ansattes kontor',NULL,NULL),(15,'LOC','GEN','Samlingen',NULL,NULL),(16,'LOC','AV','AV-materiale',NULL,NULL),(17,'LOC','REF','Oppslagsverk',NULL,NULL),(18,'LOC','CART','Boktralle',NULL,NULL),(19,'LOC','PROC','Til klargjøring',NULL,NULL),(20,'CCODE','FIC','Skjønnlitteratur',NULL,NULL),(21,'CCODE','REF','Oppslagsverk',NULL,NULL),(22,'CCODE','NFIC','Faglitteratur',NULL,NULL),(23,'WITHDRAWN','1','Trukket tilbake',NULL,NULL),(24,'NOT_LOAN','-1','I bestilling',NULL,NULL),(25,'NOT_LOAN','1','Ikke til utlån',NULL,NULL),(26,'NOT_LOAN','2','Kun til internt bruk',NULL,NULL),(27,'RESTRICTED','1','Begrenset tilgang',NULL,NULL),(28,'MANUAL_INV','Kopiavgift','0,25',NULL,NULL),(29,'BOR_NOTES','ADDR','Addresse-noter',NULL,NULL),(30,'OPAC_SUG','damaged','Eksemplaret på hylla er skadet','Eksemplaret på hylla er skadet',NULL),(31,'OPAC_SUG','bestseller','Kommende tittel av populær forfatter','Kommende tittel av populær forfatter',NULL),(32,'REPORT_GROUP','CIRC','Sirkulasjon',NULL,NULL),(33,'REPORT_GROUP','CAT','Katalog',NULL,NULL),(34,'REPORT_GROUP','PAT','Lånere',NULL,NULL),(35,'REPORT_GROUP','ACQ','Innkjøp',NULL,NULL),(36,'REPORT_GROUP','ACC','Gebyrer',NULL,NULL);
/*!40000 ALTER TABLE `authorised_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorised_values_branches`
--

DROP TABLE IF EXISTS `authorised_values_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorised_values_branches` (
  `av_id` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  KEY `av_id` (`av_id`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `authorised_values_branches_ibfk_1` FOREIGN KEY (`av_id`) REFERENCES `authorised_values` (`id`) ON DELETE CASCADE,
  CONSTRAINT `authorised_values_branches_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorised_values_branches`
--

LOCK TABLES `authorised_values_branches` WRITE;
/*!40000 ALTER TABLE `authorised_values_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `authorised_values_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblio`
--

DROP TABLE IF EXISTS `biblio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblio` (
  `biblionumber` int(11) NOT NULL AUTO_INCREMENT,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `author` mediumtext,
  `title` mediumtext,
  `unititle` mediumtext,
  `notes` mediumtext,
  `serial` tinyint(1) DEFAULT NULL,
  `seriestitle` mediumtext,
  `copyrightdate` smallint(6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datecreated` date NOT NULL,
  `abstract` mediumtext,
  PRIMARY KEY (`biblionumber`),
  KEY `blbnoidx` (`biblionumber`)
) ENGINE=InnoDB AUTO_INCREMENT=1677217 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblio`
--

LOCK TABLES `biblio` WRITE;
/*!40000 ALTER TABLE `biblio` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblio_framework`
--

DROP TABLE IF EXISTS `biblio_framework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblio_framework` (
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `frameworktext` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblio_framework`
--

LOCK TABLES `biblio_framework` WRITE;
/*!40000 ALTER TABLE `biblio_framework` DISABLE KEYS */;
INSERT INTO `biblio_framework` VALUES ('FAG','Faglitteratur'),('SKJ','Skjønnlitteratur');
/*!40000 ALTER TABLE `biblio_framework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblioimages`
--

DROP TABLE IF EXISTS `biblioimages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioimages` (
  `imagenumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) NOT NULL,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL,
  `thumbnail` mediumblob NOT NULL,
  PRIMARY KEY (`imagenumber`),
  KEY `bibliocoverimage_fk1` (`biblionumber`),
  CONSTRAINT `bibliocoverimage_fk1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblioimages`
--

LOCK TABLES `biblioimages` WRITE;
/*!40000 ALTER TABLE `biblioimages` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblioimages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `biblioitems`
--

DROP TABLE IF EXISTS `biblioitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biblioitems` (
  `biblioitemnumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `volume` mediumtext,
  `number` mediumtext,
  `itemtype` varchar(10) DEFAULT NULL,
  `isbn` varchar(30) DEFAULT NULL,
  `issn` varchar(9) DEFAULT NULL,
  `ean` varchar(13) DEFAULT NULL,
  `publicationyear` text,
  `publishercode` varchar(255) DEFAULT NULL,
  `volumedate` date DEFAULT NULL,
  `volumedesc` text,
  `collectiontitle` mediumtext,
  `collectionissn` text,
  `collectionvolume` mediumtext,
  `editionstatement` text,
  `editionresponsibility` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `illus` varchar(255) DEFAULT NULL,
  `pages` varchar(255) DEFAULT NULL,
  `notes` mediumtext,
  `size` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `lccn` varchar(25) DEFAULT NULL,
  `marc` longblob,
  `url` varchar(255) DEFAULT NULL,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_class` varchar(30) DEFAULT NULL,
  `cn_item` varchar(10) DEFAULT NULL,
  `cn_suffix` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `agerestriction` varchar(255) DEFAULT NULL,
  `totalissues` int(10) DEFAULT NULL,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`biblioitemnumber`),
  KEY `bibinoidx` (`biblioitemnumber`),
  KEY `bibnoidx` (`biblionumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `isbn` (`isbn`),
  KEY `issn` (`issn`),
  KEY `publishercode` (`publishercode`),
  CONSTRAINT `biblioitems_ibfk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1677217 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biblioitems`
--

LOCK TABLES `biblioitems` WRITE;
/*!40000 ALTER TABLE `biblioitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `biblioitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_attribute_types`
--

DROP TABLE IF EXISTS `borrower_attribute_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_attribute_types` (
  `code` varchar(10) NOT NULL,
  `description` varchar(255) NOT NULL,
  `repeatable` tinyint(1) NOT NULL DEFAULT '0',
  `unique_id` tinyint(1) NOT NULL DEFAULT '0',
  `opac_display` tinyint(1) NOT NULL DEFAULT '0',
  `password_allowed` tinyint(1) NOT NULL DEFAULT '0',
  `staff_searchable` tinyint(1) NOT NULL DEFAULT '0',
  `authorised_value_category` varchar(10) DEFAULT NULL,
  `display_checkout` tinyint(1) NOT NULL DEFAULT '0',
  `category_code` varchar(10) DEFAULT NULL,
  `class` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`code`),
  KEY `auth_val_cat_idx` (`authorised_value_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_attribute_types`
--

LOCK TABLES `borrower_attribute_types` WRITE;
/*!40000 ALTER TABLE `borrower_attribute_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_attribute_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_attribute_types_branches`
--

DROP TABLE IF EXISTS `borrower_attribute_types_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_attribute_types_branches` (
  `bat_code` varchar(10) DEFAULT NULL,
  `b_branchcode` varchar(10) DEFAULT NULL,
  KEY `bat_code` (`bat_code`),
  KEY `b_branchcode` (`b_branchcode`),
  CONSTRAINT `borrower_attribute_types_branches_ibfk_1` FOREIGN KEY (`bat_code`) REFERENCES `borrower_attribute_types` (`code`) ON DELETE CASCADE,
  CONSTRAINT `borrower_attribute_types_branches_ibfk_2` FOREIGN KEY (`b_branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_attribute_types_branches`
--

LOCK TABLES `borrower_attribute_types_branches` WRITE;
/*!40000 ALTER TABLE `borrower_attribute_types_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_attribute_types_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_attributes`
--

DROP TABLE IF EXISTS `borrower_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_attributes` (
  `borrowernumber` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `attribute` varchar(255) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  KEY `borrowernumber` (`borrowernumber`),
  KEY `code_attribute` (`code`,`attribute`),
  CONSTRAINT `borrower_attributes_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_attributes_ibfk_2` FOREIGN KEY (`code`) REFERENCES `borrower_attribute_types` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_attributes`
--

LOCK TABLES `borrower_attributes` WRITE;
/*!40000 ALTER TABLE `borrower_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_files`
--

DROP TABLE IF EXISTS `borrower_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_files` (
  `file_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_description` varchar(255) DEFAULT NULL,
  `file_content` longblob NOT NULL,
  `date_uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`file_id`),
  KEY `borrowernumber` (`borrowernumber`),
  CONSTRAINT `borrower_files_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_files`
--

LOCK TABLES `borrower_files` WRITE;
/*!40000 ALTER TABLE `borrower_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_message_preferences`
--

DROP TABLE IF EXISTS `borrower_message_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_message_preferences` (
  `borrower_message_preference_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `categorycode` varchar(10) DEFAULT NULL,
  `message_attribute_id` int(11) DEFAULT '0',
  `days_in_advance` int(11) DEFAULT '0',
  `wants_digest` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`borrower_message_preference_id`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `categorycode` (`categorycode`),
  KEY `message_attribute_id` (`message_attribute_id`),
  CONSTRAINT `borrower_message_preferences_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_preferences_ibfk_2` FOREIGN KEY (`message_attribute_id`) REFERENCES `message_attributes` (`message_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_preferences_ibfk_3` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_message_preferences`
--

LOCK TABLES `borrower_message_preferences` WRITE;
/*!40000 ALTER TABLE `borrower_message_preferences` DISABLE KEYS */;
INSERT INTO `borrower_message_preferences` VALUES (1,NULL,'AUTO',2,0,0),(2,NULL,'AUTO',6,NULL,0),(3,NULL,'AUTO',4,NULL,0),(4,NULL,'AUTO',1,NULL,0),(5,NULL,'AUTO',5,NULL,0),(11,2,NULL,2,NULL,0),(12,2,NULL,6,NULL,0),(13,2,NULL,4,NULL,0),(14,2,NULL,1,NULL,0),(15,2,NULL,5,NULL,0);
/*!40000 ALTER TABLE `borrower_message_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_message_transport_preferences`
--

DROP TABLE IF EXISTS `borrower_message_transport_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_message_transport_preferences` (
  `borrower_message_preference_id` int(11) NOT NULL DEFAULT '0',
  `message_transport_type` varchar(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`borrower_message_preference_id`,`message_transport_type`),
  KEY `message_transport_type` (`message_transport_type`),
  CONSTRAINT `borrower_message_transport_preferences_ibfk_1` FOREIGN KEY (`borrower_message_preference_id`) REFERENCES `borrower_message_preferences` (`borrower_message_preference_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrower_message_transport_preferences_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_message_transport_preferences`
--

LOCK TABLES `borrower_message_transport_preferences` WRITE;
/*!40000 ALTER TABLE `borrower_message_transport_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_message_transport_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrower_modifications`
--

DROP TABLE IF EXISTS `borrower_modifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrower_modifications` (
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `verification_token` varchar(255) NOT NULL DEFAULT '',
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `cardnumber` varchar(16) DEFAULT NULL,
  `surname` mediumtext,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10) DEFAULT NULL,
  `streettype` varchar(50) DEFAULT NULL,
  `address` mediumtext,
  `address2` text,
  `city` mediumtext,
  `state` text,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `B_streetnumber` varchar(10) DEFAULT NULL,
  `B_streettype` varchar(50) DEFAULT NULL,
  `B_address` varchar(100) DEFAULT NULL,
  `B_address2` text,
  `B_city` mediumtext,
  `B_state` text,
  `B_zipcode` varchar(25) DEFAULT NULL,
  `B_country` text,
  `B_email` text,
  `B_phone` mediumtext,
  `dateofbirth` date DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `categorycode` varchar(10) DEFAULT NULL,
  `dateenrolled` date DEFAULT NULL,
  `dateexpiry` date DEFAULT NULL,
  `gonenoaddress` tinyint(1) DEFAULT NULL,
  `lost` tinyint(1) DEFAULT NULL,
  `debarred` date DEFAULT NULL,
  `debarredcomment` varchar(255) DEFAULT NULL,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` int(11) DEFAULT NULL,
  `borrowernotes` mediumtext,
  `relationship` varchar(100) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `ethnotes` varchar(255) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL,
  `userid` varchar(75) DEFAULT NULL,
  `opacnote` mediumtext,
  `contactnote` varchar(255) DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `altcontactfirstname` varchar(255) DEFAULT NULL,
  `altcontactsurname` varchar(255) DEFAULT NULL,
  `altcontactaddress1` varchar(255) DEFAULT NULL,
  `altcontactaddress2` varchar(255) DEFAULT NULL,
  `altcontactaddress3` varchar(255) DEFAULT NULL,
  `altcontactstate` text,
  `altcontactzipcode` varchar(50) DEFAULT NULL,
  `altcontactcountry` text,
  `altcontactphone` varchar(50) DEFAULT NULL,
  `smsalertnumber` varchar(50) DEFAULT NULL,
  `privacy` int(11) DEFAULT NULL,
  PRIMARY KEY (`verification_token`,`borrowernumber`),
  KEY `verification_token` (`verification_token`),
  KEY `borrowernumber` (`borrowernumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrower_modifications`
--

LOCK TABLES `borrower_modifications` WRITE;
/*!40000 ALTER TABLE `borrower_modifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `borrower_modifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrowers`
--

DROP TABLE IF EXISTS `borrowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrowers` (
  `borrowernumber` int(11) NOT NULL AUTO_INCREMENT,
  `cardnumber` varchar(16) DEFAULT NULL,
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10) DEFAULT NULL,
  `streettype` varchar(50) DEFAULT NULL,
  `address` mediumtext NOT NULL,
  `address2` text,
  `city` mediumtext NOT NULL,
  `state` text,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `B_streetnumber` varchar(10) DEFAULT NULL,
  `B_streettype` varchar(50) DEFAULT NULL,
  `B_address` varchar(100) DEFAULT NULL,
  `B_address2` text,
  `B_city` mediumtext,
  `B_state` text,
  `B_zipcode` varchar(25) DEFAULT NULL,
  `B_country` text,
  `B_email` text,
  `B_phone` mediumtext,
  `dateofbirth` date DEFAULT NULL,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `dateenrolled` date DEFAULT NULL,
  `dateexpiry` date DEFAULT NULL,
  `gonenoaddress` tinyint(1) DEFAULT NULL,
  `lost` tinyint(1) DEFAULT NULL,
  `debarred` date DEFAULT NULL,
  `debarredcomment` varchar(255) DEFAULT NULL,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` int(11) DEFAULT NULL,
  `borrowernotes` mediumtext,
  `relationship` varchar(100) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `ethnotes` varchar(255) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL,
  `userid` varchar(75) DEFAULT NULL,
  `opacnote` mediumtext,
  `contactnote` varchar(255) DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `altcontactfirstname` varchar(255) DEFAULT NULL,
  `altcontactsurname` varchar(255) DEFAULT NULL,
  `altcontactaddress1` varchar(255) DEFAULT NULL,
  `altcontactaddress2` varchar(255) DEFAULT NULL,
  `altcontactaddress3` varchar(255) DEFAULT NULL,
  `altcontactstate` text,
  `altcontactzipcode` varchar(50) DEFAULT NULL,
  `altcontactcountry` text,
  `altcontactphone` varchar(50) DEFAULT NULL,
  `smsalertnumber` varchar(50) DEFAULT NULL,
  `privacy` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`borrowernumber`),
  UNIQUE KEY `cardnumber` (`cardnumber`),
  KEY `categorycode` (`categorycode`),
  KEY `branchcode` (`branchcode`),
  KEY `userid` (`userid`),
  KEY `guarantorid` (`guarantorid`),
  CONSTRAINT `borrowers_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`),
  CONSTRAINT `borrowers_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrowers`
--

LOCK TABLES `borrowers` WRITE;
/*!40000 ALTER TABLE `borrowers` DISABLE KEYS */;
INSERT INTO `borrowers` VALUES (7,'7','Söze','Keyser','','','','',NULL,'','','','','','','','','','','','',NULL,NULL,'','','','','','','','',NULL,'hutl','ADMIN','2013-09-19','2022-01-19',0,0,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,'','7AjNkXXC4JQpTOyXMhSOcQ',1,'flesk','','','','','','','','','','','','','',NULL,1),(8,'8','Automat_hoved1','','','','','',NULL,'','','','','','','','','','','','',NULL,NULL,'','','','','','','','',NULL,'hutl','AUTO','2013-12-18','2022-03-18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,'','$2a$08$IiT8vYz8Gn6yf0dq5eOmCuMBqoNw06V6wzmhaZurJ9YXuNWw7Qv66',2,'autohoved1','','','','','','','','','','','','','',NULL,1);
/*!40000 ALTER TABLE `borrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_borrower_circ_rules`
--

DROP TABLE IF EXISTS `branch_borrower_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch_borrower_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  PRIMARY KEY (`categorycode`,`branchcode`),
  KEY `branch_borrower_circ_rules_ibfk_2` (`branchcode`),
  CONSTRAINT `branch_borrower_circ_rules_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_borrower_circ_rules_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_borrower_circ_rules`
--

LOCK TABLES `branch_borrower_circ_rules` WRITE;
/*!40000 ALTER TABLE `branch_borrower_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_borrower_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_item_rules`
--

DROP TABLE IF EXISTS `branch_item_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch_item_rules` (
  `branchcode` varchar(10) NOT NULL,
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`itemtype`,`branchcode`),
  KEY `branch_item_rules_ibfk_2` (`branchcode`),
  CONSTRAINT `branch_item_rules_ibfk_1` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branch_item_rules_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_item_rules`
--

LOCK TABLES `branch_item_rules` WRITE;
/*!40000 ALTER TABLE `branch_item_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_item_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_transfer_limits`
--

DROP TABLE IF EXISTS `branch_transfer_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch_transfer_limits` (
  `limitId` int(8) NOT NULL AUTO_INCREMENT,
  `toBranch` varchar(10) NOT NULL,
  `fromBranch` varchar(10) NOT NULL,
  `itemtype` varchar(10) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`limitId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_transfer_limits`
--

LOCK TABLES `branch_transfer_limits` WRITE;
/*!40000 ALTER TABLE `branch_transfer_limits` DISABLE KEYS */;
/*!40000 ALTER TABLE `branch_transfer_limits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branchcategories`
--

DROP TABLE IF EXISTS `branchcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branchcategories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `categoryname` varchar(32) DEFAULT NULL,
  `codedescription` mediumtext,
  `categorytype` varchar(16) DEFAULT NULL,
  `show_in_pulldown` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`categorycode`),
  KEY `show_in_pulldown` (`show_in_pulldown`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchcategories`
--

LOCK TABLES `branchcategories` WRITE;
/*!40000 ALTER TABLE `branchcategories` DISABLE KEYS */;
INSERT INTO `branchcategories` VALUES ('ALLE','Alle filialer','Hele Deichman','searchdomain',1),('HOVED','Hovedbiblioteket','Voksenavd, Musikk & Unge Deichman','searchdomain',1);
/*!40000 ALTER TABLE `branchcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `branchname` mediumtext NOT NULL,
  `branchaddress1` mediumtext,
  `branchaddress2` mediumtext,
  `branchaddress3` mediumtext,
  `branchzip` varchar(25) DEFAULT NULL,
  `branchcity` mediumtext,
  `branchstate` mediumtext,
  `branchcountry` text,
  `branchphone` mediumtext,
  `branchfax` mediumtext,
  `branchemail` mediumtext,
  `branchurl` mediumtext,
  `issuing` tinyint(4) DEFAULT NULL,
  `branchip` varchar(15) DEFAULT NULL,
  `branchprinter` varchar(100) DEFAULT NULL,
  `branchnotes` mediumtext,
  `opac_info` text,
  PRIMARY KEY (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES ('dfb','Det Flerspråklige Bibliotek',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('dfbs','Det Flerspråklige Bibliotek Referanse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbje','Bjerke',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbjh','Bjerke, lokalhistorie',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbji','Bjerke, innvandrerlitteratur',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbjl','Bjørnholt læremidler',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbjo','Bjørnholt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbju','Bjørnholt ungdomsskole',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbli','vet ikke',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fbol','Bøler',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fdum','dummy','','','','','','','','','','','',NULL,'',NULL,'',''),('ffur','Furuset',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fgam','Gamle Oslo',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fgry','Grünerløkka',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fgyi','Grünerløkka innvanrerlitteratur',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fhol','Holmlia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('flam','Lambertseter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fmaj','Majorstua',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fnor','Nordtvet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fnti','Fnatt!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fnyd','Nydalen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fopp','Oppsal',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('frik','Rikshospitalet',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('frmm','Rommen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('froa','Røa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('from','Romsås',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fsme','Smestad',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fsor','Sørkedalen nærbibliotek',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fsti','Stovner innlån?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fsto','Stovner',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ftoi','Torshov innvandrerlitteratur',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ftor','Torshov',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('fxxx','filial X',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hbar','Barneavdelingen (Hovedutlånet)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hbbr','Barneavdelingen spesialsamling',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hsko','Skoleavdelingen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hutl','Hovedbiblioteket',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hvkr','Katalogavdeling referanse',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hvlr','Stjernesamling, lesesalen',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hvmu','Musikkavdelingen (Hovedbiblioteket)',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('hvur','Spesialsamling, fjernlån',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('info','til info?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('idep','depot?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('ukjent','mangler?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branchrelations`
--

DROP TABLE IF EXISTS `branchrelations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branchrelations` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`branchcode`,`categorycode`),
  KEY `branchcode` (`branchcode`),
  KEY `categorycode` (`categorycode`),
  CONSTRAINT `branchrelations_ibfk_1` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchrelations_ibfk_2` FOREIGN KEY (`categorycode`) REFERENCES `branchcategories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchrelations`
--

LOCK TABLES `branchrelations` WRITE;
/*!40000 ALTER TABLE `branchrelations` DISABLE KEYS */;
INSERT INTO `branchrelations` VALUES ('DFB', 'ALLE'),('DFBS', 'ALLE'),('FBJE', 'ALLE'),('FBJH', 'ALLE'),('FBJI', 'ALLE'),('FBJL', 'ALLE'),('FBJO', 'ALLE'),('FBJU', 'ALLE'),('FBLI', 'ALLE'),('FBOL', 'ALLE'),('FDUM', 'ALLE'),('FFUR', 'ALLE'),('FGAM', 'ALLE'),('FGRY', 'ALLE'),('FGYI', 'ALLE'),('FHOL', 'ALLE'),('FLAM', 'ALLE'),('FMAJ', 'ALLE'),('FNOR', 'ALLE'),('FNTI', 'ALLE'),('FNYD', 'ALLE'),('FOPP', 'ALLE'),('FRIK', 'ALLE'),('FRMM', 'ALLE'),('FROA', 'ALLE'),('FROM', 'ALLE'),('FSME', 'ALLE'),('FSOR', 'ALLE'),('FSTI', 'ALLE'),('FSTO', 'ALLE'),('FTOI', 'ALLE'),('FTOR', 'ALLE'),('FXXX', 'ALLE'),('HBAR', 'ALLE'),('HBBR', 'ALLE'),('HSKO', 'ALLE'),('HUTL', 'ALLE'),('HVKR', 'ALLE'),('HVLR', 'ALLE'),('HVMU', 'ALLE'),('HVUR', 'ALLE'),('INFO', 'ALLE'),('HBAR','HOVED'),('HBBR','HOVED'),('HSKO','HOVED'),('HUTL','HOVED'),('HVMU','HOVED');
/*!40000 ALTER TABLE `branchrelations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branchtransfers`
--

DROP TABLE IF EXISTS `branchtransfers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branchtransfers` (
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `datesent` datetime DEFAULT NULL,
  `frombranch` varchar(10) NOT NULL DEFAULT '',
  `datearrived` datetime DEFAULT NULL,
  `tobranch` varchar(10) NOT NULL DEFAULT '',
  `comments` mediumtext,
  KEY `frombranch` (`frombranch`),
  KEY `tobranch` (`tobranch`),
  KEY `itemnumber` (`itemnumber`),
  CONSTRAINT `branchtransfers_ibfk_1` FOREIGN KEY (`frombranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchtransfers_ibfk_2` FOREIGN KEY (`tobranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `branchtransfers_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branchtransfers`
--

LOCK TABLES `branchtransfers` WRITE;
/*!40000 ALTER TABLE `branchtransfers` DISABLE KEYS */;
/*!40000 ALTER TABLE `branchtransfers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `browser`
--

DROP TABLE IF EXISTS `browser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `browser` (
  `level` int(11) NOT NULL,
  `classification` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `number` bigint(20) NOT NULL,
  `endnode` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `browser`
--

LOCK TABLES `browser` WRITE;
/*!40000 ALTER TABLE `browser` DISABLE KEYS */;
/*!40000 ALTER TABLE `browser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `enrolmentperiod` smallint(6) DEFAULT NULL,
  `enrolmentperioddate` date DEFAULT NULL,
  `upperagelimit` smallint(6) DEFAULT NULL,
  `dateofbirthrequired` tinyint(1) DEFAULT NULL,
  `finetype` varchar(30) DEFAULT NULL,
  `bulk` tinyint(1) DEFAULT NULL,
  `enrolmentfee` decimal(28,6) DEFAULT NULL,
  `overduenoticerequired` tinyint(1) DEFAULT NULL,
  `issuelimit` smallint(6) DEFAULT NULL,
  `reservefee` decimal(28,6) DEFAULT NULL,
  `hidelostitems` tinyint(1) NOT NULL DEFAULT '0',
  `category_type` varchar(1) NOT NULL DEFAULT 'A',
  PRIMARY KEY (`categorycode`),
  UNIQUE KEY `categorycode` (`categorycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES ('ADMIN','administrator',100,'0000-00-00',0,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'S'),('AUTO','Automat',99,'0000-00-00',0,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'A'),('BKM','Boken kommer',99,'0000-00-00',99,5,NULL,NULL,0.000000,1,NULL,0.000000,0,'P'),('HB','Hjemmelåner',99,NULL,999,18,NULL,NULL,0.000000,1,NULL,0.000000,0,'A'),('I','Institusjon',99,'0000-00-00',999,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'I'),('FJL','Fjernlån',99,NULL,999,18,NULL,NULL,0.000000,1,NULL,0.000000,0,'I'),('J','Ungdom',99,NULL,17,5,NULL,NULL,0.000000,1,NULL,0.000000,0,'C'),('B','Barn',99,NULL,17,5,NULL,NULL,0.000000,1,NULL,0.000000,0,'C'),('BHG','Barnehage',100,'0000-00-00',999,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'I'),('L','Fylkes-/folkebibliotek',99,'0000-00-00',999,18,NULL,NULL,0.000000,1,NULL,0.000000,0,'I'),('MXV','Makslån voksen',99,'0000-00-00',999,18,NULL,NULL,0.000000,0,NULL,0.000000,0,'A'),('MDL','Midlertidig bosatt',6,'0000-00-00',999,18,NULL,NULL,0.000000,0,NULL,0.000000,0,'A'),('PAS','Pasient',99,'0000-00-00',999,18,NULL,NULL,0.000000,0,NULL,0.000000,0,'A'),('V','Voksen',99,'0000-00-00',999,18,NULL,NULL,0.000000,1,NULL,0.000000,0,'A'),('S','Bibliotekansatt',99,NULL,999,18,NULL,NULL,0.000000,0,NULL,0.000000,0,'S'),('SKO','Skole',99,NULL,999,18,NULL,NULL,0.000000,1,NULL,0.000000,0,'I'),('KL','Grunnskole',99,'0000-00-00',999,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'I'),('ELE','Elevlåner',99,'0000-00-00',999,7,NULL,NULL,0.000000,1,NULL,0.000000,0,'A'),('U','Ukjent',99,'0000-00-00',999,0,NULL,NULL,0.000000,1,NULL,0.000000,0,'A'),('UE','Utgått elev',99,'0000-00-00',999,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'C'),('VGS','Videregående skole',99,'0000-00-00',999,0,NULL,NULL,0.000000,0,NULL,0.000000,0,'I');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories_branches`
--

DROP TABLE IF EXISTS `categories_branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories_branches` (
  `categorycode` varchar(10) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  KEY `categorycode` (`categorycode`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `categories_branches_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE,
  CONSTRAINT `categories_branches_ibfk_2` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories_branches`
--

LOCK TABLES `categories_branches` WRITE;
/*!40000 ALTER TABLE `categories_branches` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories_branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `cityid` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) NOT NULL DEFAULT '',
  `city_state` varchar(100) DEFAULT NULL,
  `city_country` varchar(100) DEFAULT NULL,
  `city_zipcode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`cityid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_sort_rules`
--

DROP TABLE IF EXISTS `class_sort_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_sort_rules` (
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `sort_routine` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`class_sort_rule`),
  UNIQUE KEY `class_sort_rule_idx` (`class_sort_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_sort_rules`
--

LOCK TABLES `class_sort_rules` WRITE;
/*!40000 ALTER TABLE `class_sort_rules` DISABLE KEYS */;
INSERT INTO `class_sort_rules` VALUES ('dewey','Standard sortering for DDK','Dewey'),('generic','Generelle sorteringsregler','Generic'),('lcc','Standard sortering for LCC','LCC');
/*!40000 ALTER TABLE `class_sort_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_sources`
--

DROP TABLE IF EXISTS `class_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_sources` (
  `cn_source` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `used` tinyint(4) NOT NULL DEFAULT '0',
  `class_sort_rule` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`cn_source`),
  UNIQUE KEY `cn_source_idx` (`cn_source`),
  KEY `used_idx` (`used`),
  KEY `class_source_ibfk_1` (`class_sort_rule`),
  CONSTRAINT `class_source_ibfk_1` FOREIGN KEY (`class_sort_rule`) REFERENCES `class_sort_rules` (`class_sort_rule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_sources`
--

LOCK TABLES `class_sources` WRITE;
/*!40000 ALTER TABLE `class_sources` DISABLE KEYS */;
INSERT INTO `class_sources` VALUES ('anscr','ANSCR (Lydopptak)',0,'generic'),('ddc','Dewey desimalklassifikasjon',1,'dewey'),('lcc','Library of Congress klassifikasjon',1,'lcc'),('sudocs','SuDoc klassifikasjon (U.S. GPO)',0,'generic'),('udc','Universell desimalklassifikasjon',0,'generic'),('z','Andre klassifikasjonsskjema',0,'generic');
/*!40000 ALTER TABLE `class_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections` (
  `colId` int(11) NOT NULL AUTO_INCREMENT,
  `colTitle` varchar(100) NOT NULL DEFAULT '',
  `colDesc` text NOT NULL,
  `colBranchcode` varchar(4) DEFAULT NULL COMMENT 'branchcode for branch where item should be held.',
  PRIMARY KEY (`colId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections_tracking`
--

DROP TABLE IF EXISTS `collections_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collections_tracking` (
  `ctId` int(11) NOT NULL AUTO_INCREMENT,
  `colId` int(11) NOT NULL DEFAULT '0' COMMENT 'collections.colId',
  `itemnumber` int(11) NOT NULL DEFAULT '0' COMMENT 'items.itemnumber',
  PRIMARY KEY (`ctId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections_tracking`
--

LOCK TABLES `collections_tracking` WRITE;
/*!40000 ALTER TABLE `collections_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `collections_tracking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_batches`
--

DROP TABLE IF EXISTS `creator_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_batches` (
  `label_id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(10) NOT NULL DEFAULT '1',
  `item_number` int(11) DEFAULT NULL,
  `borrower_number` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `branch_code` varchar(10) NOT NULL DEFAULT 'NB',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`label_id`),
  KEY `branch_fk_constraint` (`branch_code`),
  KEY `item_fk_constraint` (`item_number`),
  KEY `borrower_fk_constraint` (`borrower_number`),
  CONSTRAINT `creator_batches_ibfk_1` FOREIGN KEY (`borrower_number`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `creator_batches_ibfk_2` FOREIGN KEY (`branch_code`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE,
  CONSTRAINT `creator_batches_ibfk_3` FOREIGN KEY (`item_number`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_batches`
--

LOCK TABLES `creator_batches` WRITE;
/*!40000 ALTER TABLE `creator_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_images`
--

DROP TABLE IF EXISTS `creator_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_images` (
  `image_id` int(4) NOT NULL AUTO_INCREMENT,
  `imagefile` mediumblob,
  `image_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  PRIMARY KEY (`image_id`),
  UNIQUE KEY `image_name_index` (`image_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_images`
--

LOCK TABLES `creator_images` WRITE;
/*!40000 ALTER TABLE `creator_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_layouts`
--

DROP TABLE IF EXISTS `creator_layouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_layouts` (
  `layout_id` int(4) NOT NULL AUTO_INCREMENT,
  `barcode_type` char(100) NOT NULL DEFAULT 'CODE39',
  `start_label` int(2) NOT NULL DEFAULT '1',
  `printing_type` char(32) NOT NULL DEFAULT 'BAR',
  `layout_name` char(20) NOT NULL DEFAULT 'DEFAULT',
  `guidebox` int(1) DEFAULT '0',
  `font` char(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'TR',
  `font_size` int(4) NOT NULL DEFAULT '10',
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `callnum_split` int(1) DEFAULT '0',
  `text_justify` char(1) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'L',
  `format_string` varchar(210) NOT NULL DEFAULT 'barcode',
  `layout_xml` text NOT NULL,
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`layout_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_layouts`
--

LOCK TABLES `creator_layouts` WRITE;
/*!40000 ALTER TABLE `creator_layouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_layouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `creator_templates`
--

DROP TABLE IF EXISTS `creator_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creator_templates` (
  `template_id` int(4) NOT NULL AUTO_INCREMENT,
  `profile_id` int(4) DEFAULT NULL,
  `template_code` char(100) NOT NULL DEFAULT 'DEFAULT TEMPLATE',
  `template_desc` char(100) NOT NULL DEFAULT 'Default description',
  `page_width` float NOT NULL DEFAULT '0',
  `page_height` float NOT NULL DEFAULT '0',
  `label_width` float NOT NULL DEFAULT '0',
  `label_height` float NOT NULL DEFAULT '0',
  `top_text_margin` float NOT NULL DEFAULT '0',
  `left_text_margin` float NOT NULL DEFAULT '0',
  `top_margin` float NOT NULL DEFAULT '0',
  `left_margin` float NOT NULL DEFAULT '0',
  `cols` int(2) NOT NULL DEFAULT '0',
  `rows` int(2) NOT NULL DEFAULT '0',
  `col_gap` float NOT NULL DEFAULT '0',
  `row_gap` float NOT NULL DEFAULT '0',
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`template_id`),
  KEY `template_profile_fk_constraint` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `creator_templates`
--

LOCK TABLES `creator_templates` WRITE;
/*!40000 ALTER TABLE `creator_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `creator_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `currency` varchar(10) NOT NULL DEFAULT '',
  `symbol` varchar(5) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rate` float(15,5) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency`
--

LOCK TABLES `currency` WRITE;
/*!40000 ALTER TABLE `currency` DISABLE KEYS */;
INSERT INTO `currency` VALUES ('EUR','€','2013-10-17 11:11:39',7.89400,NULL),('GBP','£','2013-10-17 11:11:39',8.96800,NULL),('NOK','$','2013-10-17 11:11:39',1.00000,NULL),('USD','$','2013-10-17 11:11:39',5.61570,NULL);
/*!40000 ALTER TABLE `currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_borrower_circ_rules`
--

DROP TABLE IF EXISTS `default_borrower_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_borrower_circ_rules` (
  `categorycode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  PRIMARY KEY (`categorycode`),
  CONSTRAINT `borrower_borrower_circ_rules_ibfk_1` FOREIGN KEY (`categorycode`) REFERENCES `categories` (`categorycode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_borrower_circ_rules`
--

LOCK TABLES `default_borrower_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_borrower_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_borrower_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_branch_circ_rules`
--

DROP TABLE IF EXISTS `default_branch_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_branch_circ_rules` (
  `branchcode` varchar(10) NOT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`branchcode`),
  CONSTRAINT `default_branch_circ_rules_ibfk_1` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_branch_circ_rules`
--

LOCK TABLES `default_branch_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_branch_circ_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_branch_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_branch_item_rules`
--

DROP TABLE IF EXISTS `default_branch_item_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_branch_item_rules` (
  `itemtype` varchar(10) NOT NULL,
  `holdallowed` tinyint(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`itemtype`),
  CONSTRAINT `default_branch_item_rules_ibfk_1` FOREIGN KEY (`itemtype`) REFERENCES `itemtypes` (`itemtype`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_branch_item_rules`
--

LOCK TABLES `default_branch_item_rules` WRITE;
/*!40000 ALTER TABLE `default_branch_item_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_branch_item_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_circ_rules`
--

DROP TABLE IF EXISTS `default_circ_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_circ_rules` (
  `singleton` enum('singleton') NOT NULL DEFAULT 'singleton',
  `maxissueqty` int(4) DEFAULT NULL,
  `holdallowed` int(1) DEFAULT NULL,
  `returnbranch` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`singleton`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_circ_rules`
--

LOCK TABLES `default_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_circ_rules` DISABLE KEYS */;
INSERT INTO `default_circ_rules` VALUES ('singleton',20,2,'homebranch');
/*!40000 ALTER TABLE `default_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedbiblio`
--

DROP TABLE IF EXISTS `deletedbiblio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletedbiblio` (
  `biblionumber` int(11) NOT NULL AUTO_INCREMENT,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `author` mediumtext,
  `title` mediumtext,
  `unititle` mediumtext,
  `notes` mediumtext,
  `serial` tinyint(1) DEFAULT NULL,
  `seriestitle` mediumtext,
  `copyrightdate` smallint(6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datecreated` date NOT NULL,
  `abstract` mediumtext,
  PRIMARY KEY (`biblionumber`),
  KEY `blbnoidx` (`biblionumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedbiblio`
--

LOCK TABLES `deletedbiblio` WRITE;
/*!40000 ALTER TABLE `deletedbiblio` DISABLE KEYS */;
/*!40000 ALTER TABLE `deletedbiblio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedbiblioitems`
--

DROP TABLE IF EXISTS `deletedbiblioitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletedbiblioitems` (
  `biblioitemnumber` int(11) NOT NULL DEFAULT '0',
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `volume` mediumtext,
  `number` mediumtext,
  `itemtype` varchar(10) DEFAULT NULL,
  `isbn` varchar(30) DEFAULT NULL,
  `issn` varchar(9) DEFAULT NULL,
  `ean` varchar(13) DEFAULT NULL,
  `publicationyear` text,
  `publishercode` varchar(255) DEFAULT NULL,
  `volumedate` date DEFAULT NULL,
  `volumedesc` text,
  `collectiontitle` mediumtext,
  `collectionissn` text,
  `collectionvolume` mediumtext,
  `editionstatement` text,
  `editionresponsibility` text,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `illus` varchar(255) DEFAULT NULL,
  `pages` varchar(255) DEFAULT NULL,
  `notes` mediumtext,
  `size` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `lccn` varchar(25) DEFAULT NULL,
  `marc` longblob,
  `url` varchar(255) DEFAULT NULL,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_class` varchar(30) DEFAULT NULL,
  `cn_item` varchar(10) DEFAULT NULL,
  `cn_suffix` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `agerestriction` varchar(255) DEFAULT NULL,
  `totalissues` int(10) DEFAULT NULL,
  `marcxml` longtext NOT NULL,
  PRIMARY KEY (`biblioitemnumber`),
  KEY `bibinoidx` (`biblioitemnumber`),
  KEY `bibnoidx` (`biblionumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `isbn` (`isbn`),
  KEY `publishercode` (`publishercode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedbiblioitems`
--

LOCK TABLES `deletedbiblioitems` WRITE;
/*!40000 ALTER TABLE `deletedbiblioitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `deletedbiblioitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deletedborrowers`
--

DROP TABLE IF EXISTS `deletedborrowers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deletedborrowers` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `cardnumber` varchar(16) DEFAULT NULL,
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `title` mediumtext,
  `othernames` mediumtext,
  `initials` text,
  `streetnumber` varchar(10) DEFAULT NULL,
  `streettype` varchar(50) DEFAULT NULL,
  `address` mediumtext NOT NULL,
  `address2` text,
  `city` mediumtext NOT NULL,
  `state` text,
  `zipcode` varchar(25) DEFAULT NULL,
  `country` text,
  `email` mediumtext,
  `phone` text,
  `mobile` varchar(50) DEFAULT NULL,
  `fax` mediumtext,
  `emailpro` text,
  `phonepro` text,
  `B_streetnumber` varchar(10) DEFAULT NULL,
  `B_streettype` varchar(50) DEFAULT NULL,
  `B_address` varchar(100) DEFAULT NULL,
  `B_address2` text,
  `B_city` mediumtext,
  `B_state` text,
  `B_zipcode` varchar(25) DEFAULT NULL,
  `B_country` text,
  `B_email` text,
  `B_phone` mediumtext,
  `dateofbirth` date DEFAULT NULL,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `dateenrolled` date DEFAULT NULL,
  `dateexpiry` date DEFAULT NULL,
  `gonenoaddress` tinyint(1) DEFAULT NULL,
  `lost` tinyint(1) DEFAULT NULL,
  `debarred` date DEFAULT NULL,
  `debarredcomment` varchar(255) DEFAULT NULL,
  `contactname` mediumtext,
  `contactfirstname` text,
  `contacttitle` text,
  `guarantorid` int(11) DEFAULT NULL,
  `borrowernotes` mediumtext,
  `relationship` varchar(100) DEFAULT NULL,
  `ethnicity` varchar(50) DEFAULT NULL,
  `ethnotes` varchar(255) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `flags` int(11) DEFAULT NULL,
  `userid` varchar(30) DEFAULT NULL,
  `opacnote` mediumtext,
  `contactnote` varchar(255) DEFAULT NULL,
  `sort1` varchar(80) DEFAULT NULL,
  `sort2` varchar(80) DEFAULT NULL,
  `altcontactfirstname` varchar(255) DEFAULT NULL,
  `altcontactsurname` varchar(255) DEFAULT NULL,
  `altcontactaddress1` varchar(255) DEFAULT NULL,
  `altcontactaddress2` varchar(255) DEFAULT NULL,
  `altcontactaddress3` varchar(255) DEFAULT NULL,
  `altcontactstate` text,
  `altcontactzipcode` varchar(50) DEFAULT NULL,
  `altcontactcountry` text,
  `altcontactphone` varchar(50) DEFAULT NULL,
  `smsalertnumber` varchar(50) DEFAULT NULL,
  `privacy` int(11) NOT NULL DEFAULT '1',
  KEY `borrowernumber` (`borrowernumber`),
  KEY `cardnumber` (`cardnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deletedborrowers`
--

LOCK TABLES `deletedborrowers` WRITE;
/*!40000 ALTER TABLE `deletedborrowers` DISABLE KEYS */;
INSERT INTO `deletedborrowers` VALUES (2,'2','Söze','Keyser','','','','',NULL,'','','','','','','','','','','','',NULL,NULL,'','','','','','','','',NULL,'hutl','ADMIN','2013-10-21','2022-02-21',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,'','ve+MVeW43CW/7fZ0SwKWug',NULL,'keysersoze','Who the hell is Keyser Söze?','','','','','','','','','','','','',NULL,1);
/*!40000 ALTER TABLE `deletedborrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleteditems`
--

DROP TABLE IF EXISTS `deleteditems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleteditems` (
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) NOT NULL DEFAULT '0',
  `barcode` varchar(20) DEFAULT NULL,
  `dateaccessioned` date DEFAULT NULL,
  `booksellerid` mediumtext,
  `homebranch` varchar(10) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `replacementprice` decimal(8,2) DEFAULT NULL,
  `replacementpricedate` date DEFAULT NULL,
  `datelastborrowed` date DEFAULT NULL,
  `datelastseen` date DEFAULT NULL,
  `stack` tinyint(1) DEFAULT NULL,
  `notforloan` tinyint(1) NOT NULL DEFAULT '0',
  `damaged` tinyint(1) NOT NULL DEFAULT '0',
  `itemlost` tinyint(1) NOT NULL DEFAULT '0',
  `wthdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `itemcallnumber` varchar(255) DEFAULT NULL,
  `coded_location_qualifier` varchar(10) DEFAULT NULL,
  `issues` smallint(6) DEFAULT NULL,
  `renewals` smallint(6) DEFAULT NULL,
  `reserves` smallint(6) DEFAULT NULL,
  `restricted` tinyint(1) DEFAULT NULL,
  `itemnotes` mediumtext,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `paidfor` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` varchar(80) DEFAULT NULL,
  `permanent_location` varchar(80) DEFAULT NULL,
  `onloan` date DEFAULT NULL,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  `materials` varchar(10) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `itype` varchar(10) DEFAULT NULL,
  `more_subfields_xml` longtext,
  `enumchron` text,
  `copynumber` varchar(32) DEFAULT NULL,
  `stocknumber` varchar(32) DEFAULT NULL,
  `marc` longblob,
  PRIMARY KEY (`itemnumber`),
  KEY `delitembarcodeidx` (`barcode`),
  KEY `delitemstocknumberidx` (`stocknumber`),
  KEY `delitembinoidx` (`biblioitemnumber`),
  KEY `delitembibnoidx` (`biblionumber`),
  KEY `delhomebranch` (`homebranch`),
  KEY `delholdingbranch` (`holdingbranch`),
  KEY `itype_idx` (`itype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleteditems`
--

LOCK TABLES `deleteditems` WRITE;
/*!40000 ALTER TABLE `deleteditems` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleteditems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ethnicity`
--

DROP TABLE IF EXISTS `ethnicity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ethnicity` (
  `code` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ethnicity`
--

LOCK TABLES `ethnicity` WRITE;
/*!40000 ALTER TABLE `ethnicity` DISABLE KEYS */;
/*!40000 ALTER TABLE `ethnicity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `export_format`
--

DROP TABLE IF EXISTS `export_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `export_format` (
  `export_format_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile` varchar(255) NOT NULL,
  `description` mediumtext NOT NULL,
  `marcfields` mediumtext NOT NULL,
  `csv_separator` varchar(2) NOT NULL,
  `field_separator` varchar(2) NOT NULL,
  `subfield_separator` varchar(2) NOT NULL,
  `encoding` varchar(255) NOT NULL,
  PRIMARY KEY (`export_format_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Used for CSV export';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `export_format`
--

LOCK TABLES `export_format` WRITE;
/*!40000 ALTER TABLE `export_format` DISABLE KEYS */;
/*!40000 ALTER TABLE `export_format` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldmapping`
--

DROP TABLE IF EXISTS `fieldmapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldmapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field` varchar(255) NOT NULL,
  `frameworkcode` char(4) NOT NULL DEFAULT '',
  `fieldcode` char(3) NOT NULL,
  `subfieldcode` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldmapping`
--

LOCK TABLES `fieldmapping` WRITE;
/*!40000 ALTER TABLE `fieldmapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `fieldmapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hold_fill_targets`
--

DROP TABLE IF EXISTS `hold_fill_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hold_fill_targets` (
  `borrowernumber` int(11) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `itemnumber` int(11) NOT NULL,
  `source_branchcode` varchar(10) DEFAULT NULL,
  `item_level_request` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemnumber`),
  KEY `bib_branch` (`biblionumber`,`source_branchcode`),
  KEY `hold_fill_targets_ibfk_1` (`borrowernumber`),
  KEY `hold_fill_targets_ibfk_4` (`source_branchcode`),
  CONSTRAINT `hold_fill_targets_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hold_fill_targets_ibfk_4` FOREIGN KEY (`source_branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hold_fill_targets`
--

LOCK TABLES `hold_fill_targets` WRITE;
/*!40000 ALTER TABLE `hold_fill_targets` DISABLE KEYS */;
/*!40000 ALTER TABLE `hold_fill_targets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_auths`
--

DROP TABLE IF EXISTS `import_auths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_auths` (
  `import_record_id` int(11) NOT NULL,
  `matched_authid` int(11) DEFAULT NULL,
  `control_number` varchar(25) DEFAULT NULL,
  `authorized_heading` varchar(128) DEFAULT NULL,
  `original_source` varchar(25) DEFAULT NULL,
  KEY `import_auths_ibfk_1` (`import_record_id`),
  KEY `matched_authid` (`matched_authid`),
  CONSTRAINT `import_auths_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_auths`
--

LOCK TABLES `import_auths` WRITE;
/*!40000 ALTER TABLE `import_auths` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_auths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_batches`
--

DROP TABLE IF EXISTS `import_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_batches` (
  `import_batch_id` int(11) NOT NULL AUTO_INCREMENT,
  `matcher_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `num_records` int(11) NOT NULL DEFAULT '0',
  `num_items` int(11) NOT NULL DEFAULT '0',
  `upload_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `overlay_action` enum('replace','create_new','use_template','ignore') NOT NULL DEFAULT 'create_new',
  `nomatch_action` enum('create_new','ignore') NOT NULL DEFAULT 'create_new',
  `item_action` enum('always_add','add_only_for_matches','add_only_for_new','ignore') NOT NULL DEFAULT 'always_add',
  `import_status` enum('staging','staged','importing','imported','reverting','reverted','cleaned') NOT NULL DEFAULT 'staging',
  `batch_type` enum('batch','z3950','webservice') NOT NULL DEFAULT 'batch',
  `record_type` enum('biblio','auth','holdings') NOT NULL DEFAULT 'biblio',
  `file_name` varchar(100) DEFAULT NULL,
  `comments` mediumtext,
  PRIMARY KEY (`import_batch_id`),
  KEY `branchcode` (`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_batches`
--

LOCK TABLES `import_batches` WRITE;
/*!40000 ALTER TABLE `import_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_biblios`
--

DROP TABLE IF EXISTS `import_biblios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_biblios` (
  `import_record_id` int(11) NOT NULL,
  `matched_biblionumber` int(11) DEFAULT NULL,
  `control_number` varchar(25) DEFAULT NULL,
  `original_source` varchar(25) DEFAULT NULL,
  `title` varchar(128) DEFAULT NULL,
  `author` varchar(80) DEFAULT NULL,
  `isbn` varchar(30) DEFAULT NULL,
  `issn` varchar(9) DEFAULT NULL,
  `has_items` tinyint(1) NOT NULL DEFAULT '0',
  KEY `import_biblios_ibfk_1` (`import_record_id`),
  KEY `matched_biblionumber` (`matched_biblionumber`),
  KEY `title` (`title`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `import_biblios_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_biblios`
--

LOCK TABLES `import_biblios` WRITE;
/*!40000 ALTER TABLE `import_biblios` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_biblios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_items`
--

DROP TABLE IF EXISTS `import_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_items` (
  `import_items_id` int(11) NOT NULL AUTO_INCREMENT,
  `import_record_id` int(11) NOT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `status` enum('error','staged','imported','reverted','ignored') NOT NULL DEFAULT 'staged',
  `marcxml` longtext NOT NULL,
  `import_error` mediumtext,
  PRIMARY KEY (`import_items_id`),
  KEY `import_items_ibfk_1` (`import_record_id`),
  KEY `itemnumber` (`itemnumber`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `import_items_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_items`
--

LOCK TABLES `import_items` WRITE;
/*!40000 ALTER TABLE `import_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_record_matches`
--

DROP TABLE IF EXISTS `import_record_matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_record_matches` (
  `import_record_id` int(11) NOT NULL,
  `candidate_match_id` int(11) NOT NULL,
  `score` int(11) NOT NULL DEFAULT '0',
  KEY `record_score` (`import_record_id`,`score`),
  CONSTRAINT `import_record_matches_ibfk_1` FOREIGN KEY (`import_record_id`) REFERENCES `import_records` (`import_record_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_record_matches`
--

LOCK TABLES `import_record_matches` WRITE;
/*!40000 ALTER TABLE `import_record_matches` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_record_matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_records`
--

DROP TABLE IF EXISTS `import_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `import_records` (
  `import_record_id` int(11) NOT NULL AUTO_INCREMENT,
  `import_batch_id` int(11) NOT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `record_sequence` int(11) NOT NULL DEFAULT '0',
  `upload_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `import_date` date DEFAULT NULL,
  `marc` longblob NOT NULL,
  `marcxml` longtext NOT NULL,
  `marcxml_old` longtext NOT NULL,
  `record_type` enum('biblio','auth','holdings') NOT NULL DEFAULT 'biblio',
  `overlay_status` enum('no_match','auto_match','manual_match','match_applied') NOT NULL DEFAULT 'no_match',
  `status` enum('error','staged','imported','reverted','items_reverted','ignored') NOT NULL DEFAULT 'staged',
  `import_error` mediumtext,
  `encoding` varchar(40) NOT NULL DEFAULT '',
  `z3950random` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`import_record_id`),
  KEY `branchcode` (`branchcode`),
  KEY `batch_sequence` (`import_batch_id`,`record_sequence`),
  KEY `batch_id_record_type` (`import_batch_id`,`record_type`),
  CONSTRAINT `import_records_ifbk_1` FOREIGN KEY (`import_batch_id`) REFERENCES `import_batches` (`import_batch_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_records`
--

LOCK TABLES `import_records` WRITE;
/*!40000 ALTER TABLE `import_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issues` (
  `borrowernumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `issuingbranch` varchar(18) DEFAULT NULL,
  `returndate` datetime DEFAULT NULL,
  `lastreneweddate` datetime DEFAULT NULL,
  `return` varchar(4) DEFAULT NULL,
  `renewals` tinyint(4) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  KEY `issuesborridx` (`borrowernumber`),
  KEY `itemnumber_idx` (`itemnumber`),
  KEY `branchcode_idx` (`branchcode`),
  KEY `issuingbranch_idx` (`issuingbranch`),
  KEY `bordate` (`borrowernumber`,`timestamp`),
  CONSTRAINT `issues_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON UPDATE CASCADE,
  CONSTRAINT `issues_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issuingrules`
--

DROP TABLE IF EXISTS `issuingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issuingrules` (
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `restrictedtype` tinyint(1) DEFAULT NULL,
  `rentaldiscount` decimal(28,6) DEFAULT NULL,
  `reservecharge` decimal(28,6) DEFAULT NULL,
  `fine` decimal(28,6) DEFAULT NULL,
  `finedays` int(11) DEFAULT NULL,
  `firstremind` int(11) DEFAULT NULL,
  `chargeperiod` int(11) DEFAULT NULL,
  `accountsent` int(11) DEFAULT NULL,
  `chargename` varchar(100) DEFAULT NULL,
  `maxissueqty` int(4) DEFAULT NULL,
  `issuelength` int(4) DEFAULT NULL,
  `lengthunit` varchar(10) DEFAULT 'days',
  `hardduedate` date DEFAULT NULL,
  `hardduedatecompare` tinyint(4) NOT NULL DEFAULT '0',
  `renewalsallowed` smallint(6) NOT NULL DEFAULT '0',
  `renewalperiod` int(4) DEFAULT NULL,
  `reservesallowed` smallint(6) NOT NULL DEFAULT '0',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `overduefinescap` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`branchcode`,`categorycode`,`itemtype`),
  KEY `categorycode` (`categorycode`),
  KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issuingrules`
--

LOCK TABLES `issuingrules` WRITE;
/*!40000 ALTER TABLE `issuingrules` DISABLE KEYS */;
INSERT INTO `issuingrules` VALUES ('*','*',NULL,0.000000,NULL,0.000000,0,7,14,NULL,NULL,20,28,'days',NULL,-1,2,14,20,'*',NULL),('*','A',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','C',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','DB,DG',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),('*','DB,DH',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','DB,DI',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','DC,DG',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),('*','DC,DH',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','DC,DI',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','ED',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,7,'days',NULL,-1,3,7,20,'*',NULL),('*','ED,DG',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),('*','ED,DH',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','ED,TF',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','EE',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,7,'days',NULL,-1,3,7,20,'*',NULL),('*','EE,DG',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),('*','EE,DH',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','EE,DI',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','EE,TF',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','EF',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,7,'days',NULL,-1,3,7,20,'*',NULL),('*','GC',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','GD',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','GG',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),('*','J',NULL,0.000000,NULL,0.000000,0,0,21,NULL,NULL,NULL,14,'days',NULL,-1,2,14,0,'*',NULL),('BKM','*',NULL,0.000000,NULL,50.000000,0,14,14,NULL,NULL,NULL,60,'days',NULL,-1,3,28,20,'*',100.000000),('I','*',NULL,0.000000,NULL,0.000000,0,7,14,NULL,NULL,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),('FJL','*',NULL,0.000000,NULL,0.000000,0,7,14,NULL,NULL,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),('B','*',NULL,0.000000,NULL,20.000000,0,7,14,NULL,NULL,20,28,'days',NULL,-1,2,28,20,'*',20.000000),('BHG','*',NULL,0.000000,NULL,0.000000,0,0,14,NULL,NULL,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),('L','*',NULL,0.000000,NULL,0.000000,0,0,14,NULL,NULL,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),('MXV','*',NULL,0.000000,NULL,50.000000,0,7,14,NULL,NULL,30,28,'days',NULL,-1,2,28,20,'*',100.000000),('MDL','*',NULL,0.000000,NULL,50.000000,0,7,14,NULL,NULL,2,28,'days',NULL,-1,2,28,20,'*',100.000000),('PAS','*',NULL,0.000000,NULL,0.000000,0,7,14,NULL,NULL,20,28,'days',NULL,-1,2,28,20,'*',NULL),('V','*',NULL,0.000000,NULL,50.000000,0,7,14,NULL,NULL,20,28,'days',NULL,-1,2,28,20,'*',100.000000),('SKO','*',NULL,0.000000,NULL,0.000000,0,7,14,NULL,NULL,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),('KL','*',NULL,0.000000,NULL,0.000000,0,7,28,NULL,NULL,NULL,60,'days',NULL,-1,8,30,20,'*',NULL),('ELE','*',NULL,0.000000,NULL,0.000000,0,14,14,NULL,NULL,NULL,28,'days',NULL,-1,3,10,20,'*',NULL),('U','*',NULL,0.000000,NULL,50.000000,0,7,14,NULL,NULL,NULL,28,'days',NULL,-1,2,28,20,'*',100.000000),('UE','*',NULL,0.000000,NULL,0.000000,0,14,14,NULL,NULL,NULL,28,'days',NULL,-1,2,10,20,'*',NULL),('VGS','*',NULL,0.000000,NULL,0.000000,0,0,14,NULL,NULL,NULL,42,'days',NULL,-1,2,28,20,'*',NULL);
/*!40000 ALTER TABLE `issuingrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_circulation_alert_preferences`
--

DROP TABLE IF EXISTS `item_circulation_alert_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_circulation_alert_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL,
  `categorycode` varchar(10) NOT NULL,
  `item_type` varchar(10) NOT NULL,
  `notification` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branchcode` (`branchcode`,`categorycode`,`item_type`,`notification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_circulation_alert_preferences`
--

LOCK TABLES `item_circulation_alert_preferences` WRITE;
/*!40000 ALTER TABLE `item_circulation_alert_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `item_circulation_alert_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemnumber` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) NOT NULL DEFAULT '0',
  `barcode` varchar(20) DEFAULT NULL,
  `dateaccessioned` date DEFAULT NULL,
  `booksellerid` mediumtext,
  `homebranch` varchar(10) DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `replacementprice` decimal(8,2) DEFAULT NULL,
  `replacementpricedate` date DEFAULT NULL,
  `datelastborrowed` date DEFAULT NULL,
  `datelastseen` date DEFAULT NULL,
  `stack` tinyint(1) DEFAULT NULL,
  `notforloan` tinyint(1) NOT NULL DEFAULT '0',
  `damaged` tinyint(1) NOT NULL DEFAULT '0',
  `itemlost` tinyint(1) NOT NULL DEFAULT '0',
  `wthdrawn` tinyint(1) NOT NULL DEFAULT '0',
  `itemcallnumber` varchar(255) DEFAULT NULL,
  `coded_location_qualifier` varchar(10) DEFAULT NULL,
  `issues` smallint(6) DEFAULT NULL,
  `renewals` smallint(6) DEFAULT NULL,
  `reserves` smallint(6) DEFAULT NULL,
  `restricted` tinyint(1) DEFAULT NULL,
  `itemnotes` mediumtext,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `paidfor` mediumtext,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` varchar(80) DEFAULT NULL,
  `permanent_location` varchar(80) DEFAULT NULL,
  `onloan` date DEFAULT NULL,
  `cn_source` varchar(10) DEFAULT NULL,
  `cn_sort` varchar(30) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  `materials` text,
  `uri` varchar(255) DEFAULT NULL,
  `itype` varchar(10) DEFAULT NULL,
  `more_subfields_xml` longtext,
  `enumchron` text,
  `copynumber` varchar(32) DEFAULT NULL,
  `stocknumber` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`itemnumber`),
  UNIQUE KEY `itembarcodeidx` (`barcode`),
  KEY `itemstocknumberidx` (`stocknumber`),
  KEY `itembinoidx` (`biblioitemnumber`),
  KEY `itembibnoidx` (`biblionumber`),
  KEY `homebranch` (`homebranch`),
  KEY `holdingbranch` (`holdingbranch`),
  KEY `itemcallnumber` (`itemcallnumber`),
  KEY `items_location` (`location`),
  KEY `items_ccode` (`ccode`),
  KEY `itype_idx` (`itype`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`biblioitemnumber`) REFERENCES `biblioitems` (`biblioitemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `items_ibfk_2` FOREIGN KEY (`homebranch`) REFERENCES `branches` (`branchcode`) ON UPDATE CASCADE,
  CONSTRAINT `items_ibfk_3` FOREIGN KEY (`holdingbranch`) REFERENCES `branches` (`branchcode`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3967925 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemtypes`
--

DROP TABLE IF EXISTS `itemtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemtypes` (
  `itemtype` varchar(10) NOT NULL DEFAULT '',
  `description` mediumtext,
  `rentalcharge` double(16,4) DEFAULT NULL,
  `notforloan` smallint(6) DEFAULT NULL,
  `imageurl` varchar(200) DEFAULT NULL,
  `summary` text,
  `checkinmsg` varchar(255) DEFAULT NULL,
  `checkinmsgtype` char(16) NOT NULL DEFAULT 'message',
  PRIMARY KEY (`itemtype`),
  UNIQUE KEY `itemtype` (`itemtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemtypes`
--

LOCK TABLES `itemtypes` WRITE;
/*!40000 ALTER TABLE `itemtypes` DISABLE KEYS */;
INSERT INTO `itemtypes` VALUES ('A','Kart',NULL,NULL,NULL,NULL,NULL,'message'),('AB','Atlas',NULL,NULL,NULL,NULL,NULL,'message'),('B','Manuskripter',NULL,NULL,NULL,NULL,NULL,'message'),('C','Noter',0.0000,0,'bridge/score.gif','','','message'),('DA','Lydopptak - grammofonplate',NULL,NULL,NULL,NULL,NULL,'message'),('DA,DG','Lydopptak - grammofonplate - musikk',NULL,NULL,NULL,NULL,NULL,'message'),('DA,DH','Lydopptak - grammofonplate - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),('DA,DI','Lydopptak - grammofonplate - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DA,DJ','Lydopptak - grammofonplate - annet',NULL,NULL,NULL,NULL,NULL,'message'),('DB','Lydopptak - kassett',NULL,NULL,NULL,NULL,NULL,'message'),('DB,DG','Lydopptak - kassett - musikk',NULL,NULL,NULL,NULL,NULL,'message'),('DB,DH','Lydopptak - kassett - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),('DB,DI','Lydopptak - kassett - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DB,DJ','Lydopptak - kassett - annet',NULL,NULL,NULL,NULL,NULL,'message'),('DC','Lydopptak - kompaktplate',NULL,NULL,NULL,NULL,NULL,'message'),('DC,DG','Lydopptak - kompaktplate - musikk',NULL,NULL,NULL,NULL,NULL,'message'),('DC,DH','Lydopptak - kompaktplate - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),('DC,DI','Lydopptak - kompaktplate - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DC,DI,DZ','Lydopptak - kompaktplate MP3 - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DC,DJ','Lydopptak - kompaktplate - annet',NULL,NULL,NULL,NULL,NULL,'message'),('DD','Lydopptak - digibok',NULL,NULL,NULL,NULL,NULL,'message'),('DD,DI','Lydopptak - digibok - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DE,DI','Lydopptak - digikort - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DG','Lydopptak - musikk',NULL,NULL,NULL,NULL,NULL,'message'),('DH','Lydopptak - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),('DI','Lydopptak - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),('DJ','Lydopptak - annen tale, annet',NULL,NULL,NULL,NULL,NULL,'message'),('DK','Kombidokument',NULL,NULL,NULL,NULL,NULL,'message'),('DZ','Lydopptak - mp3',NULL,NULL,NULL,NULL,NULL,'message'),('EA','Film og video - filmkassett',NULL,NULL,NULL,NULL,NULL,'message'),('EB','Film og video - filmsløyfe',NULL,NULL,NULL,NULL,NULL,'message'),('EC','Film og video - filmspole',NULL,NULL,NULL,NULL,NULL,'message'),('ED','Film og video - videokassett',NULL,NULL,NULL,NULL,NULL,'message'),('ED,DG','Musikk-video',0.0000,0,NULL,'','','message'),('ED,DH','Film og video - videokassett - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),('ED,TF','Film og video - videokassett - for døve',NULL,NULL,NULL,NULL,NULL,'message'),('EE','Film og video - videoplate DVD',0.0000,0,'','','','message'),('EE,DG','Film- og video - Videoplate DVD - musikk',0.0000,0,NULL,'','','message'),('EE,DH','Film- og video - Videoplate DVD - språkkurs',0.0000,0,NULL,'','','message'),('EE,DI','Film- og video - Videoplate DVD - lydbok',0.0000,0,NULL,'','','message'),('EE,TF','Film og video - videoplate DVD - for døve',0.0000,0,'','','','message'),('EF','Film og video - blu-ray',NULL,NULL,NULL,NULL,NULL,'message'),('EG','Film og video - 3D blu-ray',NULL,NULL,NULL,NULL,NULL,'message'),('FA','Grafisk materiale - bilde',NULL,NULL,NULL,NULL,NULL,'message'),('FB','Grafisk materiale - bildebånd',NULL,NULL,NULL,NULL,NULL,'message'),('FC','Grafisk materiale - bildekort',NULL,NULL,NULL,NULL,NULL,'message'),('FD','Grafisk materiale - dias',NULL,NULL,NULL,NULL,NULL,'message'),('FE','Grafisk materiale - flippover-blokk',NULL,NULL,NULL,NULL,NULL,'message'),('FF','Grafisk materiale - fotografi',NULL,NULL,NULL,NULL,NULL,'message'),('FG','Grafisk materiale - grafisk blad',NULL,NULL,NULL,NULL,NULL,'message'),('FH','Grafisk materiale - hologram',NULL,NULL,NULL,NULL,NULL,'message'),('FI','Grafisk materiale - kunstreproduksjon',NULL,NULL,NULL,NULL,NULL,'message'),('FJ','Grafisk materiale - ordkort',NULL,NULL,NULL,NULL,NULL,'message'),('FK','Grafisk materiale - originalt kunstverk',NULL,NULL,NULL,NULL,NULL,'message'),('FL','Grafisk materiale - plakat',NULL,NULL,NULL,NULL,NULL,'message'),('FM','Grafisk materiale - plansje',NULL,NULL,NULL,NULL,NULL,'message'),('FN','Grafisk materiale - postkort',NULL,NULL,NULL,NULL,NULL,'message'),('FO','Grafisk materiale - røntgenbilde',NULL,NULL,NULL,NULL,NULL,'message'),('FP','Grafisk materiale - stereobilde',NULL,NULL,NULL,NULL,NULL,'message'),('FQ','Grafisk materiale - studieplansje',NULL,NULL,NULL,NULL,NULL,'message'),('FR','Grafisk materiale - symbolkort',NULL,NULL,NULL,NULL,NULL,'message'),('FS','Grafisk materiale - teknisk tegning',NULL,NULL,NULL,NULL,NULL,'message'),('FT','Grafisk materiale - transparent',NULL,NULL,NULL,NULL,NULL,'message'),('G','Elektroniske ressurser',NULL,NULL,NULL,NULL,NULL,'message'),('GA','Nedlastbar fil',NULL,NULL,NULL,NULL,NULL,'message'),('GA,DZ,DG','Nedlastbar musikk, MP3',NULL,NULL,NULL,NULL,NULL,'message'),('GA,NA','Nedlastbar e-bok, PDF',NULL,NULL,NULL,NULL,NULL,'message'),('GB','Elektroniske ressurser - diskett',NULL,NULL,NULL,NULL,NULL,'message'),('GC','Elektroniske ressurser - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GC,MA','Dataspill - PC - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GC,MB','Dataspill - Playstation2 - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GC,MI','Dataspill - Xbox - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GC,MJ','Dataspill - Xbox 360 - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GD','Elektroniske ressurser - CD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GD,MA','Dataspill - PC - CD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GE','Elektroniske ressurser - Nettressurs',NULL,NULL,NULL,NULL,NULL,'message'),('GF','Elektroniske ressurser - Lagringsbrikke',NULL,NULL,NULL,NULL,NULL,'message'),('GF,MN','Elektroniske ressurser - Lagringsbrikke - Nintendo DS',NULL,NULL,NULL,NULL,NULL,'message'),('GG','Elektroniske ressurser - Blue-ray-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GG,MC','Dataspill - Playstation 3 - Blu-ray-ROM',NULL,NULL,NULL,NULL,NULL,'message'),('GH','Elektroniske ressurser - UMD',NULL,NULL,NULL,NULL,NULL,'message'),('GH,MD','Dataspill - Playstation Portable - UMD',NULL,NULL,NULL,NULL,NULL,'message'),('GI,MO','Dataspill - Wii-plate',NULL,NULL,NULL,NULL,NULL,'message'),('GT','Elektroniske ressurser - DTBok',NULL,NULL,NULL,NULL,NULL,'message'),('H','Tredimensjonal gjenstander',NULL,NULL,NULL,NULL,NULL,'message'),('IA','Mikroformer - mikrofilmkassett',NULL,NULL,NULL,NULL,NULL,'message'),('IB','Mikroformer - mikrofilmspole',NULL,NULL,NULL,NULL,NULL,'message'),('IC','Mikroformer - mikrofilmkort',NULL,NULL,NULL,NULL,NULL,'message'),('ID','Mikroformer - mikro-opak',NULL,NULL,NULL,NULL,NULL,'message'),('IE','Mikroformer - vinduskassettt',NULL,NULL,NULL,NULL,NULL,'message'),('J','Periodika',NULL,NULL,NULL,NULL,NULL,'message'),('K','Artikler (i periodika eller bøker)',NULL,NULL,NULL,NULL,NULL,'message'),('L','Bok',NULL,NULL,NULL,NULL,NULL,'message'),('LA','E-bok',NULL,NULL,NULL,NULL,NULL,'message'),('MA','Dataspill - PC',NULL,NULL,NULL,NULL,NULL,'message'),('MB','Dataspill - Playstation 2',NULL,NULL,NULL,NULL,NULL,'message'),('MC','Dataspill - Playstation 3',NULL,NULL,NULL,NULL,NULL,'message'),('MD','Dataspill - Playstation portable',NULL,NULL,NULL,NULL,NULL,'message'),('MI','Dataspill - Xbox',NULL,NULL,NULL,NULL,NULL,'message'),('MJ','Dataspill - Xbox 360',NULL,NULL,NULL,NULL,NULL,'message'),('MN','Dataspill - Nintendo DS',NULL,NULL,NULL,NULL,NULL,'message'),('MO','Dataspill - Nintendo Wii',NULL,NULL,NULL,NULL,NULL,'message'),('NA','PDF',NULL,NULL,NULL,NULL,NULL,'message'),('NB','EPUB',NULL,NULL,NULL,NULL,NULL,'message'),('NL','WMA',NULL,NULL,NULL,NULL,NULL,'message'),('NS','WMV',NULL,NULL,NULL,NULL,NULL,'message'),('O','DRM',NULL,NULL,NULL,NULL,NULL,'message'),('SM','Utkånstidskrift',NULL,NULL,NULL,NULL,NULL,'message'),('VO','Vertikalordner',NULL,NULL,NULL,NULL,NULL,'message');
/*!40000 ALTER TABLE `itemtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_descriptions`
--

DROP TABLE IF EXISTS `language_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_descriptions` (
  `subtag` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `lang` varchar(25) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `lang` (`lang`),
  KEY `subtag_type_lang` (`subtag`,`type`,`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_descriptions`
--

LOCK TABLES `language_descriptions` WRITE;
/*!40000 ALTER TABLE `language_descriptions` DISABLE KEYS */;
INSERT INTO `language_descriptions` VALUES ('opac','i','en','OPAC',1),('opac','i','fr','OPAC',2),('intranet','i','en','Staff Client',3),('intranet','i','fr','????',4),('prog','t','en','Prog',5),('prog','t','fr','Prog',6),('ar','language','ar','&#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577;',7),('ar','language','en','Arabic',8),('ar','language','fr','Arabe',9),('hy','language','hy','&#1344;&#1377;&#1397;&#1381;&#1408;&#1383;&#1398;',10),('hy','language','en','Armenian',11),('hy','language','fr','Armenian',12),('bg','language','bg','&#1041;&#1098;&#1083;&#1075;&#1072;&#1088;&#1089;&#1082;&#1080;',13),('bg','language','en','Bulgarian',14),('bg','language','fr','Bulgare',15),('zh','language','zh','&#20013;&#25991;',16),('zh','language','en','Chinese',17),('zh','language','fr','Chinois',18),('cs','language','cs','&#x010D;e&#353;tina',19),('cs','language','en','Czech',20),('cs','language','fr','Tchèque',21),('da','language','da','Dansk',22),('da','language','en','Danish',23),('da','language','fr','Danois',24),('nl','language','nl','Nederlands',25),('nl','language','en','Dutch',26),('nl','language','fr','Néerlandais',27),('en','language','en','English',28),('en','language','fr','Anglais',29),('fi','language','fi','suomi',30),('fi','language','en','Finnish',31),('fr','language','en','French',32),('fr','language','fr','Fran&ccedil;ais',33),('lo','language','lo','&#3742;&#3762;&#3754;&#3762;&#3749;&#3762;&#3751;',34),('lo','language','en','Lao',35),('de','language','de','Deutsch',36),('de','language','en','German',37),('de','language','fr','Allemand',38),('el','language','el','&#949;&#955;&#955;&#951;&#957;&#953;&#954;&#940;',39),('el','language','en','Greek, Modern [1453- ]',40),('el','language','fr','Grec Moderne (Après 1453)',41),('he','language','he','&#1506;&#1489;&#1512;&#1497;&#1514;',42),('he','language','en','Hebrew',43),('he','language','fr','Hébreu',44),('hi','language','hi','&#2361;&#2367;&#2344;&#2381;&#2342;&#2368;',45),('hi','language','en','Hindi',46),('hi','language','fr','Hindi',47),('hu','language','hu','Magyar',48),('hu','language','en','Hungarian',49),('hu','language','fr','Hongrois',50),('id','language','id','Bahasa Indonesia',51),('id','language','en','Indonesian',52),('id','language','fr','Indonésien',53),('it','language','it','Italiano',54),('it','language','en','Italian',55),('it','language','fr','Italien',56),('ja','language','ja','&#26085;&#26412;&#35486;',57),('ja','language','en','Japanese',58),('ja','language','fr','Japonais',59),('ko','language','ko','&#54620;&#44397;&#50612;',60),('ko','language','en','Korean',61),('ko','language','fr','Coréen',62),('la','language','la','Latina',63),('la','language','en','Latin',64),('la','language','fr','Latin',65),('gl','language','gl','Galego',66),('gl','language','en','Galician',67),('nb','language','nb','Norsk bokm&#229;l',68),('nb','language','en','Norwegian bokm&#229;l',69),('nb','language','fr','Norvégien bokm&#229;l',70),('nn','language','nb','Norsk nynorsk',71),('nn','language','nn','Norsk nynorsk',72),('nn','language','en','Norwegian nynorsk',73),('nn','language','fr','Norvégien nynorsk',74),('fa','language','fa','&#1601;&#1575;&#1585;&#1587;&#1609;',75),('fa','language','en','Persian',76),('fa','language','fr','Persan',77),('pl','language','pl','Polski',78),('pl','language','en','Polish',79),('pl','language','fr','Polonais',80),('pt','language','pt','Portugu&ecirc;s',81),('pt','language','en','Portuguese',82),('pt','language','fr','Portugais',83),('ro','language','ro','Rom&acirc;n&#259;',84),('ro','language','en','Romanian',85),('ro','language','fr','Roumain',86),('ru','language','ru','&#1056;&#1091;&#1089;&#1089;&#1082;&#1080;&#1081;',87),('ru','language','en','Russian',88),('ru','language','fr','Russe',89),('sr','language','sr','&#1089;&#1088;&#1087;&#1089;&#1082;&#1080;',90),('sr','language','en','Serbian',91),('es','language','es','Espa&ntilde;ol',92),('es','language','en','Spanish',93),('es','language','fr','Espagnol',94),('ca','language','es','Catalán',95),('ca','language','en','Catalan',96),('ca','language','fr','Catalan',97),('ca','language','ca','Català',98),('ca','language','de','Katalanisch',99),('sv','language','sv','Svenska',100),('sv','language','en','Swedish',101),('sv','language','fr','Suédois',102),('tet','language','tet','tetun',103),('tet','language','en','Tetum',104),('th','language','th','&#3616;&#3634;&#3625;&#3634;&#3652;&#3607;&#3618;',105),('th','language','en','Thai',106),('th','language','fr','Thaï',107),('tr','language','tr','T&uuml;rk&ccedil;e',108),('tr','language','en','Turkish',109),('tr','language','fr','Turc',110),('uk','language','uk','&#1059;&#1082;&#1088;&#1072;&#1111;&#1085;&#1089;&#1100;&#1082;&#1072;',111),('uk','language','en','Ukranian',112),('uk','language','fr','Ukrainien',113),('ur','language','en','Urdu',114),('ur','language','ur','&#1575;&#1585;&#1583;&#1608;',115),('Arab','script','Arab','&#1575;&#1604;&#1593;&#1585;&#1576;&#1610;&#1577;',116),('Arab','script','en','Arabic',117),('Arab','script','fr','Arabic',118),('Cyrl','script','Cyrl','????',119),('Cyrl','script','en','Cyrillic',120),('Cyrl','script','fr','Cyrillic',121),('Grek','script','Grek','????',122),('Grek','script','en','Greek',123),('Grek','script','fr','Greek',124),('Hans','script','Hans','Han (Simplified variant)',125),('Hans','script','en','Han (Simplified variant)',126),('Hans','script','fr','Han (Simplified variant)',127),('Hant','script','Hant','Han (Traditional variant)',128),('Hant','script','en','Han (Traditional variant)',129),('Hebr','script','Hebr','Hebrew',130),('Hebr','script','en','Hebrew',131),('Laoo','script','lo','Lao',132),('Laoo','script','en','Lao',133),('CA','region','en','Canada',134),('DK','region','dk','Danmark',135),('FR','region','fr','France',136),('FR','region','en','France',137),('NZ','region','en','New Zealand',138),('GB','region','en','United Kingdom',139),('US','region','en','United States',140);
/*!40000 ALTER TABLE `language_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_rfc4646_to_iso639`
--

DROP TABLE IF EXISTS `language_rfc4646_to_iso639`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_rfc4646_to_iso639` (
  `rfc4646_subtag` varchar(25) DEFAULT NULL,
  `iso639_2_code` varchar(25) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `rfc4646_subtag` (`rfc4646_subtag`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_rfc4646_to_iso639`
--

LOCK TABLES `language_rfc4646_to_iso639` WRITE;
/*!40000 ALTER TABLE `language_rfc4646_to_iso639` DISABLE KEYS */;
INSERT INTO `language_rfc4646_to_iso639` VALUES ('ar','ara',1),('hy','arm',2),('bg','bul',3),('zh','chi',4),('cs','cze',5),('da','dan',6),('nl','dut',7),('en','eng',8),('fi','fin',9),('fr','fre',10),('lo','lao',11),('de','ger',12),('el','gre',13),('he','heb',14),('hi','hin',15),('hu','hun',16),('id','ind',17),('it','ita',18),('ja','jpn',19),('ko','kor',20),('la','lat',21),('gl','glg',22),('nb','nor',23),('nb','nob',24),('nn','nno',25),('fa','per',26),('pl','pol',27),('pt','por',28),('ro','rum',29),('ru','rus',30),('sr','srp',31),('es','spa',32),('ca','cat',33),('sv','swe',34),('tet','tet',35),('th','tha',36),('tr','tur',37),('uk','ukr',38),('ur','urd',39);
/*!40000 ALTER TABLE `language_rfc4646_to_iso639` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_script_bidi`
--

DROP TABLE IF EXISTS `language_script_bidi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_script_bidi` (
  `rfc4646_subtag` varchar(25) DEFAULT NULL,
  `bidi` varchar(3) DEFAULT NULL,
  KEY `rfc4646_subtag` (`rfc4646_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_script_bidi`
--

LOCK TABLES `language_script_bidi` WRITE;
/*!40000 ALTER TABLE `language_script_bidi` DISABLE KEYS */;
INSERT INTO `language_script_bidi` VALUES ('Arab','rtl'),('Hebr','rtl');
/*!40000 ALTER TABLE `language_script_bidi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_script_mapping`
--

DROP TABLE IF EXISTS `language_script_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_script_mapping` (
  `language_subtag` varchar(25) DEFAULT NULL,
  `script_subtag` varchar(25) DEFAULT NULL,
  KEY `language_subtag` (`language_subtag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_script_mapping`
--

LOCK TABLES `language_script_mapping` WRITE;
/*!40000 ALTER TABLE `language_script_mapping` DISABLE KEYS */;
INSERT INTO `language_script_mapping` VALUES ('ar','Arab'),('he','Hebr');
/*!40000 ALTER TABLE `language_script_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_subtag_registry`
--

DROP TABLE IF EXISTS `language_subtag_registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_subtag_registry` (
  `subtag` varchar(25) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `description` varchar(25) DEFAULT NULL,
  `added` date DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `subtag` (`subtag`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_subtag_registry`
--

LOCK TABLES `language_subtag_registry` WRITE;
/*!40000 ALTER TABLE `language_subtag_registry` DISABLE KEYS */;
INSERT INTO `language_subtag_registry` VALUES ('opac','i','OPAC','2005-10-16',1),('intranet','i','Staff Client','2005-10-16',2),('prog','t','Prog','2005-10-16',3),('ar','language','Arabic','2005-10-16',4),('hy','language','Armenian','2005-10-16',5),('bg','language','Bulgarian','2005-10-16',6),('zh','language','Chinese','2005-10-16',7),('cs','language','Czech','2005-10-16',8),('da','language','Danish','2005-10-16',9),('nl','language','Dutch','2005-10-16',10),('en','language','English','2005-10-16',11),('fi','language','Finnish','2005-10-16',12),('fr','language','French','2005-10-16',13),('lo','language','Lao','2005-10-16',14),('de','language','German','2005-10-16',15),('el','language','Greek, Modern [1453- ]','2005-10-16',16),('he','language','Hebrew','2005-10-16',17),('hi','language','Hindi','2005-10-16',18),('hu','language','Hungarian','2005-10-16',19),('id','language','Indonesian','2005-10-16',20),('it','language','Italian','2005-10-16',21),('ja','language','Japanese','2005-10-16',22),('ko','language','Korean','2005-10-16',23),('la','language','Latin','2005-10-16',24),('gl','language','Galician','2005-10-16',25),('nb','language','Norwegian bokm&#229;l','2005-10-16',26),('nn','language','Norwegian nynorsk','2011-02-14',27),('fa','language','Persian','2005-10-16',28),('pl','language','Polish','2005-10-16',29),('pt','language','Portuguese','2005-10-16',30),('ro','language','Romanian','2005-10-16',31),('ru','language','Russian','2005-10-16',32),('sr','language','Serbian','2005-10-16',33),('es','language','Spanish','2005-10-16',34),('ca','language','Catalan','2013-01-12',35),('sv','language','Swedish','2005-10-16',36),('tet','language','Tetum','2005-10-16',37),('th','language','Thai','2005-10-16',38),('tr','language','Turkish','2005-10-16',39),('uk','language','Ukranian','2005-10-16',40),('ur','language','Urdu','2005-10-16',41),('Arab','script','Arabic','2005-10-16',42),('Cyrl','script','Cyrillic','2005-10-16',43),('Grek','script','Greek','2005-10-16',44),('Hans','script','Han (Simplified variant)','2005-10-16',45),('Hant','script','Han (Traditional variant)','2005-10-16',46),('Hebr','script','Hebrew','2005-10-16',47),('Laoo','script','Lao','2005-10-16',48),('CA','region','Canada','2005-10-16',49),('DK','region','Denmark','2005-10-16',50),('FR','region','France','2005-10-16',51),('NZ','region','New Zealand','2005-10-16',52),('GB','region','United Kingdom','2005-10-16',53),('US','region','United States','2005-10-16',54);
/*!40000 ALTER TABLE `language_subtag_registry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `letter`
--

DROP TABLE IF EXISTS `letter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `letter` (
  `module` varchar(20) NOT NULL DEFAULT '',
  `code` varchar(20) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `is_html` tinyint(1) DEFAULT '0',
  `title` varchar(200) NOT NULL DEFAULT '',
  `content` text,
  PRIMARY KEY (`module`,`code`,`branchcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `letter`
--

LOCK TABLES `letter` WRITE;
/*!40000 ALTER TABLE `letter` DISABLE KEYS */;
INSERT INTO `letter` VALUES ('circulation','CHECKIN','','Innlevering',0,'Melding om innlevering','Følgende dokument har blitt innlevert:\r\n----\r\n<<biblio.title>>\r\n----\r\nVennlig hilsen\r\nBiblioteket'),('circulation','CHECKOUT','','Utlån',0,'Melding om utlån','Følgende dokument har blitt lånt ut:\r\n----\r\n<<biblio.title>>\r\n----\r\nVennlig hilsen\r\nBiblioteket'),('circulation','DUE','','Innleveringspåminnelse',0,'Innleveringspåminnelse','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nDette dokumentet må nå leveres:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)'),('circulation','DUEDGST','','Innleveringspåminnelse (sammendrag)',0,'Innleveringspåminnelse','Du har <<count>> dokumenter som skulle vært levert.'),('circulation','ISSUEQSLIP','','Utlån (enkel)',1,'Utlån (enkel)','<h3><<branches.branchname>></h3>\nUtlånt til <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />\n(<<borrowers.cardnumber>>) <br />\n\n<<today>><br />\n\n<h4>Utlånt i dag</h4>\n<checkedout>\n<p>\n<<biblio.title>> <br />\nStrekkode: <<items.barcode>><br />\nInnleveringsfrist: <<issues.date_due>><br />\n</p>\n</checkedout>'),('circulation','ISSUESLIP','','Utlån',1,'Utlån','<h3><<branches.branchname>></h3>\nUtlånt til <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />\n(<<borrowers.cardnumber>>) <br />\n\n<<today>><br />\n\n<h4>Utlånt</h4>\n<checkedout>\n<p>\n<<biblio.title>> <br />\nStrekkode: <<items.barcode>><br />\nInnleveringsfrist: <<issues.date_due>><br />\n</p>\n</checkedout>\n\n<h4>Forfalte lån</h4>\n<overdue>\n<p>\n<<biblio.title>> <br />\nStrekkode: <<items.barcode>><br />\nInnleveringsfrist: <<issues.date_due>><br />\n</p>\n</overdue>\n\n<hr>\n\n<h4 style=\"text-align: center; font-style:italic;\">Nyheter</h4>\n<news>\n<div class=\"newsitem\">\n<h5 style=\"margin-bottom: 1px; margin-top: 1px\"><b><<opac_news.title>></b></h5>\n<p style=\"margin-bottom: 1px; margin-top: 1px\"><<opac_news.new>></p>\n<p class=\"newsfooter\" style=\"font-size: 8pt; font-style:italic; margin-bottom: 1px; margin-top: 1px\">Publisert <<opac_news.timestamp>></p>\n<hr />\n</div>\n</news>'),('circulation','ODUE','','Purring',0,'Purring på dokument','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har lån som skulle vært levert. Biblioteket krever ikke inn gebyrer, men vennligst lever eller forny lånet/lånene ved biblioteket.\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>> <<branches.branchaddress3>>\nTelefon: <<branches.branchphone>>\nFax: <<branches.branchfax>>\nE-post: <<branches.branchemail>>\n\nDersom du har et passord og lånet/lånene kan fornyes kan du gjøre dette på nettet. Dersom du overskrider lånetiden med mer enn 30 dager vil lånekortet bli sperret.\n\nFølgende lån har gått over tiden:\n\n<item>\"<<biblio.title>>\" av <<biblio.author>>, <<items.itemcallnumber>>, Strekkode: <<items.barcode>> Gebyr: <<items.fine>></item>\n\nPå forhånd takk.\n\n<<branches.branchname>>\n'),('circulation','PREDUE','','Forhåndspåminnelse',0,'Forhåndspåminnelse','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nDette dokumentet må snart leveres:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)'),('circulation','PREDUEDGST','','Forhåndspåminnelse (sammendrag)',0,'Forhåndspåminnelse','Du har lånt <<count>> dokumenter som snart må leveres.'),('circulation','RENEWAL','','Fornying',0,'Fornyinger','Følgende lån har blitt fornyet:\r\n----\r\n<<biblio.title>>\r\n----\r\n'),('circulation','RESERVESLIP','','Reservasjon',1,'Reservasjon','<h5>Dato: <<today>></h5>\n\n<h3> Overfør til/Reservasjon hos <<branches.branchname>></h3>\n\n<h3><<borrowers.surname>>, <<borrowers.firstname>></h3>\n\n<ul>\n    <li><<borrowers.cardnumber>></li>\n    <li><<borrowers.phone>></li>\n    <li> <<borrowers.address>><br />\n         <<borrowers.address2>><br />\n         <<borrowers.city >>  <<borrowers.zipcode>>\n    </li>\n    <li><<borrowers.email>></li>\n</ul>\n<br />\n<h3>RESERVERT</h3>\n<h4><<biblio.title>></h4>\n<h5><<biblio.author>></h5>\n<ul>\n   <li><<items.barcode>></li>\n   <li><<items.itemcallnumber>></li>\n   <li><<reserves.waitingdate>></li>\n</ul>\n<p>Kommentarer:\n<pre><<reserves.reservenotes>></pre>\n</p>\n'),('circulation','TRANSFERSLIP','','Overføringslapp',1,'Overføringslapp','<h5>Dato: <<today>></h5>\n\n<h3>Overføres til <<branches.branchname>></h3>\n\n<h3>EKSEMPLAR</h3>\n<h4><<biblio.title>></h4>\n<h5><<biblio.author>></h5>\n<ul>\n   <li><<items.barcode>></li>\n   <li><<items.itemcallnumber>></li>\n</ul>'),('claimacquisition','ACQCLAIM','','Periodikapurring',0,'Eksemplar ikke mottatt','<<aqbooksellers.name>>\r\n<<aqbooksellers.address1>>\r\n<<aqbooksellers.address2>>\r\n<<aqbooksellers.address3>>\r\n<<aqbooksellers.address4>>\r\n<<aqbooksellers.phone>>\r\n\r\n<order>Bestillingsnummer <<aqorders.ordernumber>> (<<aqorders.title>>) (<<aqorders.quantity>> ordered) ($<<aqorders.listprice>> each) har ikke blitt mottatt.</order>'),('members','ACCTDETAILS','','Mal for kontodetaljer - STANDARD',0,'Dine nye kontodetaljer i Koha.','Hei <<borrowers.title>> <<borrowers.firstname>> <<borrowers.surname>>.\r\n\r\nDine nye detaljer er:\r\n\r\nBruker:  <<borrowers.userid>>\r\nPassord: <<borrowers.password>>\r\n\r\nDersom det oppstår problemer, vennligst kontakt biblioteket.\r\n\r\nVennlig hilsen,\r\nBiblioteket\r\nkohaadmin@yoursite.org'),('members','OPAC_REG_VERIFY','','Verifikasjon av egenregistrering i publikumskatalogen',1,'Verifiser registreringen din','Hei!\n\nD har blitt registrert som bruker av biblioteket. Verifiser epostadressen din ved å klikke på lenka nedenfor:\n\nhttp://<<OPACBaseURL>>/cgi-bin/koha/opac-registration-verify.pl?token=<<borrower_modifications.verification_token>>\n\nDersom du ikke har bedt om å bli registret som bruker av biblioteket kan du se bort fra denne engangsmeldingen. Forespørselen vil snart gå ut på dato.'),('reserves','HOLD','','Hentemelding',0,'Hentemelding fra <<branches.branchname>>','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nEt reservert dokument er klart til henting fra <<reserves.waitingdate>>:\r\n\r\nTittel: <<biblio.title>>\r\nForfatter: <<biblio.author>>\r\nEksemplar: <<items.copynumber>>\r\nHentested: <<branches.branchname>>\r\n<<branches.branchaddress1>>\r\n<<branches.branchaddress2>>\r\n<<branches.branchaddress3>>\r\n<<branches.branchcity>> <<branches.branchzip>>'),('reserves','HOLDPLACED','','Melding om reservasjon',0,'Melding om reservasjon','Følgende dokument har blitt reservert : <<biblio.title>> (<<biblio.biblionumber>>) av <<borrowers.firstname>> <<borrowers.surname>> (<<borrowers.cardnumber>>).'),('reserves','HOLD_PRINT','','Hentemelding (på papir)',0,'Hentemelding','<<branches.branchname>>\r\n<<branches.branchaddress1>>\r\n<<branches.branchaddress2>>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n<<borrowers.firstname>> <<borrowers.surname>>\r\n<<borrowers.address>>\r\n<<borrowers.city>> <<borrowers.zipcode>>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n<<borrowers.firstname>> <<borrowers.surname>> <<borrowers.cardnumber>>\r\n\r\nDu har et reservert dokument som kan hentes fra  <<reserves.waitingdate>>:\r\n\r\nTittel: <<biblio.title>>\r\nForfatter: <<biblio.author>>\r\nEksemplar: <<items.copynumber>>\r\n'),('serial','RLIST','','Sirkulasjon',0,'Et dokument er nå tilgjengelig','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nDette dokumentet er tilgjengelig:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)\r\n\r\nVennligst kom og hent det når det passer.'),('suggestions','ACCEPTED','','Forslag godtatt',0,'Innkjøpsforslag godtatt','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nBiblioteket har vurdert forslaget i dag. Dokumentet vil bli bestilt så fort det lar seg gjøre. Du vil få en ny melding når bestillingen er gjort, og når dokumentet ankommer biblioteket.\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>'),('suggestions','AVAILABLE','','Foreslått dokument tilgjengelig',0,'Foreslått dokument tilgjengelig','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nVi har gleden av å informere deg om at dokumentet nå er innlemmet i samlingen.\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>'),('suggestions','ORDERED','','Innkjøpsforslag i bestilling',0,'Innkjøpsforslag i bestilling','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nVi har gleden av å informere deg om at dokumentet du foreslo nå er i bestilling.\n\nDu vil få en ny melding når dokumentet er tilgjengelig.\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>'),('suggestions','REJECTED','','Innkjøpsforslag avslått',0,'Innkjøpsforslag avslått','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nBiblioteket har vurdert innkjøpsforslaget ditt i dag, og bestemt seg for å ikke ta det til følge.\n\nBegrunnelse: <<suggestions.reason>>\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>');
/*!40000 ALTER TABLE `letter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `linktracker`
--

DROP TABLE IF EXISTS `linktracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `linktracker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `url` text,
  `timeclicked` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bibidx` (`biblionumber`),
  KEY `itemidx` (`itemnumber`),
  KEY `borridx` (`borrowernumber`),
  KEY `dateidx` (`timeclicked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `linktracker`
--

LOCK TABLES `linktracker` WRITE;
/*!40000 ALTER TABLE `linktracker` DISABLE KEYS */;
/*!40000 ALTER TABLE `linktracker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_matchers`
--

DROP TABLE IF EXISTS `marc_matchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_matchers` (
  `matcher_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `record_type` varchar(10) NOT NULL DEFAULT 'biblio',
  `threshold` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matcher_id`),
  KEY `code` (`code`),
  KEY `record_type` (`record_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_matchers`
--

LOCK TABLES `marc_matchers` WRITE;
/*!40000 ALTER TABLE `marc_matchers` DISABLE KEYS */;
/*!40000 ALTER TABLE `marc_matchers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_subfield_structure`
--

DROP TABLE IF EXISTS `marc_subfield_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_subfield_structure` (
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `tagsubfield` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `kohafield` varchar(40) DEFAULT NULL,
  `tab` tinyint(1) DEFAULT NULL,
  `authorised_value` varchar(20) DEFAULT NULL,
  `authtypecode` varchar(20) DEFAULT NULL,
  `value_builder` varchar(80) DEFAULT NULL,
  `isurl` tinyint(1) DEFAULT NULL,
  `hidden` tinyint(1) DEFAULT NULL,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  `seealso` varchar(1100) DEFAULT NULL,
  `link` varchar(80) DEFAULT NULL,
  `defaultvalue` text,
  `maxlength` int(4) NOT NULL DEFAULT '9999',
  PRIMARY KEY (`frameworkcode`,`tagfield`,`tagsubfield`),
  KEY `kohafield_2` (`kohafield`),
  KEY `tab` (`frameworkcode`,`tab`),
  KEY `kohafield` (`frameworkcode`,`kohafield`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_subfield_structure`
--

LOCK TABLES `marc_subfield_structure` WRITE;
/*!40000 ALTER TABLE `marc_subfield_structure` DISABLE KEYS */;
INSERT INTO `marc_subfield_structure` VALUES ('000','@','Postens hode','Postens hode',0,1,'',0,'','','normarc_leader.pl',0,-1,'',NULL,'','',24),('001','@','Identifikasjonsnummer','Identifikasjonsnummer',0,0,'',0,'','','',0,-1,'','','',NULL,9999),('007','@','Fysisk beskrivelse av dokumentet (R)','Fysisk beskrivelse av dokumentet (R)',1,0,'',0,'','','normarc_field_007.pl',0,-1,'',NULL,'','',9999),('008','@','Informasjonskoder','Informasjonskoder',0,0,'',0,'','','normarc_field_008.pl',0,-1,'',NULL,'','',40),('009','@','Lokale koder','Lokale koder',0,0,'',0,'','','',0,-1,'','','',NULL,9999),('010','a','Nummer','Nummer',0,0,'biblioitems.lccn',0,'','','',0,-1,'','','',NULL,9999),('015','a','Nummer','Nummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('015','b','Kilde','Kilde',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('019','a','Aldersgruppemerker for barnebøker','Aldersgruppemerker for barnebøker',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('019','b','Dokumenttype (BSMARC)','Dokumenttype',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('019','d','Litterær form/genre','Litterær form/genre',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('019','e','Litteratur tilpasset visse brukergrupper','Litteratur tilpasset visse brukergrupper',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('019','f','Andre grupper','Andre grupper',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('020','a','ISBN','ISBN',0,0,'biblioitems.isbn',0,'','','',0,-1,'','','',NULL,9999),('020','b','Innbindingsinformasjon','Innbindingsinformasjon',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('020','c','Leveringsbetingelser','Leveringsbetingelser',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('020','g','Andre tilføyelser','Andre tilføyelser',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('020','z','Feil ISBN','Feil ISBN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('022','a','Gyldig ISSN (1.8A-1.8B1, 1.8C)','Gyldig ISSN (1.8A-1.8B1, 1.8C)',0,0,'biblioitems.issn',0,'','','',0,-1,'','','',NULL,9999),('022','y','Ukorrekt ISSN','Ukorrekt ISSN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('022','z','Kansellert ISSN','Kansellert ISSN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('024','a','Standardnummer','Standardnummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('024','c','Leveringsbetingelser','Leveringsbetingelser',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('024','g','Andre tilføyelser','Andre tilføyelser',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('024','z','Feil standardnummer','Feil standardnummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('025','a','Nummer','Nummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('027','a','STRN','STRN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('027','z','Feil eller forkastet STRN','Feil eller forkastet STRN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('028','a','Utgivernummer/edisjonsnummer eller forleggernummer','Utgivernummer/edisjonsnummer eller forleggernummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('028','b','Utgiver','Utgiver',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('030','a','Gyldig CODEN','Gyldig CODEN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('030','z','Ugyldig eller forkastet CODEN','Ugyldig eller forkastet CODEN',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('033','a','Dato for innspilling/opptak','Dato for innspilling/opptak',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('033','b','Kode for geografisk område','Kode for geografisk område',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('040','a','Katalogiseringskilde','Katalogiseringskilde',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('041','a','Språk i tekst/lydspor','Språk i tekst/lydspor',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('041','b','Språk i sammendrag/undertekster','Språk i sammendrag/undertekster',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('041','g','Språk i medfølgende materiale','Språk i medfølgende materiale',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('041','h','Språk i originaldokument','Språk i originaldokument',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('045','a','År (f.eks. komposisjonsår) (R)','År (f.eks. komposisjonsår) (R)',1,0,'0',0,'','','',0,-1,'','','',NULL,9999),('060','7','Del av dokumentet som klassifikasjonskoden gjelder','Del av dokumentet som klassifikasjonskoden gjelder',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('060','a','Klassifikasjonsnummer','Klassifikasjonsnummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('060','z','Hovednummer','Hovednummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('074','a','Kode','Kode',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('080','7','Del av dokumentet som klassifikasjonskoden gjelder','Del av dokumentet som klassifikasjonskoden gjelder',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('080','a','Klassifikasjonsnummer','Klassifikasjonsnummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('080','e','Oppslagsterm til emneregister','Oppslagsterm til emneregister',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('080','z','Nummerets karakter','Nummerets karakter',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('082','2','Klassifikasjonsutgave','Klassifikasjonsutgave',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('082','7','Del av dokumentet som klassifikasjonskoden gjelder','Del av dokumentet som klassifikasjonskoden gjelder',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('082','a','Klassifikasjonsnummer','Klassifikasjonsnummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('082','e','Oppslagsterm til emneregister','Oppslagsterm til emneregister',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('082','x','Hjelpetabeller','Hjelpetabeller',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('082','z','Nummerets karakter','Nummerets karakter',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('084','7','Del av dokumentet som klassifikasjonskoden gjelder','Del av dokumentet som klassifikasjonskoden gjelder',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('084','a','Klassifikasjonsnummer','Klassifikasjonsnummer',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('084','z','Nummerets karakter','Nummerets karakter',0,0,'0',0,'','','',0,-1,'','','',NULL,9999),('100','8','Andre karakteristika forbundet med navn','Andre karakteristika forbundet med navn',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','a','Navn','Navn',0,0,'biblio.author',1,'','','',0,0,'','','',NULL,9999),('100','b','Nummer','Nummer',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','c','Andre tilføyelser','Andre tilføyelser',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','d','Årstall forbundet med navn','Årstall forbundet med navn',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','e','Betegnelse for funksjon','Betegnelse for funksjon',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','j','Nasjonalitet','Nasjonalitet',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','q','Mer fullstendig navneform','Mer fullstendig navneform',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('100','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',1,'','','',0,0,'','','',NULL,9999),('110','a','Navn','Navn',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','b','Underavdeling','Underavdeling',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','c','Sted','Sted',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','d','Dato','Dato',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','e','Betegnelse for funksjon','Betegnelse for funksjon',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','n','Nummer','Nummer',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('110','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','a','Navn (24.7-.8)','Navn (24.7-.8)',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','c','Sted','Sted',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','d','Dato','Dato',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','n','Nummer','Nummer',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('111','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','a','Standardtittel (25)','Standardtittel (25)',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','b','Underordnet enhet','Underordnet enhet',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','d','Årstall','Årstall',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','f','Utgivelsesår','Utgivelsesår',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','h','Generell materialbetegnelse','Generell materialbetegnelse',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','i','Serienummer, opusnummer, nummer fra verkfortegnelse','Serienummer, opusnummer, nummer fra verkfortegnelse',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','k','Form','Form',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','l','Språk i dokumentet','Språk i dokumentet',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','m','Besetning (25.29)[Mus]','Besetning (25.29)[Mus]',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','o','Arrangement (25.31B2)[Mus]','Arrangement (25.31B2)[Mus]',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','r','Toneart (25.31A5) [Mus]','Toneart (25.31A5) [Mus]',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','s','Versjon','Versjon',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('130','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',1,'','','',0,-1,'','','',NULL,9999),('210','a','Forkortet tittel','Forkortet tittel',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('210','b','Forklarende tilføyelser','Forklarende tilføyelser',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('222','a','Nøkkeltittel','Nøkkeltittel',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('222','b','Forklarende tilføyelser','Forklarende tilføyelser',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','a','Tittel','Tittel',0,0,'biblio.unititle',2,'','','',0,-1,'','','',NULL,9999),('240','b','Annen tittelinformasjon','Annen tittelinformasjon',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','d','Årstall','Årstall',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','f','Utgivelsesår (25.31A6)','Utgivelsesår (25.31A6)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','g','Diverse opplysninger (25.31A6)','Diverse opplysninger (25.31A6)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','h','Generell materialbetegnelse','Generell materialbetegnelse',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','i','Serienummer, opusnummer, nummer fra tematisk verkfortegnelse','Serienummer, opusnummer, nummer fra tematisk verkfortegnelse',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','k','Form','Form',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','l','Språk','Språk',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','m','Besetning (25.29)','Besetning (25.29)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','o','Arrangement for musikk','Arrangement for musikk',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','r','Toneart  (25.31A5) [Mus]','Toneart  (25.31A5) [Mus]',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','s','Versjon','Versjon',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('240','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('245','a','Tittel','Tittel',0,0,'biblio.title',2,'','','',0,0,'','','',NULL,9999),('245','b','Annen tittelinformasjon','Annen tittelinformasjon',0,0,'bibliosubtitle.subtitle',2,'','','',0,0,'','','',NULL,9999),('245','c','Ansvarsangivelse','Ansvarsangivelse',0,0,'0',2,'','','',0,0,'','','',NULL,9999),('245','h','Generell materialbetegnelse','Generell materialbetegnelse',0,0,'0',2,'','','',0,0,'','','',NULL,9999),('245','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',2,'','','',0,0,'','','',NULL,9999),('245','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',2,'','','',0,0,'','','',NULL,9999),('245','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',2,'','','',0,0,'','','',NULL,9999),('246','a','Parallelltittel','Parallelltittel',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','b','Annen tittelinformasjon','Annen tittelinformasjon',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','c','Ansvarsangivelse','Ansvarsangivelse',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','f','Dato-, bind- eller heftebetegnelse [Per]','Dato-, bind- eller heftebetegnelse [Per]',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','h','Generell materialbetegnelse','Generell materialbetegnelse',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('246','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('250','a','Utgave, opplag etc','Utgave, opplag etc',0,0,'biblioitems.editionstatement',2,'','','',0,-1,'','','',NULL,9999),('250','b','Ansvarshavende','Ansvarshavende',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('254','a','Fysisk presentasjon','Fysisk presentasjon',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('255','a','Opplysning om målestokk (3.3B)','Opplysning om målestokk (3.3B)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('255','b','Opplysning om projeksjon (3.3C)','Opplysning om projeksjon (3.3C)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('255','c','Opplysning om koordinater (3.3D1)','Opplysning om koordinater (3.3D1)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('255','d','Opplysning om sone (3.3D2)','Opplysning om sone (3.3D2)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('255','e','Opplysning om ekvinoktium (3.3D2)','Opplysning om ekvinoktium (3.3D2)',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('256','a','Filkarakteristika','Filkarakteristika',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('260','a','Sted (R)','Sted (R)',1,0,'biblioitems.place',2,'','','',0,-1,'','','',NULL,9999),('260','b','Navn på forlegger, distributør etc','Navn på forlegger, distributør etc',0,0,'biblioitems.publishercode',2,'','','',0,-1,'','','',NULL,9999),('260','c','År','År',0,0,'biblio.copyrightdate',2,'','','',0,-1,'','','',NULL,9999),('260','e','Trykkested eller produksjonssted','Trykkested eller produksjonssted',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('260','f','Trykkeriets eller produsentens navn','Trykkeriets eller produsentens navn',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('260','g','Trykkeår eller produksjonsår','Trykkeår eller produksjonsår',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('263','a','Dato','Dato',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','a','Adresse','Adresse',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','b','By','By',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','d','Land','Land',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','e','Postkode','Postkode',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','i','Adressetype','Adressetype',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','k','Telefonnummer (R)','Telefonnummer (R)',1,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','l','Telefaksnummer (R)','Telefaksnummer (R)',1,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','m','E-post adresse (R)','E-post adresse (R)',1,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','p','Kontaktperson (R)','Kontaktperson (R)',1,0,'0',2,'','','',0,-1,'','','',NULL,9999),('270','z','Note','Note',0,0,'0',2,'','','',0,-1,'','','',NULL,9999),('300','a','Omfang','Omfang',0,0,'biblioitems.pages',3,'','','',0,0,'','','',NULL,9999),('300','b','Illustrasjonsmateriale og andre fysiske detaljer','Illustrasjonsmateriale og andre fysiske detaljer',0,0,'biblioitems.illus',3,'','','',0,0,'','','',NULL,9999),('300','c','Format','Format',0,0,'biblioitems.size',3,'','','',0,0,'','','',NULL,9999),('300','e','Bilag','Bilag',0,0,'0',3,'','','',0,0,'','','',NULL,9999),('306','a','Varighet (R)','Varighet (R)',1,0,'0',3,'','','',0,-1,'','','',NULL,9999),('310','a','Periodisitet (R)','Periodisitet (R)',1,0,'0',3,'','','',0,-1,'','','',NULL,9999),('350','a','Pris (R)','Pris (R)',1,0,'0',3,'','','',0,-1,'','','',NULL,9999),('350','b','Fysisk beskrivelse (R)','Fysisk beskrivelse (R)',1,0,'0',3,'','','',0,-1,'','','',NULL,9999),('362','a','Numeriske og/eller alfabetiske og kronologiske betegnelser (R)','Numeriske og/eller alfabetiske og kronologiske betegnelser (R)',1,0,'biblioitems.volumedesc',3,'','','',0,-1,'','','',NULL,9999),('440','a','Serietittel (1.6B-1.6D)','Serietittel (1.6B-1.6D)',0,0,'biblio.seriestitle',4,'','','',0,-1,'','','',NULL,9999),('440','c','Ansvarsangivelse (1.6E)','Ansvarsangivelse (1.6E)',0,0,'0',4,'','','',0,-1,'','','',NULL,9999),('440','n','Underseriens alfabetiske eller numeriske betegnelse','Underseriens alfabetiske eller numeriske betegnelse',0,0,'biblioitems.number',4,'','','',0,-1,'','','',NULL,9999),('440','p','Tittel for underserie','Tittel for underserie',0,0,'0',4,'','','',0,-1,'','','',NULL,9999),('440','v','Nummerering innen serien','Nummerering innen serien',0,0,'biblioitems.volume',4,'','','',0,-1,'','','',NULL,9999),('440','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',4,'','','',0,-1,'','','',NULL,9999),('440','x','ISSN','ISSN',0,0,'0',4,'','','',0,-1,'','','',NULL,9999),('440','y','Nummerering i underserien','Nummerering i underserien',0,0,'0',4,'','','',0,-1,'','','',NULL,9999),('490','a','Serietittel','Serietittel',0,0,'0',4,'','','',0,-1,'','','',NULL,9999),('500','a','Notens tekst','Notens tekst',0,0,'biblio.notes',5,'','','',0,0,'','','',NULL,9999),('501','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('502','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('503','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('505','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('508','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('510','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('511','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('512','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('516','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('520','a','Notens tekst','Notens tekst',0,0,'biblio.abstract',5,'','','',0,-1,'','','',NULL,9999),('521','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('525','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('530','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('531','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('532','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('533','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('538','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('539','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('546','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('571','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('572','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('573','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('574','a','Notens tekst','Notens tekst',0,0,'0',5,'','','',0,-1,'','','',NULL,9999),('600','0','Kvalifikator (R)','Kvalifikator (R)',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','8','Andre karakteristika forbundet med navn','Andre karakteristika forbundet med navn',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','a','Navn','Navn',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','b','Nummer','Nummer',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','c','Andre tilføyelser','Andre tilføyelser',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','d','Årstall forbundet med navn','Årstall forbundet med navn',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','i','Serienummer, opusnummer, nummer fra verkfortegnelse (25.31A1-A4) [Mus]','Serienummer, opusnummer, nummer fra verkfortegnelse (25.31A1-A4) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','j','Nasjonalitet','Nasjonalitet',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','m','Besetning (25.29) [Mus]','Besetning (25.29) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','o','Arrangement (25.31B2) [Mus]','Arrangement (25.31B2) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','q','Mer fullstendig navneform','Mer fullstendig navneform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','r','Toneart [Mus]','Toneart [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','t','Tittel for dokument som er emne','Tittel for dokument som er emne',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('600','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','a','Navn','Navn',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','b','Underavdeling','Underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','c','Sted (R)','Sted (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','d','Dato (R)','Dato (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','g','Diverse opplysninger (R)','Diverse opplysninger (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','i','Serienummer, opusnummer, nummer fra verkfortegnelse','Serienummer, opusnummer, nummer fra verkfortegnelse',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','m','Besetning [Mus]','Besetning [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','n','Nummer','Nummer',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','o','Arrangement [Mus]','Arrangement [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','r','Toneart (25.31A5) [Mus]','Toneart (25.31A5) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','t','Tittel for dokument som er emne','Tittel for dokument som er emne',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('610','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','a','Navn (24.7, 24.8)','Navn (24.7, 24.8)',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','c','Sted','Sted',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','d','Dato (R)','Dato (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','n','Nummer','Nummer',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','t','Tittel for dokument som er emne','Tittel for dokument som er emne',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','y','Kronologisk underavdeling','Kronologisk underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('611','z','Geografisk underavdeling','Geografisk underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','1','Klassifikasjonskode','Klassifikasjonskode',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','a','Standardtittel (25)','Standardtittel (25)',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','b','Underordnet enhet','Underordnet enhet',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','d','Årstall (R)','Årstall (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','f','Utgivelsesår','Utgivelsesår',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','i','Serienummer, opusnummer, nummer fra verkfortegnelse','Serienummer, opusnummer, nummer fra verkfortegnelse',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','k','Form','Form',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','l','Språk i omtalt dokument','Språk i omtalt dokument',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','m','Besetning (25.29) [Mus]','Besetning (25.29) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','o','Arrangement (25.31B2) [Mus]','Arrangement (25.31B2) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','r','Toneart (25.31A5) [Mus]','Toneart (25.31A5) [Mus]',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','s','Versjon av omtalt dokument','Versjon av omtalt dokument',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('630','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','a','Tittel','Tittel',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','n','Nummer for del av verk (1.1B9, 12.1B3-4)','Nummer for del av verk (1.1B9, 12.1B3-4)',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('640','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','a','Emneord','Emneord',0,0,'bibliosubject.subject',6,'','','',0,-1,'','','',NULL,9999),('650','c','Aktive datoer','Aktive datoer',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','d','Sted','Sted',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','q','Forklarende tilføyelser','Forklarende tilføyelser',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('650','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','a','Stedsnavn eller område','Stedsnavn eller område',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','q','Forklarende tilføyelser','Forklarende tilføyelser',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('651','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('652','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('652','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('652','a','Betegnelse for komposisjonstype','Betegnelse for komposisjonstype',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('652','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','a','Fritt nøkkelord','Fritt nøkkelord',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('653','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','a','Genre/form','Genre/form',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('655','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','0','Kvalifikator (R)','Kvalifikator (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','1','Klassifikasjonskode','Klassifikasjonskode',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','2','Kilde for emneinnførselen','Kilde for emneinnførselen',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','a','Emneord','Emneord',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','v','Form underavdeling','Form underavdeling',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','x','Underavdeling (R)','Underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','y','Kronologisk underavdeling (R)','Kronologisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('656','z','Geografisk underavdeling (R)','Geografisk underavdeling (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('658','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('658','9','Språk eller språkform','Språk eller språkform',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('658','a','Betegnelse for besetning (R)','Betegnelse for besetning (R)',1,0,'0',6,'','','',0,-1,'','','',NULL,9999),('658','b','Totalt antall instrumenter','Totalt antall instrumenter',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('658','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',6,'','','',0,-1,'','','',NULL,9999),('700','7','Del av dokumentet som emneinnførselen gjelder','Del av dokumentet som emneinnførselen gjelder',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','8','Andre karakteristika forbundet med navn','Andre karakteristika forbundet med navn',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','a','Navn','Navn',0,0,'additionalauthors.author',7,'','','',0,-1,'','','',NULL,9999),('700','b','Nummer','Nummer',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','c','Andre tilføyelser','Andre tilføyelser',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','d','Årstall forbundet med navn','Årstall forbundet med navn',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','e','Betegnelse for funksjon','Betegnelse for funksjon',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','h','Materialebetegnelse','Materialebetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','i','Serienummer, opusnummer, nummer fra verkfortegnelse','Serienummer, opusnummer, nummer fra verkfortegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','j','Nasjonalitet','Nasjonalitet',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','k','Form','Form',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','l','Språk','Språk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','m','Besetning (25.29) [Mus]','Besetning (25.29) [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','o','Arrangement (25.31B2) [Mus]','Arrangement (25.31B2) [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','q','Mer fullstendig navneform','Mer fullstendig navneform',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','r','Toneart [Mus]','Toneart [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','t','Tittel i biinnførselen','Tittel i biinnførselen',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('700','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','7','Del av dokumentet som biinnførselen gjelder','Del av dokumentet som biinnførselen gjelder',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','a','Navn','Navn',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','b','Underavdeling','Underavdeling',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','c','Sted','Sted',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','d','Dato','Dato',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','e','Betegnelse for funksjon','Betegnelse for funksjon',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','h','Materialebetegnelse','Materialebetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','i','Serienummer, opusnummer, nummer fra verkfortegnelse','Serienummer, opusnummer, nummer fra verkfortegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','l','Språk','Språk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','m','Besetning [Mus]','Besetning [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','n','Nummer','Nummer',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','o','Arrangement [Mus]','Arrangement [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','r','Toneart (25.31A5) [Mus]','Toneart (25.31A5) [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','t','Tittel i biinnførselen','Tittel i biinnførselen',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('710','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','7','Del av dokumentet som biinnførselen gjelder','Del av dokumentet som biinnførselen gjelder',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','a','Navn (24.7, 24.8)','Navn (24.7, 24.8)',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','c','Sted','Sted',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','d','Dato','Dato',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','h','Materialebetegnelse','Materialebetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','l','Språk','Språk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','n','Nummer','Nummer',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','t','Tittel i biinnførselen','Tittel i biinnførselen',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('711','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','7','Del av dokumentet som biinnførselen gjelder','Del av dokumentet som biinnførselen gjelder',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','a','Standardtittel (25)','Standardtittel (25)',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','b','Underordnet enhet','Underordnet enhet',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','d','Årstall','Årstall',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','f','Utgivelsesår','Utgivelsesår',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','h','Materialebetegnelse','Materialebetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','i','Serienummer, opusnummer, nummer fra verkfortegnelse','Serienummer, opusnummer, nummer fra verkfortegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','k','Form','Form',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','l','Språk','Språk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','m','Besetning(25.29) [Mus]','Besetning(25.29) [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','o','Arrangement (25.31B2) [Mus]','Arrangement (25.31B2) [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','r','Toneart [Mus]','Toneart [Mus]',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','s','Versjon (25.18A11)','Versjon (25.18A11)',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','t','Tittel i biinnførselen','Tittel i biinnførselen',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('730','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','7','Del av dokumentet som biinnførselen gjelder','Del av dokumentet som biinnførselen gjelder',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','a','Tittel (21.30J)','Tittel (21.30J)',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','e','Type tittel','Type tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('740','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('752','a','Land','Land',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('752','b','Delstat eller fylke','Delstat eller fylke',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('752','c','Kommune','Kommune',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('752','d','By, tettsted etc','By, tettsted etc',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('753','a','Datamaskinfabrikat og -modell','Datamaskinfabrikat og -modell',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('753','b','Programmeringsspråk','Programmeringsspråk',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('753','c','Operativsystem','Operativsystem',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('760','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('762','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('765','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('767','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('770','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('772','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('773','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('775','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('776','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('777','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('780','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('785','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','7','Type hovedordningsord i delfelt $a','Type hovedordningsord i delfelt $a',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','a','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel','Hovedordningsord for posten det lenkes til, hvis dette er et personnavn, korporasjonsnavn eller en standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','b','Utgave','Utgave',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','d','Sted, forlag og dato (år) for utgivelse','Sted, forlag og dato (år) for utgivelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','e','Språkkode','Språkkode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','f','Landekode','Landekode',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','g','Relasjonsopplysninger (R)','Relasjonsopplysninger (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','h','Materialbetegnelse','Materialbetegnelse',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','i','Årstall i \"ren\" form (R)','Årstall i \"ren\" form (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','k','Serie (R)','Serie (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','s','Standardtittel','Standardtittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','t','Tittel','Tittel',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','w','Lokalt systems identifikasjonsnummer (R)','Lokalt systems identifikasjonsnummer (R)',1,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','x','ISSN','ISSN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','y','CODEN','CODEN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('787','z','ISBN','ISBN',0,0,'0',7,'','','',0,-1,'','','',NULL,9999),('800','8','Andre karakteristika forbundet med navn','Andre karakteristika forbundet med navn',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','a','Navn','Navn',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','b','Nummer','Nummer',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','c','Andre tilføyelser','Andre tilføyelser',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','d','Årstall forbundet med navn','Årstall forbundet med navn',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','j','Nasjonalitet','Nasjonalitet',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','l','Språk','Språk',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','q','Mer fullstendig navneform','Mer fullstendig navneform',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','t','Tittel for serien','Tittel for serien',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','v','Bind, nummer etc','Bind, nummer etc',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('800','x','ISSN','ISSN',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','a','Navn','Navn',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','b','Underavdeling','Underavdeling',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','c','Sted','Sted',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','d','Dato','Dato',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','l','Språk','Språk',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','n','Nummer for konferanse','Nummer for konferanse',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','t','Tittel for serien','Tittel for serien',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','v','Bind, nummer etc','Bind, nummer etc',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('810','x','ISSN','ISSN',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','a','Navn (24.7-.8)','Navn (24.7-.8)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','c','Sted','Sted',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','d','Dato','Dato',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','g','Diverse opplysninger','Diverse opplysninger',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','l','Språk','Språk',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','n','Nummer for konferanse, utstilling, møte etc','Nummer for konferanse, utstilling, møte etc',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','t','Tittel for serien','Tittel for serien',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','v','Bind, nummer etc','Bind, nummer etc',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('811','x','ISSN','ISSN',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','a','Standardisert tittel','Standardisert tittel',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','b','Underordnet enhet','Underordnet enhet',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','d','Årstall','Årstall',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','f','Utgivelsesåret for verket som katalogiseres','Utgivelsesåret for verket som katalogiseres',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','i','Serienummer, opusnummer, nummer fra verkfortegnelse [Mus]','Serienummer, opusnummer, nummer fra verkfortegnelse [Mus]',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','k','Form','Form',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','l','Språk i dokumentet','Språk i dokumentet',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','m','Besetning [Mus]','Besetning [Mus]',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','o','Arrangement [Mus]','Arrangement [Mus]',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','r','Toneart [Mus]','Toneart [Mus]',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','s','Versjon (25.18A11)','Versjon (25.18A11)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','v','Bind, nummer etc','Bind, nummer etc',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('830','x','ISSN','ISSN',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','a','Eiende bibliotek/avdeling','Eiende bibliotek/avdeling',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','b','Filial-, avdelings- eller samlingskode','Filial-, avdelings- eller samlingskode',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','c','Hyllesignatur','Hyllesignatur',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','d','Utgivelsesår, copyrightår eller trykkeår (monografier)','Utgivelsesår, copyrightår eller trykkeår (monografier)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','e','Antall eksemplarer','Antall eksemplarer',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','i','Første bind (volum/nummer) i biblioteket (periodika)','Første bind (volum/nummer) i biblioteket (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','j','Parallell bindnummerering til første bind (periodika)','Parallell bindnummerering til første bind (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','k','Første år i biblioteket (periodika)','Første år i biblioteket (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','l','Siste bind (volum/nummer) i biblioteket (periodika)','Siste bind (volum/nummer) i biblioteket (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','m','Parallell bindnummerering til siste bind (periodika)','Parallell bindnummerering til siste bind (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','n','Siste år i biblioteket (periodika)','Siste år i biblioteket (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','o','Note om begrenset oppbevaring','Note om begrenset oppbevaring',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','p','Angivelse av ufullstendighet (periodika)','Angivelse av ufullstendighet (periodika)',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','s','Status for beholdningsoppgaven','Status for beholdningsoppgaven',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('850','z','Lokal note','Lokal note',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','2','Tilgangsmetode','Tilgangsmetode',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','3','Dokumentspesifikasjon','Dokumentspesifikasjon',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','a','Vertsmaskinadresse (R)','Vertsmaskinadresse (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','b','Tilgangsnummer for vertsmaskin','Tilgangsnummer for vertsmaskin',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','c','Komprimering (R)','Komprimering (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','d','Filkatalog (R)','Filkatalog (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','f','Filnavn (R)','Filnavn (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','g','URN (Uniform Resource Name) (R)','URN (Uniform Resource Name) (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','k','Passord','Passord',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','l','Innloggingsuttrykk','Innloggingsuttrykk',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','p','Portnummer','Portnummer',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','q','Elektronisk format','Elektronisk format',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','r','Kommunikasjonsoppsett','Kommunikasjonsoppsett',0,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','s','Filstørrelse (R)','Filstørrelse (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','t','Terminalemulering (R)','Terminalemulering (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('856','u','URL (Uniform Resource Locator) (R)','URL (Uniform Resource Locator) (R)',1,0,'biblioitems.url',8,'','','',0,-1,'','','',NULL,9999),('856','z','Note (R)','Note (R)',1,0,'0',8,'','','',0,-1,'','','',NULL,9999),('900','0','Kvalifikator til emneord (R)','Kvalifikator til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','8','Andre karakteristika forbundet med navn (R)','Andre karakteristika forbundet med navn (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','a','Navn, henvisning fra','Navn, henvisning fra',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','b','Nummer','Nummer',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','c','Andre tilføyelser','Andre tilføyelser',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','d','Årstall forbundet med navn','Årstall forbundet med navn',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','g','Diverse','Diverse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','j','Nasjonalitet','Nasjonalitet',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','q','Mer fullstendig navneform','Mer fullstendig navneform',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','t','Tittel','Tittel',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','x','Underavdeling til emneord (R)','Underavdeling til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('900','z','Navn, henvisning til','Navn, henvisning til',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','0','Kvalifikator til emneord (R)','Kvalifikator til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','a','Navn, henvisning fra','Navn, henvisning fra',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','b','Underavdeling','Underavdeling',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','c','Sted','Sted',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','d','Dato','Dato',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','g','Diverse','Diverse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','n','Nummer for konferanse, utstilling etc','Nummer for konferanse, utstilling etc',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','t','Tittel','Tittel',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','x','Underavdeling til emneord (R)','Underavdeling til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('910','z','Navn, henvisning til','Navn, henvisning til',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','0','Kvalifikator til emneord','Kvalifikator til emneord',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','a','Navn, henvisning fra','Navn, henvisning fra',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','c','Sted','Sted',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','d','Dato','Dato',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','g','Diverse','Diverse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','n','Nummer for konferanse, møte, utstilling etc','Nummer for konferanse, møte, utstilling etc',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','q','Forklarende tilføyelse','Forklarende tilføyelse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','t','Tittel','Tittel',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','u','Sorteringsdelfelt for delfelt $t','Sorteringsdelfelt for delfelt $t',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','x','Underavdeling til emneord','Underavdeling til emneord',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('911','z','Navn, henvisning til','Navn, henvisning til',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','0','Kvalifikator til emneord (R)','Kvalifikator til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','a','Standardtittel, henvisning fra','Standardtittel, henvisning fra',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','b','Underordnet enhet','Underordnet enhet',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','d','Årstall','Årstall',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','f','Utgivelsesåret for verket som katalogiseres','Utgivelsesåret for verket som katalogiseres',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','g','Diverse','Diverse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','i','Serienummer, opusnummer, nummer fra verkfortegnelse [Mus]','Serienummer, opusnummer, nummer fra verkfortegnelse [Mus]',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','k','Form','Form',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','l','Språk','Språk',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','m','Besetning [Mus]','Besetning [Mus]',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','o','Arrangement [Mus]','Arrangement [Mus]',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','q','Forklarende tilføyelse.','Forklarende tilføyelse.',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','r','Toneart [Mus]','Toneart [Mus]',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','s','Versjon','Versjon',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','x','Underavdeling til emneord (R)','Underavdeling til emneord (R)',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('930','z','Standardtittel, henvisning til','Standardtittel, henvisning til',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','0','Kvalifikator til emneord (R)','Kvalifikator til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','a','Tittel, henvisning fra','Tittel, henvisning fra',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','g','Diverse','Diverse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','n','Nummer for del av verk','Nummer for del av verk',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','p','Tittel for del av verk','Tittel for del av verk',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','x','Underavdeling til emneord (R)','Underavdeling til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('940','z','Tittel, henvisning til','Tittel, henvisning til',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('942','0','Antall utlån, alle eksemplarer','Antall utlån, alle eksemplarer',0,0,'biblioitems.totalissues',9,'','','',0,-5,'',NULL,'','',9999),('942','2','Kilde for klassifikasjon','Kilde for klassifikasjon',0,0,'biblioitems.cn_source',9,'','','',0,-1,'',NULL,'','',9999),('942','6','Koha normalisert klassifikasjon for sortering','Koha normalisert klassifikasjon for sortering',0,0,'biblioitems.cn_sort',-1,'','','',0,7,'',NULL,'','',9999),('942','a','Institusjonskode [utgått]','Institusjonskode [utgått]',0,0,'',9,'','','',0,-5,'',NULL,'','',9999),('942','c','Koha [standard] dokumenttype','Koha dokumenttype',0,1,'biblioitems.itemtype',9,'itemtypes','','',0,-1,'',NULL,'','',9999),('942','e','Utgave','Utgave',0,0,'',9,'','','',0,-1,'',NULL,'','',9999),('942','h','Klassifikasjon del','Klassifikasjon del',0,0,'biblioitems.cn_class',9,'','','',0,-1,'',NULL,'','',9999),('942','i','Eksemplar del','Eksemplar del',1,0,'biblioitems.cn_item',9,'','','',0,-1,'',NULL,'','',9999),('942','k','Hyllesignatur prefiks','Hyllesignatur prefiks',0,0,'',9,'','','',0,-1,'',NULL,'','',9999),('942','m','Hyllesignatur postfiks','Hyllesignatur postfiks',0,0,'biblioitems.cn_suffix',9,'','','',0,-1,'',NULL,'','',9999),('942','n','Skjul i OPAC','Skjul i OPAC',0,0,'',9,'','','',0,-1,'',NULL,'','',9999),('942','s','Periodikamarkør','Periodikamarkør',0,0,'biblio.serial',9,'','','',0,-5,'',NULL,'','',9999),('950','0','Kvalifikator til emneord (R)','Kvalifikator til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('950','a','Navn eller ord, henvisning fra','Navn eller ord, henvisning fra',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('950','g','Diverse','Diverse',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('950','q','Forklarende tilføyelser til delfelt $a','Forklarende tilføyelser til delfelt $a',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('950','w','Sorteringsdelfelt for delfelt $a','Sorteringsdelfelt for delfelt $a.',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('950','x','Underavdeling til emneord (R)','Underavdeling til emneord (R)',1,0,'0',9,'','','',0,-1,'','','',NULL,9999),('950','z','Navn eller ord, henvisning til','Navn eller ord, henvisning til',0,0,'0',9,'','','',0,-1,'','','',NULL,9999),('952','0','Trukket tilbake','Trukket tilbake',0,0,'items.wthdrawn',10,'WITHDRAWN','','',0,0,'','','',NULL,9999),('952','1','Tapt','Tapt',0,0,'items.itemlost',10,'LOST','','',0,0,'','','',NULL,9999),('952','2','Kilde for klassifikasjon','Kilde for klassifikasjon',0,0,'items.cn_source',10,'cn_source','','',NULL,0,'','','',NULL,9999),('952','3','Materialespesifikasjon (innbundet årgang eller lignende)','Materialespesifikasjon (innbundet årgang eller lignende)',0,0,'items.materials',10,'','','',NULL,0,'','','',NULL,9999),('952','4','Skadet','Skadet',0,0,'items.damaged',10,'DAMAGED','','',NULL,0,'','','',NULL,9999),('952','5','Begrensninger på bruk','Begrensninger på bruk',0,0,'items.restricted',10,'RESTRICTED','','',0,0,'','','',NULL,9999),('952','6','Koha normalisert klassifikasjon for sortering','Koha normalisert klassifikasjon for sortering',0,0,'items.cn_sort',-1,'','','',0,7,'','','',NULL,9999),('952','7','Ikke til utlån','Ikke til utlån',0,0,'items.notforloan',10,'NOT_LOAN','','',0,0,'','','',NULL,9999),('952','8','Koha samling','Koha samling',0,0,'items.ccode',10,'CCODE','','',0,0,'','','',NULL,9999),('952','9','Koha eksemplarnummer (autogenerert)','Koha eksemplarnummer',0,0,'items.itemnumber',-1,'','','',0,7,'','','',NULL,9999),('952','a','Plassering (eiende filial)','Plassering (eiende filial)',0,0,'items.homebranch',10,'branches','','',0,0,'','','',NULL,9999),('952','b','Annen plassering (midlertidig filial)','Annen plassering (midlertidig filial)',0,0,'items.holdingbranch',10,'branches','','',0,0,'','','',NULL,9999),('952','c','Hylleplassering','Hylleplassering',0,0,'items.location',10,'LOC','','',0,0,'','','',NULL,9999),('952','d','Anskaffelsesdato','Anskaffelsesdato',0,0,'items.dateaccessioned',10,'','','dateaccessioned.pl',0,0,'','','',NULL,9999),('952','e','Kilde for anskaffelse','Kilde for anskaffelse',0,0,'items.booksellerid',10,'','','',0,0,'','','',NULL,9999),('952','f','Kodet plasseringskvalifikator','Kodet plasseringskvalifikator',0,0,'items.coded_location_qualifier',10,'','','',NULL,0,'','','',NULL,9999),('952','g','Pris (normal innkjøpspris)','Pris (normal innkjøpspris)',0,0,'items.price',10,'','','',0,0,'','','',NULL,9999),('952','h','Serienummerering / kronologi','Serienummerering / kronologi',0,0,'items.enumchron',10,'','','',0,0,'','','',NULL,9999),('952','j','Samling','Samling',0,0,'items.stack',10,'STACK','','',NULL,0,'','','',NULL,9999),('952','l','Koha utlån','Koha utlån',0,0,'items.issues',10,'','','',NULL,-5,'','','',NULL,9999),('952','m','Koha fornyinger','Koha fornyinger',0,0,'items.renewals',10,'','','',NULL,-5,'','','',NULL,9999),('952','n','Koha reserveringer','Koha reserveringer',0,0,'items.reserves',10,'','','',NULL,-5,'','','',NULL,9999),('952','o','Koha hyllesignatur','Koha hyllesignatur',0,0,'items.itemcallnumber',10,'','',NULL,0,0,'','','',NULL,9999),('952','p','Strekkode','Strekkode',0,0,'items.barcode',10,'','','barcode.pl',0,0,'','','',NULL,9999),('952','q','Koha utlånt','Koha utlånt',0,0,'items.onloan',10,'','','',NULL,-5,'','','',NULL,9999),('952','r','Koha dato sist sett','Koha dato sist sett',0,0,'items.datelastseen',10,'','','',NULL,-5,'','','',NULL,9999),('952','s','Koha dato sist utlånt','Koha dato sist utlånt',0,0,'items.datelastborrowed',10,'','','',NULL,-5,'','','',NULL,9999),('952','t','Eksemplarnummer','Eksemplarnummer',0,0,'items.copynumber',10,'','','',NULL,0,'','','',NULL,9999),('952','u','Uniform Resource Identifier (URI)','Uniform Resource Identifier (URI)',0,0,'items.uri',10,'','','',1,0,'','','',NULL,9999),('952','v','Pris (erstatningspris)','Pris (erstatningspris)',0,0,'items.replacementprice',10,'','','',0,0,'','','',NULL,9999),('952','w','Pris gjelder fra','Pris gjelder fra',0,0,'items.replacementpricedate',10,'','','',0,0,'','','',NULL,9999),('952','x','Intern note','Intern note',1,0,'items.paidfor',10,'','','',NULL,7,'','','',NULL,9999),('952','y','Koha dokumenttype','Koha dokumenttype',0,0,'items.itype',10,'itemtypes','','',NULL,0,'','','',NULL,9999),('952','z','Synlig note','Synlig note',0,0,'items.itemnotes',10,'','','',NULL,0,'','','',NULL,9999),('999','a','Dokumenttype [Ikke i bruk]','Dokumenttype [Ikke i bruk]',0,0,NULL,-1,NULL,NULL,'',NULL,-5,'','','',NULL,9999),('999','b','Koha Dewey [Ikke i bruk]','Koha Dewey [Ikke i bruk]',0,0,NULL,0,NULL,NULL,'',NULL,-5,'','','',NULL,9999),('999','c','Koha biblionummer','Koha biblionummer',0,0,'biblio.biblionumber',-1,NULL,NULL,'',NULL,-5,'','','',NULL,9999),('999','d','Koha biblioitemnummer','Koha biblioitemnummer',0,0,'biblioitems.biblioitemnumber',-1,NULL,NULL,'',NULL,-5,'','','',NULL,9999);
/*!40000 ALTER TABLE `marc_subfield_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marc_tag_structure`
--

DROP TABLE IF EXISTS `marc_tag_structure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `marc_tag_structure` (
  `tagfield` varchar(3) NOT NULL DEFAULT '',
  `liblibrarian` varchar(255) NOT NULL DEFAULT '',
  `libopac` varchar(255) NOT NULL DEFAULT '',
  `repeatable` tinyint(4) NOT NULL DEFAULT '0',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0',
  `authorised_value` varchar(10) DEFAULT NULL,
  `frameworkcode` varchar(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`frameworkcode`,`tagfield`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marc_tag_structure`
--

LOCK TABLES `marc_tag_structure` WRITE;
/*!40000 ALTER TABLE `marc_tag_structure` DISABLE KEYS */;
INSERT INTO `marc_tag_structure` VALUES ('000','Postens hode','Postens hode',0,1,'',''),('001','Identifikasjonsnummer','Identifikasjonsnummer',0,0,'',''),('007','Fysisk beskrivelse av dokumentet (R)','Fysisk beskrivelse av dokumentet (R)',1,0,'',''),('008','Informasjonskoder','Informasjonskoder',0,0,'',''),('009','Lokale koder','Lokale koder',0,0,'',''),('010','Nasjonalbibliografisk kontrollnummer','Nasjonalbibliografisk kontrollnummer',0,0,'',''),('015','Andre bibliografiske kontrollnummer (R)','Andre bibliografiske kontrollnummer (R)',1,0,'',''),('019','Utvidet informasjonskodefelt','Utvidet informasjonskodefelt',0,0,'',''),('020','Internasjonalt standard boknummer (ISBN)','Internasjonalt standard boknummer (ISBN)',1,0,'',''),('022','Internasjonalt standard periodikanummer (ISSN) (R) [Per]','Internasjonalt standard periodikanummer (ISSN) (R) [Per]',1,0,'',''),('024','Andre standardnumre','Andre standardnumre',0,0,'',''),('025','Europeisk artikkelnummer (EAN)','Europeisk artikkelnummer (EAN)',0,0,'',''),('027','Standard teknisk rapportnummer (STRN)','Standard teknisk rapportnummer (STRN)',0,0,'',''),('028','Utgivernummer/Edisjonsnummer (R) [Mus]','Utgivernummer/Edisjonsnummer (R) [Mus]',1,0,'',''),('030','CODEN [Per]','CODEN [Per]',0,0,'',''),('033','Dato og sted for en hendelse (R)','Dato og sted for en hendelse (R)',1,0,'',''),('040','Katalogiseringskilde','Katalogiseringskilde',0,0,'',''),('041','Språkkoder','Språkkoder',0,0,'',''),('044','Kode for produsentland [F/V, Mus]','Kode for produsentland [F/V, Mus]',0,0,'',''),('045','Kronologi [Mus]','Kronologi [Mus]',0,0,'',''),('060','National Library of Medicine klassifikasjonsnummer (R)','National Library of Medicine klassifikasjonsnummer (R)',1,0,'',''),('074','Offentlig trykksaknummer','Offentlig trykksaknummer',0,0,'',''),('080','Universal desimalklassifikasjon (UDK) (R)','Universal desimalklassifikasjon (UDK) (R)',1,0,'',''),('082','Dewey desimalklassifikasjon (DDK) (R)','Dewey desimalklassifikasjon (DDK) (R)',1,0,'',''),('084','Andre klassifikasjonsnummer (R)','Andre klassifikasjonsnummer (R)',1,0,'',''),('09X','Lokale felt','Lokale felt',0,0,'',''),('100','Hovedordningsord personnavn','Hovedordningsord personnavn',0,0,'',''),('110','Hovedordningsord korporasjonsnavn','Hovedordningsord korporasjonsnavn',0,0,'',''),('111','Hovedordningsord konferanse-, møte-, utstillingsnavn etc','Hovedordningsord konferanse-, møte-, utstillingsnavn etc',0,0,'',''),('130','Hovedordningsord standardtittel','Hovedordningsord standardtittel',0,0,'',''),('210','Forkortet tittel [Per]','Forkortet tittel [Per]',0,0,'',''),('222','Nøkkeltittel [Per]','Nøkkeltittel [Per]',0,0,'',''),('240','Standardtittel','Standardtittel',0,0,'',''),('245','Tittel og ansvarsopplysninger','Tittel og ansvarsopplysninger',0,0,'',''),('246','Parallelltittel (R)','Parallelltittel (R)',1,0,'',''),('250','Utgave','Utgave',0,0,'',''),('254','Musikktrykkets fysiske presentasjon [Mus]','Musikktrykkets fysiske presentasjon [Mus]',0,0,'',''),('255','Matematiske data [Kar]','Matematiske data [Kar]',0,0,'',''),('256','Filkarakteristika [Fil]','Filkarakteristika [Fil]',0,0,'',''),('260','Utgivelse, distribusjon osv','Utgivelse, distribusjon osv',0,0,'',''),('263','Beregnet publikasjonsdato','Beregnet publikasjonsdato',0,0,'',''),('270','Adresse (R)','Adresse (R)',1,0,'',''),('300','Fysisk beskrivelse','Fysisk beskrivelse',0,0,'',''),('306','Varighet [Mus]','Varighet [Mus]',0,0,'',''),('310','Periodisitet [Per]','Periodisitet [Per]',0,0,'',''),('350','Pris [Per]','Pris [Per]',0,0,'',''),('362','Numeriske og/eller alfabetiske og kronologiske betegnelser [Per]','Numeriske og/eller alfabetiske og kronologiske betegnelser [Per]',0,0,'',''),('440','Serieangivelse med biinnførsel (R)','Serieangivelse med biinnførsel (R)',1,0,'',''),('490','Serieangivelse uten biinnførsel (R)','Serieangivelse uten biinnførsel (R)',1,0,'',''),('500','Generell note (R)','Generell note (R)',1,0,'',''),('501','\"Sammen med\"-note (R)','\"Sammen med\"-note (R)',1,0,'',''),('502','Avhandlinger, dissertaser og hovedoppgaver (R)','Avhandlinger, dissertaser og hovedoppgaver (R)',1,0,'',''),('503','Utgave/Historikk (R)','Utgave/Historikk (R)',1,0,'',''),('505','Innholdsnote (R)','Innholdsnote (R)',1,0,'',''),('508','Ansvarshavende (R)','Ansvarshavende (R)',1,0,'',''),('510','Referanser (R)','Referanser (R)',1,0,'',''),('511','Note for utøvere / Medarbeidere [Mus, F/V] (R)','Note for utøvere / Medarbeidere [Mus, F/V] (R)',1,0,'',''),('512','Art, ramme eller kunstnerisk form (R)','Art, ramme eller kunstnerisk form (R)',1,0,'',''),('516','Filtype [Fil] (R)','Filtype [Fil] (R)',1,0,'',''),('520','Sammendrag (R)','Sammendrag (R)',1,0,'',''),('521','Brukergruppe (R)','Brukergruppe (R)',1,0,'',''),('525','Bilag og supplementer (R)','Bilag og supplementer (R)',1,0,'',''),('530','Andre materialtyper (R)','Andre materialtyper (R)',1,0,'',''),('531','Spesielle materialdetaljer (R)','Spesielle materialdetaljer (R)',1,0,'',''),('532','Utgivelse, distribusjon, etc (R)','Utgivelse, distribusjon, etc (R)',1,0,'',''),('533','Fysisk beskrivelse (R)','Fysisk beskrivelse (R)',1,0,'',''),('538','Systemdetaljer og filkarakteristika [Fil] (R)','Systemdetaljer og filkarakteristika [Fil] (R)',1,0,'',''),('539','Serier (R)','Serier (R)',1,0,'',''),('546','Språk og/eller oversettelse/bearbeidelse (R)','Språk og/eller oversettelse/bearbeidelse (R)',1,0,'',''),('571','Nummerbetegnelser (R)','Nummerbetegnelser (R)',1,0,'',''),('572','Varianter av tittel (R)','Varianter av tittel (R)',1,0,'',''),('573','Kilde for hovedtittel (R)','Kilde for hovedtittel (R)',1,0,'',''),('574','Originaltittel (R)','Originaltittel (R)',1,0,'',''),('59X','Lokale noter (R)','Lokale noter (R)',1,0,'',''),('600','Emneinnførsel personnavn (R)','Emneinnførsel personnavn (R)',1,0,'',''),('610','Emneinnførsel korporasjonsnavn (R)','Emneinnførsel korporasjonsnavn (R)',1,0,'',''),('611','Emneinnførsel konferanse-, møte-, utstillingsnavn etc (R)','Emneinnførsel konferanse-, møte-, utstillingsnavn etc (R)',1,0,'',''),('630','Emneinnførsel standardtittel (R)','Emneinnførsel standardtittel (R)',1,0,'',''),('640','Emneinnførsel tittel (R)','Emneinnførsel tittel (R)',1,0,'',''),('650','Generelle emneord (R)','Generelle emneord (R)',1,0,'',''),('651','Geografisk sted som emneord (R)','Geografisk sted som emneord (R)',1,0,'',''),('652','Komposisjonstype [Mus] (R)','Komposisjonstype [Mus] (R)',1,0,'',''),('653','Frie nøkkelord (R)','Frie nøkkelord (R)',1,0,'',''),('655','Genre-/form-emneord (R)','Genre-/form-emneord (R)',1,0,'',''),('656','Yrkesbetegnelse som emneord (R)','Yrkesbetegnelse som emneord (R)',1,0,'',''),('658','Besetning [Mus] (R)','Besetning [Mus] (R)',1,0,'',''),('69X','Lokale emneinnførsler (R)','Lokale emneinnførsler (R)',1,0,'',''),('700','Biinnførsel personnavn (R)','Biinnførsel personnavn (R)',1,0,'',''),('710','Biinnførsel korporasjonsnavn (R)','Biinnførsel korporasjonsnavn (R)',1,0,'',''),('711','Biinnførsel konferanse-, møte-, utstillingsnavn etc (R)','Biinnførsel konferanse-, møte-, utstillingsnavn etc (R)',1,0,'',''),('730','Biinnførsel standardtittel (R)','Biinnførsel standardtittel (R)',1,0,'',''),('740','Biinnførsel tittel (R)','Biinnførsel tittel (R)',1,0,'',''),('752','Biinnførsel stedsnavn (hierarkisk) (R)','Biinnførsel stedsnavn (hierarkisk) (R)',1,0,'',''),('753','Biinnførsel systemkrav [Fil] (R)','Biinnførsel systemkrav [Fil] (R)',1,0,'',''),('760','Overordnet enhet (R)','Overordnet enhet (R)',1,0,'',''),('762','Underordnet enhet (R)','Underordnet enhet (R)',1,0,'',''),('765','Originalspråkutgave (R)','Originalspråkutgave (R)',1,0,'',''),('767','Oversatt utgave (R)','Oversatt utgave (R)',1,0,'',''),('770','Supplement (R)','Supplement (R)',1,0,'',''),('772','Hoveddokument (R)','Hoveddokument (R)',1,0,'',''),('773','Vertsdokument (R)','Vertsdokument (R)',1,0,'',''),('775','Andre utgaver (R)','Andre utgaver (R)',1,0,'',''),('776','Andre materialvarianter (R)','Andre materialvarianter (R)',1,0,'',''),('777','Utgitt sammen med (R)','Utgitt sammen med (R)',1,0,'',''),('780','Fortsettelse av (R)','Fortsettelse av (R)',1,0,'',''),('785','Fortsettes i (R)','Fortsettes i (R)',1,0,'',''),('787','Ikkespesifisert relasjon (R)','Ikkespesifisert relasjon (R)',1,0,'',''),('79X','Lokale lenker (R)','Lokale lenker (R)',1,0,'',''),('800','Serieinnførsel personnavn (R)','Serieinnførsel personnavn (R)',1,0,'',''),('810','Serieinnførsel korporasjonsnavn (R)','Serieinnførsel korporasjonsnavn (R)',1,0,'',''),('811','Serieinnførsel konferanse-, møte-, utstillingsnavn etc (R)','Serieinnførsel konferanse-, møte-, utstillingsnavn etc (R)',1,0,'',''),('830','Serieinnførsel standardtittel (R)','Serieinnførsel standardtittel (R)',1,0,'',''),('850','Eiende institusjon og beholdningsinformasjon (R)','Eiende institusjon og beholdningsinformasjon (R)',1,0,'',''),('856','Elektronisk lokalisering og tilgang (R)','Elektronisk lokalisering og tilgang (R)',1,0,'',''),('900','Henvisning fra personnavn (R)','Henvisning fra personnavn (R)',1,0,'',''),('910','Henvisning fra korporasjonsnavn (R)','Henvisning fra korporasjonsnavn (R)',1,0,'',''),('911','Henvisning fra konferanse-, møte-, utstillingsnavn etc (R)','Henvisning fra konferanse-, møte-, utstillingsnavn etc (R)',1,0,'',''),('930','Henvisning fra standardtittel (R)','Henvisning fra standardtittel (R)',1,0,'',''),('940','Henvisning fra tittel (R)','Henvisning fra tittel (R)',1,0,'',''),('942','Andre opplysninger (Koha)','Andre opplysninger (Koha)',0,0,'',''),('950','Andre henvisninger (R)','Andre henvisninger (R)',1,0,'',''),('952','Eksemplarinformasjon (Koha)','Eksemplarinformasjon (Koha)',1,0,'',''),('999','Kontrollnummer (Koha)','Kontrollnummer (Koha)',1,0,'',''),('99X','Lokale henvisninger (R)','Lokale henvisninger (R)',1,0,'','');
/*!40000 ALTER TABLE `marc_tag_structure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchchecks`
--

DROP TABLE IF EXISTS `matchchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchchecks` (
  `matcher_id` int(11) NOT NULL,
  `matchcheck_id` int(11) NOT NULL AUTO_INCREMENT,
  `source_matchpoint_id` int(11) NOT NULL,
  `target_matchpoint_id` int(11) NOT NULL,
  PRIMARY KEY (`matchcheck_id`),
  KEY `matcher_matchchecks_ifbk_1` (`matcher_id`),
  KEY `matcher_matchchecks_ifbk_2` (`source_matchpoint_id`),
  KEY `matcher_matchchecks_ifbk_3` (`target_matchpoint_id`),
  CONSTRAINT `matcher_matchchecks_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchchecks_ifbk_2` FOREIGN KEY (`source_matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchchecks_ifbk_3` FOREIGN KEY (`target_matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchchecks`
--

LOCK TABLES `matchchecks` WRITE;
/*!40000 ALTER TABLE `matchchecks` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matcher_matchpoints`
--

DROP TABLE IF EXISTS `matcher_matchpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matcher_matchpoints` (
  `matcher_id` int(11) NOT NULL,
  `matchpoint_id` int(11) NOT NULL,
  KEY `matcher_matchpoints_ifbk_1` (`matcher_id`),
  KEY `matcher_matchpoints_ifbk_2` (`matchpoint_id`),
  CONSTRAINT `matcher_matchpoints_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matcher_matchpoints_ifbk_2` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matcher_matchpoints`
--

LOCK TABLES `matcher_matchpoints` WRITE;
/*!40000 ALTER TABLE `matcher_matchpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `matcher_matchpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchpoint_component_norms`
--

DROP TABLE IF EXISTS `matchpoint_component_norms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchpoint_component_norms` (
  `matchpoint_component_id` int(11) NOT NULL,
  `sequence` int(11) NOT NULL DEFAULT '0',
  `norm_routine` varchar(50) NOT NULL DEFAULT '',
  KEY `matchpoint_component_norms` (`matchpoint_component_id`,`sequence`),
  CONSTRAINT `matchpoint_component_norms_ifbk_1` FOREIGN KEY (`matchpoint_component_id`) REFERENCES `matchpoint_components` (`matchpoint_component_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchpoint_component_norms`
--

LOCK TABLES `matchpoint_component_norms` WRITE;
/*!40000 ALTER TABLE `matchpoint_component_norms` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchpoint_component_norms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchpoint_components`
--

DROP TABLE IF EXISTS `matchpoint_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchpoint_components` (
  `matchpoint_id` int(11) NOT NULL,
  `matchpoint_component_id` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(3) NOT NULL DEFAULT '',
  `subfields` varchar(40) NOT NULL DEFAULT '',
  `offset` int(4) NOT NULL DEFAULT '0',
  `length` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matchpoint_component_id`),
  KEY `by_sequence` (`matchpoint_id`,`sequence`),
  CONSTRAINT `matchpoint_components_ifbk_1` FOREIGN KEY (`matchpoint_id`) REFERENCES `matchpoints` (`matchpoint_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchpoint_components`
--

LOCK TABLES `matchpoint_components` WRITE;
/*!40000 ALTER TABLE `matchpoint_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchpoint_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matchpoints`
--

DROP TABLE IF EXISTS `matchpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matchpoints` (
  `matcher_id` int(11) NOT NULL,
  `matchpoint_id` int(11) NOT NULL AUTO_INCREMENT,
  `search_index` varchar(30) NOT NULL DEFAULT '',
  `score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`matchpoint_id`),
  KEY `matchpoints_ifbk_1` (`matcher_id`),
  CONSTRAINT `matchpoints_ifbk_1` FOREIGN KEY (`matcher_id`) REFERENCES `marc_matchers` (`matcher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matchpoints`
--

LOCK TABLES `matchpoints` WRITE;
/*!40000 ALTER TABLE `matchpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `matchpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_attributes`
--

DROP TABLE IF EXISTS `message_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_attributes` (
  `message_attribute_id` int(11) NOT NULL AUTO_INCREMENT,
  `message_name` varchar(40) NOT NULL DEFAULT '',
  `takes_days` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`message_attribute_id`),
  UNIQUE KEY `message_name` (`message_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_attributes`
--

LOCK TABLES `message_attributes` WRITE;
/*!40000 ALTER TABLE `message_attributes` DISABLE KEYS */;
INSERT INTO `message_attributes` VALUES (1,'Item_Due',0),(2,'Advance_Notice',1),(4,'Hold_Filled',0),(5,'Item_Check_in',0),(6,'Item_Checkout',0);
/*!40000 ALTER TABLE `message_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_queue`
--

DROP TABLE IF EXISTS `message_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_queue` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `subject` text,
  `content` text,
  `metadata` text,
  `letter_code` varchar(64) DEFAULT NULL,
  `message_transport_type` varchar(20) NOT NULL,
  `status` enum('sent','pending','failed','deleted') NOT NULL DEFAULT 'pending',
  `time_queued` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `to_address` mediumtext,
  `from_address` mediumtext,
  `content_type` text,
  KEY `message_id` (`message_id`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `message_transport_type` (`message_transport_type`),
  CONSTRAINT `messageq_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `messageq_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_queue`
--

LOCK TABLES `message_queue` WRITE;
/*!40000 ALTER TABLE `message_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_transport_types`
--

DROP TABLE IF EXISTS `message_transport_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_transport_types` (
  `message_transport_type` varchar(20) NOT NULL,
  PRIMARY KEY (`message_transport_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_transport_types`
--

LOCK TABLES `message_transport_types` WRITE;
/*!40000 ALTER TABLE `message_transport_types` DISABLE KEYS */;
INSERT INTO `message_transport_types` VALUES ('email'),('feed'),('print'),('sms');
/*!40000 ALTER TABLE `message_transport_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_transports`
--

DROP TABLE IF EXISTS `message_transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_transports` (
  `message_attribute_id` int(11) NOT NULL,
  `message_transport_type` varchar(20) NOT NULL,
  `is_digest` tinyint(1) NOT NULL DEFAULT '0',
  `letter_module` varchar(20) NOT NULL DEFAULT '',
  `letter_code` varchar(20) NOT NULL DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`message_attribute_id`,`message_transport_type`,`is_digest`),
  KEY `message_transport_type` (`message_transport_type`),
  KEY `letter_module` (`letter_module`,`letter_code`),
  KEY `message_transports_ibfk_3` (`letter_module`,`letter_code`,`branchcode`),
  CONSTRAINT `message_transports_ibfk_1` FOREIGN KEY (`message_attribute_id`) REFERENCES `message_attributes` (`message_attribute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_transports_ibfk_2` FOREIGN KEY (`message_transport_type`) REFERENCES `message_transport_types` (`message_transport_type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_transports_ibfk_3` FOREIGN KEY (`letter_module`, `letter_code`, `branchcode`) REFERENCES `letter` (`module`, `code`, `branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_transports`
--

LOCK TABLES `message_transports` WRITE;
/*!40000 ALTER TABLE `message_transports` DISABLE KEYS */;
INSERT INTO `message_transports` VALUES (5,'email',0,'circulation','CHECKIN',''),(5,'sms',0,'circulation','CHECKIN',''),(6,'email',0,'circulation','CHECKOUT',''),(6,'sms',0,'circulation','CHECKOUT',''),(1,'email',0,'circulation','DUE',''),(1,'sms',0,'circulation','DUE',''),(1,'email',1,'circulation','DUEDGST',''),(1,'sms',1,'circulation','DUEDGST',''),(2,'email',0,'circulation','PREDUE',''),(2,'sms',0,'circulation','PREDUE',''),(2,'email',1,'circulation','PREDUEDGST',''),(2,'sms',1,'circulation','PREDUEDGST',''),(4,'email',0,'reserves','HOLD',''),(4,'sms',0,'reserves','HOLD','');
/*!40000 ALTER TABLE `message_transports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `message_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `message_type` varchar(1) NOT NULL,
  `message` text NOT NULL,
  `message_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `need_merge_authorities`
--

DROP TABLE IF EXISTS `need_merge_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `need_merge_authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authid` bigint(20) NOT NULL,
  `done` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `need_merge_authorities`
--

LOCK TABLES `need_merge_authorities` WRITE;
/*!40000 ALTER TABLE `need_merge_authorities` DISABLE KEYS */;
/*!40000 ALTER TABLE `need_merge_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifys`
--

DROP TABLE IF EXISTS `notifys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifys` (
  `notify_id` int(11) NOT NULL DEFAULT '0',
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `itemnumber` int(11) NOT NULL DEFAULT '0',
  `notify_date` date DEFAULT NULL,
  `notify_send_date` date DEFAULT NULL,
  `notify_level` int(1) NOT NULL DEFAULT '0',
  `method` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifys`
--

LOCK TABLES `notifys` WRITE;
/*!40000 ALTER TABLE `notifys` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets`
--

DROP TABLE IF EXISTS `oai_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `spec` varchar(80) NOT NULL,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `spec` (`spec`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets`
--

LOCK TABLES `oai_sets` WRITE;
/*!40000 ALTER TABLE `oai_sets` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets_biblios`
--

DROP TABLE IF EXISTS `oai_sets_biblios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets_biblios` (
  `biblionumber` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  PRIMARY KEY (`biblionumber`,`set_id`),
  KEY `oai_sets_biblios_ibfk_2` (`set_id`),
  CONSTRAINT `oai_sets_biblios_ibfk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oai_sets_biblios_ibfk_2` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets_biblios`
--

LOCK TABLES `oai_sets_biblios` WRITE;
/*!40000 ALTER TABLE `oai_sets_biblios` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets_biblios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets_descriptions`
--

DROP TABLE IF EXISTS `oai_sets_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets_descriptions` (
  `set_id` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  KEY `oai_sets_descriptions_ibfk_1` (`set_id`),
  CONSTRAINT `oai_sets_descriptions_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets_descriptions`
--

LOCK TABLES `oai_sets_descriptions` WRITE;
/*!40000 ALTER TABLE `oai_sets_descriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_sets_mappings`
--

DROP TABLE IF EXISTS `oai_sets_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oai_sets_mappings` (
  `set_id` int(11) NOT NULL,
  `marcfield` char(3) NOT NULL,
  `marcsubfield` char(1) NOT NULL,
  `marcvalue` varchar(80) NOT NULL,
  KEY `oai_sets_mappings_ibfk_1` (`set_id`),
  CONSTRAINT `oai_sets_mappings_ibfk_1` FOREIGN KEY (`set_id`) REFERENCES `oai_sets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_sets_mappings`
--

LOCK TABLES `oai_sets_mappings` WRITE;
/*!40000 ALTER TABLE `oai_sets_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_sets_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_issues`
--

DROP TABLE IF EXISTS `old_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_issues` (
  `borrowernumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `issuingbranch` varchar(18) DEFAULT NULL,
  `returndate` datetime DEFAULT NULL,
  `lastreneweddate` datetime DEFAULT NULL,
  `return` varchar(4) DEFAULT NULL,
  `renewals` tinyint(4) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `issuedate` datetime DEFAULT NULL,
  KEY `old_issuesborridx` (`borrowernumber`),
  KEY `old_issuesitemidx` (`itemnumber`),
  KEY `branchcode_idx` (`branchcode`),
  KEY `issuingbranch_idx` (`issuingbranch`),
  KEY `old_bordate` (`borrowernumber`,`timestamp`),
  CONSTRAINT `old_issues_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_issues_ibfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_issues`
--

LOCK TABLES `old_issues` WRITE;
/*!40000 ALTER TABLE `old_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `old_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_reserves`
--

DROP TABLE IF EXISTS `old_reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_reserves` (
  `reserve_id` int(11) NOT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) DEFAULT NULL,
  `constrainttype` varchar(1) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `notificationdate` date DEFAULT NULL,
  `reminderdate` date DEFAULT NULL,
  `cancellationdate` date DEFAULT NULL,
  `reservenotes` mediumtext,
  `priority` smallint(6) DEFAULT NULL,
  `found` varchar(1) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `itemnumber` int(11) DEFAULT NULL,
  `waitingdate` date DEFAULT NULL,
  `expirationdate` date DEFAULT NULL,
  `lowestPriority` tinyint(1) NOT NULL,
  `suspend` tinyint(1) NOT NULL DEFAULT '0',
  `suspend_until` datetime DEFAULT NULL,
  PRIMARY KEY (`reserve_id`),
  KEY `old_reserves_borrowernumber` (`borrowernumber`),
  KEY `old_reserves_biblionumber` (`biblionumber`),
  KEY `old_reserves_itemnumber` (`itemnumber`),
  KEY `old_reserves_branchcode` (`branchcode`),
  CONSTRAINT `old_reserves_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_reserves_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `old_reserves_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_reserves`
--

LOCK TABLES `old_reserves` WRITE;
/*!40000 ALTER TABLE `old_reserves` DISABLE KEYS */;
/*!40000 ALTER TABLE `old_reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opac_news`
--

DROP TABLE IF EXISTS `opac_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opac_news` (
  `idnew` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL DEFAULT '',
  `new` text NOT NULL,
  `lang` varchar(25) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expirationdate` date DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnew`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opac_news`
--

LOCK TABLES `opac_news` WRITE;
/*!40000 ALTER TABLE `opac_news` DISABLE KEYS */;
/*!40000 ALTER TABLE `opac_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `overduerules`
--

DROP TABLE IF EXISTS `overduerules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `overduerules` (
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `categorycode` varchar(10) NOT NULL DEFAULT '',
  `delay1` int(4) DEFAULT NULL,
  `letter1` varchar(20) DEFAULT NULL,
  `debarred1` varchar(1) DEFAULT '0',
  `delay2` int(4) DEFAULT NULL,
  `debarred2` varchar(1) DEFAULT '0',
  `letter2` varchar(20) DEFAULT NULL,
  `delay3` int(4) DEFAULT NULL,
  `letter3` varchar(20) DEFAULT NULL,
  `debarred3` int(1) DEFAULT '0',
  PRIMARY KEY (`branchcode`,`categorycode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `overduerules`
--

LOCK TABLES `overduerules` WRITE;
/*!40000 ALTER TABLE `overduerules` DISABLE KEYS */;
/*!40000 ALTER TABLE `overduerules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patroncards`
--

DROP TABLE IF EXISTS `patroncards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patroncards` (
  `cardid` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` varchar(10) NOT NULL DEFAULT '1',
  `borrowernumber` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cardid`),
  KEY `patroncards_ibfk_1` (`borrowernumber`),
  CONSTRAINT `patroncards_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patroncards`
--

LOCK TABLES `patroncards` WRITE;
/*!40000 ALTER TABLE `patroncards` DISABLE KEYS */;
/*!40000 ALTER TABLE `patroncards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patronimage`
--

DROP TABLE IF EXISTS `patronimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patronimage` (
  `cardnumber` varchar(16) NOT NULL,
  `mimetype` varchar(15) NOT NULL,
  `imagefile` mediumblob NOT NULL,
  PRIMARY KEY (`cardnumber`),
  CONSTRAINT `patronimage_fk1` FOREIGN KEY (`cardnumber`) REFERENCES `borrowers` (`cardnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patronimage`
--

LOCK TABLES `patronimage` WRITE;
/*!40000 ALTER TABLE `patronimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `patronimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_offline_operations`
--

DROP TABLE IF EXISTS `pending_offline_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pending_offline_operations` (
  `operationid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(30) NOT NULL,
  `branchcode` varchar(10) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `action` varchar(10) NOT NULL,
  `barcode` varchar(20) DEFAULT NULL,
  `cardnumber` varchar(16) DEFAULT NULL,
  `amount` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`operationid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_offline_operations`
--

LOCK TABLES `pending_offline_operations` WRITE;
/*!40000 ALTER TABLE `pending_offline_operations` DISABLE KEYS */;
/*!40000 ALTER TABLE `pending_offline_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `module_bit` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`module_bit`,`code`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`module_bit`) REFERENCES `userflags` (`bit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'circulate_remaining_permissions','Øvrige rettigheter for sirkulasjon'),(1,'overdues_report','Execute overdue items report'),(1,'override_renewals','Overstyre blokkerte fornyinger'),(3,'manage_circ_rules','Endre sirkulasjonsregler'),(3,'parameters_remaining_permissions','Øvrige rettigheter knyttet til systempreferanser'),(6,'modify_holds_priority','Endre rekkefølge på reserveringer'),(6,'place_holds','Foreta reservering for lånere'),(9,'edit_catalogue','Endre katalogen (Endre bibliografiske poster og eksemplaropplysninger)'),(9,'edit_items','Endre eksmeplarer'),(9,'fast_cataloging','Hurtigkatalogisering'),(11,'budget_add_del','Legge til og slette budsjetter (men ikke endre budsjetter)'),(11,'budget_manage','Administrere budsjetter'),(11,'budget_manage_all','Administrere alle budsjetter'),(11,'budget_modify','Endre budsjetter (kan ikke legge til kontolinjer, men endre eksisterende)'),(11,'contracts_manage','Administrere kontrakter'),(11,'group_manage','Administrere bestillinger og kurv-grupper'),(11,'order_manage','Administrere bestillinger og kurver'),(11,'order_receive','Administrere bestillinger og kurver'),(11,'period_manage','Administrere perioder'),(11,'planning_manage','Administrere budsjettplaner'),(11,'vendors_manage','Administrere leverandører'),(13,'batch_upload_patron_images','Laste opp bilder av lånere enkeltvis eller en masse'),(13,'delete_anonymize_patrons','Slette utgåtte lånere og anonymisere lånehistorikk'),(13,'edit_calendar','Definere dager da biblioteket er stengt'),(13,'edit_news','Legge ut nyhter i OPACen og det interne grensesnittet'),(13,'edit_notices','Definere meldinger'),(13,'edit_notice_status_triggers','Definere utløsere for meldinger og statusenderinger for for sent leverte dokumenter'),(13,'edit_patrons','Utføre satsvise endringer av lånere'),(13,'edit_quotes','Endre sitater for dagens sitat-funksjonen'),(13,'export_catalog','Eksportere bibliografiske data og beholdningsdata'),(13,'import_patrons','Importere låneropplysninger'),(13,'inventory','Foreta varetelling'),(13,'items_batchdel','Utføre masseslettinger av eksemplarer'),(13,'items_batchmod','Utføre masseendringer av eksemplarer'),(13,'label_creator','Lage etiketter og strekkoder basert på bibliografiske poster og lånerdata'),(13,'manage_csv_profiles','Administrere CSV eksportprofiler'),(13,'manage_staged_marc','Behandle lagrede MARC-poster, inkludert ferdigstilling og reversering av importer'),(13,'moderate_comments','Behandle kommentarer fra lånere'),(13,'moderate_tags','Behandle tagger fra lånere'),(13,'rotating_collections','Administrere roterende samlinger'),(13,'schedule_tasks','Planlegge oppgaver som skal kjøres'),(13,'stage_marc_import','Importere MARC-poster til brønnen'),(13,'upload_local_cover_images','Laste opp lokale omslagsbilder'),(13,'view_system_logs','Se Koha sine logger'),(15,'check_expiration','Sjekke utløpsdato for et periodikum'),(15,'claim_serials','Purre manglende tidsskrifthefter'),(15,'create_subscription','Opprette abonnementer'),(15,'delete_subscription','Slette eksisterende abonnementer'),(15,'edit_subscription','Endre eksisterende abonnementer'),(15,'receive_serials','Heftemottak'),(15,'renew_subscription','Fornye abonnementer'),(15,'routing','Sirkulasjon'),(16,'create_reports','Opprette SQL-rapporter'),(16,'execute_reports','Kjøre SQL-rapporter'),(19,'configure','Configure plugins'),(19,'manage','Manage plugins ( install / uninstall )'),(19,'report','Use report plugins'),(19,'tool','Use tool plugins');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_data`
--

DROP TABLE IF EXISTS `plugin_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_data` (
  `plugin_class` varchar(255) NOT NULL,
  `plugin_key` varchar(255) NOT NULL,
  `plugin_value` text,
  PRIMARY KEY (`plugin_class`,`plugin_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_data`
--

LOCK TABLES `plugin_data` WRITE;
/*!40000 ALTER TABLE `plugin_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugin_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers` (
  `printername` varchar(40) NOT NULL DEFAULT '',
  `printqueue` varchar(20) DEFAULT NULL,
  `printtype` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`printername`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers`
--

LOCK TABLES `printers` WRITE;
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers_profile`
--

DROP TABLE IF EXISTS `printers_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers_profile` (
  `profile_id` int(4) NOT NULL AUTO_INCREMENT,
  `printer_name` varchar(40) NOT NULL DEFAULT 'Default Printer',
  `template_id` int(4) NOT NULL DEFAULT '0',
  `paper_bin` varchar(20) NOT NULL DEFAULT 'Bypass',
  `offset_horz` float NOT NULL DEFAULT '0',
  `offset_vert` float NOT NULL DEFAULT '0',
  `creep_horz` float NOT NULL DEFAULT '0',
  `creep_vert` float NOT NULL DEFAULT '0',
  `units` char(20) NOT NULL DEFAULT 'POINT',
  `creator` char(15) NOT NULL DEFAULT 'Labels',
  PRIMARY KEY (`profile_id`),
  UNIQUE KEY `printername` (`printer_name`,`template_id`,`paper_bin`,`creator`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers_profile`
--

LOCK TABLES `printers_profile` WRITE;
/*!40000 ALTER TABLE `printers_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `printers_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotes`
--

DROP TABLE IF EXISTS `quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` text,
  `text` mediumtext NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotes`
--

LOCK TABLES `quotes` WRITE;
/*!40000 ALTER TABLE `quotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `borrowernumber` int(11) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `rating_value` tinyint(1) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`borrowernumber`,`biblionumber`),
  KEY `ratings_ibfk_2` (`biblionumber`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repeatable_holidays`
--

DROP TABLE IF EXISTS `repeatable_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repeatable_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `weekday` smallint(6) DEFAULT NULL,
  `day` smallint(6) DEFAULT NULL,
  `month` smallint(6) DEFAULT NULL,
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repeatable_holidays`
--

LOCK TABLES `repeatable_holidays` WRITE;
/*!40000 ALTER TABLE `repeatable_holidays` DISABLE KEYS */;
INSERT INTO `repeatable_holidays` VALUES (2,'',0,NULL,NULL,'','Søndager'),(3,'',NULL,1,1,'','1. nyttårsdag'),(4,'',NULL,1,5,'','1. mai'),(5,'',NULL,17,5,'','17. mai'),(6,'',NULL,25,12,'','1. juledag'),(7,'',NULL,26,12,'','2. juledag');
/*!40000 ALTER TABLE `repeatable_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports_dictionary`
--

DROP TABLE IF EXISTS `reports_dictionary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `saved_sql` text,
  `report_area` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dictionary_area_idx` (`report_area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports_dictionary`
--

LOCK TABLES `reports_dictionary` WRITE;
/*!40000 ALTER TABLE `reports_dictionary` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports_dictionary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserveconstraints`
--

DROP TABLE IF EXISTS `reserveconstraints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserveconstraints` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `biblioitemnumber` int(11) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserveconstraints`
--

LOCK TABLES `reserveconstraints` WRITE;
/*!40000 ALTER TABLE `reserveconstraints` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserveconstraints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserves`
--

DROP TABLE IF EXISTS `reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserves` (
  `reserve_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `reservedate` date DEFAULT NULL,
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `constrainttype` varchar(1) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `notificationdate` date DEFAULT NULL,
  `reminderdate` date DEFAULT NULL,
  `cancellationdate` date DEFAULT NULL,
  `reservenotes` mediumtext,
  `priority` smallint(6) DEFAULT NULL,
  `found` varchar(1) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `itemnumber` int(11) DEFAULT NULL,
  `waitingdate` date DEFAULT NULL,
  `expirationdate` date DEFAULT NULL,
  `lowestPriority` tinyint(1) NOT NULL,
  `suspend` tinyint(1) NOT NULL DEFAULT '0',
  `suspend_until` datetime DEFAULT NULL,
  PRIMARY KEY (`reserve_id`),
  KEY `priorityfoundidx` (`priority`,`found`),
  KEY `borrowernumber` (`borrowernumber`),
  KEY `biblionumber` (`biblionumber`),
  KEY `itemnumber` (`itemnumber`),
  KEY `branchcode` (`branchcode`),
  CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_3` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_4` FOREIGN KEY (`branchcode`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserves`
--

LOCK TABLES `reserves` WRITE;
/*!40000 ALTER TABLE `reserves` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `reviewid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `biblionumber` int(11) DEFAULT NULL,
  `review` text,
  `approved` tinyint(4) DEFAULT NULL,
  `datereviewed` datetime DEFAULT NULL,
  PRIMARY KEY (`reviewid`),
  KEY `reviews_ibfk_1` (`borrowernumber`),
  KEY `reviews_ibfk_2` (`biblionumber`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roadtype`
--

DROP TABLE IF EXISTS `roadtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roadtype` (
  `roadtypeid` int(11) NOT NULL AUTO_INCREMENT,
  `road_type` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`roadtypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roadtype`
--

LOCK TABLES `roadtype` WRITE;
/*!40000 ALTER TABLE `roadtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `roadtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_reports`
--

DROP TABLE IF EXISTS `saved_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) DEFAULT NULL,
  `report` longtext,
  `date_run` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_reports`
--

LOCK TABLES `saved_reports` WRITE;
/*!40000 ALTER TABLE `saved_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved_sql`
--

DROP TABLE IF EXISTS `saved_sql`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saved_sql` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `savedsql` text,
  `last_run` datetime DEFAULT NULL,
  `report_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `notes` text,
  `cache_expiry` int(11) NOT NULL DEFAULT '300',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `report_area` varchar(6) DEFAULT NULL,
  `report_group` varchar(80) DEFAULT NULL,
  `report_subgroup` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sql_area_group_idx` (`report_group`,`report_subgroup`),
  KEY `boridx` (`borrowernumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved_sql`
--

LOCK TABLES `saved_sql` WRITE;
/*!40000 ALTER TABLE `saved_sql` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved_sql` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_history`
--

DROP TABLE IF EXISTS `search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_history` (
  `userid` int(11) NOT NULL,
  `sessionid` varchar(32) NOT NULL,
  `query_desc` varchar(255) NOT NULL,
  `query_cgi` text NOT NULL,
  `total` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `userid` (`userid`),
  KEY `sessionid` (`sessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Opac search history results';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_history`
--

LOCK TABLES `search_history` WRITE;
/*!40000 ALTER TABLE `search_history` DISABLE KEYS */;
INSERT INTO `search_history` VALUES (1,'4fb66458b9236abcb27ead5bc32115fd','kw,wrdl: jason, ','q=jason',369,'2013-10-10 11:58:52'),(1,'4fb66458b9236abcb27ead5bc32115fd','kw,wrdl: jason, au:Jason','idx=kw&q=jason&sort_by=relevance_dsc&limit=au%3AJason',308,'2013-10-10 11:59:00');
/*!40000 ALTER TABLE `search_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serial`
--

DROP TABLE IF EXISTS `serial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serial` (
  `serialid` int(11) NOT NULL AUTO_INCREMENT,
  `biblionumber` varchar(100) NOT NULL DEFAULT '',
  `subscriptionid` varchar(100) NOT NULL DEFAULT '',
  `serialseq` varchar(100) NOT NULL DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `planneddate` date DEFAULT NULL,
  `notes` text,
  `publisheddate` date DEFAULT NULL,
  `itemnumber` text,
  `claimdate` date DEFAULT NULL,
  `routingnotes` text,
  PRIMARY KEY (`serialid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serial`
--

LOCK TABLES `serial` WRITE;
/*!40000 ALTER TABLE `serial` DISABLE KEYS */;
/*!40000 ALTER TABLE `serial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serialitems`
--

DROP TABLE IF EXISTS `serialitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serialitems` (
  `itemnumber` int(11) NOT NULL,
  `serialid` int(11) NOT NULL,
  UNIQUE KEY `serialitemsidx` (`itemnumber`),
  KEY `serialitems_sfk_1` (`serialid`),
  CONSTRAINT `serialitems_sfk_1` FOREIGN KEY (`serialid`) REFERENCES `serial` (`serialid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `serialitems_sfk_2` FOREIGN KEY (`itemnumber`) REFERENCES `items` (`itemnumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serialitems`
--

LOCK TABLES `serialitems` WRITE;
/*!40000 ALTER TABLE `serialitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `serialitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_throttle`
--

DROP TABLE IF EXISTS `services_throttle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_throttle` (
  `service_type` varchar(10) NOT NULL DEFAULT '',
  `service_count` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`service_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_throttle`
--

LOCK TABLES `services_throttle` WRITE;
/*!40000 ALTER TABLE `services_throttle` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_throttle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(32) NOT NULL,
  `a_session` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_data`
--

DROP TABLE IF EXISTS `social_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_data` (
  `isbn` varchar(30) NOT NULL DEFAULT '',
  `num_critics` int(11) DEFAULT NULL,
  `num_critics_pro` int(11) DEFAULT NULL,
  `num_quotations` int(11) DEFAULT NULL,
  `num_videos` int(11) DEFAULT NULL,
  `score_avg` decimal(5,2) DEFAULT NULL,
  `num_scores` int(11) DEFAULT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_data`
--

LOCK TABLES `social_data` WRITE;
/*!40000 ALTER TABLE `social_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `special_holidays`
--

DROP TABLE IF EXISTS `special_holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_holidays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `day` smallint(6) NOT NULL DEFAULT '0',
  `month` smallint(6) NOT NULL DEFAULT '0',
  `year` smallint(6) NOT NULL DEFAULT '0',
  `isexception` smallint(1) NOT NULL DEFAULT '1',
  `title` varchar(50) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `special_holidays`
--

LOCK TABLES `special_holidays` WRITE;
/*!40000 ALTER TABLE `special_holidays` DISABLE KEYS */;
/*!40000 ALTER TABLE `special_holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `statistics` (
  `datetime` datetime DEFAULT NULL,
  `branch` varchar(10) DEFAULT NULL,
  `proccode` varchar(4) DEFAULT NULL,
  `value` double(16,4) DEFAULT NULL,
  `type` varchar(16) DEFAULT NULL,
  `other` mediumtext,
  `usercode` varchar(10) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `itemtype` varchar(10) DEFAULT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `associatedborrower` int(11) DEFAULT NULL,
  `ccode` varchar(10) DEFAULT NULL,
  KEY `timeidx` (`datetime`),
  KEY `branch_idx` (`branch`),
  KEY `proccode_idx` (`proccode`),
  KEY `type_idx` (`type`),
  KEY `usercode_idx` (`usercode`),
  KEY `itemnumber_idx` (`itemnumber`),
  KEY `itemtype_idx` (`itemtype`),
  KEY `borrowernumber_idx` (`borrowernumber`),
  KEY `associatedborrower_idx` (`associatedborrower`),
  KEY `ccode_idx` (`ccode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistics`
--

LOCK TABLES `statistics` WRITE;
/*!40000 ALTER TABLE `statistics` DISABLE KEYS */;
/*!40000 ALTER TABLE `statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stopwords`
--

DROP TABLE IF EXISTS `stopwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stopwords` (
  `word` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stopwords`
--

LOCK TABLES `stopwords` WRITE;
/*!40000 ALTER TABLE `stopwords` DISABLE KEYS */;
INSERT INTO `stopwords` VALUES ('eller'),('en'),('og'),('som'),('eller'),('en'),('og'),('som');
/*!40000 ALTER TABLE `stopwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `subscriptionid` int(11) NOT NULL AUTO_INCREMENT,
  `librarian` varchar(100) DEFAULT '',
  `startdate` date DEFAULT NULL,
  `aqbooksellerid` int(11) DEFAULT '0',
  `cost` int(11) DEFAULT '0',
  `aqbudgetid` int(11) DEFAULT '0',
  `weeklength` int(11) DEFAULT '0',
  `monthlength` int(11) DEFAULT '0',
  `numberlength` int(11) DEFAULT '0',
  `periodicity` tinyint(4) DEFAULT '0',
  `dow` varchar(100) DEFAULT '',
  `numberingmethod` varchar(100) DEFAULT '',
  `notes` mediumtext,
  `status` varchar(100) NOT NULL DEFAULT '',
  `add1` int(11) DEFAULT '0',
  `every1` int(11) DEFAULT '0',
  `whenmorethan1` int(11) DEFAULT '0',
  `setto1` int(11) DEFAULT NULL,
  `lastvalue1` int(11) DEFAULT NULL,
  `add2` int(11) DEFAULT '0',
  `every2` int(11) DEFAULT '0',
  `whenmorethan2` int(11) DEFAULT '0',
  `setto2` int(11) DEFAULT NULL,
  `lastvalue2` int(11) DEFAULT NULL,
  `add3` int(11) DEFAULT '0',
  `every3` int(11) DEFAULT '0',
  `innerloop1` int(11) DEFAULT '0',
  `innerloop2` int(11) DEFAULT '0',
  `innerloop3` int(11) DEFAULT '0',
  `whenmorethan3` int(11) DEFAULT '0',
  `setto3` int(11) DEFAULT NULL,
  `lastvalue3` int(11) DEFAULT NULL,
  `issuesatonce` tinyint(3) NOT NULL DEFAULT '1',
  `firstacquidate` date DEFAULT NULL,
  `manualhistory` tinyint(1) NOT NULL DEFAULT '0',
  `irregularity` text,
  `letter` varchar(20) DEFAULT NULL,
  `numberpattern` tinyint(3) DEFAULT '0',
  `distributedto` text,
  `internalnotes` longtext,
  `callnumber` text,
  `location` varchar(80) DEFAULT '',
  `branchcode` varchar(10) NOT NULL DEFAULT '',
  `hemisphere` tinyint(3) DEFAULT '0',
  `lastbranch` varchar(10) DEFAULT NULL,
  `serialsadditems` tinyint(1) NOT NULL DEFAULT '0',
  `staffdisplaycount` varchar(10) DEFAULT NULL,
  `opacdisplaycount` varchar(10) DEFAULT NULL,
  `graceperiod` int(11) NOT NULL DEFAULT '0',
  `enddate` date DEFAULT NULL,
  `closed` int(1) NOT NULL DEFAULT '0',
  `reneweddate` date DEFAULT NULL,
  PRIMARY KEY (`subscriptionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptionhistory`
--

DROP TABLE IF EXISTS `subscriptionhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptionhistory` (
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `subscriptionid` int(11) NOT NULL DEFAULT '0',
  `histstartdate` date DEFAULT NULL,
  `histenddate` date DEFAULT NULL,
  `missinglist` longtext NOT NULL,
  `recievedlist` longtext NOT NULL,
  `opacnote` varchar(150) NOT NULL DEFAULT '',
  `librariannote` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`subscriptionid`),
  KEY `biblionumber` (`biblionumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptionhistory`
--

LOCK TABLES `subscriptionhistory` WRITE;
/*!40000 ALTER TABLE `subscriptionhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptionhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptionroutinglist`
--

DROP TABLE IF EXISTS `subscriptionroutinglist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriptionroutinglist` (
  `routingid` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `ranking` int(11) DEFAULT NULL,
  `subscriptionid` int(11) NOT NULL,
  PRIMARY KEY (`routingid`),
  UNIQUE KEY `subscriptionid` (`subscriptionid`,`borrowernumber`),
  KEY `subscriptionroutinglist_ibfk_1` (`borrowernumber`),
  CONSTRAINT `subscriptionroutinglist_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subscriptionroutinglist_ibfk_2` FOREIGN KEY (`subscriptionid`) REFERENCES `subscription` (`subscriptionid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptionroutinglist`
--

LOCK TABLES `subscriptionroutinglist` WRITE;
/*!40000 ALTER TABLE `subscriptionroutinglist` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptionroutinglist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suggestions`
--

DROP TABLE IF EXISTS `suggestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `suggestions` (
  `suggestionid` int(8) NOT NULL AUTO_INCREMENT,
  `suggestedby` int(11) NOT NULL DEFAULT '0',
  `suggesteddate` date NOT NULL DEFAULT '0000-00-00',
  `managedby` int(11) DEFAULT NULL,
  `manageddate` date DEFAULT NULL,
  `acceptedby` int(11) DEFAULT NULL,
  `accepteddate` date DEFAULT NULL,
  `rejectedby` int(11) DEFAULT NULL,
  `rejecteddate` date DEFAULT NULL,
  `STATUS` varchar(10) NOT NULL DEFAULT '',
  `note` mediumtext,
  `author` varchar(80) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `copyrightdate` smallint(6) DEFAULT NULL,
  `publishercode` varchar(255) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `volumedesc` varchar(255) DEFAULT NULL,
  `publicationyear` smallint(6) DEFAULT '0',
  `place` varchar(255) DEFAULT NULL,
  `isbn` varchar(30) DEFAULT NULL,
  `mailoverseeing` smallint(1) DEFAULT '0',
  `biblionumber` int(11) DEFAULT NULL,
  `reason` text,
  `patronreason` text,
  `budgetid` int(11) DEFAULT NULL,
  `branchcode` varchar(10) DEFAULT NULL,
  `collectiontitle` text,
  `itemtype` varchar(30) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `price` decimal(28,6) DEFAULT NULL,
  `total` decimal(28,6) DEFAULT NULL,
  PRIMARY KEY (`suggestionid`),
  KEY `suggestedby` (`suggestedby`),
  KEY `managedby` (`managedby`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suggestions`
--

LOCK TABLES `suggestions` WRITE;
/*!40000 ALTER TABLE `suggestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `suggestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systempreferences`
--

DROP TABLE IF EXISTS `systempreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systempreferences` (
  `variable` varchar(50) NOT NULL DEFAULT '',
  `value` text,
  `options` mediumtext,
  `explanation` text,
  `type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systempreferences`
--

LOCK TABLES `systempreferences` WRITE;
/*!40000 ALTER TABLE `systempreferences` DISABLE KEYS */;
INSERT INTO `systempreferences` VALUES ('AcqCreateItem','ordering','ordering|receiving|cataloguing','Define when the item is created : when ordering, when receiving, or in cataloguing module','Choice'),('AcqViewBaskets','user','user|branch|all','Define which baskets a user is allowed to view: his own only, any within his branch or all','Choice'),('AddPatronLists','categorycode','categorycode|category_type','Allow user to choose what list to pick up from when adding patrons','Choice'),('advancedMARCeditor','0','','If ON, the MARC editor won\'t display field/subfield descriptions','YesNo'),('AdvancedSearchTypes','itemtypes','itemtypes|ccode','Select which set of fields comprise the Type limit in the advanced search','Choice'),('AgeRestrictionMarker','Aldersgrense|Age|',NULL,'Markers for age restriction indication, e.g. FSK|PEGI|Age|','free'),('AgeRestrictionOverride','1',NULL,'Allow staff to check out an item with age restriction.','YesNo'),('AllFinesNeedOverride','1','0','If on, staff will be asked to override every fine, even if it is below noissuescharge.','YesNo'),('AllowAllMessageDeletion','0','','Allow any Library to delete any message','YesNo'),('AllowFineOverride','0','0','If on, staff will be able to issue books to patrons with fines greater than noissuescharge.','YesNo'),('AllowHoldDateInFuture','0','','If set a date field is displayed on the Hold screen of the Staff Interface, allowing the hold date to be set in the future.','YesNo'),('AllowHoldPolicyOverride','0',NULL,'Allow staff to override hold policies when placing holds','YesNo'),('AllowHoldsOnDamagedItems','1','','Allow hold requests to be placed on damaged items','YesNo'),('AllowHoldsOnPatronsPossessions','1',NULL,'Allow holds on records that patron have items of it','YesNo'),('AllowItemsOnHoldCheckout','0','','Do not generate RESERVE_WAITING and RESERVED warning when checking out items reserved to someone else. This allows self checkouts for those items.','YesNo'),('AllowMultipleCovers','0','1','Allow multiple cover images to be attached to each bibliographic record.','YesNo'),('AllowNotForLoanOverride','0','','If ON, Koha will allow the librarian to loan a not for loan item.','YesNo'),('AllowOnShelfHolds','1','','Allow hold requests to be placed on items that are not on loan','YesNo'),('AllowPKIAuth','None','None|Common Name|emailAddress','Use the field from a client-side SSL certificate to look a user in the Koha database','Choice'),('AllowPurchaseSuggestionBranchChoice','0','1','Allow user to choose branch when making a purchase suggestion','YesNo'),('AllowRenewalLimitOverride','0',NULL,'if ON, allows renewal limits to be overridden on the circulation screen','YesNo'),('AllowReturnToBranch','anywhere','anywhere|homebranch|holdingbranch|homeorholdingbranch','Where an item may be returned','Choice'),('AllowSelfCheckReturns','1','','If enabled, patrons may return items through the Web-based Self Checkout','YesNo'),('alphabet','A B C D E F G H I J K L M N O P Q R S T U V W X Y Z Æ Ø Å',NULL,'Alphabet than can be expanded into browse links, e.g. on Home > Patrons','free'),('AlternateHoldingsField','',NULL,'The MARC field/subfield that contains alternate holdings information for bibs taht do not have items attached (e.g. 852abchi for libraries converting from MARC Magician).','free'),('AlternateHoldingsSeparator','',NULL,'The string to use to separate subfields in alternate holdings displays.','free'),('AmazonAssocTag','','','See:  http://aws.amazon.com','free'),('AmazonCoverImages','0','','Display Cover Images in Staff Client from Amazon Web Services','YesNo'),('AmazonLocale','US','US|CA|DE|FR|JP|UK','Use to set the Locale of your Amazon.com Web Services','Choice'),('AnonSuggestions','0',NULL,'Set to enable Anonymous suggestions to AnonymousPatron borrowernumber','YesNo'),('AnonymousPatron','0',NULL,'Set the identifier (borrowernumber) of the anonymous patron. Used for Suggestion and reading history privacy',''),('AuthDisplayHierarchy','0','','Display authority hierarchies','YesNo'),('AuthoritiesLog','0','0','If ON, log edit/create/delete actions on authorities.','YesNo'),('authoritysep','--','10','Used to separate a list of authorities in a display. Usually --','free'),('autoBarcode','OFF','incremental|annual|hbyymmincr|EAN13|OFF','Used to autogenerate a barcode: incremental will be of the form 1, 2, 3; annual of the form 2007-0001, 2007-0002; hbyymmincr of the form HB08010001 where HB=Home Branch','Choice'),('AutoCreateAuthorities','0',NULL,'Automatically create authorities that do not exist when cataloging records.','YesNo'),('AutoEmailOpacUser','0',NULL,'Sends notification emails containing new account details to patrons - when account is created.','YesNo'),('AutoEmailPrimaryAddress','OFF','email|emailpro|B_email|cardnumber|OFF','Defines the default email address where \'Account Details\' emails are sent.','Choice'),('AutoLocation','0',NULL,'If ON, IP authentication is enabled, blocking access to the staff client from unauthorized IP addresses','YesNo'),('AutomaticItemReturn','1',NULL,'If ON, Koha will automatically set up a transfer of this item to its homebranch','YesNo'),('autoMemberNum','1','','If ON, patron number is auto-calculated','YesNo'),('AutoResumeSuspendedHolds','1',NULL,'Allow suspended holds to be automatically resumed by a set date.','YesNo'),('AutoSelfCheckAllowed','0','','For corporate and special libraries which want web-based self-check available from any PC without the need for a manual staff login. Most libraries will want to leave this turned off. If on, requires self-check ID and password to be entered in AutoSelfCheckID and AutoSelfCheckPass sysprefs.','YesNo'),('AutoSelfCheckID','','','Staff ID with circulation rights to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.','free'),('AutoSelfCheckPass','','','Password to be used for automatic web-based self-check. Only applies if AutoSelfCheckAllowed syspref is turned on.','free'),('Babeltheque','0','','Turn ON Babeltheque content  - See babeltheque.com to subscribe to this service','YesNo'),('Babeltheque_url_js','','','Url for Babeltheque javascript (e.g. http://www.babeltheque.com/bw_XX.js)','Free'),('Babeltheque_url_update','','','Url for Babeltheque update (E.G. http://www.babeltheque.com/.../file.csv.bz2)','Free'),('BakerTaylorBookstoreURL','','','URL template for \"My Libary Bookstore\" links, to which the \"key\" value is appended, and \"https://\" is prepended.  It should include your hostname and \"Parent Number\".  Make this variable empty to turn MLB links off.  Example: ocls.mylibrarybookstore.com/MLB/actions/searchHandler.do?nextPage=bookDetails&parentNum=10923&key=',''),('BakerTaylorEnabled','0','','Enable or disable all Baker & Taylor features.','YesNo'),('BakerTaylorPassword','','','Baker & Taylor Password for Content Cafe (external content)','Free'),('BakerTaylorUsername','','','Baker & Taylor Username for Content Cafe (external content)','Free'),('BasketConfirmations','1','always ask for confirmation.|do not ask for confirmation.','When closing or reopening a basket,','Choice'),('BiblioAddsAuthorities','0',NULL,'If ON, adding a new biblio will check for an existing authority record and create one on the fly if one doesn\'t exist','YesNo'),('BiblioDefaultView','normal','normal|marc|isbd','Choose the default detail view in the catalog; choose between normal, marc or isbd','Choice'),('BlockReturnOfWithdrawnItems','1','0','If enabled, items that are marked as withdrawn cannot be returned.','YesNo'),('BorrowerMandatoryField','surname|cardnumber',NULL,'Choose the mandatory fields for a patron\'s account','free'),('borrowerRelationship','far|mor','','Define valid relationships between a guarantor & a guarantee (separated by | or ,)','free'),('BorrowerRenewalPeriodBase','now','dateexpiry|now','Set whether the borrower renewal date should be counted from the dateexpiry or from the current date ','Choice'),('BorrowersLog','1',NULL,'If ON, log edit/create/delete actions on patron data','YesNo'),('BorrowersTitles','Fru|Frøken|Herr',NULL,'Define appropriate Titles for patrons','free'),('BorrowerUnwantedField','title|othernames|initials|streetnumber|streettype|state|fax|emailpro|B_streetnumber|B_streettype|B_state|B_email|B_phone|flags|opacnote|contactnote|sort1|sort2|altcontactfirstname|altcontactsurname|altcontactaddress1|altcontactaddress2|altcontactaddress3|altcontactstate|altcontactzipcode|altcontactcountry|altcontactphone',NULL,'Name the fields you don\'t need to store for a patron\'s account','free'),('BranchTransferLimitsType','itemtype','itemtype|ccode','When using branch transfer limits, choose whether to limit by itemtype or collection code.','Choice'),('CalculateFinesOnReturn','1','','Switch to control if overdue fines are calculated on return or not','YesNo'),('CalendarFirstDayOfWeek','Monday','Sunday|Monday','Select the first day of week to use in the calendar.','Choice'),('canreservefromotherbranches','1','','With Independent branches on, can a user from one library place a hold on an item from another library','YesNo'),('casAuthentication','0','','Enable or disable CAS authentication','YesNo'),('casLogout','0','','Does a logout from Koha should also log the user out of CAS?','YesNo'),('casServerUrl','https://localhost:8443/cas','','URL of the cas server','Free'),('CatalogModuleRelink','0',NULL,'If OFF the linker will never replace the authids that are set in the cataloging module.','YesNo'),('CataloguingLog','0',NULL,'If ON, log edit/create/delete actions on bibliographic data. WARNING: this feature is very resource consuming.','YesNo'),('checkdigit','none','none|katipo','If ON, enable checks on patron cardnumber: none or \"Katipo\" style checks','Choice'),('CircAutocompl','1',NULL,'If ON, autocompletion is enabled for the Circulation input','YesNo'),('CircAutoPrintQuickSlip','1',NULL,'Choose what should happen when an empty barcode field is submitted in circulation: Display a print quick slip window or Clear the screen.','YesNo'),('CircControl','ItemHomeLibrary','PickupLibrary|PatronLibrary|ItemHomeLibrary','Specify the agency that controls the circulation and fines policy','Choice'),('COinSinOPACResults','1','','If ON, use COinS in OPAC search results page.  NOTE: this can slow down search response time significantly','YesNo'),('CurrencyFormat','FR','US|FR','Determines the display format of currencies. eg: \'36000\' is displayed as \'360 000,00\'  in \'FR\' or \'360,000.00\'  in \'US\'.','Choice'),('dateformat','metric','metric|us|iso','Define global date format (us mm/dd/yyyy, metric dd/mm/yyy, ISO yyyy-mm-dd)','Choice'),('DebugLevel','2','0|1|2','Define the level of debugging information sent to the browser when errors are encountered (set to 0 in production). 0=none, 1=some, 2=most','Choice'),('decreaseLoanHighHolds',NULL,'','Decreases the loan period for items with number of holds above the threshold specified in decreaseLoanHighHoldsValue','YesNo'),('decreaseLoanHighHoldsDuration',NULL,'','Specifies a number of days that a loan is reduced to when used in conjunction with decreaseLoanHighHolds','Integer'),('decreaseLoanHighHoldsValue',NULL,'','Specifies a threshold for the minimum number of holds needed to trigger a reduction in loan duration (used with decreaseLoanHighHolds)','Integer'),('DefaultClassificationSource','ddc',NULL,'Default classification scheme used by the collection. E.g., Dewey, LCC, etc.','ClassSources'),('DefaultLanguageField008','nor','','Fill in the default language for field 008 Range 35-37 (e.g. eng, nor, ger, see <a href=\"http://www.loc.gov/marc/languages/language_code.html\">MARC Code List for Languages</a>)','Free'),('defaultSortField','relevance','relevance|popularity|call_number|pubdate|acqdate|title|author','Specify the default field used for sorting','Choice'),('defaultSortOrder','dsc','asc|dsc|az|za','Specify the default sort order','Choice'),('delimiter',';',';|tabulation|,|/|\\|#||','Define the default separator character for exporting reports','Choice'),('Display856uAsImage','OFF','OFF|Details|Results|Both','Display the URI in the 856u field as an image, the corresponding Staff Client XSLT option must be on','Choice'),('DisplayClearScreenButton','0','','If set to ON, a clear screen button will appear on the circulation page.','YesNo'),('displayFacetCount','0',NULL,NULL,'YesNo'),('DisplayIconsXSLT','1','','If ON, displays the format, audience, and material type icons in XSLT MARC21 results and detail pages.','YesNo'),('DisplayMultiPlaceHold','1','','Display the ability to place multiple holds or not','YesNo'),('DisplayOPACiconsXSLT','1','','If ON, displays the format, audience, and material type icons in XSLT MARC21 results and detail pages in the OPAC.','YesNo'),('dontmerge','1',NULL,'If ON, modifying an authority record will not update all associated bibliographic records immediately, ask your system administrator to enable the merge_authorities.pl cron job','YesNo'),('EasyAnalyticalRecords','0','','If on, display in the catalogue screens tools to easily setup analytical record relationships','YesNo'),('emailLibrarianWhenHoldIsPlaced','0',NULL,'If ON, emails the librarian whenever a hold is placed','YesNo'),('EnableBorrowerFiles','0',NULL,'If enabled, allows librarians to upload and attach arbitrary files to a borrower record.','YesNo'),('EnableOpacSearchHistory','1','YesNo','Enable or disable opac search history',''),('EnhancedMessagingPreferences','1','','If ON, allows patrons to select to receive additional messages about items due or nearly due.','YesNo'),('expandedSearchOption','0',NULL,'If ON, set advanced search to be expanded by default','YesNo'),('ExpireReservesMaxPickUpDelay','0','','Enabling this allows holds to expire automatically if they have not been picked by within the time period specified in ReservesMaxPickUpDelay','YesNo'),('ExpireReservesMaxPickUpDelayCharge','0',NULL,'If ExpireReservesMaxPickUpDelay is enabled, and this field has a non-zero value, than a borrower whose waiting hold has expired will be charged this amount.','free'),('ExtendedPatronAttributes','0',NULL,'Use extended patron IDs and attributes','YesNo'),('FacetLabelTruncationLength','20',NULL,'Specify the facet max length in OPAC','Integer'),('FilterBeforeOverdueReport','0','','Do not run overdue report until filter selected','YesNo'),('FineNotifyAtCheckin','0',NULL,'If ON notify librarians of overdue fines on the items they are checking in.','YesNo'),('finesCalendar','noFinesWhenClosed','ignoreCalendar|noFinesWhenClosed','Specify whether to use the Calendar in calculating duedates and fines','Choice'),('FinesIncludeGracePeriod','1',NULL,'If enabled, fines calculations will include the grace period.','YesNo'),('FinesLog','1',NULL,'If ON, log fines','YesNo'),('finesMode','production','off|test|production','Choose the fines mode, \'off\', \'test\' (emails admin report) or \'production\' (accrue overdue fines).  Requires accruefines cronjob.','Choice'),('FrameworksLoaded','sysprefs.sql|class_sources.sql|message_transport_types.sql|normarc.sql|sample_notices.sql|sample_notices_message_attributes.sql|sample_notices_message_transports.sql|stopwords.sql|subtag_registry.sql|system_preferences.sql|userflags.sql|userpermissions.sql',NULL,'Frameworks loaded through webinstaller','choice'),('FRBRizeEditions','0','','If ON, Koha will query one or more ISBN web services for associated ISBNs and display an Editions tab on the details pages','YesNo'),('gist','0','','Default Goods and Services tax rate NOT in %, but in numeric form (0.12 for 12%), set to 0 to disable GST','Integer'),('GoogleJackets','0',NULL,'if ON, displays jacket covers from Google Books API','YesNo'),('hidelostitems','0','','If ON, disables display of\"lost\" items in OPAC.','YesNo'),('HidePatronName','0','','If this is switched on, patron\'s cardnumber will be shown instead of their name on the holds and catalog screens','YesNo'),('hide_marc','0',NULL,'If ON, disables display of MARC fields, subfield codes & indicators (still shows data)','YesNo'),('HighlightOwnItemsOnOPAC','0','','If on, and a patron is logged into the OPAC, items from his or her home library will be emphasized and shown first in search results and item details.','YesNo'),('HighlightOwnItemsOnOPACWhich','PatronBranch','PatronBranch|OpacURLBranch','Decides which branch\'s items to emphasize. If PatronBranch, emphasize the logged in user\'s library\'s items. If OpacURLBranch, highlight the items of the Apache var BRANCHCODE defined in Koha\'s Apache configuration file.','Choice'),('HoldsToPullStartDate','2',NULL,'Set the default start date for the Holds to pull list to this many days ago','Integer'),('HomeOrHoldingBranch','holdingbranch','holdingbranch|homebranch','Used by Circulation to determine which branch of an item to check with independent branches on, and by search to determine which branch to choose for availability ','Choice'),('HomeOrHoldingBranchReturn','homebranch','holdingbranch|homebranch','Used by Circulation to determine which branch of an item to check checking-in items','Choice'),('HTML5MediaEnabled','not','not|opac|staff|both','Show a tab with a HTML5 media player for files catalogued in field 856','Choice'),('HTML5MediaExtensions','webm|ogg|ogv|oga|vtt','','Media file extensions','free'),('IDreamBooksReadometer','0','','Display Readometer from IDreamBooks.com','YesNo'),('IDreamBooksResults','0','','Display IDreamBooks.com rating in search results','YesNo'),('IDreamBooksReviews','0','','Display book review snippets from IDreamBooks.com','YesNo'),('ILS-DI','0','','Enables ILS-DI services at OPAC.','YesNo'),('ILS-DI:AuthorizedIPs','','Restricts usage of ILS-DI to some IPs','.','Free'),('ImageLimit','5','','Limit images stored in the database by the Patron Card image manager to this number.','Integer'),('IncludeSeeFromInSearches','0','','Include see-from references in searches.','YesNo'),('IndependantBranches','0',NULL,'If ON, increases security between libraries','YesNo'),('InProcessingToShelvingCart','0','','If set, when any item with a location code of PROC is \'checked in\', it\'s location code will be changed to CART.','YesNo'),('INTRAdidyoumean',NULL,NULL,'Did you mean? configuration for the Intranet. Do not change, as this is controlled by /cgi-bin/koha/admin/didyoumean.pl.','Free'),('IntranetBiblioDefaultView','normal','normal|marc|isbd|labeled_marc','Choose the default detail view in the staff interface; choose between normal, labeled_marc, marc or isbd','Choice'),('intranetbookbag','1','','If ON, enables display of Cart feature in the intranet','YesNo'),('intranetcolorstylesheet','','50','Define the color stylesheet to use in the Staff Client','free'),('IntranetFavicon','','','Enter a complete URL to an image to replace the default Koha favicon on the Staff client','free'),('IntranetmainUserblock','','70|10','Add a block of HTML that will display on the intranet home page','Textarea'),('IntranetNav','','70|10','Use HTML tabs to add navigational links to the top-hand navigational bar in the Staff Client','Textarea'),('IntranetNumbersPreferPhrase','0',NULL,'Control the use of phr operator in callnumber and standard number staff client searches','YesNo'),('intranetreadinghistory','1','','If ON, Reading History is enabled for all patrons','YesNo'),('IntranetSlipPrinterJS','','','Use this JavaScript for printing slips. Define at least function printThenClose(). For use e.g. with Firefox PlugIn jsPrintSetup, see http://jsprintsetup.mozdev.org/','Free'),('intranetstylesheet','','50','Enter a complete URL to use an alternate layout stylesheet in Intranet','free'),('IntranetUserCSS','h1#logo {background: transparent url(http://datatest.deichman.no/saltfiles/koha/logo.png) no-repeat scroll 0%; }',NULL,'Add CSS to be included in the intranet in an embedded <style> tag.','free'),('intranetuserjs','$(document).ready(function(){
  $("#entryform #userid").attr("disabled", true);
  $("#entryform #cardnumber").blur(function(){
    $("#entryform #userid").val($("#entryform #cardnumber").val());
  });
});','70|10','Custom javascript for inclusion in Intranet','Textarea'),('intranet_includes','includes',NULL,'The includes directory you want for specific look of Koha (includes or includes_npl for example)','Free'),('ISBD','#100||{ 100a }{ 100b }{ 100c }{ 100d }{ 110a }{ 110b }{ 110c }{ 110d }{ 110e }{ 110f }{ 110g }{ 130a }{ 130d }{ 130f }{ 130g }{ 130h }{ 130k }{ 130l }{ 130m }{ 130n }{ 130o }{ 130p }{ 130r }{ 130s }{ 130t }|<br/><br/>\r\n#245||{ 245a }{ 245b }{245f }{ 245g }{ 245k }{ 245n }{ 245p }{ 245s }{ 245h }|\r\n#246||{ : 246i }{ 246a }{ 246b }{ 246f }{ 246g }{ 246n }{ 246p }{ 246h }|\r\n#242||{ = 242a }{ 242b }{ 242n }{ 242p }{ 242h }|\r\n#245||{ 245c }|\r\n#242||{ = 242c }|\r\n#250| - |{ 250a }{ 250b }|\r\n#254|, |{ 254a }|\r\n#255|, |{ 255a }{ 255b }{ 255c }{ 255d }{ 255e }{ 255f }{ 255g }|\r\n#256|, |{ 256a }|\r\n#257|, |{ 257a }|\r\n#258|, |{ 258a }{ 258b }|\r\n#260| - |{ 260a }{ 260b }{ 260c }|\r\n#300| - |{ 300a }{ 300b }{ 300c }{ 300d }{ 300e }{ 300f }{ 300g }|\r\n#306| - |{ 306a }|\r\n#307| - |{ 307a }{ 307b }|\r\n#310| - |{ 310a }{ 310b }|\r\n#321| - |{ 321a }{ 321b }|\r\n#340| - |{ 3403 }{ 340a }{ 340b }{ 340c }{ 340d }{ 340e }{ 340f }{ 340h }{ 340i }|\r\n#342| - |{ 342a }{ 342b }{ 342c }{ 342d }{ 342e }{ 342f }{ 342g }{ 342h }{ 342i }{ 342j }{ 342k }{ 342l }{ 342m }{ 342n }{ 342o }{ 342p }{ 342q }{ 342r }{ 342s }{ 342t }{ 342u }{ 342v }{ 342w }|\r\n#343| - |{ 343a }{ 343b }{ 343c }{ 343d }{ 343e }{ 343f }{ 343g }{ 343h }{ 343i }|\r\n#351| - |{ 3513 }{ 351a }{ 351b }{ 351c }|\r\n#352| - |{ 352a }{ 352b }{ 352c }{ 352d }{ 352e }{ 352f }{ 352g }{ 352i }{ 352q }|\r\n#362| - |{ 362a }{ 351z }|\r\n#440| - |{ 440a }{ 440n }{ 440p }{ 440v }{ 440x }|.\r\n#490| - |{ 490a }{ 490v }{ 490x }|.\r\n#800| - |{ 800a }{ 800b }{ 800c }{ 800d }{ 800e }{ 800f }{ 800g }{ 800h }{ 800j }{ 800k }{ 800l }{ 800m }{ 800n }{ 800o }{ 800p }{ 800q }{ 800r }{ 800s }{ 800t }{ 800u }{ 800v }|.\r\n#810| - |{ 810a }{ 810b }{ 810c }{ 810d }{ 810e }{ 810f }{ 810g }{ 810h }{ 810k }{ 810l }{ 810m }{ 810n }{ 810o }{ 810p }{ 810r }{ 810s }{ 810t }{ 810u }{ 810v }|.\r\n#811| - |{ 811a }{ 811c }{ 811d }{ 811e }{ 811f }{ 811g }{ 811h }{ 811k }{ 811l }{ 811n }{ 811p }{ 811q }{ 811s }{ 811t }{ 811u }{ 811v }|.\r\n#830| - |{ 830a }{ 830d }{ 830f }{ 830g }{ 830h }{ 830k }{ 830l }{ 830m }{ 830n }{ 830o }{ 830p }{ 830r }{ 830s }{ 830t }{ 830v }|.\r\n#500|<br/><br/>|{ 5003 }{ 500a }|\r\n#501|<br/><br/>|{ 501a }|\r\n#502|<br/><br/>|{ 502a }|\r\n#504|<br/><br/>|{ 504a }|\r\n#505|<br/><br/>|{ 505a }{ 505t }{ 505r }{ 505g }{ 505u }|\r\n#506|<br/><br/>|{ 5063 }{ 506a }{ 506b }{ 506c }{ 506d }{ 506u }|\r\n#507|<br/><br/>|{ 507a }{ 507b }|\r\n#508|<br/><br/>|{ 508a }{ 508a }|\r\n#510|<br/><br/>|{ 5103 }{ 510a }{ 510x }{ 510c }{ 510b }|\r\n#511|<br/><br/>|{ 511a }|\r\n#513|<br/><br/>|{ 513a }{513b }|\r\n#514|<br/><br/>|{ 514z }{ 514a }{ 514b }{ 514c }{ 514d }{ 514e }{ 514f }{ 514g }{ 514h }{ 514i }{ 514j }{ 514k }{ 514m }{ 514u }|\r\n#515|<br/><br/>|{ 515a }|\r\n#516|<br/><br/>|{ 516a }|\r\n#518|<br/><br/>|{ 5183 }{ 518a }|\r\n#520|<br/><br/>|{ 5203 }{ 520a }{ 520b }{ 520u }|\r\n#521|<br/><br/>|{ 5213 }{ 521a }{ 521b }|\r\n#522|<br/><br/>|{ 522a }|\r\n#524|<br/><br/>|{ 524a }|\r\n#525|<br/><br/>|{ 525a }|\r\n#526|<br/><br/>|{\\n510i }{\\n510a }{ 510b }{ 510c }{ 510d }{\\n510x }|\r\n#530|<br/><br/>|{\\n5063 }{\\n506a }{ 506b }{ 506c }{ 506d }{\\n506u }|\r\n#533|<br/><br/>|{\\n5333 }{\\n533a }{\\n533b }{\\n533c }{\\n533d }{\\n533e }{\\n533f }{\\n533m }{\\n533n }|\r\n#534|<br/><br/>|{\\n533p }{\\n533a }{\\n533b }{\\n533c }{\\n533d }{\\n533e }{\\n533f }{\\n533m }{\\n533n }{\\n533t }{\\n533x }{\\n533z }|\r\n#535|<br/><br/>|{\\n5353 }{\\n535a }{\\n535b }{\\n535c }{\\n535d }|\r\n#538|<br/><br/>|{\\n5383 }{\\n538a }{\\n538i }{\\n538u }|\r\n#540|<br/><br/>|{\\n5403 }{\\n540a }{ 540b }{ 540c }{ 540d }{\\n520u }|\r\n#544|<br/><br/>|{\\n5443 }{\\n544a }{\\n544b }{\\n544c }{\\n544d }{\\n544e }{\\n544n }|\r\n#545|<br/><br/>|{\\n545a }{ 545b }{\\n545u }|\r\n#546|<br/><br/>|{\\n5463 }{\\n546a }{ 546b }|\r\n#547|<br/><br/>|{\\n547a }|\r\n#550|<br/><br/>|{ 550a }|\r\n#552|<br/><br/>|{ 552z }{ 552a }{ 552b }{ 552c }{ 552d }{ 552e }{ 552f }{ 552g }{ 552h }{ 552i }{ 552j }{ 552k }{ 552l }{ 552m }{ 552n }{ 562o }{ 552p }{ 552u }|\r\n#555|<br/><br/>|{ 5553 }{ 555a }{ 555b }{ 555c }{ 555d }{ 555u }|\r\n#556|<br/><br/>|{ 556a }{ 506z }|\r\n#563|<br/><br/>|{ 5633 }{ 563a }{ 563u }|\r\n#565|<br/><br/>|{ 5653 }{ 565a }{ 565b }{ 565c }{ 565d }{ 565e }|\r\n#567|<br/><br/>|{ 567a }|\r\n#580|<br/><br/>|{ 580a }|\r\n#581|<br/><br/>|{ 5633 }{ 581a }{ 581z }|\r\n#584|<br/><br/>|{ 5843 }{ 584a }{ 584b }|\r\n#585|<br/><br/>|{ 5853 }{ 585a }|\r\n#586|<br/><br/>|{ 5863 }{ 586a }|\r\n#020|<br/><br/><label>ISBN: </label>|{ 020a }{ 020c }|\r\n#022|<br/><br/><label>ISSN: </label>|{ 022a }|\r\n#222| = |{ 222a }{ 222b }|\r\n#210| = |{ 210a }{ 210b }|\r\n#024|<br/><br/><label>Standard No.: </label>|{ 024a }{ 024c }{ 024d }{ 0242 }|\r\n#027|<br/><br/><label>Standard Tech. Report. No.: </label>|{ 027a }|\r\n#028|<br/><br/><label>Publisher. No.: </label>|{ 028a }{ 028b }|\r\n#013|<br/><br/><label>Patent No.: </label>|{ 013a }{ 013b }{ 013c }{ 013d }{ 013e }{ 013f }|\r\n#030|<br/><br/><label>CODEN: </label>|{ 030a }|\r\n#037|<br/><br/><label>Source: </label>|{ 037a }{ 037b }{ 037c }{ 037f }{ 037g }{ 037n }|\r\n#010|<br/><br/><label>LCCN: </label>|{ 010a }|\r\n#015|<br/><br/><label>Nat. Bib. No.: </label>|{ 015a }{ 0152 }|\r\n#016|<br/><br/><label>Nat. Bib. Agency Control No.: </label>|{ 016a }{ 0162 }|\r\n#600|<br/><br/><label>Subjects--Personal Names: </label>|{\\n6003 }{\\n600a}{ 600b }{ 600c }{ 600d }{ 600e }{ 600f }{ 600g }{ 600h }{--600k}{ 600l }{ 600m }{ 600n }{ 600o }{--600p}{ 600r }{ 600s }{ 600t }{ 600u }{--600x}{--600z}{--600y}{--600v}|\r\n#610|<br/><br/><label>Subjects--Corporate Names: </label>|{\\n6103 }{\\n610a}{ 610b }{ 610c }{ 610d }{ 610e }{ 610f }{ 610g }{ 610h }{--610k}{ 610l }{ 610m }{ 610n }{ 610o }{--610p}{ 610r }{ 610s }{ 610t }{ 610u }{--610x}{--610z}{--610y}{--610v}|\r\n#611|<br/><br/><label>Subjects--Meeting Names: </label>|{\\n6113 }{\\n611a}{ 611b }{ 611c }{ 611d }{ 611e }{ 611f }{ 611g }{ 611h }{--611k}{ 611l }{ 611m }{ 611n }{ 611o }{--611p}{ 611r }{ 611s }{ 611t }{ 611u }{--611x}{--611z}{--611y}{--611v}|\r\n#630|<br/><br/><label>Subjects--Uniform Titles: </label>|{\\n630a}{ 630b }{ 630c }{ 630d }{ 630e }{ 630f }{ 630g }{ 630h }{--630k }{ 630l }{ 630m }{ 630n }{ 630o }{--630p}{ 630r }{ 630s }{ 630t }{--630x}{--630z}{--630y}{--630v}|\r\n#648|<br/><br/><label>Subjects--Chronological Terms: </label>|{\\n6483 }{\\n648a }{--648x}{--648z}{--648y}{--648v}|\r\n#650|<br/><br/><label>Subjects--Topical Terms: </label>|{\\n6503 }{\\n650a}{ 650b }{ 650c }{ 650d }{ 650e }{--650x}{--650z}{--650y}{--650v}|\r\n#651|<br/><br/><label>Subjects--Geographic Terms: </label>|{\\n6513 }{\\n651a}{ 651b }{ 651c }{ 651d }{ 651e }{--651x}{--651z}{--651y}{--651v}|\r\n#653|<br/><br/><label>Subjects--Index Terms: </label>|{ 653a }|\r\n#654|<br/><br/><label>Subjects--Facted Index Terms: </label>|{\\n6543 }{\\n654a}{--654b}{--654x}{--654z}{--654y}{--654v}|\r\n#655|<br/><br/><label>Index Terms--Genre/Form: </label>|{\\n6553 }{\\n655a}{--655b}{--655x }{--655z}{--655y}{--655v}|\r\n#656|<br/><br/><label>Index Terms--Occupation: </label>|{\\n6563 }{\\n656a}{--656k}{--656x}{--656z}{--656y}{--656v}|\r\n#657|<br/><br/><label>Index Terms--Function: </label>|{\\n6573 }{\\n657a}{--657x}{--657z}{--657y}{--657v}|\r\n#658|<br/><br/><label>Index Terms--Curriculum Objective: </label>|{\\n658a}{--658b}{--658c}{--658d}{--658v}|\r\n#050|<br/><br/><label>LC Class. No.: </label>|{ 050a }{ / 050b }|\r\n#082|<br/><br/><label>Dewey Class. No.: </label>|{ 082a }{ / 082b }|\r\n#080|<br/><br/><label>Universal Decimal Class. No.: </label>|{ 080a }{ 080x }{ / 080b }|\r\n#070|<br/><br/><label>National Agricultural Library Call No.: </label>|{ 070a }{ / 070b }|\r\n#060|<br/><br/><label>National Library of Medicine Call No.: </label>|{ 060a }{ / 060b }|\r\n#074|<br/><br/><label>GPO Item No.: </label>|{ 074a }|\r\n#086|<br/><br/><label>Gov. Doc. Class. No.: </label>|{ 086a }|\r\n#088|<br/><br/><label>Report. No.: </label>|{ 088a }|','70|10','ISBD','Textarea'),('IssueLog','1',NULL,'If ON, log checkout activity','YesNo'),('IssueLostItem','alert','Defines what should be done when an attempt is made to issue an item that has been marked as lost.','alert|confirm|nothing','Choice'),('IssuingInProcess','0',NULL,'If ON, disables fines if the patron is issuing item that accumulate debt','YesNo'),('item-level_itypes','1','','If ON, enables Item-level Itemtype / Issuing Rules','YesNo'),('itemBarcodeInputFilter','','whitespace|T-prefix|cuecat|libsuite8|EAN13','If set, allows specification of a item barcode input filter','Choice'),('itemcallnumber','082ab',NULL,'The MARC field/subfield that is used to calculate the itemcallnumber (Dewey would be 082ab or 092ab; LOC would be 050ab or 090ab) could be 852hi from an item record','free'),('KohaAdminEmailAddress','root@localhost','','Define the email address where patron modification requests are sent','free'),('LabelMARCView','standard','standard|economical','Define how a MARC record will display','Choice'),('language','en,nb-NO',NULL,'Set the default language in the staff client.','Languages'),('LetterLog','1',NULL,'If ON, log all notices sent','YesNo'),('LibraryName','','','Define the library name as displayed on the OPAC',''),('LibraryThingForLibrariesEnabled','0','','Enable or Disable Library Thing for Libraries Features','YesNo'),('LibraryThingForLibrariesID','','','See:http://librarything.com/forlibraries/','free'),('LibraryThingForLibrariesTabbedView','0','','Put LibraryThingForLibraries Content in Tabs.','YesNo'),('LinkerKeepStale','0',NULL,'If ON the authority linker will keep existing authority links for headings where it is unable to find a match.','YesNo'),('LinkerModule','Default','Default|FirstMatch|LastMatch','Chooses which linker module to use (see documentation).','Choice'),('LinkerOptions','','','A pipe-separated list of options for the linker.','free'),('LinkerRelink','1',NULL,'If ON the authority linker will relink headings that have previously been linked every time it runs.','YesNo'),('LocalCoverImages','0','1','Display local cover images on intranet details pages.','YesNo'),('ManInvInNoissuesCharge','1',NULL,'MANUAL_INV charges block checkouts (added to noissuescharge).','YesNo'),('MARCAuthorityControlField008','|| aca||aabn           | a|a     d',NULL,NULL,'Textarea'),('marcflavour','NORMARC','MARC21|UNIMARC|NORMARC','Define global MARC flavor (MARC21, UNIMARC or NORMARC) used for character encoding','Choice'),('MARCOrgCode','OSt','','Define MARC Organization Code - http://www.loc.gov/marc/organizations/orgshome.html','free'),('MaxFine',NULL,'','Maximum fine a patron can have for all late returns at one moment. Single item caps are specified in the circulation rules matrix.','Integer'),('maxItemsInSearchResults','20',NULL,'Specify the maximum number of items to display for each result on a page of results','free'),('maxoutstanding','5','','maximum amount withstanding to be able make holds','Integer'),('maxRecordsForFacets','20',NULL,NULL,'Integer'),('maxreserves','50','','Define maximum number of holds a patron can place','Integer'),('memberofinstitution','0',NULL,'If ON, patrons can be linked to institutions','YesNo'),('minPasswordLength','3',NULL,'Specify the minimum length of a patron/staff password','free'),('NewItemsDefaultLocation','','','If set, all new items will have a location of the given Location Code ( Authorized Value type LOC )',''),('noissuescharge','5','','Define maximum amount withstanding before check outs are blocked','Integer'),('noItemTypeImages','0',NULL,'If ON, disables item-type images','YesNo'),('NotesBlacklist','',NULL,'List of notes fields that should not appear in the title notes/description separator of details','free'),('NoticeCSS','',NULL,'Notices CSS url.','free'),('NotifyBorrowerDeparture','30',NULL,'Define number of days before expiry where circulation is warned about patron account expiry','Integer'),('NovelistSelectEnabled','0',NULL,'Enable Novelist Select content.  Requires Novelist Profile and Password','YesNo'),('NovelistSelectPassword',NULL,NULL,'Enable Novelist user Profile','free'),('NovelistSelectProfile',NULL,NULL,'Novelist Select user Password','free'),('NovelistSelectView','tab','tab|above|below|right','Where to display Novelist Select content','Choice'),('numReturnedItemsToShow','20',NULL,'Number of returned items to show on the check-in page','Integer'),('numSearchResults','20',NULL,'Specify the maximum number of results to display on a page of results','Integer'),('numSearchRSSResults','50',NULL,'Specify the maximum number of results to display on a RSS page of results','Integer'),('OAI-PMH','1',NULL,'if ON, OAI-PMH server is enabled','YesNo'),('OAI-PMH:archiveID','KOHA-OAI-TEST',NULL,'OAI-PMH archive identification','Free'),('OAI-PMH:AutoUpdateSets','1','','Automatically update OAI sets when a bibliographic record is created or updated','YesNo'),('OAI-PMH:ConfFile','',NULL,'If empty, Koha OAI Server operates in normal mode, otherwise it operates in extended mode.','File'),('OAI-PMH:MaxCount','50',NULL,'OAI-PMH maximum number of records by answer to ListRecords and ListIdentifiers queries','Integer'),('OCLCAffiliateID','','','Use with FRBRizeEditions and XISBN. You can sign up for an AffiliateID here: http://www.worldcat.org/wcpa/do/AffiliateUserServices?method=initSelfRegister','free'),('OpacAddMastheadLibraryPulldown','0','','Adds a pulldown menu to select the library to search on the opac masthead.','YesNo'),('OPACAllowHoldDateInFuture','0','','If set, along with the AllowHoldDateInFuture system preference, OPAC users can set the date of a hold to be in the future.','YesNo'),('OpacAllowPublicListCreation','1',NULL,'If set, allows opac users to create public lists','YesNo'),('OpacAllowSharingPrivateLists','0',NULL,'If set, allows opac users to share private lists with other patrons','YesNo'),('OPACAllowUserToChooseBranch','1','1','Allow the user to choose the branch they want to pickup their hold from','YesNo'),('OPACAmazonCoverImages','0','','Display cover images on OPAC from Amazon Web Services','YesNo'),('OpacAuthorities','1',NULL,'If ON, enables the search authorities link on OPAC','YesNo'),('OPACBaseURL',NULL,NULL,'Specify the Base URL of the OPAC, e.g., opac.mylibrary.com, the http:// will be added automatically by Koha.','Free'),('opacbookbag','1','','If ON, enables display of Cart feature','YesNo'),('OpacBrowser','0',NULL,'If ON, enables subject authorities browser on OPAC (needs to set misc/cronjob/sbuild_browser_and_cloud.pl)','YesNo'),('OpacBrowseResults','1',NULL,'Disable/enable browsing and paging search results from the OPAC detail page.','YesNo'),('OpacCloud','0',NULL,'If ON, enables subject cloud on OPAC','YesNo'),('opaccolorstylesheet','colors.css','','Define an auxiliary stylesheet for OPAC use, to override specified settings from the primary opac.css stylesheet. Enter the filename (if the file is in the server\'s css directory) or a complete URL beginning with http (if the file lives on a remote server).','free'),('opaccredits','','70|10','Define HTML Credits at the bottom of the OPAC page','Textarea'),('OPACdefaultSortField','relevance','relevance|popularity|call_number|pubdate|acqdate|title|author','Specify the default field used for sorting','Choice'),('OPACdefaultSortOrder','dsc','asc|dsc|za|az','Specify the default sort order','Choice'),('OPACdidyoumean',NULL,NULL,'Did you mean? configuration for the OPAC. Do not change, as this is controlled by /cgi-bin/koha/admin/didyoumean.pl.','Free'),('OPACDisplay856uAsImage','OFF','OFF|Details|Results|Both','Display the URI in the 856u field as an image, the corresponding OPACXSLT option must be on','Choice'),('OpacExportOptions','bibtex|dc|marcxml|marc8|utf8|marcstd|mods|ris','','Define export options available on OPAC detail page.','free'),('OpacFavicon','','','Enter a complete URL to an image to replace the default Koha favicon on the OPAC','free'),('OPACFineNoRenewals','100','','Fine limit above which user cannot renew books via OPAC','Integer'),('OPACFinesTab','1','','If OFF the patron fines tab in the OPAC is disabled.','YesNo'),('OPACFRBRizeEditions','0','','If ON, the OPAC will query one or more ISBN web services for associated ISBNs and display an Editions tab on the details pages','YesNo'),('opacheader','','70|10','Add HTML to be included as a custom header in the OPAC','Textarea'),('OpacHiddenItems','','','This syspref allows to define custom rules for hiding specific items at opac. See docs/opac/OpacHiddenItems.txt for more informations.','Textarea'),('OpacHighlightedWords','1','','If Set, then queried words are higlighted in OPAC','YesNo'),('OPACItemHolds','1','','Allow OPAC users to place hold on specific items. If OFF, users can only request next available copy.','YesNo'),('OpacItemLocation','callnum','callnum|ccode|location','Show the shelving location of items in the opac','Choice'),('OPACItemsResultsDisplay','0','','If OFF : show only the status of items in result list.If ON : show full location of items (branch+location+callnumber) as in staff interface','YesNo'),('OpacKohaUrl','1',NULL,'Show \'Powered by Koha\' text on OPAC footer.',NULL),('opaclanguages','en,nb-NO',NULL,'Set the default language in the OPAC.','Languages'),('opaclanguagesdisplay','1','','If ON, enables display of Change Language feature on OPAC','YesNo'),('opaclayoutstylesheet','opac.css','','Enter the name of the layout CSS stylesheet to use in the OPAC','free'),('OPACLocalCoverImages','0','1','Display local cover images on OPAC search and details pages.','YesNo'),('OpacMaintenance','0','','If ON, enables maintenance warning in OPAC','YesNo'),('OpacMainUserBlock','<p>Velkommen til Koha...</p><hr />','70|10','A user-defined block of HTML  in the main content area of the opac main page','Textarea'),('OpacMainUserBlockMobile','',NULL,'Show the following HTML in its own column on the main page of the OPAC (mobile version):','free'),('OPACMobileUserCSS','',NULL,'Include the following CSS for the mobile view on all pages in the OPAC:','free'),('OPACMySummaryHTML','','70|10','Enter the HTML that will appear in a column on the \'my summary\' and \'my reading history\' tabs when a user is logged in to the OPAC. Enter {BIBLIONUMBER}, {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the HTML. Leave blank to disable.','Textarea'),('OpacNav','<p>Viktige lenker kan plasseres her</p>','70|10','Use HTML tags to add navigational links to the left-hand navigational bar in OPAC','Textarea'),('OpacNavBottom','Important links here.','70|10','Use HTML tags to add navigational links to the left-hand navigational bar in OPAC','Textarea'),('OpacNavRight','','70|10','Show the following HTML in the right hand column of the main page under the main login form','Textarea'),('OPACNoResultsFound','','70|10','Display this HTML when no results are found for a search in the OPAC','Textarea'),('OPACNumbersPreferPhrase','0',NULL,'Control the use of phr operator in callnumber and standard number OPAC searches','YesNo'),('OPACnumSearchResults','20',NULL,'Specify the maximum number of results to display on a page of results','Integer'),('OpacPasswordChange','1',NULL,'If ON, enables patron-initiated password change in OPAC (disable it when using LDAP auth)','YesNo'),('OPACPatronDetails','1','','If OFF the patron details tab in the OPAC is disabled.','YesNo'),('OPACpatronimages','0',NULL,'Enable patron images in the OPAC','YesNo'),('OpacPrivacy','0',NULL,'if ON, allows patrons to define their privacy rules (reading history)','YesNo'),('OpacPublic','1',NULL,'Turn on/off public OPAC','YesNo'),('opacreadinghistory','1','','If ON, enables display of Patron Circulation History in OPAC','YesNo'),('OpacRenewalAllowed','0',NULL,'If ON, users can renew their issues directly from their OPAC account','YesNo'),('OpacRenewalBranch','checkoutbranch','itemhomebranch|patronhomebranch|checkoutbranch|null','Choose how the branch for an OPAC renewal is recorded in statistics','Choice'),('OPACResultsSidebar','','70|10','Define HTML to be included on the search results page, underneath the facets sidebar','Textarea'),('OPACSearchForTitleIn','<li><a href=\"http://worldcat.org/search?q={TITLE}\" target=\"_blank\">Andre bibliotek (WorldCat)</a></li><li><a href=\"http://www.scholar.google.com/scholar?q={TITLE}\" target=\"_blank\">Andre databaser (Google Scholar)</a></li><li><a href=\"http://www.bookfinder.com/search/?author={AUTHOR}&amp;title={TITLE}&amp;st=xl&amp;ac=qr\" target=\"_blank\">Nettbutikker (Bookfinder.com)</a></li>','70|10','Enter the HTML that will appear in the \'Search for this title in\' box on the detail page in the OPAC.  Enter {TITLE}, {AUTHOR}, or {ISBN} in place of their respective variables in the URL. Leave blank to disable \'More Searches\' menu.','Textarea'),('OpacSeparateHoldings','0',NULL,'Separate current branch holdings from other holdings (OPAC)','YesNo'),('OpacSeparateHoldingsBranch','homebranch','homebranch|holdingbranch','Branch used to separate holdings (OPAC)','Choice'),('opacSerialDefaultTab','subscriptions','holdings|serialcollection|subscriptions','Define the default tab for serials in OPAC.','Choice'),('OPACSerialIssueDisplayCount','3','','Number of serial issues to display per subscription in the OPAC','Integer'),('OPACShelfBrowser','1','','Enable/disable Shelf Browser on item details page. WARNING: this feature is very resource consuming on collections with large numbers of items.','YesNo'),('OPACShowBarcode','0','','Show items barcode in holding tab','YesNo'),('OPACShowCheckoutName','0','','Displays in the OPAC the name of patron who has checked out the material. WARNING: Most sites should leave this off. It is intended for corporate or special sites which need to track who has the item.','YesNo'),('OpacShowFiltersPulldownMobile','1',NULL,'Show the search filters pulldown on the mobile version of the OPAC.','YesNo'),('OPACShowHoldQueueDetails','none','none|priority|holds|holds_priority','Show holds details in OPAC','Choice'),('OpacShowLibrariesPulldownMobile','1',NULL,'Show the libraries pulldown on the mobile version of the OPAC.','YesNo'),('OpacShowRecentComments','0',NULL,'If ON a link to recent comments will appear in the OPAC masthead','YesNo'),('OPACShowUnusedAuthorities','1','','Show authorities that are not being used in the OPAC.','YesNo'),('opacsmallimage','http://datatest.deichman.no/saltfiles/koha/logo.png','','Enter a complete URL to an image to replace the default Koha logo','free'),('OpacStarRatings','all','disable|all|details',NULL,'Choice'),('OpacSuppression','0','','Turn ON the OPAC Suppression feature, requires further setup, ask your system administrator for details','YesNo'),('OpacSuppressionByIPRange','','','Restrict the suppression to IP adresses outside of the IP range','free'),('opacthemes','prog','','Define the current theme for the OPAC interface.','Themes'),('OpacTopissue','0',NULL,'If ON, enables the \'most popular items\' link on OPAC. Warning, this is an EXPERIMENTAL feature, turning ON may overload your server','YesNo'),('OPACURLOpenInNewWindow','0',NULL,'If ON, URLs in the OPAC open in a new window','YesNo'),('OPACUserCSS','h1#libraryname { width: 180px; }',NULL,'Add CSS to be included in the OPAC in an embedded <style> tag.','free'),('opacuserjs','','70|10','Define custom javascript for inclusion in OPAC','Textarea'),('opacuserlogin','1',NULL,'Enable or disable display of user login features','YesNo'),('OPACViewOthersSuggestions','0',NULL,'If ON, allows all suggestions to be displayed in the OPAC','YesNo'),('OPACXSLTDetailsDisplay','default','','Enable XSL stylesheet control over details page display on OPAC','Free'),('OPACXSLTResultsDisplay','default','','Enable XSL stylesheet control over results page display on OPAC','Free'),('OpenLibraryCovers','0',NULL,'If ON Openlibrary book covers will be show','YesNo'),('OrderPdfFormat','pdfformat::layout3pages','Controls what script is used for printing (basketgroups)','','free'),('OverdueNoticeBcc','','','Email address to bcc outgoing overdue notices sent by email','free'),('OverduesBlockCirc','noblock','noblock|confirmation|block','When checking out an item should overdues block checkout, generate a confirmation dialogue, or allow checkout','Choice'),('patronimages','0',NULL,'Enable patron images for the Staff Client','YesNo'),('PatronSelfRegistration','1',NULL,'If enabled, patrons will be able to register themselves via the OPAC.','YesNo'),('PatronSelfRegistrationAdditionalInstructions','','','A free text field to display additional instructions to newly self registered patrons.','free'),('PatronSelfRegistrationBorrowerMandatoryField','surname|firstname',NULL,'Choose the mandatory fields for a patron\'s account, when registering via the OPAC.','free'),('PatronSelfRegistrationBorrowerUnwantedField','',NULL,'Name the fields you don\'t want to display when registering a new patron via the OPAC.','free'),('PatronSelfRegistrationDefaultCategory','PT','','A patron registered via the OPAC will receive a borrower category code set in this system preference.','free'),('PatronSelfRegistrationExpireTemporaryAccountsDelay','0',NULL,'If PatronSelfRegistrationDefaultCategory is enabled, this system preference controls how long a patron can have a temporary status before the account is deleted automatically. It is an integer value representing a number of days to wait before deleting a temporary patron account. Setting it to 0 disables the deleting of temporary accounts.','Integer'),('PatronSelfRegistrationVerifyByEmail','0',NULL,'If enabled, any patron attempting to register themselves via the OPAC will be required to verify themselves via email to activate his or her account.','YesNo'),('PatronsPerPage','20','20','Number of Patrons Per Page displayed by default','Integer'),('Persona','0','','Use Mozilla Persona for login','YesNo'),('PrefillItem','0','','When a new item is added, should it be prefilled with last created item values?','YesNo'),('previousIssuesDefaultSortOrder','asc','asc|desc','Specify the sort order of Previous Issues on the circulation page','Choice'),('printcirculationslips','1','','If ON, enable printing circulation receipts','YesNo'),('PrintNoticesMaxLines','0','','If greater than 0, sets the maximum number of lines an overdue notice will print. If the number of items is greater than this number, the notice will end with a warning asking the borrower to check their online account for a full list of overdue items.','Integer'),('QueryAutoTruncate','1',NULL,'If ON, query truncation is enabled by default','YesNo'),('QueryFuzzy','1',NULL,'If ON, enables fuzzy option for searches','YesNo'),('QueryStemming','1',NULL,'If ON, enables query stemming','YesNo'),('QueryWeightFields','1',NULL,'If ON, enables field weighting','YesNo'),('QuoteOfTheDay','0',NULL,'Enable or disable display of Quote of the Day on the OPAC home page','YesNo'),('RandomizeHoldsQueueWeight','0',NULL,'if ON, the holds queue in circulation will be randomized, either based on all location codes, or by the location codes specified in StaticHoldsQueueWeight','YesNo'),('RecordLocalUseOnReturn','0',NULL,'If ON, statistically record returns of unissued items as local use, instead of return','YesNo'),('RefundLostItemFeeOnReturn','1',NULL,'If enabled, the lost item fee charged to a borrower will be refunded when the lost item is returned.','YesNo'),('RenewalPeriodBase','date_due','date_due|now','Set whether the renewal date should be counted from the date_due or from the moment the Patron asks for renewal ','Choice'),('RenewalSendNotice','0','',NULL,'YesNo'),('RenewSerialAddsSuggestion','0',NULL,'If ON, adds a new suggestion at serial subscription renewal','YesNo'),('RentalsInNoissuesCharge','1',NULL,'Rental charges block checkouts (added to noissuescharge).','YesNo'),('RequestOnOpac','1',NULL,'If ON, globally enables patron holds on OPAC','YesNo'),('ReservesControlBranch','PatronLibrary','ItemHomeLibrary|PatronLibrary','Branch checked for members reservations rights','Choice'),('ReservesMaxPickUpDelay','7','','Define the Maximum delay to pick up an item on hold','Integer'),('ReservesNeedReturns','1','','If ON, a hold placed on an item available in this library must be checked-in, otherwise, a hold on a specific item, that is in the library & available is considered available','YesNo'),('ReturnBeforeExpiry','0',NULL,'If ON, checkout will be prevented if returndate is after patron card expiry','YesNo'),('ReturnLog','1',NULL,'If ON, enables the circulation (returns) log','YesNo'),('ReturnToShelvingCart','0','','If set, when any item is \'checked in\', it\'s location code will be changed to CART.','YesNo'),('reviewson','1','','If ON, enables patron reviews of bibliographic records in the OPAC','YesNo'),('RoutingListAddReserves','1','','If ON the patrons on routing lists are automatically added to holds on the issue.','YesNo'),('RoutingListNote','To change this note edit <a href=\"/cgi-bin/koha/admin/preferences.pl?op=search&searchfield=RoutingListNote#jumped\">RoutlingListNote</a> system preference.','70|10','Define a note to be shown on all routing lists','Textarea'),('RoutingSerials','1',NULL,'If ON, serials routing is enabled','YesNo'),('SCOUserCSS','',NULL,'Add CSS to be included in the SCO module in an embedded <style> tag.','free'),('SCOUserJS','',NULL,'Define custom javascript for inclusion in the SCO module','free'),('SearchMyLibraryFirst','0',NULL,'If ON, OPAC searches return results limited by the user\'s library by default if they are logged in','YesNo'),('SelfCheckHelpMessage','','70|10','Enter HTML to include under the basic Web-based Self Checkout instructions on the Help page','Textarea'),('SelfCheckTimeout','120','','Define the number of seconds before the Web-based Self Checkout times out a patron','Integer'),('SeparateHoldings','0',NULL,'Separate current branch holdings from other holdings','YesNo'),('SeparateHoldingsBranch','homebranch','homebranch|holdingbranch','Branch used to separate holdings','Choice'),('SessionStorage','mysql','mysql|Pg|tmp','Use database or a temporary file for storing session data','Choice'),('ShelfBrowserUsesCcode','1','0','Use the item collection code when finding items for the shelf browser.','YesNo'),('ShelfBrowserUsesHomeBranch','1','1','Use the item home branch when finding items for the shelf browser.','YesNo'),('ShelfBrowserUsesLocation','1','1','Use the item location when finding items for the shelf browser.','YesNo'),('ShowPatronImageInWebBasedSelfCheck','1','','If ON, displays patron image when a patron uses web-based self-checkout','YesNo'),('ShowReviewer','full','none|full|first|surname|firstandinitial|username','Choose how a commenter\'s identity is presented alongside comments in the OPAC','Choice'),('ShowReviewerPhoto','1','','If ON, photo of reviewer will be shown beside comments in OPAC','YesNo'),('singleBranchMode','0',NULL,'Operate in Single-branch mode, hide branch selection in the OPAC','YesNo'),('SlipCSS','',NULL,'Slips CSS url.','free'),('SMSSendDriver','','','Sets which SMS::Send driver is used to send SMS messages.','free'),('SocialNetworks','0','','Enable/Disable social networks links in opac detail pages','YesNo'),('soundon','0','','Enable circulation sounds during checkin and checkout in the staff interface.  Not supported by all web browsers yet.','YesNo'),('SpecifyDueDate','1','','Define whether to display \"Specify Due Date\" form in Circulation','YesNo'),('SpineLabelAutoPrint','0','','If this setting is turned on, a print dialog will automatically pop up for the quick spine label printer.','YesNo'),('SpineLabelFormat','<itemcallnumber><copynumber>','30|10','This preference defines the format for the quick spine label printer. Just list the fields you would like to see in the order you would like to see them, surrounded by <>, for example <itemcallnumber>.','Textarea'),('SpineLabelShowPrintOnBibDetails','0','','If turned on, a \"Print Label\" link will appear for each item on the bib details page in the staff interface.','YesNo'),('StaffAuthorisedValueImages','1',NULL,'','YesNo'),('staffClientBaseURL','',NULL,'Specify the base URL of the staff client','free'),('StaffSerialIssueDisplayCount','3','','Number of serial issues to display per subscription in the Staff client','Integer'),('StaticHoldsQueueWeight','0',NULL,'Specify a list of library location codes separated by commas -- the list of codes will be traversed and weighted with first values given higher weight for holds fulfillment -- alternatively, if RandomizeHoldsQueueWeight is set, the list will be randomly selective','Integer'),('SubfieldsToUseWhenPrefill','','','Define a list of subfields to use when prefilling items (separated by space)','Free'),('SubscriptionDuplicateDroppedInput','','','List of fields which must not be rewritten when a subscription is duplicated (Separated by pipe |)','Free'),('SubscriptionHistory','simplified','simplified|full','Define the display preference for serials issue history in OPAC','Choice'),('SubscriptionLog','1',NULL,'If ON, enables subscriptions log','YesNo'),('suggestion','1','','If ON, enables patron suggestions feature in OPAC','YesNo'),('SuspendHoldsIntranet','1','Allow holds to be suspended from the intranet.',NULL,'YesNo'),('SuspendHoldsOpac','1','Allow holds to be suspended from the OPAC.',NULL,'YesNo'),('SvcMaxReportRows','10',NULL,'Maximum number of rows to return via the report web service.','Integer'),('SyndeticsAuthorNotes','0','','Display Notes about the Author on OPAC from Syndetics','YesNo'),('SyndeticsAwards','0','','Display Awards on OPAC from Syndetics','YesNo'),('SyndeticsClientCode','0','','Client Code for using Syndetics Solutions content','free'),('SyndeticsCoverImages','0','','Display Cover Images from Syndetics','YesNo'),('SyndeticsCoverImageSize','MC','MC|LC','Choose the size of the Syndetics Cover Image to display on the OPAC detail page, MC is Medium, LC is Large','Choice'),('SyndeticsEditions','0','','Display Editions from Syndetics','YesNo'),('SyndeticsEnabled','0','','Turn on Syndetics Enhanced Content','YesNo'),('SyndeticsExcerpt','0','','Display Excerpts and first chapters on OPAC from Syndetics','YesNo'),('SyndeticsReviews','0','','Display Reviews on OPAC from Syndetics','YesNo'),('SyndeticsSeries','0','','Display Series information on OPAC from Syndetics','YesNo'),('SyndeticsSummary','0','','Display Summary Information from Syndetics','YesNo'),('SyndeticsTOC','0','','Display Table of Content information from Syndetics','YesNo'),('TagsEnabled','1','','Enables or disables all tagging features.  This is the main switch for tags.','YesNo'),('TagsExternalDictionary',NULL,'','Path on server to local ispell executable, used to set $Lingua::Ispell::path  This dictionary is used as a \"whitelist\" of pre-allowed tags.',''),('TagsInputOnDetail','1','','Allow users to input tags from the detail page.','YesNo'),('TagsInputOnList','0','','Allow users to input tags from the search results list.','YesNo'),('TagsModeration','0','','Require tags from patrons to be approved before becoming visible.','YesNo'),('TagsShowOnDetail','10','','Number of tags to display on detail page.  0 is off.','Integer'),('TagsShowOnList','6','','Number of tags to display on search results list.  0 is off.','Integer'),('template','prog','','Define the preferred staff interface template','Themes'),('ThingISBN','0','','Use with FRBRizeEditions. If ON, Koha will use the ThingISBN web service in the Editions tab on the detail pages.','YesNo'),('TimeFormat','24hr','12hr|24hr','Defines the global time format for visual output.','Choice'),('timeout','12000000',NULL,'Inactivity timeout for cookies authentication (in seconds)','Integer'),('todaysIssuesDefaultSortOrder','desc','asc|desc','Specify the sort order of Todays Issues on the circulation page','Choice'),('TraceCompleteSubfields','0','0','Force subject tracings to only match complete subfields.','YesNo'),('TraceSubjectSubdivisions','0','1','Create searches on all subdivisions for subject tracings.','YesNo'),('TrackClicks','0',NULL,'Track links clicked','Integer'),('TransfersMaxDaysWarning','3',NULL,'Define the days before a transfer is suspected of having a problem','Integer'),('TransferWhenCancelAllWaitingHolds','0',NULL,'Transfer items when cancelling all waiting holds','YesNo'),('UNIMARCAuthorityField100','afrey50      ba0',NULL,NULL,'Textarea'),('UNIMARCAuthorsFacetsSeparator',', ',NULL,'UNIMARC authors facets separator','short'),('UNIMARCField100Language','fre',NULL,'UNIMARC field 100 default language','short'),('UniqueItemFields','barcode','','Space-separated list of fields that should be unique (used in acquisition module for item creation). Fields must be valid SQL column names of items table','Free'),('UpdateTotalIssuesOnCirc','0',NULL,'Whether to update the totalissues field in the biblio on each circ.','YesNo'),('uppercasesurnames','0',NULL,'If ON, surnames are converted to upper case in patron entry form','YesNo'),('URLLinkText','',NULL,'Text to display as the link anchor in the OPAC','free'),('UseAuthoritiesForTracings','1','0','Use authority record numbers for subject tracings instead of heading strings.','YesNo'),('UseBranchTransferLimits','1','','If ON, Koha will will use the rules defined in branch_transfer_limits to decide if an item transfer should be allowed.','YesNo'),('UseControlNumber','0','','If ON, record control number (w subfields) and control number (001) are used for linking of bibliographic records.','YesNo'),('useDaysMode','Calendar','Calendar|Days|Datedue','Choose the method for calculating due date: select Calendar to use the holidays module, and Days to ignore the holidays module','Choice'),('UseICU','0','1','Tell Koha if ICU indexing is in use for Zebra or not.','YesNo'),('UseKohaPlugins','1','','Enable or disable the ability to use Koha Plugins.','YesNo'),('UseQueryParser','0',NULL,'If enabled, try to use QueryParser for queries.','YesNo'),('UseTablesortForCirc','0','','If on, use the JQuery tablesort function on the list of current borrower checkouts on the circulation page.  Note that the use of this function may slow down circ for patrons with may checkouts.','YesNo'),('UseTransportCostMatrix','0','','Use Transport Cost Matrix when filling holds','YesNo'),('Version','3.1206000',NULL,'The Koha database version. WARNING: Do not change this value manually, it is maintained by the webinstaller',NULL),('viewISBD','1','','Allow display of ISBD view of bibiographic records','YesNo'),('viewLabeledMARC','0','','Allow display of labeled MARC view of bibiographic records','YesNo'),('viewMARC','1','','Allow display of MARC view of bibiographic records','YesNo'),('virtualshelves','1','','If ON, enables Lists management','YesNo'),('WaitingNotifyAtCheckin','0',NULL,'If ON, notify librarians of waiting holds for the patron whose items they are checking in.','YesNo'),('WebBasedSelfCheck','1',NULL,'If ON, enables the web-based self-check system','YesNo'),('XISBN','0','','Use with FRBRizeEditions. If ON, Koha will use the OCLC xISBN web service in the Editions tab on the detail pages. See: http://www.worldcat.org/affiliate/webservices/xisbn/app.jsp','YesNo'),('XISBNDailyLimit','999','','The xISBN Web service is free for non-commercial use when usage does not exceed 1000 requests per day','Integer'),('XSLTDetailsDisplay','default','','Enable XSL stylesheet control over details page display on intranet','Free'),('XSLTResultsDisplay','default','','Enable XSL stylesheet control over results page display on intranet','Free'),('yuipath','local','local|http://yui.yahooapis.com/2.5.1/build','Insert the path to YUI libraries, choose local if you use koha offline','Choice'),('z3950AuthorAuthFields','701,702,700',NULL,'Define the MARC biblio fields for Personal Name Authorities to fill biblio.author','free'),('z3950NormalizeAuthor','0','','If ON, Personal Name Authorities will replace authors in biblio.author','YesNo');
/*!40000 ALTER TABLE `systempreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `entry` varchar(255) NOT NULL DEFAULT '',
  `weight` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_all`
--

DROP TABLE IF EXISTS `tags_all`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_all` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `borrowernumber` int(11) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `term` varchar(255) NOT NULL,
  `language` int(4) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `tags_borrowers_fk_1` (`borrowernumber`),
  KEY `tags_biblionumber_fk_1` (`biblionumber`),
  CONSTRAINT `tags_borrowers_fk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_biblionumber_fk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_all`
--

LOCK TABLES `tags_all` WRITE;
/*!40000 ALTER TABLE `tags_all` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_all` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_approval`
--

DROP TABLE IF EXISTS `tags_approval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_approval` (
  `term` varchar(255) NOT NULL,
  `approved` int(1) NOT NULL DEFAULT '0',
  `date_approved` datetime DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `weight_total` int(9) NOT NULL DEFAULT '1',
  PRIMARY KEY (`term`),
  KEY `tags_approval_borrowers_fk_1` (`approved_by`),
  CONSTRAINT `tags_approval_borrowers_fk_1` FOREIGN KEY (`approved_by`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_approval`
--

LOCK TABLES `tags_approval` WRITE;
/*!40000 ALTER TABLE `tags_approval` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_approval` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_index`
--

DROP TABLE IF EXISTS `tags_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_index` (
  `term` varchar(255) NOT NULL,
  `biblionumber` int(11) NOT NULL,
  `weight` int(9) NOT NULL DEFAULT '1',
  PRIMARY KEY (`term`,`biblionumber`),
  KEY `tags_index_biblionumber_fk_1` (`biblionumber`),
  CONSTRAINT `tags_index_term_fk_1` FOREIGN KEY (`term`) REFERENCES `tags_approval` (`term`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tags_index_biblionumber_fk_1` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_index`
--

LOCK TABLES `tags_index` WRITE;
/*!40000 ALTER TABLE `tags_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tmp_holdsqueue`
--

DROP TABLE IF EXISTS `tmp_holdsqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tmp_holdsqueue` (
  `biblionumber` int(11) DEFAULT NULL,
  `itemnumber` int(11) DEFAULT NULL,
  `barcode` varchar(20) DEFAULT NULL,
  `surname` mediumtext NOT NULL,
  `firstname` text,
  `phone` text,
  `borrowernumber` int(11) NOT NULL,
  `cardnumber` varchar(16) DEFAULT NULL,
  `reservedate` date DEFAULT NULL,
  `title` mediumtext,
  `itemcallnumber` varchar(255) DEFAULT NULL,
  `holdingbranch` varchar(10) DEFAULT NULL,
  `pickbranch` varchar(10) DEFAULT NULL,
  `notes` text,
  `item_level_request` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tmp_holdsqueue`
--

LOCK TABLES `tmp_holdsqueue` WRITE;
/*!40000 ALTER TABLE `tmp_holdsqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `tmp_holdsqueue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_cost`
--

DROP TABLE IF EXISTS `transport_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_cost` (
  `frombranch` varchar(10) NOT NULL,
  `tobranch` varchar(10) NOT NULL,
  `cost` decimal(6,2) NOT NULL,
  `disable_transfer` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`frombranch`,`tobranch`),
  KEY `transport_cost_ibfk_2` (`tobranch`),
  CONSTRAINT `transport_cost_ibfk_1` FOREIGN KEY (`frombranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transport_cost_ibfk_2` FOREIGN KEY (`tobranch`) REFERENCES `branches` (`branchcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_cost`
--

LOCK TABLES `transport_cost` WRITE;
/*!40000 ALTER TABLE `transport_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `transport_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permissions`
--

DROP TABLE IF EXISTS `user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permissions` (
  `borrowernumber` int(11) NOT NULL DEFAULT '0',
  `module_bit` int(11) NOT NULL DEFAULT '0',
  `code` varchar(64) DEFAULT NULL,
  KEY `user_permissions_ibfk_1` (`borrowernumber`),
  KEY `user_permissions_ibfk_2` (`module_bit`,`code`),
  CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`module_bit`, `code`) REFERENCES `permissions` (`module_bit`, `code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permissions`
--

LOCK TABLES `user_permissions` WRITE;
/*!40000 ALTER TABLE `user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userflags`
--

DROP TABLE IF EXISTS `userflags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userflags` (
  `bit` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(30) DEFAULT NULL,
  `flagdesc` varchar(255) DEFAULT NULL,
  `defaulton` int(11) DEFAULT NULL,
  PRIMARY KEY (`bit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userflags`
--

LOCK TABLES `userflags` WRITE;
/*!40000 ALTER TABLE `userflags` DISABLE KEYS */;
INSERT INTO `userflags` VALUES (0,'superlibrarian','Tilgang til alle bibliotekarfunksjoner',0),(1,'circulate','Sirkulasjon',0),(2,'catalogue','Søke i katalogen (internt)',0),(3,'parameters','Endre Kohas systempreferanser',0),(4,'borrowers','Legge til og endre lånere',0),(5,'permissions','Endre brukerrettigheter',0),(6,'reserveforothers','Reservere og endre reservasjoner for lånere',0),(7,'borrow','Låne dokumenter',1),(9,'editcatalogue','Endre katalogen (Endre bibliografiske poster og eksemplaropplysninger)',0),(10,'updatecharges','Endre gebyrer for lånere',0),(11,'acquisition','Innkjøp og/eller behandling av forslag',0),(12,'management','Endre \"library managament parameters\"',0),(13,'tools','Bruke verktøy (eksport, import, strekkoder)',0),(14,'editauthorities','Tilgang til å endre autoriteter',0),(15,'serials','Tilgang til å endre abonnementer',0),(16,'reports','Tilgang til rapportmodulen',0),(17,'staffaccess','Endre innlogging og rettigheter for bibliotekansatte',0),(19,'plugins','Koha plugins',0);
/*!40000 ALTER TABLE `userflags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualshelfcontents`
--

DROP TABLE IF EXISTS `virtualshelfcontents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualshelfcontents` (
  `shelfnumber` int(11) NOT NULL DEFAULT '0',
  `biblionumber` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) DEFAULT NULL,
  `dateadded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `borrowernumber` int(11) DEFAULT NULL,
  KEY `shelfnumber` (`shelfnumber`),
  KEY `biblionumber` (`biblionumber`),
  KEY `shelfcontents_ibfk_3` (`borrowernumber`),
  CONSTRAINT `virtualshelfcontents_ibfk_1` FOREIGN KEY (`shelfnumber`) REFERENCES `virtualshelves` (`shelfnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shelfcontents_ibfk_2` FOREIGN KEY (`biblionumber`) REFERENCES `biblio` (`biblionumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `shelfcontents_ibfk_3` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualshelfcontents`
--

LOCK TABLES `virtualshelfcontents` WRITE;
/*!40000 ALTER TABLE `virtualshelfcontents` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtualshelfcontents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualshelfshares`
--

DROP TABLE IF EXISTS `virtualshelfshares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualshelfshares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shelfnumber` int(11) NOT NULL,
  `borrowernumber` int(11) DEFAULT NULL,
  `invitekey` varchar(10) DEFAULT NULL,
  `sharedate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `virtualshelfshares_ibfk_1` (`shelfnumber`),
  KEY `virtualshelfshares_ibfk_2` (`borrowernumber`),
  CONSTRAINT `virtualshelfshares_ibfk_1` FOREIGN KEY (`shelfnumber`) REFERENCES `virtualshelves` (`shelfnumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `virtualshelfshares_ibfk_2` FOREIGN KEY (`borrowernumber`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualshelfshares`
--

LOCK TABLES `virtualshelfshares` WRITE;
/*!40000 ALTER TABLE `virtualshelfshares` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtualshelfshares` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `virtualshelves`
--

DROP TABLE IF EXISTS `virtualshelves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `virtualshelves` (
  `shelfnumber` int(11) NOT NULL AUTO_INCREMENT,
  `shelfname` varchar(255) DEFAULT NULL,
  `owner` int(11) DEFAULT NULL,
  `category` varchar(1) DEFAULT NULL,
  `sortfield` varchar(16) DEFAULT NULL,
  `lastmodified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `allow_add` tinyint(1) DEFAULT '0',
  `allow_delete_own` tinyint(1) DEFAULT '1',
  `allow_delete_other` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`shelfnumber`),
  KEY `virtualshelves_ibfk_1` (`owner`),
  CONSTRAINT `virtualshelves_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `borrowers` (`borrowernumber`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `virtualshelves`
--

LOCK TABLES `virtualshelves` WRITE;
/*!40000 ALTER TABLE `virtualshelves` DISABLE KEYS */;
/*!40000 ALTER TABLE `virtualshelves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `z3950servers`
--

DROP TABLE IF EXISTS `z3950servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `z3950servers` (
  `host` varchar(255) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `db` varchar(255) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` mediumtext,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checked` smallint(6) DEFAULT NULL,
  `rank` int(11) DEFAULT NULL,
  `syntax` varchar(80) DEFAULT NULL,
  `timeout` int(11) NOT NULL DEFAULT '0',
  `icon` text,
  `position` enum('primary','secondary','') NOT NULL DEFAULT 'primary',
  `type` enum('zed','opensearch') NOT NULL DEFAULT 'zed',
  `encoding` text,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `z3950servers`
--

LOCK TABLES `z3950servers` WRITE;
/*!40000 ALTER TABLE `z3950servers` DISABLE KEYS */;
INSERT INTO `z3950servers` VALUES ('lx2.loc.gov',210,'LCDB','','','LIBRARY OF CONGRESS',1,0,0,'USMARC',0,NULL,'primary','zed','utf8',''),('rikard10',210,'LCDB','','','LIBRARY OF CONGRESS (PROXY)',2,0,0,'USMARC',0,NULL,'primary','zed','utf8',''),('z3950.bibsys.no',2100,'BIBSYS','','','BIBSYS',12,1,1,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('z3950.nb.no',2100,'Norbok','','','NORBOK',13,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('z3950.nb.no',2100,'Sambok','','','SAMBOK',14,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('z3950.deich.folkebibl.no',210,'data','','','DEICHMAN',15,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('z3950.trondheim.folkebibl.no',210,'data','','','TRONDHEIM',16,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('z3950.bergen.folkebibl.no',210,'data','','','BERGEB',17,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('bokbase.stavanger.folkebibl.no',9909,'nor1','','','STAVANGER',18,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1',''),('z3950.barum.folkebibl.no',210,'data','','','BÆRUM',19,0,0,'NORMARC',0,NULL,'primary','zed','ISO_8859-1','');
/*!40000 ALTER TABLE `z3950servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zebraqueue`
--

DROP TABLE IF EXISTS `zebraqueue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zebraqueue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `biblio_auth_number` bigint(20) unsigned NOT NULL DEFAULT '0',
  `operation` char(20) NOT NULL DEFAULT '',
  `server` char(20) NOT NULL DEFAULT '',
  `done` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `zebraqueue_lookup` (`server`,`biblio_auth_number`,`operation`,`done`)
) ENGINE=InnoDB AUTO_INCREMENT=1672222 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zebraqueue`
--

LOCK TABLES `zebraqueue` WRITE;
/*!40000 ALTER TABLE `zebraqueue` DISABLE KEYS */;
/*!40000 ALTER TABLE `zebraqueue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-10-22 10:04:00
