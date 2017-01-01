CREATE SCHEMA `rss_reader` ;


-- DROP PROCEDURE `data_mining`.`test_init_reprocess`;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_mining`.`noticis_reprocess_StopWordsnoticias`()
BEGIN
	UPDATE data_mining.noticias
	SET fecha_analisis_texto=null;
END$$
DELIMITER ;

