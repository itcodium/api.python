
DROP PROCEDURE IF EXISTS   `${NameLower}GetAll`;
DELIMITER $$
CREATE PROCEDURE `${NameLower}GetAll`()
BEGIN
    select ${SelectColumns}
    from ${Name};
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `${NameLower}GetById`;
DELIMITER $$
CREATE  PROCEDURE `${NameLower}GetById`(pk int)
BEGIN
    select ${SelectColumns} 
    from ${Name}
    where ${PK}=pk;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `${NameLower}Delete`;
DELIMITER $$
CREATE  PROCEDURE `${NameLower}Delete`(pk int)
BEGIN
    delete from ${Name}
    where ${PK}=pk;
	SELECT  ROW_COUNT() row_count;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `${NameLower}Insert`;
DELIMITER $$
CREATE  PROCEDURE `${NameLower}Insert`(
${InsertParams}
)
BEGIN
    INSERT INTO ${Name}(${InsertColumns})
        VALUES(${InsertValues});
	SELECT  ROW_COUNT() row_count;	
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS   `${NameLower}Update`;
DELIMITER $$
CREATE   PROCEDURE `${NameLower}Update`(${UpdateParams}
    )
BEGIN
    UPDATE ${Name}
    SET ${UpdateData};
	SELECT  ROW_COUNT() row_count;
END$$
DELIMITER ;
 
