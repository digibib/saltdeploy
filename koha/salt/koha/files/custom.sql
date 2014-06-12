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

--
-- Table structure for table `authorised_values`
--

TRUNCATE TABLE `authorised_values`;
LOCK TABLES `authorised_values` WRITE;
/*!40000 ALTER TABLE `authorised_values` DISABLE KEYS */;
INSERT INTO `authorised_values` VALUES 
(1,'SUGGEST','BSELL','Bestselger',NULL,NULL),
(2,'SUGGEST','SCD','Bibliotekets eksemplar er skadet',NULL,NULL),
(3,'SUGGEST','LCL','Bibliotekets eksemplar er tapt',NULL,NULL),
(4,'SUGGEST','AVILL','Tilgjengelig via fjernlån',NULL,NULL),
(5,'LOST','2','Regnes som tapt',NULL,NULL),
(6,'LOST','1','Tapt',NULL,NULL),
(7,'LOST','3','Tapt og erstattet',NULL,NULL),
(8,'LOST','4','Savnet',NULL,NULL),
(9,'DAMAGED','1','Skadet',NULL,NULL),
(10,'LOC','FIC','Skjønnlitteratur',NULL,NULL),
(11,'LOC','CHILD','Barneavdelingen',NULL,NULL),
(12,'LOC','DISPLAY','På utstilling',NULL,NULL),
(13,'LOC','NEW','Nyhetshylla',NULL,NULL),
(14,'LOC','STAFF','Ansattes kontor',NULL,NULL),
(15,'LOC','GEN','Samlingen',NULL,NULL),
(16,'LOC','AV','AV-materiale',NULL,NULL),
(17,'LOC','REF','Oppslagsverk',NULL,NULL),
(18,'LOC','CART','Boktralle',NULL,NULL),
(19,'LOC','PROC','Til klargjøring',NULL,NULL),
(20,'CCODE','FIC','Skjønnlitteratur',NULL,NULL),
(21,'CCODE','REF','Oppslagsverk',NULL,NULL),
(22,'CCODE','NFIC','Faglitteratur',NULL,NULL),
(23,'WITHDRAWN','1','Trukket tilbake',NULL,NULL),
(24,'NOT_LOAN','-1','I bestilling',NULL,NULL),
(25,'NOT_LOAN','1','Ikke til utlån',NULL,NULL),
(26,'NOT_LOAN','2','Kun til internt bruk',NULL,NULL),
(27,'RESTRICTED','1','Begrenset tilgang',NULL,NULL),
(28,'MANUAL_INV','Kopiavgift','0,25',NULL,NULL),
(29,'BOR_NOTES','ADDR','Addresse-noter',NULL,NULL),
(30,'OPAC_SUG','damaged','Eksemplaret på hylla er skadet','Eksemplaret på hylla er skadet',NULL),
(31,'OPAC_SUG','bestseller','Kommende tittel av populær forfatter','Kommende tittel av populær forfatter',NULL),
(32,'REPORT_GROUP','CIRC','Sirkulasjon',NULL,NULL),
(33,'REPORT_GROUP','CAT','Katalog',NULL,NULL),
(34,'REPORT_GROUP','PAT','Lånere',NULL,NULL),
(35,'REPORT_GROUP','ACQ','Innkjøp',NULL,NULL),
(36,'REPORT_GROUP','ACC','Gebyrer',NULL,NULL);
/*!40000 ALTER TABLE `authorised_values` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `borrowers`
--
TRUNCATE TABLE `borrowers`;
LOCK TABLES `borrowers` WRITE;
/*!40000 ALTER TABLE `borrowers` DISABLE KEYS */;
INSERT INTO `borrowers` (borrowernumber,cardnumber,surname,firstname,address,city,branchcode,categorycode,dateenrolled,dateexpiry,password,flags,userid) 
VALUES 
(1,'1','Söze','Keyser','','','hutl','ADMIN','2013-09-19','2022-01-19','7AjNkXXC4JQpTOyXMhSOcQ',1,'flesk'),
(2,'2','Automat_hoved1','','','','hutl','AUTO','2013-12-18','2022-03-18','$2a$08$IiT8vYz8Gn6yf0dq5eOmCuMBqoNw06V6wzmhaZurJ9YXuNWw7Qv66',2,'autohoved1');
/*!40000 ALTER TABLE `borrowers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branchcategories`
--
TRUNCATE TABLE `branchcategories`;
LOCK TABLES `branchcategories` WRITE;
/*!40000 ALTER TABLE `branchcategories` DISABLE KEYS */;
INSERT INTO `branchcategories` VALUES 
('ALLE','Alle filialer','Hele Deichman','searchdomain',1),
('HOVED','Hovedbiblioteket','Voksenavd, Musikk & Unge Deichman','searchdomain',1);
/*!40000 ALTER TABLE `branchcategories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branches`
--
TRUNCATE TABLE `branches`;
LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` (branchcode, branchname) 
VALUES 
('dfb','Det Flerspråklige Bibliotek'),
('dfbs','Det Flerspråklige Bibliotek Referanse'),
('fbje','Bjerke'),
('fbjh','Bjerke, lokalhistorie'),
('fbji','Bjerke, innvandrerlitteratur'),
('fbjl','Bjørnholt læremidler'),
('fbjo','Bjørnholt'),
('fbju','Bjørnholt ungdomsskole'),
('fbli','vet ikke'),
('fbol','Bøler'),
('fdum','dummy'),
('ffur','Furuset'),
('fgam','Gamle Oslo'),
('fgry','Grünerløkka'),
('fgyi','Grünerløkka innvanrerlitteratur'),
('fhol','Holmlia'),
('flam','Lambertseter'),
('fmaj','Majorstua'),
('fnor','Nordtvet'),
('fnti','Fnatt!'),
('fnyd','Nydalen'),
('fopp','Oppsal'),
('frik','Rikshospitalet'),
('frmm','Rommen'),
('froa','Røa'),
('from','Romsås'),
('fsme','Smestad'),
('fsor','Sørkedalen nærbibliotek'),
('fsti','Stovner innlån?'),
('fsto','Stovner'),
('ftoi','Torshov innvandrerlitteratur'),
('ftor','Torshov'),
('fxxx','filial X'),
('hbar','Barneavdelingen (Hovedutlånet)'),
('hbbr','Barneavdelingen spesialsamling'),
('hsko','Skoleavdelingen'),
('hutl','Hovedbiblioteket'),
('hvkr','Katalogavdeling referanse'),
('hvlr','Stjernesamling, lesesalen'),
('hvmu','Musikkavdelingen (Hovedbiblioteket)'),
('hvur','Spesialsamling, fjernlån'),
('info','til info?'),
('idep','depot?'),
('ukjent','mangler?'),
('cpl', '(test)'),
('mpl', '(test)'),
('rpl', '(test)');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `branchrelations`
--

TRUNCATE TABLE `branchrelations`;
LOCK TABLES `branchrelations` WRITE;
/*!40000 ALTER TABLE `branchrelations` DISABLE KEYS */;
INSERT INTO `branchrelations` (branchcode, categorycode)
VALUES ('DFB', 'ALLE'),
('DFBS', 'ALLE'),
('FBJE', 'ALLE'),
('FBJH', 'ALLE'),
('FBJI', 'ALLE'),
('FBJL', 'ALLE'),
('FBJO', 'ALLE'),
('FBJU', 'ALLE'),
('FBLI', 'ALLE'),
('FBOL', 'ALLE'),
('FDUM', 'ALLE'),
('FFUR', 'ALLE'),
('FGAM', 'ALLE'),
('FGRY', 'ALLE'),
('FGYI', 'ALLE'),
('FHOL', 'ALLE'),
('FLAM', 'ALLE'),
('FMAJ', 'ALLE'),
('FNOR', 'ALLE'),
('FNTI', 'ALLE'),
('FNYD', 'ALLE'),
('FOPP', 'ALLE'),
('FRIK', 'ALLE'),
('FRMM', 'ALLE'),
('FROA', 'ALLE'),
('FROM', 'ALLE'),
('FSME', 'ALLE'),
('FSOR', 'ALLE'),
('FSTI', 'ALLE'),
('FSTO', 'ALLE'),
('FTOI', 'ALLE'),
('FTOR', 'ALLE'),
('FXXX', 'ALLE'),
('HBAR', 'ALLE'),
('HBBR', 'ALLE'),
('HSKO', 'ALLE'),
('HUTL', 'ALLE'),
('HVKR', 'ALLE'),
('HVLR', 'ALLE'),
('HVMU', 'ALLE'),
('HVUR', 'ALLE'),
('INFO', 'ALLE'),
('HBAR','HOVED'),
('HBBR','HOVED'),
('HSKO','HOVED'),
('HUTL','HOVED'),
('HVMU','HOVED');
/*!40000 ALTER TABLE `branchrelations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categories`
--
TRUNCATE TABLE `categories`;
LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (categorycode,description,enrolmentperiod,upperagelimit,finetype,overduenoticerequired,category_type)
VALUES 
('ADMIN','administrator',100,0,0,0,'S'),
('AUTO','Automat',99,0,0,0,'A'),
('BKM','Boken kommer',99,99,5,1,'P'),
('HB','Hjemmelåner',99,999,18,1,'A'),
('I','Institusjon',99,999,0,0,'I'),
('FJL','Fjernlån',99,999,18,1,'I'),
('J','Ungdom',99,17,5,1,'C'),
('B','Barn',99,17,5,1,'C'),
('BHG','Barnehage',100,999,0,0,'I'),
('L','Fylkes-/folkebibliotek',99,999,18,1,'I'),
('MXV','Makslån voksen',99,999,18,0,'A'),
('MDL','Midlertidig bosatt',6,999,18,0,'A'),
('PAS','Pasient',99,999,18,0,'A'),
('V','Voksen',99,999,18,1,'A'),
('S','Bibliotekansatt',99,999,18,0,'S'),
('SKO','Skole',99,999,18,1,'I'),
('KL','Grunnskole',99,999,0,0,'I'),
('ELE','Elevlåner',99,999,7,1,'A'),
('U','Ukjent',99,999,0,1,'A'),
('UE','Utgått elev',99,999,0,0,'C'),
('VGS','Videregående skole',99,999,0,0,'I');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `default_circ_rules`
--
TRUNCATE TABLE `default_circ_rules`;
LOCK TABLES `default_circ_rules` WRITE;
/*!40000 ALTER TABLE `default_circ_rules` DISABLE KEYS */;
INSERT INTO `default_circ_rules` (singleton,maxissueqty,holdallowed,returnbranch)
VALUES ('singleton',20,2,'homebranch');
/*!40000 ALTER TABLE `default_circ_rules` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `issuingrules`
--

TRUNCATE TABLE `issuingrules`;
LOCK TABLES `issuingrules` WRITE;
/*!40000 ALTER TABLE `issuingrules` DISABLE KEYS */;
INSERT INTO `issuingrules` (categorycode,itemtype,fine,finedays,firstremind,chargeperiod,maxissueqty,issuelength,lengthunit,hardduedate,hardduedatecompare,renewalsallowed,renewalperiod,reservesallowed,branchcode,overduefinescap)
VALUES 
('*','*',0.000000,0,7,14,20,28,'days',NULL,-1,2,14,20,'*',NULL),
('*','A',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','C',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','DB,DG',0.000000,0,0,21,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),
('*','DB,DH',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','DB,DI',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','DC,DG',0.000000,0,0,21,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),
('*','DC,DH',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','DC,DI',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','ED',0.000000,0,0,21,NULL,7,'days',NULL,-1,3,7,20,'*',NULL),
('*','ED,DG',0.000000,0,0,21,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),
('*','ED,DH',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','ED,TF',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','EE',0.000000,0,0,21,NULL,7,'days',NULL,-1,3,7,20,'*',NULL),
('*','EE,DG',0.000000,0,0,21,NULL,14,'days',NULL,-1,3,14,20,'*',NULL),
('*','EE,DH',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','EE,DI',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','EE,TF',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','EF',0.000000,0,0,21,NULL,7,'days',NULL,-1,3,7,20,'*',NULL),
('*','GC',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','GD',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','GG',0.000000,0,0,21,NULL,28,'days',NULL,-1,3,28,20,'*',NULL),
('*','J',0.000000,0,0,21,NULL,14,'days',NULL,-1,2,14,0,'*',NULL),
('BKM','*',50.000000,0,14,14,NULL,60,'days',NULL,-1,3,28,20,'*',100.000000),
('I','*',0.000000,0,7,14,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),
('FJL','*',0.000000,0,7,14,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),
('B','*',20.000000,0,7,14,20,28,'days',NULL,-1,2,28,20,'*',20.000000),
('BHG','*',0.000000,0,0,14,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),
('L','*',0.000000,0,0,14,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),
('MXV','*',50.000000,0,7,14,30,28,'days',NULL,-1,2,28,20,'*',100.000000),
('MDL','*',50.000000,0,7,14,2,28,'days',NULL,-1,2,28,20,'*',100.000000),
('PAS','*',0.000000,0,7,14,20,28,'days',NULL,-1,2,28,20,'*',NULL),
('V','*',50.000000,0,7,14,20,28,'days',NULL,-1,2,28,20,'*',100.000000),
('SKO','*',0.000000,0,7,14,NULL,42,'days',NULL,-1,2,28,20,'*',NULL),
('KL','*',0.000000,0,7,28,NULL,60,'days',NULL,-1,8,30,20,'*',NULL),
('ELE','*',0.000000,0,14,14,NULL,28,'days',NULL,-1,3,10,20,'*',NULL),
('U','*',50.000000,0,7,14,NULL,28,'days',NULL,-1,2,28,20,'*',100.000000),
('UE','*',0.000000,0,14,14,NULL,28,'days',NULL,-1,2,10,20,'*',NULL),
('VGS','*',0.000000,0,0,14,NULL,42,'days',NULL,-1,2,28,20,'*',NULL);
/*!40000 ALTER TABLE `issuingrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `itemtypes`
--
TRUNCATE TABLE `itemtypes`;
LOCK TABLES `itemtypes` WRITE;
/*!40000 ALTER TABLE `itemtypes` DISABLE KEYS */;
INSERT INTO `itemtypes` (itemtype,description,rentalcharge,notforloan,imageurl,summary,checkinmsg,checkinmsgtype)
VALUES 
('A','Kart',NULL,NULL,NULL,NULL,NULL,'message'),
('AB','Atlas',NULL,NULL,NULL,NULL,NULL,'message'),
('B','Manuskripter',NULL,NULL,NULL,NULL,NULL,'message'),
('C','Noter',0.0000,0,'bridge/score.gif',NULL,NULL,'message'),
('DA','Lydopptak - grammofonplate',NULL,NULL,NULL,NULL,NULL,'message'),
('DA,DG','Lydopptak - grammofonplate - musikk',NULL,NULL,NULL,NULL,NULL,'message'),
('DA,DH','Lydopptak - grammofonplate - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),
('DA,DI','Lydopptak - grammofonplate - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DA,DJ','Lydopptak - grammofonplate - annet',NULL,NULL,NULL,NULL,NULL,'message'),
('DB','Lydopptak - kassett',NULL,NULL,NULL,NULL,NULL,'message'),
('DB,DG','Lydopptak - kassett - musikk',NULL,NULL,NULL,NULL,NULL,'message'),
('DB,DH','Lydopptak - kassett - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),
('DB,DI','Lydopptak - kassett - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DB,DJ','Lydopptak - kassett - annet',NULL,NULL,NULL,NULL,NULL,'message'),
('DC','Lydopptak - kompaktplate',NULL,NULL,NULL,NULL,NULL,'message'),
('DC,DG','Lydopptak - kompaktplate - musikk',NULL,NULL,NULL,NULL,NULL,'message'),
('DC,DH','Lydopptak - kompaktplate - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),
('DC,DI','Lydopptak - kompaktplate - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DC,DI,DZ','Lydopptak - kompaktplate MP3 - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DC,DJ','Lydopptak - kompaktplate - annet',NULL,NULL,NULL,NULL,NULL,'message'),
('DD','Lydopptak - digibok',NULL,NULL,NULL,NULL,NULL,'message'),
('DD,DI','Lydopptak - digibok - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DE,DI','Lydopptak - digikort - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DG','Lydopptak - musikk',NULL,NULL,NULL,NULL,NULL,'message'),
('DH','Lydopptak - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),
('DI','Lydopptak - lydbok',NULL,NULL,NULL,NULL,NULL,'message'),
('DJ','Lydopptak - annen tale, annet',NULL,NULL,NULL,NULL,NULL,'message'),
('DK','Kombidokument',NULL,NULL,NULL,NULL,NULL,'message'),
('DZ','Lydopptak - mp3',NULL,NULL,NULL,NULL,NULL,'message'),
('EA','Film og video - filmkassett',NULL,NULL,NULL,NULL,NULL,'message'),
('EB','Film og video - filmsløyfe',NULL,NULL,NULL,NULL,NULL,'message'),
('EC','Film og video - filmspole',NULL,NULL,NULL,NULL,NULL,'message'),
('ED','Film og video - videokassett',NULL,NULL,NULL,NULL,NULL,'message'),
('ED,DG','Musikk-video',0.0000,0,NULL,NULL,NULL,'message'),
('ED,DH','Film og video - videokassett - språkkurs',NULL,NULL,NULL,NULL,NULL,'message'),
('ED,TF','Film og video - videokassett - for døve',NULL,NULL,NULL,NULL,NULL,'message'),
('EE','Film og video - videoplate DVD',0.0000,0,NULL,NULL,NULL,'message'),
('EE,DG','Film- og video - Videoplate DVD - musikk',0.0000,0,NULL,NULL,NULL,'message'),
('EE,DH','Film- og video - Videoplate DVD - språkkurs',0.0000,0,NULL,NULL,NULL,'message'),
('EE,DI','Film- og video - Videoplate DVD - lydbok',0.0000,0,NULL,NULL,NULL,'message'),
('EE,TF','Film og video - videoplate DVD - for døve',0.0000,0,NULL,NULL,NULL,'message'),
('EF','Film og video - blu-ray',NULL,NULL,NULL,NULL,NULL,'message'),
('EG','Film og video - 3D blu-ray',NULL,NULL,NULL,NULL,NULL,'message'),
('FA','Grafisk materiale - bilde',NULL,NULL,NULL,NULL,NULL,'message'),
('FB','Grafisk materiale - bildebånd',NULL,NULL,NULL,NULL,NULL,'message'),
('FC','Grafisk materiale - bildekort',NULL,NULL,NULL,NULL,NULL,'message'),
('FD','Grafisk materiale - dias',NULL,NULL,NULL,NULL,NULL,'message'),
('FE','Grafisk materiale - flippover-blokk',NULL,NULL,NULL,NULL,NULL,'message'),
('FF','Grafisk materiale - fotografi',NULL,NULL,NULL,NULL,NULL,'message'),
('FG','Grafisk materiale - grafisk blad',NULL,NULL,NULL,NULL,NULL,'message'),
('FH','Grafisk materiale - hologram',NULL,NULL,NULL,NULL,NULL,'message'),
('FI','Grafisk materiale - kunstreproduksjon',NULL,NULL,NULL,NULL,NULL,'message'),
('FJ','Grafisk materiale - ordkort',NULL,NULL,NULL,NULL,NULL,'message'),
('FK','Grafisk materiale - originalt kunstverk',NULL,NULL,NULL,NULL,NULL,'message'),
('FL','Grafisk materiale - plakat',NULL,NULL,NULL,NULL,NULL,'message'),
('FM','Grafisk materiale - plansje',NULL,NULL,NULL,NULL,NULL,'message'),
('FN','Grafisk materiale - postkort',NULL,NULL,NULL,NULL,NULL,'message'),
('FO','Grafisk materiale - røntgenbilde',NULL,NULL,NULL,NULL,NULL,'message'),
('FP','Grafisk materiale - stereobilde',NULL,NULL,NULL,NULL,NULL,'message'),
('FQ','Grafisk materiale - studieplansje',NULL,NULL,NULL,NULL,NULL,'message'),
('FR','Grafisk materiale - symbolkort',NULL,NULL,NULL,NULL,NULL,'message'),
('FS','Grafisk materiale - teknisk tegning',NULL,NULL,NULL,NULL,NULL,'message'),
('FT','Grafisk materiale - transparent',NULL,NULL,NULL,NULL,NULL,'message'),
('G','Elektroniske ressurser',NULL,NULL,NULL,NULL,NULL,'message'),
('GA','Nedlastbar fil',NULL,NULL,NULL,NULL,NULL,'message'),
('GA,DZ,DG','Nedlastbar musikk, MP3',NULL,NULL,NULL,NULL,NULL,'message'),
('GA,NA','Nedlastbar e-bok, PDF',NULL,NULL,NULL,NULL,NULL,'message'),
('GB','Elektroniske ressurser - diskett',NULL,NULL,NULL,NULL,NULL,'message'),
('GC','Elektroniske ressurser - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GC,MA','Dataspill - PC - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GC,MB','Dataspill - Playstation2 - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GC,MI','Dataspill - Xbox - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GC,MJ','Dataspill - Xbox 360 - DVD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GD','Elektroniske ressurser - CD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GD,MA','Dataspill - PC - CD-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GE','Elektroniske ressurser - Nettressurs',NULL,NULL,NULL,NULL,NULL,'message'),
('GF','Elektroniske ressurser - Lagringsbrikke',NULL,NULL,NULL,NULL,NULL,'message'),
('GF,MN','Elektroniske ressurser - Lagringsbrikke - Nintendo DS',NULL,NULL,NULL,NULL,NULL,'message'),
('GG','Elektroniske ressurser - Blue-ray-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GG,MC','Dataspill - Playstation 3 - Blu-ray-ROM',NULL,NULL,NULL,NULL,NULL,'message'),
('GH','Elektroniske ressurser - UMD',NULL,NULL,NULL,NULL,NULL,'message'),
('GH,MD','Dataspill - Playstation Portable - UMD',NULL,NULL,NULL,NULL,NULL,'message'),
('GI,MO','Dataspill - Wii-plate',NULL,NULL,NULL,NULL,NULL,'message'),
('GT','Elektroniske ressurser - DTBok',NULL,NULL,NULL,NULL,NULL,'message'),
('H','Tredimensjonal gjenstander',NULL,NULL,NULL,NULL,NULL,'message'),
('IA','Mikroformer - mikrofilmkassett',NULL,NULL,NULL,NULL,NULL,'message'),
('IB','Mikroformer - mikrofilmspole',NULL,NULL,NULL,NULL,NULL,'message'),
('IC','Mikroformer - mikrofilmkort',NULL,NULL,NULL,NULL,NULL,'message'),
('ID','Mikroformer - mikro-opak',NULL,NULL,NULL,NULL,NULL,'message'),
('IE','Mikroformer - vinduskassettt',NULL,NULL,NULL,NULL,NULL,'message'),
('J','Periodika',NULL,NULL,NULL,NULL,NULL,'message'),
('K','Artikler (i periodika eller bøker)',NULL,NULL,NULL,NULL,NULL,'message'),
('L','Bok',NULL,NULL,NULL,NULL,NULL,'message'),
('LA','E-bok',NULL,NULL,NULL,NULL,NULL,'message'),
('MA','Dataspill - PC',NULL,NULL,NULL,NULL,NULL,'message'),
('MB','Dataspill - Playstation 2',NULL,NULL,NULL,NULL,NULL,'message'),
('MC','Dataspill - Playstation 3',NULL,NULL,NULL,NULL,NULL,'message'),
('MD','Dataspill - Playstation portable',NULL,NULL,NULL,NULL,NULL,'message'),
('MI','Dataspill - Xbox',NULL,NULL,NULL,NULL,NULL,'message'),
('MJ','Dataspill - Xbox 360',NULL,NULL,NULL,NULL,NULL,'message'),
('MN','Dataspill - Nintendo DS',NULL,NULL,NULL,NULL,NULL,'message'),
('MO','Dataspill - Nintendo Wii',NULL,NULL,NULL,NULL,NULL,'message'),
('NA','PDF',NULL,NULL,NULL,NULL,NULL,'message'),
('NB','EPUB',NULL,NULL,NULL,NULL,NULL,'message'),
('NL','WMA',NULL,NULL,NULL,NULL,NULL,'message'),
('NS','WMV',NULL,NULL,NULL,NULL,NULL,'message'),
('O','DRM',NULL,NULL,NULL,NULL,NULL,'message'),
('SM','Utkånstidskrift',NULL,NULL,NULL,NULL,NULL,'message'),
('VO','Vertikalordner',NULL,NULL,NULL,NULL,NULL,'message');
/*!40000 ALTER TABLE `itemtypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `letter`
--

TRUNCATE TABLE `letter`;
LOCK TABLES `letter` WRITE;
/*!40000 ALTER TABLE `letter` DISABLE KEYS */;
INSERT INTO `letter` (module,code,branchcode,name,is_html,title,content)
VALUES 
('circulation','CHECKIN','','Innlevering',0,'Melding om innlevering','Følgende dokument har blitt innlevert:\r\n----\r\n<<biblio.title>>\r\n----\r\nVennlig hilsen\r\nBiblioteket'),
('circulation','CHECKOUT','','Utlån',0,'Melding om utlån','Følgende dokument har blitt lånt ut:\r\n----\r\n<<biblio.title>>\r\n----\r\nVennlig hilsen\r\nBiblioteket'),
('circulation','DUE','','Innleveringspåminnelse',0,'Innleveringspåminnelse','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nDette dokumentet må nå leveres:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)'),
('circulation','DUEDGST','','Innleveringspåminnelse (sammendrag)',0,'Innleveringspåminnelse','Du har <<count>> dokumenter som skulle vært levert.'),
('circulation','ISSUEQSLIP','','Utlån (enkel)',1,'Utlån (enkel)','<h3><<branches.branchname>></h3>\nUtlånt til <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />\n(<<borrowers.cardnumber>>) <br />\n\n<<today>><br />\n\n<h4>Utlånt i dag</h4>\n<checkedout>\n<p>\n<<biblio.title>> <br />\nStrekkode: <<items.barcode>><br />\nInnleveringsfrist: <<issues.date_due>><br />\n</p>\n</checkedout>'),
('circulation','ISSUESLIP','','Utlån',1,'Utlån','<h3><<branches.branchname>></h3>\nUtlånt til <<borrowers.title>> <<borrowers.firstname>> <<borrowers.initials>> <<borrowers.surname>> <br />\n(<<borrowers.cardnumber>>) <br />\n\n<<today>><br />\n\n<h4>Utlånt</h4>\n<checkedout>\n<p>\n<<biblio.title>> <br />\nStrekkode: <<items.barcode>><br />\nInnleveringsfrist: <<issues.date_due>><br />\n</p>\n</checkedout>\n\n<h4>Forfalte lån</h4>\n<overdue>\n<p>\n<<biblio.title>> <br />\nStrekkode: <<items.barcode>><br />\nInnleveringsfrist: <<issues.date_due>><br />\n</p>\n</overdue>\n\n<hr>\n\n<h4 style=\"text-align: center; font-style:italic;\">Nyheter</h4>\n<news>\n<div class=\"newsitem\">\n<h5 style=\"margin-bottom: 1px; margin-top: 1px\"><b><<opac_news.title>></b></h5>\n<p style=\"margin-bottom: 1px; margin-top: 1px\"><<opac_news.new>></p>\n<p class=\"newsfooter\" style=\"font-size: 8pt; font-style:italic; margin-bottom: 1px; margin-top: 1px\">Publisert <<opac_news.timestamp>></p>\n<hr />\n</div>\n</news>'),
('circulation','ODUE','','Purring',0,'Purring på dokument','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har lån som skulle vært levert. Biblioteket krever ikke inn gebyrer, men vennligst lever eller forny lånet/lånene ved biblioteket.\n\n<<branches.branchname>>\n<<branches.branchaddress1>>\n<<branches.branchaddress2>> <<branches.branchaddress3>>\nTelefon: <<branches.branchphone>>\nFax: <<branches.branchfax>>\nE-post: <<branches.branchemail>>\n\nDersom du har et passord og lånet/lånene kan fornyes kan du gjøre dette på nettet. Dersom du overskrider lånetiden med mer enn 30 dager vil lånekortet bli sperret.\n\nFølgende lån har gått over tiden:\n\n<item>\"<<biblio.title>>\" av <<biblio.author>>, <<items.itemcallnumber>>, Strekkode: <<items.barcode>> Gebyr: <<items.fine>></item>\n\nPå forhånd takk.\n\n<<branches.branchname>>\n'),
('circulation','PREDUE','','Forhåndspåminnelse',0,'Forhåndspåminnelse','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nDette dokumentet må snart leveres:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)'),
('circulation','PREDUEDGST','','Forhåndspåminnelse (sammendrag)',0,'Forhåndspåminnelse','Du har lånt <<count>> dokumenter som snart må leveres.'),
('circulation','RENEWAL','','Fornying',0,'Fornyinger','Følgende lån har blitt fornyet:\r\n----\r\n<<biblio.title>>\r\n----\r\n'),
('circulation','RESERVESLIP','','Reservasjon',1,'Reservasjon','<h5>Dato: <<today>></h5>\n\n<h3> Overfør til/Reservasjon hos <<branches.branchname>></h3>\n\n<h3><<borrowers.surname>>, <<borrowers.firstname>></h3>\n\n<ul>\n    <li><<borrowers.cardnumber>></li>\n    <li><<borrowers.phone>></li>\n    <li> <<borrowers.address>><br />\n         <<borrowers.address2>><br />\n         <<borrowers.city >>  <<borrowers.zipcode>>\n    </li>\n    <li><<borrowers.email>></li>\n</ul>\n<br />\n<h3>RESERVERT</h3>\n<h4><<biblio.title>></h4>\n<h5><<biblio.author>></h5>\n<ul>\n   <li><<items.barcode>></li>\n   <li><<items.itemcallnumber>></li>\n   <li><<reserves.waitingdate>></li>\n</ul>\n<p>Kommentarer:\n<pre><<reserves.reservenotes>></pre>\n</p>\n'),
('circulation','TRANSFERSLIP','','Overføringslapp',1,'Overføringslapp','<h5>Dato: <<today>></h5>\n\n<h3>Overføres til <<branches.branchname>></h3>\n\n<h3>EKSEMPLAR</h3>\n<h4><<biblio.title>></h4>\n<h5><<biblio.author>></h5>\n<ul>\n   <li><<items.barcode>></li>\n   <li><<items.itemcallnumber>></li>\n</ul>'),
('claimacquisition','ACQCLAIM','','Periodikapurring',0,'Eksemplar ikke mottatt','<<aqbooksellers.name>>\r\n<<aqbooksellers.address1>>\r\n<<aqbooksellers.address2>>\r\n<<aqbooksellers.address3>>\r\n<<aqbooksellers.address4>>\r\n<<aqbooksellers.phone>>\r\n\r\n<order>Bestillingsnummer <<aqorders.ordernumber>> (<<aqorders.title>>) (<<aqorders.quantity>> ordered) ($<<aqorders.listprice>> each) har ikke blitt mottatt.</order>'),
('members','ACCTDETAILS','','Mal for kontodetaljer - STANDARD',0,'Dine nye kontodetaljer i Koha.','Hei <<borrowers.title>> <<borrowers.firstname>> <<borrowers.surname>>.\r\n\r\nDine nye detaljer er:\r\n\r\nBruker:  <<borrowers.userid>>\r\nPassord: <<borrowers.password>>\r\n\r\nDersom det oppstår problemer, vennligst kontakt biblioteket.\r\n\r\nVennlig hilsen,\r\nBiblioteket\r\nkohaadmin@yoursite.org'),
('members','OPAC_REG_VERIFY','','Verifikasjon av egenregistrering i publikumskatalogen',1,'Verifiser registreringen din','Hei!\n\nD har blitt registrert som bruker av biblioteket. Verifiser epostadressen din ved å klikke på lenka nedenfor:\n\nhttp://<<OPACBaseURL>>/cgi-bin/koha/opac-registration-verify.pl?token=<<borrower_modifications.verification_token>>\n\nDersom du ikke har bedt om å bli registret som bruker av biblioteket kan du se bort fra denne engangsmeldingen. Forespørselen vil snart gå ut på dato.'),
('reserves','HOLD','','Hentemelding',0,'Hentemelding fra <<branches.branchname>>','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nEt reservert dokument er klart til henting fra <<reserves.waitingdate>>:\r\n\r\nTittel: <<biblio.title>>\r\nForfatter: <<biblio.author>>\r\nEksemplar: <<items.copynumber>>\r\nHentested: <<branches.branchname>>\r\n<<branches.branchaddress1>>\r\n<<branches.branchaddress2>>\r\n<<branches.branchaddress3>>\r\n<<branches.branchcity>> <<branches.branchzip>>'),
('reserves','HOLDPLACED','','Melding om reservasjon',0,'Melding om reservasjon','Følgende dokument har blitt reservert : <<biblio.title>> (<<biblio.biblionumber>>) av <<borrowers.firstname>> <<borrowers.surname>> (<<borrowers.cardnumber>>).'),
('reserves','HOLD_PRINT','','Hentemelding (på papir)',0,'Hentemelding','<<branches.branchname>>\r\n<<branches.branchaddress1>>\r\n<<branches.branchaddress2>>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n<<borrowers.firstname>> <<borrowers.surname>>\r\n<<borrowers.address>>\r\n<<borrowers.city>> <<borrowers.zipcode>>\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n<<borrowers.firstname>> <<borrowers.surname>> <<borrowers.cardnumber>>\r\n\r\nDu har et reservert dokument som kan hentes fra  <<reserves.waitingdate>>:\r\n\r\nTittel: <<biblio.title>>\r\nForfatter: <<biblio.author>>\r\nEksemplar: <<items.copynumber>>\r\n'),
('serial','RLIST','','Sirkulasjon',0,'Et dokument er nå tilgjengelig','<<borrowers.firstname>> <<borrowers.surname>>,\r\n\r\nDette dokumentet er tilgjengelig:\r\n\r\n<<biblio.title>>, <<biblio.author>> (<<items.barcode>>)\r\n\r\nVennligst kom og hent det når det passer.'),
('suggestions','ACCEPTED','','Forslag godtatt',0,'Innkjøpsforslag godtatt','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nBiblioteket har vurdert forslaget i dag. Dokumentet vil bli bestilt så fort det lar seg gjøre. Du vil få en ny melding når bestillingen er gjort, og når dokumentet ankommer biblioteket.\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>'),
('suggestions','AVAILABLE','','Foreslått dokument tilgjengelig',0,'Foreslått dokument tilgjengelig','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nVi har gleden av å informere deg om at dokumentet nå er innlemmet i samlingen.\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>'),
('suggestions','ORDERED','','Innkjøpsforslag i bestilling',0,'Innkjøpsforslag i bestilling','Dear <<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nVi har gleden av å informere deg om at dokumentet du foreslo nå er i bestilling.\n\nDu vil få en ny melding når dokumentet er tilgjengelig.\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>'),
('suggestions','REJECTED','','Innkjøpsforslag avslått',0,'Innkjøpsforslag avslått','<<borrowers.firstname>> <<borrowers.surname>>,\n\nDu har foreslått at biblioteket kjøper inn <<suggestions.title>> av <<suggestions.author>>.\n\nBiblioteket har vurdert innkjøpsforslaget ditt i dag, og bestemt seg for å ikke ta det til følge.\n\nBegrunnelse: <<suggestions.reason>>\n\nEr det noe du lurer på, vennligst kontakt oss på <<branches.branchemail>>.\n\nVennlig hilsen,\n\n<<branches.branchname>>');
/*!40000 ALTER TABLE `letter` ENABLE KEYS */;
UNLOCK TABLES;

