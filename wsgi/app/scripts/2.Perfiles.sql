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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Perfiles de seguridad';


DROP PROCEDURE IF EXISTS `perfilDelete`;
DELIMITER $$
CREATE  PROCEDURE `perfilDelete`(pk int)
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
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilGetAll`;
DELIMITER $$
CREATE  PROCEDURE `perfilGetAll`()
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_perfil;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilGetById`;
DELIMITER $$
CREATE  PROCEDURE `perfilGetById`(pk int)
BEGIN
    select id_perfil,perfil,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_perfil
    where id_perfil=pk;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilInsert`;
DELIMITER $$
CREATE  PROCEDURE `perfilInsert`(

	pPerfil varchar(50),
	pVigencia_Desde datetime ,
	pVigencia_Hasta datetime ,
	pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO app_perfil(perfil,vigencia_desde,vigencia_hasta,fecha_creacion,creado_por)
        VALUES(pPerfil,pVigencia_Desde,pVigencia_Hasta,now(),pCreado_Por);
    SELECT  ROW_COUNT() row_count;    
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilmoduloDelete`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloDelete`(pk int)
BEGIN
    delete from app_perfil_modulo
    where id_perfil_modulo=pk;
    SELECT  ROW_COUNT() row_count;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilmoduloGetAll`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloGetAll`()
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from app_perfil_modulo;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilmoduloGetById`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloGetById`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from app_perfil_modulo
    where id_perfil_modulo=pk;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilmoduloGetByIdPerfil`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloGetByIdPerfil`(pk int)
BEGIN
    select id_perfil_modulo,id_perfil,id_modulo, enabled,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from app_perfil_modulo
    where id_perfil=pk;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilmoduloGetByModuloUsuario`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloGetByModuloUsuario`(pModulo varchar(100),pIdUsuario int)
BEGIN
    select a.id_perfil,a.id_modulo,a.enabled
	from app_perfil_modulo a
		inner join hr_app_modulo b on
		a.id_modulo=b.id_modulo
        inner join hr_app_usuario c 
			on c.id_perfil=a.id_perfil
	where b.modulo=pModulo
		and c.id_usuario=pIdUsuario;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `perfilmoduloInsert`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloInsert`(
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
        
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilmoduloUpdate`;
DELIMITER $$
CREATE  PROCEDURE `perfilmoduloUpdate`(
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
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `perfilUpdate`;
DELIMITER $$
CREATE  PROCEDURE `perfilUpdate`(
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
END$$
DELIMITER ;
