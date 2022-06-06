-- MariaDB dump 10.19  Distrib 10.5.15-MariaDB, for Linux (x86_64)
--
-- Host: 172.18.0.2    Database: project92
-- ------------------------------------------------------
-- Server version	10.7.3-MariaDB-1:10.7.3+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `project92`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `project92` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `project92`;

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Company` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Budget` decimal(65,2) DEFAULT NULL CHECK (`Budget` >= 0),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ergo`
--

DROP TABLE IF EXISTS `Ergo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ergo` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) DEFAULT NULL,
  `Brief` varchar(255) DEFAULT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date NOT NULL,
  `Duration` int(11) GENERATED ALWAYS AS (year(`EndDate`) - year(`StartDate`)) VIRTUAL CHECK (`Duration` <= 4 and `Duration` >= 1),
  `Budget` decimal(65,2) DEFAULT NULL CHECK (`Budget` >= 0),
  `Programma` int(11) NOT NULL,
  `MasterStelexos` int(11) NOT NULL,
  `MasterOrganization` int(11) NOT NULL,
  `Responsible` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `Programma` (`Programma`),
  KEY `MasterStelexos` (`MasterStelexos`),
  KEY `MasterOrganization` (`MasterOrganization`),
  KEY `Responsible` (`Responsible`),
  KEY `end_date` (`EndDate`),
  CONSTRAINT `Ergo_ibfk_1` FOREIGN KEY (`Programma`) REFERENCES `Programma` (`ID`),
  CONSTRAINT `Ergo_ibfk_2` FOREIGN KEY (`MasterStelexos`) REFERENCES `Stelexos` (`ID`),
  CONSTRAINT `Ergo_ibfk_3` FOREIGN KEY (`MasterOrganization`) REFERENCES `Organization` (`ID`),
  CONSTRAINT `Ergo_ibfk_4` FOREIGN KEY (`Responsible`) REFERENCES `Researcher` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Organization`
--

DROP TABLE IF EXISTS `Organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Organization` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Abbreviation` varchar(255) DEFAULT NULL,
  `Street` varchar(255) DEFAULT NULL,
  `StreetNo` varchar(255) DEFAULT NULL,
  `City` varchar(255) DEFAULT NULL,
  `PostalCode` varchar(255) DEFAULT NULL,
  `UnivID` int(11) DEFAULT NULL,
  `CompID` int(11) DEFAULT NULL,
  `ResID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UnivID` (`UnivID`),
  KEY `CompID` (`CompID`),
  KEY `ResID` (`ResID`),
  CONSTRAINT `Organization_ibfk_1` FOREIGN KEY (`UnivID`) REFERENCES `University` (`ID`),
  CONSTRAINT `Organization_ibfk_2` FOREIGN KEY (`CompID`) REFERENCES `Company` (`ID`),
  CONSTRAINT `Organization_ibfk_3` FOREIGN KEY (`ResID`) REFERENCES `Research_Center` (`ID`),
  CONSTRAINT `chk` CHECK (`UnivID` is null and `CompID` is null and `ResID` is not null or `UnivID` is null and `CompID` is not null and `ResID` is null or `UnivID` is not null and `CompID` is null and `ResID` is null)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Paradoteo`
--

