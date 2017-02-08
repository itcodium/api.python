CREATE TABLE `hr_error` (
  `id_error` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(2) DEFAULT NULL,
  `value` varchar(5) DEFAULT NULL,
  `message` varchar(1024) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_error`),
  UNIQUE KEY `value` (`lang`,`value`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;


DROP PROCEDURE IF EXISTS   `getErrorMessage`;
DELIMITER $
CREATE PROCEDURE `getErrorMessage`(pLang varchar(2),pValue varchar(5))
BEGIN
    SELECT getErrorMessage(pLang,pValue) ErrorMessage;
END$
DELIMITER ;


DROP FUNCTION IF EXISTS   `getErrorMessage`;
DELIMITER $
CREATE  FUNCTION `getErrorMessage`(pLang varchar(2),pValue varchar(5)) RETURNS varchar(1024) CHARSET utf8
BEGIN
	DECLARE  vMessage varchar(1024);
    DECLARE vLanguage varchar(500);
    
    IF pLang='' OR pLang is NULL THEN
    	SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
    ELSE 
		SET vLanguage=pLang;
    END IF;
  
	SET vMessage =(	SELECT  message	
					FROM hr_error
					WHERE lang=vLanguage AND value=pValue);
                    
	IF  IFNULL(vMessage ,'') =''THEN 
		SET vLanguage =(select getParamValue('DEFAULT_LANGUAGE'));
    	SET vMessage =( SELECT  message
						FROM hr_error
						WHERE lang=vLanguage AND value='A0001');
		RETURN replace(vMessage,'@param0',pValue);
    END IF;
    return vMessage ;
  
END$
DELIMITER ;


DROP FUNCTION IF EXISTS   `raiseError`;
DELIMITER $$
CREATE  FUNCTION `raiseError`(pLang varchar(2),pValue varchar(5)) RETURNS varchar(1024) CHARSET utf8
BEGIN

	DECLARE  vMessage varchar(1024);
    
	SELECT  message
	INTO vMessage 
	FROM hr_error
	WHERE lang=pLang AND value=pValue;
    
    /*
	SIGNAL SQLSTATE VALUE pValue 
	SET MESSAGE_TEXT =vMessage;
    */

	RETURN '';
END$$
DELIMITER ;
