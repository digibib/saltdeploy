-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: koha_{{ pillar['koha']['instance'] }}
-- ------------------------------------------------------
-- Server version 5.5.32-0ubuntu0.13.04.1

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
-- Current Database: `koha_{{ pillar['koha']['instance'] }}`
--

USE `koha_{{ pillar['koha']['instance'] }}`;

LOCK TABLES `systempreferences` WRITE;
/*!40000 ALTER TABLE `systempreferences` DISABLE KEYS */;

UPDATE systempreferences SET value = '2', options = '' WHERE variable = 'DebugLevel';

UPDATE systempreferences SET value = '1', options = '' WHERE variable = 'AllowOnShelfHolds';

UPDATE systempreferences SET value = '1' WHERE variable = 'AutomaticItemReturn';

UPDATE systempreferences SET value = '1', options = '' WHERE variable = 'AllowItemsOnHoldCheckout';

-- Issue #1870: Skjuling av felter i Koha sitt skjema for registrering av brukere
UPDATE systempreferences SET value = 'borrowernumber|cardnumber|surname|city|zipcode|dateofbirth|categorycode|sex|password' WHERE variable = 'BorrowerMandatoryField';
UPDATE systempreferences SET value = 'title|othernames|initials|streetnumber|streettype|state|fax|emailpro|B_streetnumber|B_streettype|B_state|B_email|B_phone|flags|opacnote|contactnote|sort1|sort2|altcontactfirstname|altcontactsurname|altcontactaddress1|altcontactaddress2|altcontactaddress3|altcontactstate|altcontactzipcode|altcontactcountry|altcontactphone' WHERE variable = 'BorrowerUnwantedField';

UPDATE systempreferences SET value = '1' WHERE variable = 'EnhancedMessagingPreferences';

UPDATE systempreferences SET value = '1' WHERE variable = 'ILS-DI';
UPDATE systempreferences SET value = '' WHERE variable = 'ILS-DI:AuthorizedIPs';

-- TODO: formulate js for printing
UPDATE systempreferences SET value = '' WHERE variable = 'IntranetSlipPrinterJS';


-- Issue #1895: Automatisk bruke strekkoden på lånekortet som brukernavn
UPDATE systempreferences SET value = '
$(document).ready(function(){
  $("#entryform #userid").attr("disabled", true);
  $("#entryform #cardnumber").blur(function(){
    $("#entryform #userid").val($("#entryform #cardnumber").val());
  });
});' WHERE variable = 'intranetuserjs';

-- TODO: remove this when cataloguing goes pure RDF
UPDATE systempreferences SET value = '1' WHERE variable = 'OAI-PMH';
UPDATE systempreferences SET value = 'KOHA-OAI-TEST' WHERE variable = 'OAI-PMH:archiveID';

-- TODO: remove opac setting when it is superfluous
UPDATE systempreferences SET value = 'h1#logo {background: transparent url(http://datatest.deichman.no/saltfiles/koha/logo.png) no-repeat scroll 0%; }' WHERE variable = 'IntranetUserCSS';
UPDATE systempreferences SET value = 'h1#libraryname { width: 180px; }' WHERE variable = 'OPACUserCSS';

UPDATE systempreferences SET value = 'NO::HTTP' WHERE variable = 'SMSSendDriver';

UPDATE systempreferences SET value = '1' WHERE variable = 'UseKohaPlugins';
/*!40000 ALTER TABLE `systempreferences` ENABLE KEYS */;
UNLOCK TABLES;
