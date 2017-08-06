CREATE DATABASE  IF NOT EXISTS `basic` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `basic`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: basic
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `app_error`
--

DROP TABLE IF EXISTS `app_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_error` (
  `id_error` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) DEFAULT NULL,
  `value` varchar(5) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_error`),
  UNIQUE KEY `value` (`lang`,`value`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_error`
--

LOCK TABLES `app_error` WRITE;
/*!40000 ALTER TABLE `app_error` DISABLE KEYS */;
INSERT INTO `app_error` VALUES (1,'ES','A0000','El usuario o contraseña no validos','2017-02-12 16:39:49'),(2,'ES','A0001','No se encontro el parametro @param0','2017-02-12 16:39:51'),(4,'ES','A0002','No se ha enviado token de validacion.','2017-02-12 16:39:54'),(5,'ES','A0003','El token ha expirado.','2017-02-12 16:39:56'),(6,'ES','A0004','El token no es valido.','2017-02-12 16:39:59'),(7,'ES','A0005','No esta autorizado a acceder al modulo.','2017-02-12 16:40:00'),(8,'ES','A0006','La operacion se realizo correctamente.','2017-02-12 16:40:01'),(9,'ES','A0007','Se borraron @param0 registros.','2017-02-12 16:40:02'),(10,'ES','A0008','Se modificaron @param0 registros.','2017-02-12 16:40:03'),(11,'ES','A0009','Se insertaron @param0 registros.','2017-02-12 16:40:05'),(12,'ES','A0010','No se puede borrar el registro dado que tiene datos relacionados..','2017-02-12 16:40:06'),(13,'ES','A0011','Ya se han agregado elementos al menu.','2017-02-12 16:40:08');
/*!40000 ALTER TABLE `app_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_menu`
--

DROP TABLE IF EXISTS `app_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `menu_order` int(11) DEFAULT NULL,
  `id_perfil` int(11) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_menu`
--

LOCK TABLES `app_menu` WRITE;
/*!40000 ALTER TABLE `app_menu` DISABLE KEYS */;
INSERT INTO `app_menu` VALUES (53,NULL,NULL,'/#/admin/menu',1,14),(54,NULL,NULL,NULL,19,24),(55,NULL,NULL,NULL,22,23),(56,NULL,NULL,NULL,20,21),(57,NULL,NULL,NULL,25,26),(58,NULL,NULL,NULL,27,28),(59,NULL,NULL,NULL,29,30),(60,NULL,NULL,NULL,12,13),(61,NULL,NULL,NULL,10,11),(62,NULL,NULL,NULL,8,9),(63,NULL,NULL,NULL,6,7),(64,NULL,NULL,NULL,15,18),(65,NULL,NULL,'/#/admin/menu',16,17),(66,NULL,NULL,'test1',2,5),(67,NULL,NULL,'/#/admin/menu444',3,4);
/*!40000 ALTER TABLE `app_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_menu_perfil`
--

DROP TABLE IF EXISTS `app_menu_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_menu_perfil` (
  `id_menu_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) NOT NULL,
  `id_perfil` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_menu_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_menu_perfil`
--

LOCK TABLES `app_menu_perfil` WRITE;
/*!40000 ALTER TABLE `app_menu_perfil` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_menu_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_menu_text`
--

DROP TABLE IF EXISTS `app_menu_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_menu_text` (
  `id_menu_text` int(11) NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) DEFAULT NULL,
  `menu_text` varchar(128) NOT NULL,
  `lang` varchar(2) NOT NULL,
  `title` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_menu_text`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_menu_text`
--

LOCK TABLES `app_menu_text` WRITE;
/*!40000 ALTER TABLE `app_menu_text` DISABLE KEYS */;
INSERT INTO `app_menu_text` VALUES (49,53,'Administrador de aplicaciones','ES',NULL),(56,60,'Menu','ES',NULL),(57,61,'Perfiles','ES',NULL),(58,62,'Modulos','ES',NULL),(59,63,'Perfiles-Modulos','ES',NULL),(60,64,'Login','ES',NULL),(61,65,'TEST_000','ES',NULL),(62,66,'TEST_0001','ES','test del titulo_ MOD');
/*!40000 ALTER TABLE `app_menu_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_modulo`
--

DROP TABLE IF EXISTS `app_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_modulo` (
  `id_modulo` int(11) NOT NULL AUTO_INCREMENT,
  `modulo` varchar(100) NOT NULL,
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_modulo`),
  UNIQUE KEY `modulo_UNIQUE` (`modulo`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Modulos del sistema';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_modulo`
--

LOCK TABLES `app_modulo` WRITE;
/*!40000 ALTER TABLE `app_modulo` DISABLE KEYS */;
INSERT INTO `app_modulo` VALUES (16,'Usuario','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2017-02-12 19:27:08','',NULL),(19,'Modulo','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2017-02-12 19:27:08','',NULL),(21,'Perfil','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2017-02-12 19:27:08','',NULL),(22,'PerfilModulo','2016-06-01 00:00:00','2018-06-01 00:00:00','dbo','2017-02-12 19:27:08','Test',NULL),(23,'Menu','2016-01-01 00:00:00','2050-01-01 00:00:00','test','2017-02-12 19:27:08','',NULL),(24,'test999_ZZZ','2016-01-01 00:00:00','2018-01-01 00:00:00','test','2017-02-13 00:19:44',NULL,NULL);
/*!40000 ALTER TABLE `app_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_param`
--

DROP TABLE IF EXISTS `app_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_param` (
  `id_param` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(50) DEFAULT NULL,
  `value` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id_param`),
  UNIQUE KEY `value` (`param_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_param`
--

LOCK TABLES `app_param` WRITE;
/*!40000 ALTER TABLE `app_param` DISABLE KEYS */;
INSERT INTO `app_param` VALUES (1,'DEFAULT_LANGUAGE','ES'),(2,'NO_SE_ENCONTRO_PARAMETRO','');
/*!40000 ALTER TABLE `app_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_perfil`
--

DROP TABLE IF EXISTS `app_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_perfil` (
  `id_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `perfil` varchar(50) NOT NULL,
  `vigencia_desde` datetime NOT NULL,
  `vigencia_hasta` datetime DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfil`),
  UNIQUE KEY `perfil_UNIQUE` (`perfil`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='Perfiles de seguridad';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_perfil`
--

LOCK TABLES `app_perfil` WRITE;
/*!40000 ALTER TABLE `app_perfil` DISABLE KEYS */;
INSERT INTO `app_perfil` VALUES (1,'Administrador','2016-06-01 00:00:00','2020-06-01 00:00:00','test','2017-02-12 19:24:50','',NULL),(22,'usuario','2016-01-01 00:00:00','2018-01-01 00:00:00','test','2017-02-12 19:24:50','',NULL),(23,'nada','2016-01-01 00:00:00','2020-01-01 00:00:00','test','2017-02-12 19:24:50','',NULL);
/*!40000 ALTER TABLE `app_perfil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_perfil_modulo`
--

DROP TABLE IF EXISTS `app_perfil_modulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_perfil_modulo` (
  `id_perfil_modulo` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `creado_por` varchar(20) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfil_modulo`),
  UNIQUE KEY `uq_perfil_modulo` (`id_perfil`,`id_modulo`),
  KEY `id_perfil_idx` (`id_perfil`),
  KEY `FK_Id_modulo_idx` (`id_modulo`),
  CONSTRAINT `FK_Id_modulo` FOREIGN KEY (`id_modulo`) REFERENCES `app_modulo` (`id_modulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_id_perfil` FOREIGN KEY (`id_perfil`) REFERENCES `app_perfil` (`id_perfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='Relacion perfiles-modulo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_perfil_modulo`
--

LOCK TABLES `app_perfil_modulo` WRITE;
/*!40000 ALTER TABLE `app_perfil_modulo` DISABLE KEYS */;
INSERT INTO `app_perfil_modulo` VALUES (22,1,21,1,'test','2018-06-01 03:00:00','test','2016-09-26 04:27:24'),(23,1,19,1,'test','2018-06-01 03:00:00','test','2016-09-26 04:27:27'),(25,1,16,1,'test','2018-06-01 03:00:00','test','2016-09-26 04:44:30'),(26,1,22,1,'test','2018-06-01 03:00:00','test','2016-09-26 04:27:48'),(36,22,16,1,'test','2016-09-28 01:14:48',NULL,NULL),(37,22,22,0,'test','2016-09-28 01:27:05','test','2016-09-28 01:27:50'),(38,1,23,1,'test','2016-10-09 19:04:14',NULL,NULL);
/*!40000 ALTER TABLE `app_perfil_modulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_session_keys`
--

DROP TABLE IF EXISTS `app_session_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_session_keys` (
  `uuid` varchar(64) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `expiration` datetime NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `ck_session_keys__users` (`id_usuario`),
  CONSTRAINT `ck_session_keys__users` FOREIGN KEY (`id_usuario`) REFERENCES `app_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_session_keys`
--

LOCK TABLES `app_session_keys` WRITE;
/*!40000 ALTER TABLE `app_session_keys` DISABLE KEYS */;
INSERT INTO `app_session_keys` VALUES ('02a89193-3b17-11e6-a1f2-c04a00011902',2,'2050-06-25 18:24:29','2016-06-25 20:54:29'),('1f221745-8519-11e6-a581-c04a00011902',4,'2020-09-27 22:46:02','2016-09-28 01:16:02'),('4b9cac7f-851c-11e6-a581-c04a00011902',5,'2020-09-27 23:08:45','2016-09-28 01:38:45');
/*!40000 ALTER TABLE `app_session_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_usuario`
--

DROP TABLE IF EXISTS `app_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(11) DEFAULT NULL,
  `usuario` varchar(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `vigencia_desde` date NOT NULL,
  `vigencia_hasta` date DEFAULT NULL,
  `lang` varchar(2) DEFAULT 'ES',
  `creado_por` varchar(100) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `modificado_por` varchar(20) DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Tabla de usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_usuario`
--

LOCK TABLES `app_usuario` WRITE;
/*!40000 ALTER TABLE `app_usuario` DISABLE KEYS */;
INSERT INTO `app_usuario` VALUES (2,1,'admin','Administrador','Sistema','p.haddad.p@gmail.com','4297f44b13955235245b2497399d7a93','2016-01-01',NULL,'ES','dbo','2016-04-27 19:43:09',NULL,NULL),(4,22,'usuario','usuario','usuario','usuario@test.com.ar','4297f44b13955235245b2497399d7a93','2016-01-01','2004-01-01','ES','test','2016-09-28 01:15:34',NULL,NULL),(5,23,'nada','nada','nada','nada@com.ar','4297f44b13955235245b2497399d7a93','2016-01-01','2020-01-01','ES','test','2016-09-28 01:32:48',NULL,NULL);
/*!40000 ALTER TABLE `app_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'basic'
--

--
-- Dumping routines for database 'basic'
--
/*!50003 DROP FUNCTION IF EXISTS `getErrorMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getErrorMessage`(pLang varchar(2),pValue varchar(5)) RETURNS varchar(1024) CHARSET utf8
BEGIN
  DECLARE  vMessage varchar(1024);
    DECLARE vLanguage varchar(500);
    
    IF pLang='' OR pLang is NULL THEN
      SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
    ELSE 
    SET vLanguage=pLang;
    END IF;
  
  SET vMessage =( SELECT  message 
          FROM app_error
          WHERE lang=vLanguage AND value=pValue);
                    
  IF  IFNULL(vMessage ,'') =''THEN 
    SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
      SET vMessage =( SELECT  message
            FROM app_error
            WHERE lang=vLanguage AND value='A0001');
    RETURN replace(vMessage,'@param0',pValue);
    END IF;
    return vMessage ;
   
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getParamValue` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getParamValue`(pParamName varchar(50)) RETURNS varchar(500) CHARSET utf8
BEGIN

  DECLARE  vParamValue varchar(1024);
    
  SELECT  value
  INTO vParamValue 
  FROM app_param
  WHERE param_name=pParamName;

  RETURN vParamValue;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `raiseError` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `raiseError`(pLang varchar(2),pValue varchar(5)) RETURNS varchar(1024) CHARSET utf8
BEGIN

  DECLARE  vMessage varchar(1024);
    
  SELECT  message
  INTO vMessage 
  FROM app_error
  WHERE lang=pLang AND value=pValue;
    
    /*
  SIGNAL SQLSTATE VALUE pValue 
  SET MESSAGE_TEXT =vMessage;
    */

  RETURN '';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getErrorMessage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getErrorMessage`(pLang varchar(2),pValue varchar(5))
BEGIN
    SELECT getErrorMessage(pLang,pValue) ErrorMessage;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSessionKeyByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionKeyByUser`(pUserName varchar(20),pPassword varchar(50),pLang varchar(2))
