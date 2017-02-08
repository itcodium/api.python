DROP FUNCTION IF EXISTS   `getParamValue`;
DELIMITER $$
CREATE FUNCTION `getParamValue`(pParamName varchar(50)) RETURNS varchar(500) CHARSET utf8
BEGIN

	DECLARE  vParamValue varchar(1024);
    
	SELECT  value
	INTO vParamValue 
	FROM hr_param
	WHERE param_name=pParamName;

	RETURN vParamValue;
END$$
DELIMITER ;
