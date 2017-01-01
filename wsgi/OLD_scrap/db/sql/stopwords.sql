/*
delete from stopwords.texto_palabras;
delete from stopwords.texto;
delete from stopwords.palabra;
update stopwords.texto
SET fecha_proceso=null;

UPDATE data_mining.noticias
SET fecha_analisis_texto=null;

*/
select count(1)
from stopwords.texto
where fecha_proceso is null; 

SET fecha_analisis_texto=null;

-- Buscar clientes

select * from stopwords.cliente
where codigo='NOTICIAS';

-- Buscar Texto de los clientes
select count(1) from stopwords.texto
where source_field_name='copete'
where cliente_id=1
and fecha_creacion>'2015-11-14';

-- Buscar las palabras generadas para el cliente
select b.source_field_name,b.source_id,a.id,a.texto_id,a.palabra_id,a.orden,a.repeticiones,c.palabra 
from stopwords.texto_palabras a
	inner join stopwords.texto b
		on a.texto_id=b.id	
		inner join stopwords.palabra c
			on a.palabra_id=c.id
order by a.texto_id,a.orden;

texto
-- listar palabras
select palabra, length(palabra) 
from stopwords.palabra
-- where palabra='tres'
order by length(palabra);

-- Contar la cantidad total de palabras almacenadas en la tabla
select count(1)
from stopwords.palabra;


-- 90 rows
select a.id,a.texto_id,a.orden, b.palabra ,count(palabra_id)
from stopwords.texto_palabras a
	inner join stopwords.palabra b
		on a.palabra_id=b.id
    inner join stopwords.texto c
		on c.id =a.texto_id    
WHERE a.fecha_creacion>='2015-11-14'
	and c.source_field_name='copete'
group by b.palabra
order by count(palabra_id) desc;  

select c.source_id,c.texto,a.*
from stopwords.texto_palabras a
	inner join stopwords.palabra b
		on a.palabra_id=b.id
      inner join stopwords.texto c
		on c.id =a.texto_id
WHERE b.palabra='maca';



-- Noticias Link
SELECT a.*,b.link 
FROM data_mining.noticias a
	inner join data_mining.link b
on a.idlink=b.idLink    
where idNoticia=6;


-- Borrar palabras

select * from stopwords.texto
where fecha_proceso> '2015-11-15 00:00:00'
and source_field_name='copete';


-- Borrar datos de la tabla: texto y texto_palabras

DELETE a.* -- 14709
from stopwords.texto_palabras a
      inner join stopwords.texto c
		on c.id =a.texto_id
WHERE c.source_field_name ='copete';

DELETE c.* -- 2204
from stopwords.texto c
WHERE c.source_field_name='copete';
 


-- CALL `stopwords`.`insert_texto_palabras`('debe45684rá');
DROP PROCEDURE `stopwords`.`textoPalabrasInsert`

DELIMITER $$
CREATE  DEFINER=`root`@`localhost` PROCEDURE `stopwords`.`textoPalabrasInsert`(pTextoId int,pPalabra varchar(250),pRepeticiones int,pOrden int,pCreadoPor varchar(128))
BEGIN
	DECLARE palabra_id int;
	select id into palabra_id from stopwords.palabra
	where palabra=pPalabra;
    
    IF palabra_id IS NULL THEN 
        INSERT INTO stopwords.palabra (palabra,creado_por)
			values(pPalabra,user());
        
        SELECT LAST_INSERT_ID() INTO palabra_id;
    END IF;
    INSERT INTO texto_palabras(texto_id,palabra_id,repeticiones,orden,creado_por)
		VALUES(pTextoId,palabra_id,pRepeticiones,pOrden,pCreadoPor);
END$$
DELIMITER ;


DROP PROCEDURE `stopwords`.`textoSetFechaProceso`

DELIMITER $$
CREATE  DEFINER=`root`@`localhost` PROCEDURE `stopwords`.`textoSetFechaProceso`(pTextoId int)
BEGIN
	UPDATE stopwords.texto
    SET fecha_proceso=now()
    WHERE id=pTextoId;
END$$
DELIMITER ;



	

 