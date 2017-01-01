/*
DROP PROCEDURE IF EXISTS test_init_reprocess;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `noticias_reprocess_StopWordsnoticias`()
BEGIN
	UPDATE data_mining.noticias
	SET fecha_analisis_texto=null;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS test_reset_tables;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_reset_tables`()
BEGIN
	delete from texto_palabras;
	delete from texto;
	delete from palabra;	
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS   test_init_reprocess;  
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_init_reprocess`()
BEGIN
	update texto
	SET fecha_proceso=null;
END$$
DELIMITER ;
*/

-- CALL `texto_GetByClientAll`(1); 
DROP PROCEDURE  IF EXISTS `texto_GetByClientAll`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_GetByClientAll`(pClienteId INT)
BEGIN
	SELECT * FROM texto
    WHERE cliente_idcliente=pClienteId;
END$$
DELIMITER ;

-- CALL `texto_CountByClient`(1); 
DROP PROCEDURE IF EXISTS `texto_CountByClient`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_CountByClient`(pClienteId INT)
BEGIN
	SELECT count(1) total
    FROM texto
    WHERE cliente_id=pClienteId;
END$$
DELIMITER ;

-- CALL `texto_CountTextoToProcessByClient`(1); 
DROP PROCEDURE IF EXISTS `texto_CountTextoToProcessByClient`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_CountTextoToProcessByClient`(pClienteId INT)
BEGIN
	select count(1) Total
	from texto
	where fecha_proceso is null
    and cliente_id=pClienteId; 
END$$
DELIMITER ;


-- ---------------------------------------------------------------------
-- REPORTE POR:  
-- category,category_sub,field_name
-- ---------------------------------------------------------------------
-- CALL `texto_CountByClientCategory`(1); 

DROP PROCEDURE IF EXISTS `texto_CountByClientCategory`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_CountByClientCategory`(pClienteId INT)
BEGIN
	select source_category,count(1) Total
    from texto
	where cliente_id=pClienteId
	group by source_category;
END$$
DELIMITER ;

-- -------------------
--  Field Name    
-- -------------------

-- CALL `texto_GetAllClientFieldName`(1); 
DROP PROCEDURE IF EXISTS `texto_GetAllClientFieldName`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_GetAllClientFieldName`(pClienteId INT)
BEGIN
	select source_field_name
    from texto
	where cliente_id=pClienteId
	group by source_field_name;
END$$
DELIMITER ; 

-- CALL `texto_CountByClientFieldName`(1,'infobae'); 
DROP PROCEDURE IF EXISTS `texto_CountByClientFieldName`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_CountByClientFieldName`(pClienteId INT,pCategory varchar(128))
BEGIN
	select source_category,source_field_name,count(1) Total
    from texto
	where cliente_id=pClienteId
    and source_category=ifnull(pCategory,source_category)
	group by source_category,source_field_name;
END$$
DELIMITER ;



-- CALL `texto_CountByClientSubCategory`(1,'Infobae'); 
DROP PROCEDURE IF EXISTS `texto_CountByClientSubCategory`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_CountByClientSubCategory`(pClienteId INT,pCategory varchar(128))
BEGIN
	select source_category,source_category_sub,count(1) Total
    from texto
	where cliente_id=pClienteId
    and source_category=ifnull(pCategory,source_category)
	group by source_category,source_category_sub
    order by source_category,count(1) desc;
END$$
DELIMITER ;



-- CALL `texto_CountByClientCategorySubFieldName`(1,null); 
DROP PROCEDURE IF EXISTS `texto_CountByClientCategorySubFieldName`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_CountByClientCategorySubFieldName`(pClienteId INT,pCategory varchar(128))
BEGIN
	select source_category,source_category_sub,source_field_name,count(1) Total
    from texto
	where cliente_id=pClienteId
    and source_category=ifnull(pCategory,source_category)
	group by source_category,source_category_sub,source_field_name
    order by source_category,count(1) desc;
