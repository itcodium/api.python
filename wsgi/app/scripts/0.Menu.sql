CREATE TABLE `app_menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `menu_order` int(11) DEFAULT NULL,
  `id_perfil` int(11) DEFAULT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

CREATE TABLE `app_menu_perfil` (
  `id_menu_perfil` int(11) NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) NOT NULL,
  `id_perfil` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_menu_perfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_menu_text` (
  `id_menu_text` int(11) NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) DEFAULT NULL,
  `menu_text` varchar(50) NOT NULL,
  `lang` varchar(2) NOT NULL,
  PRIMARY KEY (`id_menu_text`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;


DELIMITER $$
CREATE  PROCEDURE `menu_addNodeChild`(pId_menu int,pLang varchar(2),pName varchar(128))
BEGIN
		DECLARE myLeft INT;
		SET myLeft =(SELECT lft  FROM app_menu		WHERE id_menu = pId_menu);

		UPDATE app_menu SET rgt = rgt + 2 WHERE rgt > myLeft;
		UPDATE app_menu SET lft = lft + 2 WHERE lft > myLeft;

		INSERT INTO app_menu(lft, rgt) 
			VALUES(myLeft + 1, myLeft + 2);
            
        INSERT INTO app_menu_text(id_menu,menu_text,lang )
        VALUES(LAST_INSERT_ID(),pName,pLang);    
        SELECT  ROW_COUNT() row_count;	

	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_addNodeSameLevel`(pId_menu int,pLang varchar(2),pName varchar(128))
BEGIN
		DECLARE vErrorMessage varchar(1024);
        DECLARE myRight INT;
        DECLARE id INT;
        
        
        
        IF pId_menu =0 OR pId_menu IS NULL  THEN
			IF (SELECT COUNT(*) FROM app_menu)=0 THEN
				INSERT INTO app_menu(lft,rgt)
					VALUES(1,2);
				INSERT INTO app_menu_text(id_menu,menu_text,lang )
					VALUES(LAST_INSERT_ID(),pName,pLang);
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
			
			INSERT INTO app_menu(lft, rgt) 
				VALUES( myRight + 1, myRight + 2);
			
            SET id=LAST_INSERT_ID();
        
			INSERT INTO app_menu_text(id_menu,menu_text,lang )
			VALUES(id,pName,pLang);
            
            SELECT  id as id_menu, ROW_COUNT() row_count;	
		END IF;

	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_deleteNode`(pId_menu int)
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

 	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_deleteNodeMoveChild`(pId_menu int)
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

	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getAll`(pLang varchar(2))
BEGIN
		SELECT a.id_menu,b.menu_text
		FROM app_menu  a
			inner join app_menu_text b
				on a.id_menu=b.id_menu
		where b.lang=pLang
		ORDER BY lft;
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getAllLeafNodes`(pLang varchar(2))
BEGIN
		SELECT c.menu_text
		FROM app_menu node,app_menu_text AS c
		WHERE node.rgt = node.lft + 1
			AND node.id_menu=c.id_menu 
            AND c.lang=pLang;
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getDepthSubTree`(id int,pLang varchar(2))
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
		 
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getFullTree`(id int,pLang varchar(2))
BEGIN
		SELECT c.menu_text
		FROM app_menu AS node,app_menu AS parent,app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu=c.id_menu 
				AND parent.id_menu =id 
				AND c.lang=pLang
		ORDER BY node.lft;
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getImmediateSubordinatesNode`(id int,pLang varchar(2))
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
    END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getNodesDepth`(pLang varchar(2))
BEGIN
		SELECT node.lft,node.id_menu ,c.menu_text , (COUNT(parent.id_menu) - 1) AS depth
		FROM app_menu AS node,
			 app_menu AS parent,
             app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
				AND node.id_menu=c.id_menu 
				AND c.lang=pLang
		GROUP BY node.id_menu 
		ORDER BY node.lft;
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_getSinglePath`(id int,pLang varchar(2))
BEGIN
		SELECT c.menu_text 
		FROM app_menu AS node,app_menu AS parent,app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
			AND node.id_menu =id 
            AND parent.id_menu=c.id_menu 
             AND c.lang=pLang
		ORDER BY parent.lft;
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_List`(pLang varchar(2))
BEGIN
		SELECT node.id_menu,CONCAT( REPEAT('    ', COUNT(parent.id_menu) - 1), c.menu_text) AS name
		FROM app_menu AS node,	app_menu AS parent,app_menu_text AS c
		WHERE node.lft BETWEEN parent.lft AND parent.rgt
        and c.lang=pLang
         and node.id_menu=c.id_menu -- and parent.id_menu=c.id_menu
		GROUP BY node.id_menu
        ORDER BY node.lft;
	END$$
DELIMITER ;

DELIMITER $$
CREATE  PROCEDURE `menu_updateNode`(pId_menu int,pLang varchar(2),pName varchar(128))
BEGIN
		UPDATE app_menu_text
		SET 
			menu_text=pName
		WHERE id_menu= pId_menu and lang=pLang;
        SELECT  ROW_COUNT() row_count;	
	END$$
DELIMITER ;
