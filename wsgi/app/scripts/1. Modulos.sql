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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Modulos del sistema';


DROP PROCEDURE IF EXISTS   `moduloDelete`;
DELIMITER $$
CREATE  PROCEDURE `moduloDelete`(pk int)
BEGIN
    delete from app_modulo
    where id_modulo=pk;
    SELECT  ROW_COUNT() row_count;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `moduloGetAll`;
DELIMITER $$
CREATE  PROCEDURE `moduloGetAll`()
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_modulo;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `moduloGetById`;
DELIMITER $$
CREATE  PROCEDURE `moduloGetById`(pk int)
BEGIN
    select id_modulo,modulo,vigencia_desde,vigencia_hasta,creado_por,modificado_por
    from app_modulo
    where id_modulo=pk;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `moduloInsert`;
DELIMITER $$
CREATE  PROCEDURE `moduloInsert`(

  pModulo varchar(100),
  pVigencia_Desde datetime ,
  pVigencia_Hasta datetime ,
  pCreado_Por varchar(20)
)
BEGIN
    INSERT INTO app_modulo(modulo,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion)
        VALUES(pModulo,pVigencia_Desde,pVigencia_Hasta,pCreado_Por,now());
  SELECT  ROW_COUNT() row_count;        
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `moduloUpdate`;
DELIMITER $$
CREATE  PROCEDURE `moduloUpdate`(
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
END$$
DELIMITER ;