END$$
DELIMITER ;

-- --------------------------------------------------------------------------
-- FIN 1
-- --------------------------------------------------------------------------

-- CALL `texto_GetByClientCategory`(1); 
DROP PROCEDURE IF EXISTS `texto_GetByClientCategory`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_GetByClientCategory`(pClienteId INT)
BEGIN
	select source_category
    from texto
	where cliente_id=pClienteId
	group by source_category;
END$$
DELIMITER ;


-- CALL `texto_GetByClientSubCategory`(1,'infobae'); 
DROP PROCEDURE IF EXISTS `texto_GetByClientSubCategory`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_GetByClientSubCategory`(pClienteId INT,pCategory varchar(128))
BEGIN
	select source_category,source_category_sub
    from texto
	where cliente_id=pClienteId
    and source_category=ifnull(pCategory,source_category )
	group by source_category,source_category_sub;
END$$
DELIMITER ;
 

-- CALL `texto_GetClientCategorySubFieldName`(1,'infobae'); 
DROP PROCEDURE IF EXISTS `texto_GetClientCategorySubFieldName`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_GetClientCategorySubFieldName`(pClienteId INT,pCategory varchar(128))
BEGIN
	select source_category,source_category_sub,source_field_name
    from texto
	where cliente_id=pClienteId
    and source_category=ifnull(pCategory,source_category )
	group by source_category,source_category_sub,source_field_name
    order by source_category;
END$$
DELIMITER ;

-- --------------------------------------------------------------------------
-- FIN 2
-- --------------------------------------------------------------------------


-- -------------------------------------------------------------------------------------
-- call `texto_countByClientDay`(1)
DROP PROCEDURE IF EXISTS `texto_countByClientDay`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_countByClientDay`(pClienteId INT)
BEGIN
	SELECT DATE(source_date) source_date,count(1) Total
    FROM texto
    WHERE cliente_id=pClienteId
    group by DATE(source_date)
    ORDER BY DATE(source_date) desc;
END$$
DELIMITER ;


-- call `texto_countByClientCategoryDay`(1,null,'2015-10-15')
DROP PROCEDURE IF EXISTS `texto_countByClientCategoryDay`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_countByClientCategoryDay`(pClienteId INT,pSource_category varchar(128),pDate datetime )
BEGIN

	SELECT  DATE(source_date) source_date,source_category,count(1) Total
    FROM texto
    WHERE cliente_id=pClienteId
		and source_category=ifnull(pSource_category,source_category )
          and substr(source_date,1,10) =ifnull(substr(pDate,1,10),substr(source_date,1,10))
    group by DATE(source_date),source_category
    ORDER by DATE(source_date) desc,count(1) desc;
END$$
DELIMITER ;
 

-- call `texto_countByClientCategorySubDay`(1,null,'2015-11-29')
DROP PROCEDURE  IF EXISTS `texto_countByClientCategorySubDay`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_countByClientCategorySubDay`(pClienteId INT,pSource_category varchar(128),pDate datetime )
BEGIN

	SELECT  DATE(source_date) source_date,source_category,source_category_sub,count(1) Total
    FROM texto
    WHERE cliente_id=pClienteId
		and source_category=ifnull(pSource_category,source_category )
          and substr(source_date,1,10) =ifnull(substr(pDate,1,10),substr(source_date,1,10))
    group by DATE(source_date),source_category,source_category_sub
    ORDER by DATE(source_date) desc,source_category,count(1) desc;