BEGIN
	
    
    
	DECLARE  vUUID varchar(64);
	DECLARE  vExpiration datetime;
	DECLARE  vId_usuario int;
    DECLARE vErrorMessage varchar(1024);
    DECLARE vLanguage varchar(500);
    IF pLang='' OR pLang IS NULL  THEN
		SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
    ELSE    
		SET vLanguage =pLang;
	END IF;	
    
    -- https://dev.mysql.com/doc/refman/5.5/en/error-messages-server.html
    /*
     Error: 1437 SQLSTATE: 42000 (ER_TOO_LONG_BODY)
	 Message: Routine body for '%s' is too long
    */
 
    
     SELECT id_usuario
		INTO vId_usuario  
    FROM app_usuario
	WHERE usuario=pUserName and password=pPassword;
    
    IF vId_usuario  IS NOT NULL THEN 
    
    	SELECT a.uuid
			INTO vUUID
		FROM app_session_keys a 
		WHERE a.id_usuario=vId_usuario and a.expiration>NOW();
        
        IF vUUID  IS NULL THEN 
			SET vExpiration= DATE_ADD(NOW(),INTERVAL 30 MINUTE);
			INSERT app_session_keys( uuid,expiration,id_usuario)
						values( uuid(),vExpiration,vId_usuario);
        END IF;
        
		START TRANSACTION;
			UPDATE app_usuario
			SET 
				lang=vLanguage
			WHERE id_usuario=vId_usuario;
		COMMIT;
		
        
		SELECT b.id_usuario,b.uuid ,b.expiration,
				a.id_usuario,a.usuario,a.nombre,a.apellido,a.email,a.lang,a.id_perfil
		FROM app_usuario a
			inner join  app_session_keys b
			on a.id_usuario=b.id_usuario
		WHERE b.id_usuario=vId_usuario 
				and b.expiration>NOW();
    ELSE	
		SET vErrorMessage =(SELECT getErrorMessage(vLanguage ,'A0000'));
		SIGNAL SQLSTATE VALUE 'A0000' SET MESSAGE_TEXT =vErrorMessage;
    END IF;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSessionKeys` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionKeys`()
