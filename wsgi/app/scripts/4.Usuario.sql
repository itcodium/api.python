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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='Tabla de usuarios';


DROP PROCEDURE IF EXISTS   `usuarioDelete`;
DELIMITER $$
CREATE  PROCEDURE `usuarioDelete`(pk int)
BEGIN
    delete from app_usuario
    where id_usuario=pk;
  SELECT  ROW_COUNT() row_count;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `usuarioGetAll`;
DELIMITER $$
CREATE  PROCEDURE `usuarioGetAll`()
BEGIN
    select id_usuario,usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion,modificado_por,fecha_modificacion
    from app_usuario;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `usuarioGetById`;
DELIMITER $$
CREATE  PROCEDURE `usuarioGetById`(pk int)
BEGIN
    select id_usuario,usuario,nombre,apellido,email,password,id_perfil,vigencia_desde,vigencia_hasta,creado_por,fecha_creacion,modificado_por,fecha_modificacion 
    from app_usuario
    where id_usuario=pk;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   `usuarioInsert`;
DELIMITER $$
CREATE  PROCEDURE `usuarioInsert`(
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
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioUpdate`;
DELIMITER $$
CREATE  PROCEDURE `usuarioUpdate`(
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
END$$
DELIMITER ;