END$$
DELIMITER ;
 
 
-- call `texto_countByClientYearMonth`(1,'Infobae',null,2015)
DROP PROCEDURE IF EXISTS `texto_countByClientYearMonth`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_countByClientYearMonth`(pClienteId INT,pSource_category varchar(128), pSource_field_name varchar(128),pYear int)
BEGIN
	SELECT source_category,source_field_name,year(source_date),month(source_date),count(1) Total
    FROM texto
    WHERE cliente_id=pClienteId
        and source_category=ifnull(pSource_category,source_category )
		and source_field_name =ifnull(pSource_field_name,source_field_name ) 
        and year(source_date)=ifnull(pYear,year(source_date))
    group by source_category,year(source_date),month(source_date)
    ORDER BY source_category,DATE(source_date) desc;
END$$
DELIMITER ;


-- call `texto_countByClientCategoriaSubYearMonth`(1,'Infobae',2015,11)
DROP PROCEDURE IF EXISTS `texto_countByClientCategoriaSubYearMonth`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_countByClientCategoriaSubYearMonth`(pClienteId INT,pSource_category varchar(128), pYear int,pMonth int)
BEGIN
	SELECT source_category,source_category_sub,year(source_date),month(source_date),count(1) Total
    FROM texto
    WHERE cliente_id=pClienteId
        and source_category=ifnull(pSource_category,source_category )
        and year(source_date)=ifnull(pYear,year(source_date))
        and month(source_date)=ifnull(pMonth ,month(source_date))
    group by source_category,source_category_sub,year(source_date),month(source_date)
    ORDER BY source_category,DATE(source_date) desc;
END$$
DELIMITER ;


-- call `texto_countByClientCategoriaSubFieldYearMonth`(1,'Infobae','titulo',2015,11)
DROP PROCEDURE IF EXISTS `texto_countByClientCategoriaSubFieldYearMonth`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_countByClientCategoriaSubFieldYearMonth`(pClienteId INT,pSource_category varchar(128), pSource_field_name varchar(128),pYear int,pMonth int)
BEGIN
	SELECT source_category,source_category_sub,source_field_name,year(source_date),month(source_date),count(1) Total
    FROM texto
    WHERE cliente_id=pClienteId
        and source_category=ifnull(pSource_category,source_category )
		and source_field_name =ifnull(pSource_field_name,source_field_name ) 
        and year(source_date)=ifnull(pYear,year(source_date))
        and month(source_date)=ifnull(pMonth ,month(source_date))
    group by source_category,source_category_sub,source_field_name,year(source_date),month(source_date)
    ORDER BY source_category,count(1)  desc;
END$$
DELIMITER ;



-- call `texto_GetByClientSourceDate`(1,'Infobae','copete','2015-10-15')
DROP PROCEDURE IF EXISTS `texto_GetByClientSourceDate`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_GetByClientSourceDate`(pClienteId INT,pSource_category varchar(128),pSource_field_name varchar(128),pDate datetime)
BEGIN
	SELECT *
    FROM texto
    WHERE cliente_id=pClienteId 
		and source_category=ifnull(pSource_category,source_category )
        and source_field_name =ifnull(pSource_field_name,source_field_name ) 
        and substr(source_date,1,10) =ifnull(substr(pDate,1,10),substr(source_date,1,10))
    ORDER BY source_category,source_category_sub;    
END$$
DELIMITER ;

-- ---------------------------------------------
-- ADMINISTRADOR
-- ---------------------------------------------

