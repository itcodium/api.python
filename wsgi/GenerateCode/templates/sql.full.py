
-- DROP PROCEDURE `${Schema}`.`${NameLower}GetAll`
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `${Schema}`.`${NameLower}GetAll`()
BEGIN
    select ${SelectColumns}
    from ${Schema}.${Name};
END$$
DELIMITER ;


-- DROP PROCEDURE `${Schema}`.`${NameLower}GetById`
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `${Schema}`.`${NameLower}GetById`(pk int)
BEGIN
    select ${SelectColumns} 
    from ${Schema}.${Name}
    where ${PK}=pk;
END$$
DELIMITER ;


-- DROP PROCEDURE `${Schema}`.`${NameLower}Delete`
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `${Schema}`.`${NameLower}Delete`(pk int)
BEGIN
    delete from ${Schema}.${Name}
    where ${PK}=pk;
END$$
DELIMITER ;


-- DROP PROCEDURE `${Schema}`.`${NameLower}Insert`
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `${Schema}`.`${NameLower}Insert`(
${InsertParams}
)
BEGIN
    INSERT INTO ${Schema}.${Name}(${InsertColumns})
        VALUES(${InsertValues});
END$$
DELIMITER ;


-- DROP PROCEDURE `${Schema}`.`${NameLower}Update`
DELIMITER $$
CREATE  DEFINER=`root`@`localhost` PROCEDURE `${Schema}`.`${NameLower}Update`(${UpdateParams}
    )
BEGIN
    UPDATE ${Schema}.${Name}
    SET ${UpdateData};
END$$
DELIMITER ;
 
