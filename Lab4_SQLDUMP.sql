DROP DATABASE IF EXISTS `ts1`;
CREATE DATABASE  IF NOT EXISTS `ts1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `ts1`;

CREATE USER IF NOT EXISTS 'mysql'@'localhost' IDENTIFIED BY 'prac';
GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'localhost';

-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: ts1
-- ------------------------------------------------------
-- Server version	9.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET GLOBAL TIME_ZONE='-3:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL UNIQUE,
  `hashedPassword` varchar(50) DEFAULT NULL,
  `salt` varchar(50) DEFAULT NULL,
  `regVerified` bool DEFAULT NULL,
  `birth` varchar(50) DEFAULT NULL,
  `tweets` int(11) DEFAULT NULL,
  `followers` int(11) DEFAULT NULL,
  `following` int(11) DEFAULT NULL,
  `isVerified` bool DEFAULT NULL,
  `isAdmin` bool DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `Tweet`
--

DROP TABLE IF EXISTS `Tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tweets` (
  `tweetid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `text` varchar(140) DEFAULT NULL,
  `likes` int(11) DEFAULT NULL,
  `retweets` int(11) DEFAULT NULL,
  `comments` int(11) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `parentTweet` int(11) DEFAULT NULL,
  PRIMARY KEY (`tweetid`),
  KEY `tweets_users_fk` (`uid`),
  KEY `tweets_tweets_fk` (`parentTweet`),
  CONSTRAINT `tweets_tweets_fk` FOREIGN KEY (`parentTweet`) REFERENCES `Tweets` (`tweetid`),
  CONSTRAINT `tweets_users_fk` FOREIGN KEY (`uid`) REFERENCES `Users` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT= 282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `Follow`
--

DROP TABLE IF EXISTS `Follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Follows` (
  `uid1` int(11) NOT NULL,
  `uid2` int(11) NOT NULL,
  PRIMARY KEY (`uid1`,`uid2`),
  KEY `uid1_follow_fk` (`uid1`),
  KEY `uid2_follow_fk` (`uid2`),
  CONSTRAINT `uid2_follow_fk` FOREIGN KEY (`uid2`) REFERENCES `Users` (`uid`),
  CONSTRAINT `uid1_follow_fk` FOREIGN KEY (`uid1`) REFERENCES `Users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `Retweet`
--

DROP TABLE IF EXISTS `Retweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Retweets` (
  `uid` int(11) NOT NULL,
  `tweetid` int(11) NOT NULL,  
  PRIMARY KEY (`uid`,`tweetid`),
  KEY `uid_retweet_fk` (`uid`),
  KEY `tweetid_retweet_fk` (`tweetid`),
  CONSTRAINT `tweetid_retweet_fk` FOREIGN KEY (`tweetid`) REFERENCES `Tweets` (`tweetid`),
  CONSTRAINT `uid_retweet_fk` FOREIGN KEY (`uid`) REFERENCES `Users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `Likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Likes` (
  `uid` int(11) NOT NULL,
  `tweetid` int(11) NOT NULL,  
  PRIMARY KEY (`uid`,`tweetid`),
  KEY `uid_like_fk` (`uid`),
  KEY `tweetid_like_fk` (`tweetid`),
  CONSTRAINT `tweetid_like_fk` FOREIGN KEY (`tweetid`) REFERENCES `Tweets` (`tweetid`),
  CONSTRAINT `uid_like_fk` FOREIGN KEY (`uid`) REFERENCES `Users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` (`username`,`firstname`,`lastname`,`mail`) VALUES ('MESPUGA11','Mireia','Espuga', 'mireia.espuga01@estudiant.upf.edu');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-28  9:32:06