-- call `clientes_GetAll`()
DROP PROCEDURE IF EXISTS `clientes_GetAll`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientes_GetAll`()
BEGIN
	select * from cliente;
END$$
DELIMITER ;

-- call `clientes_GetByCodigo`('NOTICIAS')
DROP PROCEDURE IF EXISTS `clientes_GetByCodigo`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `clientes_GetByCodigo`(pCodigo varchar(25))
BEGIN
	select * from cliente
	where codigo=pCodigo;
END$$
DELIMITER ;

-- -----------------------------
-- STOP WORDS
-- -----------------------------

-- call `texto_palabras_GetByClientFieldName`(1,'infobae','Política','titulo','2015-10-02')
DROP PROCEDURE IF EXISTS `texto_palabras_GetByClientFieldName`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_palabras_GetByClientFieldName`(pClienteId INT,pSource_category varchar(128),pCategory_sub varchar(128),pSource_field_name varchar(128),pDate datetime)
BEGIN
 
	select  b.cliente_id, b.source_id, b.source_category,b.source_category_sub, b.source_field_name,b.source_date,a.id,a.texto_id,a.palabra_id,a.orden,a.repeticiones,c.palabra 
	from texto_palabras a
		inner join texto b
			on a.texto_id=b.id	
			inner join palabra c
				on a.palabra_id=c.id
	where b.cliente_id=pClienteId 
    and source_category=ifnull(pSource_category,source_category )
		and source_category_sub=ifnull(pCategory_sub,source_category_sub )
		and source_field_name =ifnull(pSource_field_name,source_field_name ) 
        and substr(source_date,1,10) =ifnull(substr(pDate,1,10) ,substr(source_date,1,10) )  
	order by a.texto_id,a.orden;
END$$
DELIMITER ;


-- call `texto_palabras_GetByClientIdTexto`(1,1,'copete');
DROP PROCEDURE IF EXISTS `texto_palabras_GetByClientIdTexto`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `texto_palabras_GetByClientIdTexto`(pClienteId INT,pSourceId INT,pField_name varchar(128))
BEGIN
    -- Procedure para buscar resultado del proceso de stopwords por el id correpondiente al al origen de datos
	select b.cliente_id, b.source_id, b.source_field_name,b.source_date,a.id,a.texto_id,a.palabra_id,a.orden,a.repeticiones,c.palabra 
	from texto_palabras a
		inner join texto b
			on a.texto_id=b.id	
			inner join palabra c
				on a.palabra_id=c.id
	where b.cliente_id=pClienteId 
		and b.source_id=pSourceId
        and source_field_name =ifnull(pField_name,source_field_name ) 
	order by a.texto_id,a.orden;
    
END$$
DELIMITER ;


-- call `palabras_countByClient`(1);
DROP PROCEDURE IF EXISTS `palabras_countByClient`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_countByClient`(pClienteId INT)
BEGIN
	select count(1) total
	from texto_palabras a
			 inner join texto b
				 on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId;
END$$
DELIMITER ; 


-- call `palabras_CountAll`(1);
DROP PROCEDURE IF EXISTS `palabras_CountAll`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_CountAll`(pClienteId INT)
BEGIN
	select c.palabra,count(1)
	from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId
		group by c.palabra
		order by count(1) desc;
END$$
DELIMITER ;

-- call `palabras_CountAllByCategory`(1,'Clarin','2015-11-29',-1);
DROP PROCEDURE IF EXISTS `palabras_CountAllByCategory`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_CountAllByCategory`(pClienteId INT,pSource_category varchar(128),pDate datetime,pLimit INT )
BEGIN
-- ,pSource_category varchar(128),pCategory_sub varchar(128),pSource_field_name varchar(128),pDate datetime)
	select  b.source_category,c.palabra,count(1)
	from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId
        and b.source_category=ifnull(pSource_category,b.source_category )
        and substr(source_date,1,10) =ifnull(substr(pDate,1,10) ,substr(source_date,1,10) )  
		group by b.source_category,c.palabra
		order by b.source_category,count(1) desc
        limit pLimit;
END$$
DELIMITER ;

-- call `palabras_CountAllByCategorySub`(1,'la nacion','Politica','2015-11-29',-1);
DROP PROCEDURE IF EXISTS `palabras_CountAllByCategorySub`;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_CountAllByCategorySub`(pClienteId INT,pSource_category varchar(128),pCategory_sub varchar(128),pDate datetime,pLimit INT )
BEGIN
-- pCategory_sub varchar(128),pSource_field_name varchar(128),pDate datetime)
	select  b.source_category,b.source_category_sub,c.palabra,count(1)
	from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
	where b.cliente_id=pClienteId
        and b.source_category=ifnull(pSource_category,b.source_category )
        and source_category_sub=ifnull(pCategory_sub,source_category_sub )
        and substr(source_date,1,10) =ifnull(substr(pDate,1,10) ,substr(source_date,1,10) )  
		group by b.source_category,b.source_category_sub,c.palabra
		order by b.source_category,b.source_category_sub,count(1) desc
        limit pLimit;
