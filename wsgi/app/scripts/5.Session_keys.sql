CREATE TABLE `app_session_keys` (
  `uuid` varchar(64) DEFAULT NULL,
  `id_usuario` int(11) NOT NULL,
  `expiration` datetime NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `ck_session_keys__users` (`id_usuario`),
  CONSTRAINT `ck_session_keys__users` FOREIGN KEY (`id_usuario`) REFERENCES `app_usuario` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP PROCEDURE IF EXISTS   `getSessionKeyByUser`;

DELIMITER $$
CREATE  PROCEDURE `getSessionKeyByUser`(pUserName varchar(20),pPassword varchar(50),pLang varchar(2))
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
    
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `getSessionKeys`;
DELIMITER $$
CREATE  PROCEDURE `getSessionKeys`()
BEGIN
   	Select 
	  uuid,
	  id_usuario,
      expiration
	FROM app_session_keys
	WHERE expiration > now();
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `getSessionkeysByUUID`;
DELIMITER $$
CREATE  PROCEDURE `getSessionkeysByUUID`(pUuid varchar(64))
BEGIN
    select uuid,id_usuario,expiration,created
    from app_session_keys
    where uuid=pUuid;
END$$
DELIMITER ;