BEGIN
   	Select 
	  uuid,
	  id_usuario,
      expiration
	FROM app_session_keys
	WHERE expiration > now();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSessionkeysByUUID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSessionkeysByUUID`(pUuid varchar(64))
BEGIN
    select uuid,id_usuario,expiration,created
    from app_session_keys
    where uuid=pUuid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_addNodeChild` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_addNodeChild`(pId_menu int,pLang varchar(2),pName varchar(128),pLink varchar(512),pTitle varchar(512))
BEGIN
		DECLARE myLeft INT;
		SET myLeft =(SELECT lft  FROM app_menu		WHERE id_menu = pId_menu);

		UPDATE app_menu SET rgt = rgt + 2 WHERE rgt > myLeft;
		UPDATE app_menu SET lft = lft + 2 WHERE lft > myLeft;

		INSERT INTO app_menu(lft, rgt,link ) 
			VALUES(myLeft + 1, myLeft + 2,pLink);
            
        INSERT INTO app_menu_text(id_menu,menu_text,lang,title )
        VALUES(LAST_INSERT_ID(),pName,pLang,pTitle);    
        SELECT  ROW_COUNT() row_count;	

	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_addNodeSameLevel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_addNodeSameLevel`(pId_menu int,pLang varchar(2),pName varchar(128),pLink varchar(512),pTitle varchar(512))