END$$
DELIMITER ;

-- call `palabras_Search`('cristina');
DROP PROCEDURE IF EXISTS `palabras_Search`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_Search`(pPalabra varchar(250))
BEGIN
	select * 
    from palabra
    WHERE palabra LIKE CONCAT(pPalabra ,'%');
END$$
DELIMITER ;


-- call `palabras_GetAll`();
DROP PROCEDURE IF EXISTS `palabras_GetAll`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_GetAll`()
BEGIN
	select * 
    from palabra
    order by palabra;
END$$
DELIMITER ;

-- call `palabras_GetSummary`(1,'copete');
DROP PROCEDURE IF EXISTS `palabras_GetSummary`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_GetSummary`(pClienteId INT,pSource_field_name varchar(128))
BEGIN
		select c.palabra ,count(a.palabra_id)
		from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId 
			and b.source_field_name=pSource_field_name
		group by  c.palabra  
		order by count(a.palabra_id) desc;
END$$
DELIMITER ;

-- call `palabras_GetSummaryByDay`(1,'copete','2015-11-14');
DROP PROCEDURE IF EXISTS `palabras_GetSummaryByDay`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_GetSummaryByDay`(pClienteId INT,pSource_field_name varchar(128),pDate datetime)
BEGIN
		select year(b.source_date) year,week(b.source_date) week, substr(b.source_date,1,10) ,c.palabra ,count(a.palabra_id) total
	from texto_palabras a
		inner join texto b
			on a.texto_id=b.id	
			inner join palabra c
				on a.palabra_id=c.id
	where b.cliente_id=pClienteId
        and b.source_field_name=ifnull(pSource_field_name,  b.source_field_name)
        and substr(source_date,1,10) =ifnull(substr(pDate,1,10) ,substr(source_date,1,10) )  
    group by year(b.source_date) ,week(b.source_date),b.source_date, c.palabra  
	order by year(b.source_date) ,week(b.source_date) desc, substr(b.source_date,1,10)  desc,count(a.palabra_id) desc;
END$$
DELIMITER ;

 
-- call `palabras_GetSummaryByWeek`(1,'titulo','2015-11-25');
DROP PROCEDURE IF EXISTS `palabras_GetSummaryByWeek`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_GetSummaryByWeek`(pClienteId INT,pSource_field_name varchar(128),pDate datetime)
BEGIN
	-- By week    
	select year(b.source_date) year,week(b.source_date) week,c.palabra ,count(a.palabra_id) total
		from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId
			and b.source_field_name=pSource_field_name
            and year(b.source_date)=ifnull(year(pDate),  year(b.source_date))
            and week(b.source_date)=ifnull(week(pDate),  week(b.source_date))
		group by year(b.source_date),week(b.source_date)  ,c.palabra  
		order by year(b.source_date),week(b.source_date) desc, count(a.palabra_id) desc,year(b.source_date) ;
END$$
DELIMITER ;

 
-- call `palabras_GetSummaryByMonth`(1,'titulo',null);
DROP PROCEDURE IF EXISTS `palabras_GetSummaryByMonth`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_GetSummaryByMonth`(pClienteId INT,pSource_field_name varchar(128),pDate datetime)
BEGIN
	-- By month
	select year(b.source_date),month(b.source_date),b.source_field_name,c.palabra ,count(a.palabra_id)
		from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId
			and b.source_field_name=pSource_field_name
            and year(b.source_date)=ifnull(year(pDate),  year(b.source_date))
            and  month(b.source_date)=ifnull(month(pDate),  month(b.source_date)) 
		group by year(b.source_date),month(b.source_date),b.source_field_name,c.palabra  
		order by year(b.source_date) desc,month(b.source_date) desc,count(a.palabra_id) desc,c.palabra  ;
