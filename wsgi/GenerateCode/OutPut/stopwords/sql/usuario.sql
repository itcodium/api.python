
DROP PROCEDURE IF EXISTS   `usuarioGetAll`;
DELIMITER $
CREATE PROCEDURE `usuarioGetAll`()
BEGIN
    select id,nombre,apellido,usuario,habilitado,creado_por,modificado_por,fecha_creacion,fecha_modificacion
    from usuario;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioGetById`;
DELIMITER $
CREATE  PROCEDURE `usuarioGetById`(pk int)
BEGIN
    select id,nombre,apellido,usuario,habilitado,creado_por,modificado_por,fecha_creacion,fecha_modificacion 
    from usuario
    where id=pk;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioDelete`;
DELIMITER $
CREATE  PROCEDURE `usuarioDelete`(pk int)
BEGIN
    delete from usuario
    where id=pk;
	SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioInsert`;
DELIMITER $
CREATE  PROCEDURE `usuarioInsert`(

	pNombre varchar(50),
	pApellido varchar(50),
	pUsuario varchar(50),
	pHabilitado tinyint ,
	pCreado_Por varchar(50),
	pFecha_Modificacion timestamp 
)
BEGIN
    INSERT INTO usuario(nombre,apellido,usuario,habilitado,creado_por,fecha_modificacion)
        VALUES(pNombre,pApellido,pUsuario,pHabilitado,pCreado_Por,pFecha_Modificacion);
	SELECT  ROW_COUNT() row_count;	
END$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `usuarioUpdate`;
DELIMITER $
CREATE   PROCEDURE `usuarioUpdate`(
	pId int,
	pNombre varchar(50),
	pApellido varchar(50),
	pUsuario varchar(50),
	pHabilitado tinyint,
	pModificado_Por varchar(50),
	pFecha_Modificacion timestamp
    )
BEGIN
    UPDATE usuario
    SET 
		nombre=pNombre,
		apellido=pApellido,
		usuario=pUsuario,
		habilitado=pHabilitado,
		modificado_por=pModificado_Por,
		fecha_modificacion=pFecha_Modificacion
	WHERE id=pId;
	SELECT  ROW_COUNT() row_count;
END$
DELIMITER ;
 