DROP TABLE IF EXISTS `Paradoteo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Paradoteo` (
  `Title` varchar(255) NOT NULL,
  `Ergo` int(11) NOT NULL,
  `Summary` varchar(255) DEFAULT NULL,
  `Deadline` date DEFAULT NULL,
  PRIMARY KEY (`Title`,`Ergo`),
  KEY `Ergo` (`Ergo`),
  CONSTRAINT `Paradoteo_ibfk_1` FOREIGN KEY (`Ergo`) REFERENCES `Ergo` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Pedio`
--

DROP TABLE IF EXISTS `Pedio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pedio` (
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PedioRelation`
--

DROP TABLE IF EXISTS `PedioRelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PedioRelation` (
  `Pedio` varchar(255) NOT NULL,
  `Ergo` int(11) NOT NULL,
  PRIMARY KEY (`Pedio`,`Ergo`),
  KEY `Ergo` (`Ergo`),
  CONSTRAINT `PedioRelation_ibfk_1` FOREIGN KEY (`Pedio`) REFERENCES `Pedio` (`Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `PedioRelation_ibfk_2` FOREIGN KEY (`Ergo`) REFERENCES `Ergo` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Programma`
--

DROP TABLE IF EXISTS `Programma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Programma` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Research_Center`
--

DROP TABLE IF EXISTS `Research_Center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Research_Center` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Ministry_Budget` decimal(65,2) DEFAULT NULL CHECK (`Ministry_Budget` >= 0),
  `Private_Budget` decimal(65,2) DEFAULT NULL CHECK (`Private_Budget` >= 0),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Researcher`
--

DROP TABLE IF EXISTS `Researcher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Researcher` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Gender` enum('Male','Female') DEFAULT NULL,
  `DoBirth` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Review` (
  `Researcher` int(11) NOT NULL,
  `Ergo` int(11) NOT NULL,
  `Grade` int(11) NOT NULL,
  `Date` date NOT NULL,
  PRIMARY KEY (`Ergo`),
  KEY `Researcher` (`Researcher`),
  CONSTRAINT `Review_ibfk_1` FOREIGN KEY (`Researcher`) REFERENCES `Researcher` (`ID`) ON DELETE NO ACTION,
  CONSTRAINT `Review_ibfk_2` FOREIGN KEY (`Ergo`) REFERENCES `Ergo` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER
	test
BEFORE INSERT ON Review FOR EACH ROW
BEGIN
  IF( (SELECT e.MasterOrganization AS `Organization` FROM Ergo e WHERE e.ID=NEW.Ergo) =  (SELECT w.Organization FROM WorksForOrganization w WHERE w.Researcher=NEW.Researcher) ) THEN
  	signal sqlstate '45000' set message_text = 'Ο αξιολογητής εργάζεται στον οργανισμό που διαχειρίζεται το έργο';
    #ROLLBACK;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Stelexos`
--

DROP TABLE IF EXISTS `Stelexos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stelexos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `Gender` enum('Male','Female') DEFAULT NULL,
  `DoBirth` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Telephone`
--

DROP TABLE IF EXISTS `Telephone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Telephone` (
  `Number` varchar(15) NOT NULL,
  `Organization` int(11) NOT NULL,
  PRIMARY KEY (`Organization`,`Number`),
  CONSTRAINT `Telephone_ibfk_1` FOREIGN KEY (`Organization`) REFERENCES `Organization` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `University`
--

DROP TABLE IF EXISTS `University`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `University` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Budget` decimal(65,2) DEFAULT NULL CHECK (`Budget` >= 0),
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WorksForErgo`
--

DROP TABLE IF EXISTS `WorksForErgo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorksForErgo` (
  `Ergo` int(11) NOT NULL,
  `Researcher` int(11) NOT NULL,
  PRIMARY KEY (`Ergo`,`Researcher`),
  KEY `Researcher` (`Researcher`),
  CONSTRAINT `WorksForErgo_ibfk_1` FOREIGN KEY (`Ergo`) REFERENCES `Ergo` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `WorksForErgo_ibfk_2` FOREIGN KEY (`Researcher`) REFERENCES `Researcher` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `WorksForOrganization`
--

DROP TABLE IF EXISTS `WorksForOrganization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `WorksForOrganization` (
  `Organization` int(11) NOT NULL,
  `Researcher` int(11) NOT NULL,
  `SINCE` date NOT NULL,
  PRIMARY KEY (`Researcher`),
  KEY `Organization` (`Organization`),
  CONSTRAINT `WorksForOrganization_ibfk_1` FOREIGN KEY (`Organization`) REFERENCES `Organization` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `WorksForOrganization_ibfk_2` FOREIGN KEY (`Researcher`) REFERENCES `Researcher` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `view1`
--

DROP TABLE IF EXISTS `view1`;
/*!50001 DROP VIEW IF EXISTS `view1`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view1` (
  `researcher_ID` tinyint NOT NULL,
  `first_name` tinyint NOT NULL,
  `last_name` tinyint NOT NULL,
  `ergo_id` tinyint NOT NULL,
  `title` tinyint NOT NULL,
  `brief` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view2`
--

DROP TABLE IF EXISTS `view2`;
/*!50001 DROP VIEW IF EXISTS `view2`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `view2` (
  `org_id` tinyint NOT NULL,
  `org_name` tinyint NOT NULL,
  `year` tinyint NOT NULL,
  `count` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `project92`
--

USE `project92`;

--
-- Final view structure for view `view1`
--

/*!50001 DROP TABLE IF EXISTS `view1`*/;
/*!50001 DROP VIEW IF EXISTS `view1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `view1` AS select `p`.`ID` AS `researcher_ID`,`p`.`FirstName` AS `first_name`,`p`.`LastName` AS `last_name`,`pm`.`ID` AS `ergo_id`,`pm`.`Title` AS `title`,`pm`.`Brief` AS `brief` from ((`WorksForErgo` `w` join `Researcher` `p` on(`w`.`Researcher` = `p`.`ID`)) join `Ergo` `pm` on(`w`.`Ergo` = `pm`.`ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view2`
--

/*!50001 DROP TABLE IF EXISTS `view2`*/;
/*!50001 DROP VIEW IF EXISTS `view2`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `view2` AS select `o`.`ID` AS `org_id`,`o`.`Name` AS `org_name`,year(`e`.`StartDate`) AS `year`,count(concat(`o`.`ID`,',',`e`.`StartDate`)) AS `count` from (`Ergo` `e` join `Organization` `o` on(`e`.`MasterOrganization` = `o`.`ID`)) group by `o`.`ID`,year(`e`.`StartDate`) */;
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

-- Dump completed on 2022-06-05 21:10:12