BEGIN
		DECLARE vErrorMessage varchar(1024);
        DECLARE myRight INT;
        DECLARE id INT;
        
        
        
        IF pId_menu =0 OR pId_menu IS NULL  THEN
			IF (SELECT COUNT(*) FROM app_menu)=0 THEN
				INSERT INTO app_menu(lft,rgt,link)
					VALUES(1,2,pLink);
				INSERT INTO app_menu_text(id_menu,menu_text,lang,title )
					VALUES(LAST_INSERT_ID(),pName,pLang,pTitle);
			ELSE	
				
				SET vErrorMessage =(SELECT getErrorMessage(pLang ,'A0011'));
				SIGNAL SQLSTATE VALUE 'A0011' SET MESSAGE_TEXT =vErrorMessage;
			END IF;
			
		END IF;                
		
        IF pId_menu >0  AND pId_menu IS NOT NULL THEN
			-- SELECT @myRight := rgt FROM app_menu WHERE id_menu =pId_menu;
            SELECT rgt 
				INTO myRight 
            FROM app_menu WHERE id_menu =pId_menu;
            
            

			UPDATE app_menu SET rgt = rgt + 2 WHERE rgt > myRight;
			UPDATE app_menu SET lft = lft + 2 WHERE lft > myRight;
			
			INSERT INTO app_menu(lft, rgt,link) 
				VALUES( myRight + 1, myRight + 2,plink);
			
            SET id=LAST_INSERT_ID();
        
			INSERT INTO app_menu_text(id_menu,menu_text,lang ,title)
			VALUES(id,pName,pLang,pTitle);
            
            SELECT  id as id_menu, ROW_COUNT() row_count;	
		END IF;

	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_deleteNode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_deleteNode`(pId_menu int)
BEGIN
		DECLARE vCount INT;
        DECLARE myLeft INT;
        DECLARE myRight INT;
        DECLARE myWidth INT;
        SET vCount=0;

		SELECT myLeft = lft, myRight = rgt, myWidth = rgt - lft + 1
		FROM app_menu
		WHERE id_menu= pId_menu;

		DELETE FROM app_menu WHERE lft BETWEEN myLeft AND myRight;
        DELETE FROM app_menu_text WHERE id_menu= pId_menu;
        SET  vCount=(SELECT  ROW_COUNT());	

		UPDATE app_menu SET rgt = rgt - myWidth WHERE rgt > myRight;
		UPDATE app_menu SET lft = lft - myWidth WHERE lft > myRight;
        
        SELECT  vCount row_count;	

 	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_deleteNodeMoveChild` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_deleteNodeMoveChild`(pId_menu int)
BEGIN

		SELECT @myLeft := lft, @myRight := rgt, @myWidth := rgt - lft + 1
		FROM app_menu
		WHERE id_menu = pId_menu;

		DELETE FROM app_menu WHERE lft = @myLeft;
        DELETE FROM app_menu_text WHERE id_menu= pId_menu;
        SELECT  ROW_COUNT() row_count;	

		UPDATE app_menu SET rgt = rgt - 1, lft = lft - 1 WHERE lft BETWEEN @myLeft AND @myRight;
		UPDATE app_menu SET rgt = rgt - 2 WHERE rgt > @myRight;
		UPDATE app_menu SET lft = lft - 2 WHERE lft > @myRight;

	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getAll`(pLang varchar(2))