END$$
DELIMITER ;


-- call `palabras_GetSummaryByYear`(1,'copete','2015-12-25');
DROP PROCEDURE IF EXISTS `palabras_GetSummaryByYear`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `palabras_GetSummaryByYear`(pClienteId INT,pSource_field_name varchar(128),pDate datetime)
BEGIN
	select year(b.source_date),c.palabra ,count(a.palabra_id)
		from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=pClienteId
			and b.source_field_name=pSource_field_name
            and year(b.source_date)=ifnull(year(pDate),  year(b.source_date))
		group by year(b.source_date),c.palabra  
		order by year(b.source_date),count(a.palabra_id) desc;  
END$$
DELIMITER ;	
 
-- ---------------------------------------------- 
-- Procedures del proceso de STOP WORDS
-- ----------------------------------------------


-- CALL `insert_texto_palabras`('debe45684rá');
DROP PROCEDURE `textoPalabrasInsert`;
DELIMITER $$
CREATE  DEFINER=`root`@`localhost` PROCEDURE `textoPalabrasInsert`(pTextoId int,pPalabra varchar(250),pRepeticiones int,pOrden int,pCreadoPor varchar(128))
BEGIN
	DECLARE palabra_id int;
	select id into palabra_id from palabra
	where palabra=pPalabra;
    
    IF palabra_id IS NULL THEN 
        INSERT INTO palabra (palabra,creado_por)
			values(pPalabra,user());
        
        SELECT LAST_INSERT_ID() INTO palabra_id;
    END IF;
    INSERT INTO texto_palabras(texto_id,palabra_id,repeticiones,orden,creado_por)
		VALUES(pTextoId,palabra_id,pRepeticiones,pOrden,pCreadoPor);
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS `textoSetFechaProceso`;
DELIMITER $$
CREATE  DEFINER=`root`@`localhost` PROCEDURE `textoSetFechaProceso`(pTextoId int)
BEGIN
	UPDATE texto
    SET fecha_proceso=now()
    WHERE id=pTextoId;
END$$
DELIMITER ;

 

/*
Tabla Texto:
	
    Se cargan los textos del cliente. El sistema generara reportes de los datos del cliente 
    segun los siguientes campos
    
	source_category
	source_category_sub
	source_field_name
	source_date
    
    Para permitir identificar el origen de los datos se podran cargar categorias y sub categorias
    
    EJ: source_category: 		Diario	(Diario1, diario2, diario..)
		source_category_sub: 	Politica (seccion1, seccion2,seccion...)
        source_field_name: 		Titulo	(Texto a procear)
        source_date: 			Fecha de la noticia (Fecha del texto)
        
	
    REPORTES
    
    a. Segun la cantidad de registros del cliente (Fecha Proceso - CLIENTE)
    
		- Cantidad total de registros procesados por:
			
			  i. Dia
			 ii. Semana
			iii. Mes
			 iv. Año
		
        - Registros pendientes de procesar
        
        
    b. Resultado del stopword (Por CLIENTE)
    
		filtrar por:	 Todos,Dia,Semana,Mes,Año  (Fecha texto)
        field_name	
        categoria
        categoria sub
        
        
			 i. total de palabras cargadas por cliente
            ii. Top 10 palabras mas utilizadas por cliente
           iii. Top 20 
		    iv. Top 50 
             v. Top 100
            vi. Top 250

*/
 
