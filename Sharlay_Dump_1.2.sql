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
INSERT INTO `follows` VALUES (1,2),(1,4),(1,10),(2,3),(2,10),(3,4),(4,3),(4,9),(7,4),(7,9),(8,4),(8,5),(8,6),(8,7),(8,9),(9,4),(10,2),(10,7);
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
INSERT INTO `likes` VALUES (1,283),(1,296),(1,303),(2,282),(2,287),(2,295),(2,303),(3,285),(3,294),(3,303),(4,287),(4,296),(4,303),(8,290),(8,291),(8,300),(8,303),(9,288),(9,289),(9,292),(9,301),(9,302),(9,303),(10,293),(10,296),(10,303);
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
INSERT INTO `retweets` VALUES (1,283,'2020-06-26 21:03:08'),(2,295,'2020-06-26 21:04:52'),(3,288,'2020-06-26 20:59:37'),(3,294,'2020-06-26 20:59:52'),(8,300,'2020-06-26 21:08:37'),(9,292,'2020-06-26 21:01:15'),(9,302,'2020-06-26 21:00:37'),(10,283,'2020-06-26 21:06:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweets`
--

LOCK TABLES `tweets` WRITE;
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
INSERT INTO `tweets` VALUES (282,1,'I finally get off work, hallelujah... Now it\'s time to play!',1,0,0,'2020-06-25 21:04:29',NULL),(283,2,'I miss NBA games, I can\'t wait to see my Warriors again!',1,2,0,'2020-06-24 06:27:18',NULL),(285,2,'Bored right now. I\'ve played all my games. Hit like if you are too',1,0,0,'2020-06-26 20:08:44',NULL),(287,3,'My eyes hurts from so much playing. It\'s time to sleep for a while :)',2,0,0,'2020-06-26 20:11:16',NULL),(288,4,'I am looking forward to the new season of Noragami!!! ^^',1,1,0,'2020-06-23 18:12:08',NULL),(289,5,'Bastante preocupado por el covid, iré suficientemente protegido?? Suerte que casi no salgo de casa jaja',1,0,0,'2020-06-26 20:13:44',NULL),(290,5,'Estoy harto de ver a gente sin mascarilla, no es tan complicado tener un poco de empatía!',1,0,0,'2020-06-23 10:10:24',NULL),(291,6,'Por fin voy a poder volver a sacar fotos, sígueme si quieres una sesión! Mientras voy jugando al Rocket League',1,0,0,'2020-06-26 20:15:26',NULL),(292,7,'Llevo media carrera y no sé ni lo que estoy haciendo... Pensaba que informàtica trataria mas de videojuegos :(',1,1,0,'2020-06-25 19:15:49',NULL),(293,7,'No me apetece ni salir de casa. Quién un lol?',1,0,0,'2020-06-26 20:17:25',NULL),(294,10,'Here no one puts on the mask, we will have problems again at any time :/ This is not a game, we only have one life',1,1,0,'2020-06-26 20:18:52',NULL),(295,10,'If there\'s someone I can\'t listen to for more than two minutes, it\'s Trump.',1,1,0,'2020-06-24 14:19:28',NULL),(296,3,'I really can\'t sleep, I don\'t know what\'s wrong with me (??)',3,0,0,'2020-06-26 20:20:33',NULL),(297,8,'No se que es mas triste, si haber acabado el curso sin ver a mis compañeros o ver al Barcelona...',0,0,0,'2020-06-24 21:58:21',NULL),(298,8,'No me puedo creer que tenga que estudiar para la sele, solo me apetece jugar al fifa',0,0,0,'2020-06-26 20:24:33',NULL),(299,9,'No me puedo creer que no hayan sacado nunca un juego de Sakura, yo habría comprado 20!!',0,0,0,'2020-06-24 09:45:26',NULL),(300,9,'Nunca fui mucho de Nintendogs, ahora, si hubiese sido Nintencats...',1,1,0,'2020-06-26 20:27:07',NULL),(301,4,'OMG, the Android Noragami game is fucking awesome!!',1,0,0,'2020-06-26 20:34:03',NULL),(302,4,'A Spanish just followed me! Hola amiga :)',1,1,0,'2020-06-26 20:35:00',NULL),(303,4,'I have just joined to Sharlay, hey gamers!! :D',7,0,0,'2020-06-23 08:45:12',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'milson85','Milton','Hanson','mhanson@gmail.com','u1cknfKRz9IcFYUjOT8Sj5DvSTHVQHX+cx+ulElmlPo=','crCfki3rOFvt5otP',1,'1985-04-05',2,0,3,0,0,'VGtl8prytrefH_xbeeemL7m10UoOJR-O'),(2,'kellybee12','Alyssa','Kelley','akelley@gmail.com','RFy50yLsZjBREL1kb6pIRyLaaN/BqSRHwRMaZ4UdvYo=','kq7+rDfYp1fxD6ec',1,'1992-05-12',3,2,2,0,0,'a06xTYrxHk-20yn8GoWCKrY6w9BBKool'),(3,'silvermissy','Abigail','George','ageorge@gmail.com','d6lqlV8zfir6R7+kIVnUVZm6pwoM+AWbNhoUPnYSfIQ=','7L3jx98WGPYqTMKz',1,'1998-12-05',4,2,1,0,0,'3ttlVLr_zjV_J7ki0Vv8iQiuku5kUB_O'),(4,'animebot','Shawn','Fleming','sfleming@gmail.com','3c+0HCkB372nVTT6K9ne+0KXqeziXl2fXogIBeOrzDg=','8z5wkH5mnoUmNT4l',1,'2000-12-08',4,5,2,0,0,'FZXjuSmpICH451froscvmXPlJIvarLjN'),(5,'hopez26','Hugo','Lopez','hlopez@gmail.com','IQ/H5uDPCUOhlu3Rhl5xzyrcoYZAKGl2Z1TnOuwsmMQ=','d2MOb62JBgOktwpL',1,'1999-01-26',2,1,0,0,0,'mLxRXZ9IJoXmTIJvfyuWPi5DEuCjfeDF'),(6,'felipo37','Felipe','Sancho','fsancho@gmail.com','TvyxFlJq2ndAtyfkXCKXy1DRmQpmcWzGeMHcWJIq+2M=','LrCAGSy3lLPPMxvi',1,'1997-09-08',1,1,0,0,0,'Czx3nYc_a_hEjh5vgU5YFDoYnTJSqDc4'),(7,'carlii00','Carla','Martinez','cmartinez@gmail.com','QiplkgK7dOOySifWrh/FCk8DvHr/KF6sRwDQvODXQGo=','okQnQc7mg8L9ufQE',1,'2000-07-17',2,2,2,0,0,'EiJLRU-DO4S_9aK2Ueyc2I86l6QIaV_B'),(8,'fcbiker02','Iker','Santos','isantos@gmail.com','BY81FZhYHJ8v/31twC/gt9G36vfaEhIWkzXD/+W6DAk=','DqruJ8PaCUMm+AgV',1,'2002-02-01',3,0,5,0,0,'7-0-Q2ltdKYCu7FLJv9Qp7STzaBO3Szj'),(9,'sushipan','Sara','Paredes','sparedes@gmail.com','x9NVXysQDU3W1+O6B6YjvGEOcANJ/gTxIl3kKuMqhTQ=','pq3PDjX+2L9X+XGh',1,'2001-10-08',4,3,1,0,0,'KEwANEqq5H9BuSpzwwmWu2y3edGcJ4xJ'),(10,'phills90','Peter','Hills','phills@gmail.com','g8Cx7ySDtu13zdtKRjButnn/FGM8vFAFK8DeNXMKUow=','yzbFSpOXr6C/z/uA',1,'1990-04-24',3,2,2,0,0,'m6Prc-TuYu_zCAw9EHptmoGChGZvxGqd'),(11,'sharlay_admin','Sharlay','Admin','sadmin@gmail.com','Usm0xowBEkWG4RPPjq5M7BX/kljY0rIr2CTR6v5v3vo=','5RJa4l5esGbp1o3J',1,'1999-01-01',0,0,0,0,1,'kpAmw412j4ojz-zYWI2OVAUx37bo_5eQ'),(12,'aherrero','Angel','Herrero','aherrero@gmail.com','+Vvdhype8xss7a+HOFN9/jTvWHvBMwL3gQlCKaWvRLk=','p/KWYA+QCCzgzoQi',1,'1999-01-25',0,0,0,0,1,'VuMuK8WmKqgXW-yfQN08y51THEvrJwor');
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

-- Dump completed on 2020-06-26 22:57:39
SET SQL_SAFE_UPDATES = 0;