BEGIN
		SELECT a.id_menu,b.menu_text
		FROM app_menu  a
			inner join app_menu_text b
				on a.id_menu=b.id_menu
		where b.lang=pLang
		ORDER BY lft;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getAllLeafNodes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getAllLeafNodes`(pLang varchar(2))
BEGIN
		SELECT c.menu_text
		FROM app_menu node,app_menu_text AS c
		WHERE node.rgt = node.lft + 1
			AND node.id_menu=c.id_menu 
            AND c.lang=pLang;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getDepthSubTree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getDepthSubTree`(id int,pLang varchar(2))
BEGIN
     SELECT c.menu_text , (COUNT(parent.id_menu) - (sub_tree.depth + 1)) AS depth
		FROM app_menu AS node,
			app_menu AS parent,
			app_menu AS sub_parent,
            app_menu_text AS c,
			(
				SELECT node.id_menu, (COUNT(parent.id_menu) - 1) AS depth
				FROM app_menu AS node,
				app_menu AS parent
				WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu = id 
				GROUP BY node.id_menu
				ORDER BY node.lft
			)AS sub_tree
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
			AND sub_parent.id_menu = sub_tree.id_menu
            AND node.id_menu=c.id_menu 
			AND c.lang=pLang
		GROUP BY c.menu_text 
		ORDER BY node.lft;
		 
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getFullTree` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getFullTree`(id int,pLang varchar(2))
BEGIN
		SELECT c.menu_text
		FROM app_menu AS node,app_menu AS parent,app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu=c.id_menu 
				AND parent.id_menu =id 
				AND c.lang=pLang
		ORDER BY node.lft;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getImmediateSubordinatesNode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getImmediateSubordinatesNode`(id int,pLang varchar(2))
BEGIN
    	SELECT c.menu_text, (COUNT(parent.id_menu) - (sub_tree.depth + 1)) AS depth
		FROM app_menu AS node,
			app_menu AS parent,
			app_menu AS sub_parent,
            app_menu_text AS c,
			(
				SELECT node.id_menu, (COUNT(parent.id_menu) - 1) AS depth
				FROM app_menu AS node,
				app_menu AS parent
				WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu = id 
				GROUP BY node.id_menu
				ORDER BY node.lft
			)AS sub_tree
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
			AND sub_parent.id_menu = sub_tree.id_menu
            AND node.id_menu=c.id_menu 
			AND c.lang=pLang
		GROUP BY c.menu_text
		HAVING depth <= 1
		ORDER BY node.lft;
    END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getNodesDepth` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getNodesDepth`(pLang varchar(2))
BEGIN
		SELECT node.lft,node.id_menu,node.link ,c.menu_text,c.title , (COUNT(parent.id_menu) - 1) AS depth
		FROM app_menu AS node,
			 app_menu AS parent,
             app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu=c.id_menu 
				AND c.lang=pLang
		GROUP BY node.id_menu 
		ORDER BY node.lft;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_getSinglePath` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_getSinglePath`(id int,pLang varchar(2))
BEGIN
		SELECT c.menu_text 
		FROM app_menu AS node,app_menu AS parent,app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.id_menu =id 
            AND parent.id_menu=c.id_menu 
             AND c.lang=pLang
		ORDER BY parent.lft;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_List` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_List`(pLang varchar(2))
BEGIN
		SELECT node.id_menu,CONCAT( REPEAT('    ', COUNT(parent.id_menu) - 1), c.menu_text) AS name
		FROM app_menu AS node,	app_menu AS parent,app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
        and c.lang=pLang
         and node.id_menu=c.id_menu -- and parent.id_menu=c.id_menu
		GROUP BY node.id_menu
        ORDER BY node.lft;
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `menu_updateNode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `menu_updateNode`(pId_menu int,pLang varchar(2),pName varchar(128),pLink varchar(512),pTitle varchar(512))
BEGIN
		DECLARE row_count INT;
		SET row_count=0;

		UPDATE app_menu_text
		SET 
			menu_text=pName,
			title=pTitle
		WHERE id_menu= pId_menu and lang=pLang;
		
		SET row_count=ROW_COUNT();

		UPDATE app_menu
		SET 
			link=pLink
		WHERE id_menu= pId_menu;

		SET row_count=row_count+ROW_COUNT();
		

        SELECT  ROW_COUNT() row_count;	
	END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloDelete`(pk int)
BEGIN
    delete from app_modulo
    where id_modulo=pk;
    SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloGetAll`()
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_modulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloGetById`(pk int)
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_modulo
    where id_modulo=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloInsert`(

  pModulo varchar(100),
  pVigencia_Desde datetime ,
  pVigencia_Hasta datetime ,
  pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO app_modulo(modulo,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion)
        VALUES(pModulo,pVigencia_Desde,pVigencia_Hasta,pCreado_Por,now());
  SELECT  ROW_COUNT() row_count;        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `moduloUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `moduloUpdate`(
  pId_Modulo int,
  pModulo varchar(100),
  pVigencia_Desde datetime,
  pVigencia_Hasta datetime,
  pModificado_Por varchar(20)
    )
BEGIN
    UPDATE app_modulo
    SET 
    modulo=pModulo,
    vigencia_desde=pVigencia_Desde,
    vigencia_hasta=pVigencia_Hasta,
    modificado_por=pModificado_Por,
    fecha_modificacion=now()
  WHERE id_modulo=pId_Modulo;
    SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilDelete`(pk int)
BEGIN
	DECLARE vErrorMessage varchar(1024);
	DECLARE  vCount varchar(1024);
	SELECT count(1)
		INTO vCount
    FROM app_perfil_modulo
	WHERE id_perfil=pk and enabled=1;
    
    IF vCount = 0 THEN
	    DELETE FROM app_perfil_modulo
        WHERE id_perfil=pk;
    ELSE
    	SET vErrorMessage =(SELECT getErrorMessage('' ,'A0010'));
		SIGNAL SQLSTATE VALUE 'A0010' SET MESSAGE_TEXT =vErrorMessage;
    END IF; 
    
    DELETE FROM app_perfil where id_perfil=pk;
    SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilGetAll`()
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_perfil;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilGetById`(pk int)
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_perfil
    where id_perfil=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilInsert`(

	pPerfil varchar(50),
	pVigencia_Desde datetime ,
	pVigencia_Hasta datetime ,
	pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO app_perfil(perfil,vigencia_desde,vigencia_hasta,fecha_creacion,creado_por)
        VALUES(pPerfil,pVigencia_Desde,pVigencia_Hasta,now(),pCreado_Por);
    SELECT  ROW_COUNT() row_count;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloDelete`(pk int)
BEGIN
    delete from app_perfil_modulo
    where id_perfil_modulo=pk;
    SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetAll`()
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from app_perfil_modulo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetById`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from app_perfil_modulo
    where id_perfil_modulo=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetByIdPerfil` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetByIdPerfil`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo, enabled,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from app_perfil_modulo
    where id_perfil=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloGetByModuloUsuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloGetByModuloUsuario`(pModulo varchar(100),pIdUsuario int)
BEGIN
    select a.id_perfil,a.id_modulo,a.enabled
	from app_perfil_modulo a
		inner join app_modulo b on
		a.id_modulo=b.id_modulo
        inner join app_usuario c 
			on c.id_perfil=a.id_perfil
	where b.modulo=pModulo
		and c.id_usuario=pIdUsuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloInsert`(
	pId_Perfil int ,
	pId_Modulo int ,
	pEnabled int,
	pCreado_Por varchar(20)
)
BEGIN
	DECLARE  vId_perfil_modulo int;

	SELECT id_perfil_modulo
		INTO vId_perfil_modulo  
    FROM app_perfil_modulo
	WHERE id_perfil=pId_Perfil and id_modulo=pId_Modulo;

	IF vId_perfil_modulo  IS NULL THEN 
	    INSERT INTO app_perfil_modulo(id_perfil,id_modulo,enabled,creado_por)
	        VALUES(pId_Perfil,pId_Modulo,pEnabled,pCreado_Por);
	   	SELECT  ROW_COUNT() row_count;    
	ELSE	
		CALL perfilmoduloUpdate(vId_perfil_modulo, pId_Perfil,pId_Modulo,pEnabled,pCreado_Por );	
    END IF;        
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilmoduloUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilmoduloUpdate`(
	pId_Perfil_Modulo int,
	pId_Perfil int,
	pId_Modulo int,
	pEnabled int,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE app_perfil_modulo
    SET 
		id_perfil=pId_Perfil,
		id_modulo=pId_Modulo,
		enabled =pEnabled,
		modificado_por=pModificado_Por,
		fecha_modificacion=now()
	WHERE id_perfil_modulo=pId_Perfil_Modulo;
	SELECT  ROW_COUNT() row_count;    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `perfilUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `perfilUpdate`(
	pId_Perfil int,
	pPerfil varchar(50),
	pVigencia_Desde datetime,
	pVigencia_Hasta datetime,
	pModificado_Por varchar(20)
    )
BEGIN
    UPDATE app_perfil
    SET 
		perfil=pPerfil,
		vigencia_desde=pVigencia_Desde,
		vigencia_hasta=pVigencia_Hasta,
		modificado_por=pModificado_Por,
		fecha_modificacion=now()
	WHERE id_perfil=pId_Perfil;
    SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarioDelete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarioDelete`(pk int)
BEGIN
    delete from app_usuario
    where id_usuario=pk;
  SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarioGetAll` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarioGetAll`()
BEGIN
    select id_usuario,usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from app_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarioGetById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarioGetById`(pk int)
BEGIN
    select id_usuario,usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from app_usuario
    where id_usuario=pk;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarioInsert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarioInsert`(
  pUsuario varchar(50),
  pNombre varchar(50),
  pApellido varchar(50),
  pEmail varchar(200),
  pPassword varchar(200),
  pId_Perfil int ,
  pVigencia_Desde date ,
  pVigencia_Hasta date ,
  pCreado_Por varchar(100)
  
)
BEGIN
    INSERT INTO app_usuario(usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por)
        VALUES(pUsuario,pNombre,pApellido,pEmail,pPassword,pId_Perfil,pVigencia_Desde,pVigencia_Hasta,pCreado_Por);
  SELECT  ROW_COUNT() row_count;  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `usuarioUpdate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `usuarioUpdate`(
  pId_Usuario int,
  pUsuario varchar(50),
  pNombre varchar(50),
  pApellido varchar(50),
  pEmail varchar(200),
  pPassword varchar(200),
  pId_Perfil int,
  pVigencia_Desde date,
  pVigencia_Hasta date,
  pModificado_Por varchar(20)
    )
BEGIN
    UPDATE app_usuario
    SET 
    usuario=pUsuario,
    nombre=pNombre,
    apellido=pApellido,
    email=pEmail,
    password=pPassword,
    id_perfil=pId_Perfil,
    vigencia_desde=pVigencia_Desde,
    vigencia_hasta=pVigencia_Hasta,
    modificado_por=pModificado_Por,
    fecha_modificacion=now()
  WHERE id_usuario=pId_Usuario;
    
  SELECT  ROW_COUNT() row_count;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-05 20:52:06
