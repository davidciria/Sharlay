DROP DATABASE IF EXISTS `ts1`;
CREATE DATABASE  IF NOT EXISTS `ts1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ts1`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: ts1
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `follows`
--

DROP TABLE IF EXISTS `follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `follows` (
  `uid1` int NOT NULL,
  `uid2` int NOT NULL,
  PRIMARY KEY (`uid1`,`uid2`),
  KEY `uid1_follow_fk` (`uid1`),
  KEY `uid2_follow_fk` (`uid2`),
  CONSTRAINT `uid1_follow_fk` FOREIGN KEY (`uid1`) REFERENCES `users` (`uid`),
  CONSTRAINT `uid2_follow_fk` FOREIGN KEY (`uid2`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `follows`
--

LOCK TABLES `follows` WRITE;
/*!40000 ALTER TABLE `follows` DISABLE KEYS */;
/*!40000 ALTER TABLE `follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `uid` int NOT NULL,
  `tweetid` int NOT NULL,
  PRIMARY KEY (`uid`,`tweetid`),
  KEY `uid_like_fk` (`uid`),
  KEY `tweetid_like_fk` (`tweetid`),
  CONSTRAINT `tweetid_like_fk` FOREIGN KEY (`tweetid`) REFERENCES `tweets` (`tweetid`),
  CONSTRAINT `uid_like_fk` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `retweets`
--

DROP TABLE IF EXISTS `retweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `retweets` (
  `uid` int NOT NULL,
  `tweetid` int NOT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`uid`,`tweetid`),
  KEY `uid_retweet_fk` (`uid`),
  KEY `tweetid_retweet_fk` (`tweetid`),
  CONSTRAINT `tweetid_retweet_fk` FOREIGN KEY (`tweetid`) REFERENCES `tweets` (`tweetid`),
  CONSTRAINT `uid_retweet_fk` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `retweets`
--

LOCK TABLES `retweets` WRITE;
/*!40000 ALTER TABLE `retweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `retweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tweets`
--

DROP TABLE IF EXISTS `tweets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tweets` (
  `tweetid` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `text` varchar(140) DEFAULT NULL,
  `likes` int DEFAULT NULL,
  `retweets` int DEFAULT NULL,
  `comments` int DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `parentTweet` int DEFAULT NULL,
  PRIMARY KEY (`tweetid`),
  KEY `tweets_users_fk` (`uid`),
  KEY `tweets_tweets_fk` (`parentTweet`),
  CONSTRAINT `tweets_tweets_fk` FOREIGN KEY (`parentTweet`) REFERENCES `tweets` (`tweetid`),
  CONSTRAINT `tweets_users_fk` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=282 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweets`
--

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `hashedPassword` varchar(50) DEFAULT NULL,
  `salt` varchar(50) DEFAULT NULL,
  `regVerified` tinyint(1) DEFAULT NULL,
  `birth` varchar(50) DEFAULT NULL,
  `tweets` int DEFAULT NULL,
  `followers` int DEFAULT NULL,
  `following` int DEFAULT NULL,
  `isVerified` tinyint(1) DEFAULT NULL,
  `isAdmin` tinyint(1) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'milson85','Milton','Hanson','mhanson@gmail.com','u1cknfKRz9IcFYUjOT8Sj5DvSTHVQHX+cx+ulElmlPo=','crCfki3rOFvt5otP',1,'1985-04-05',0,0,0,0,0,'VGtl8prytrefH_xbeeemL7m10UoOJR-O'),(2,'kellybee12','Alyssa','Kelley','akelley@gmail.com','RFy50yLsZjBREL1kb6pIRyLaaN/BqSRHwRMaZ4UdvYo=','kq7+rDfYp1fxD6ec',1,'1992-05-12',0,0,0,0,0,'a06xTYrxHk-20yn8GoWCKrY6w9BBKool'),(3,'silvermissy','Abigail','George','ageorge@gmail.com','d6lqlV8zfir6R7+kIVnUVZm6pwoM+AWbNhoUPnYSfIQ=','7L3jx98WGPYqTMKz',1,'1998-12-05',0,0,0,0,0,'3ttlVLr_zjV_J7ki0Vv8iQiuku5kUB_O'),(4,'animebot','Shawn','Fleming','sfleming@gmail.com','3c+0HCkB372nVTT6K9ne+0KXqeziXl2fXogIBeOrzDg=','8z5wkH5mnoUmNT4l',1,'2000-12-08',0,0,0,0,0,'FZXjuSmpICH451froscvmXPlJIvarLjN'),(5,'hopez26','Hugo','Lopez','hlopez@gmail.com','IQ/H5uDPCUOhlu3Rhl5xzyrcoYZAKGl2Z1TnOuwsmMQ=','d2MOb62JBgOktwpL',1,'1999-01-26',0,0,0,0,0,'mLxRXZ9IJoXmTIJvfyuWPi5DEuCjfeDF'),(6,'felipo37','Felipe','Sancho','fsancho@gmail.com','TvyxFlJq2ndAtyfkXCKXy1DRmQpmcWzGeMHcWJIq+2M=','LrCAGSy3lLPPMxvi',1,'1997-09-08',0,0,0,0,0,'Czx3nYc_a_hEjh5vgU5YFDoYnTJSqDc4'),(7,'carlii00','Carla','Martinez','cmartinez@gmail.com','QiplkgK7dOOySifWrh/FCk8DvHr/KF6sRwDQvODXQGo=','okQnQc7mg8L9ufQE',1,'2000-07-17',0,0,0,0,0,'EiJLRU-DO4S_9aK2Ueyc2I86l6QIaV_B'),(8,'fcbiker02','Iker','Santos','isantos@gmail.com','BY81FZhYHJ8v/31twC/gt9G36vfaEhIWkzXD/+W6DAk=','DqruJ8PaCUMm+AgV',1,'2002-02-01',0,0,0,0,0,'7-0-Q2ltdKYCu7FLJv9Qp7STzaBO3Szj'),(9,'sushipan','Sara','Paredes','sparedes@gmail.com','x9NVXysQDU3W1+O6B6YjvGEOcANJ/gTxIl3kKuMqhTQ=','pq3PDjX+2L9X+XGh',1,'2001-10-08',0,0,0,0,0,'KEwANEqq5H9BuSpzwwmWu2y3edGcJ4xJ'),(10,'phills90','Peter','Hills','phills@gmail.com','g8Cx7ySDtu13zdtKRjButnn/FGM8vFAFK8DeNXMKUow=','yzbFSpOXr6C/z/uA',1,'1990-04-24',0,0,0,0,0,'m6Prc-TuYu_zCAw9EHptmoGChGZvxGqd');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-26 18:45:57