/*
CALL `noticiasGetById`(7467);

CALL `texto_CountByClient`(1); 
CALL `texto_CountTextoToProcessByClient`(1); 
CALL `texto_GetByClientCategory`(1);  
CALL `texto_CountByClientCategory`(1); 
CALL `texto_GetByClientSubCategory`(1,'infobae'); 
CALL `texto_GetClientCategorySubFieldName`(1,'infobae');   

CALL `texto_GetAllClientFieldName`(1);
CALL `texto_CountByClientFieldName`(1,'infobae'); 
CALL `texto_CountByClientSubCategory`(1,'Infobae'); 
CALL `texto_CountByClientCategorySubFieldName`(1,'Infobae');  -- Falta el filtro por field name
CALL `texto_GetClientCategorySubFieldName`(1,'Infobae'); 


 -- Administrador
call `clientes_GetAll`();
call `clientes_GetByCodigo`('NOTICIAS');

-- STOP WORDS

call `texto_countByClientDay`(1);
call `texto_countByClientCategoryDay`(1,null,null);
call `texto_countByClientCategorySubDay`(1,'Infobae','2015-12-03');
call `texto_countByClientYearMonth`(1,'Infobae','titulo',2015);
call `texto_countByClientCategoriaSubYearMonth`(1,'Infobae',2015,11);
call `texto_countByClientCategoriaSubFieldYearMonth`(1,'clarin','titulo',2015,11);
call `texto_GetByClientSourceDate`(1,null,'titulo','2015-12-01');

call `texto_palabras_GetByClientFieldName`(1,'infobae','Política','titulo','2015-10-02');
call `texto_palabras_GetByClientIdTexto`(1,1,'copete');


call `palabras_countByClient`(1);
call `palabras_CountAll`(1);
call `palabras_CountAllByCategory`(1,'Clarin','2015-11-29',-1);
call `palabras_CountAllByCategorySub`(1,'Clarin','Deportes','2015-11-29',-1);

call `palabras_GetAll`();
call `palabras_Search`('test');


call `palabras_GetSummary`(1,'copete');
call `palabras_GetSummaryByDay`(1,'titulo','2015-01-02');
call `palabras_GetSummaryByWeek`(1,'titulo','2015-01-25');
call `palabras_GetSummaryByMonth`(1,'titulo','2015-11-25');
call `palabras_GetSummaryByYear`(1,'copete','2015-11-25');

*/


-- Actualiza registros para poder reprocesarlos
-- CALL `test_reset_tables`();
-- CALL `test_init_reprocess`();
-- CALL `data_mining`.`test_init_reprocess`()

-- ------------------------------------------ 
-- NOTICIAS POR PALABRA
-- ------------------------------------------

/*
select *
from  palabra
where id=50703

select *
from  texto
where fecha_creacion>'2015-12-31 00:00:00'
and id=74150
limit 10000;

select * 
from texto_palabras
where fecha_creacion>'2015-12-29 22:08:28'
limit 10;

select * from data_mining.noticias
where idNoticia in(
select b.source_id
		from texto_palabras a
			inner join texto b
				on a.texto_id=b.id	
				inner join palabra c
					on a.palabra_id=c.id
		where b.cliente_id=1
			and b.source_field_name='titulo'
			and  year(b.source_date)=year(now())
            and c.palabra='parís'
			order by year(b.source_date));  
            

-- 90 rows
select a.id,a.texto_id,a.orden, b.palabra ,count(b.palabra_id)
from texto_palabras a
	inner join palabra b
		on a.palabra_id=b.id
    inner join texto c
		on c.id =a.texto_id    
WHERE a.fecha_creacion>='2015-11-14'
	and c.source_field_name='copete'
group by b.palabra
order by count(b.palabra_id) desc;  


select c.source_id,c.texto,a.*
from texto_palabras a
	inner join palabra b
		on a.palabra_id=b.id
      inner join texto c
		on c.id =a.texto_id
WHERE b.palabra='maca';


-- Borrar datos de la tabla: texto y texto_palabras

DELETE a.* -- 14709
from texto_palabras a
      inner join texto c
		on c.id =a.texto_id
WHERE c.source_field_name ='copete';

DELETE c.* -- 2204
from texto c
WHERE c.source_field_name='copete';
 
 */