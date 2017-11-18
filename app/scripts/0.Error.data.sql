   
  /*
    delete from app_error where value= 'A0002' and lang='ES'
    
    select * from app_error
    select * from app_param;  

  */


-- Insertar Parametros 


  INSERT INTO app_param(param_name,value)
  VALUES('DEFAULT_LANGUAGE','ES');
  
  INSERT INTO app_param(param_name,value)
  VALUES('NO_SE_ENCONTRO_PARAMETRO','');


  insert into app_error(value,lang, message)
  values('A0000','ES','El usuario o contraseña no validos'); 
  
  insert into app_error(value,lang, message)
   values('A0001','ES','No se encontro el parametro @param0');
  
  insert into app_error(value,lang, message)
  values('A0002','ES','No se ha enviado token de validacion.'); 
    
  insert into app_error(value,lang, message)
  values('A0003','ES','El token ha expirado.'); 
  
  insert into app_error(value,lang, message)
  values('A0004','ES','El token no es valido.'); 
  
  insert into app_error(value,lang, message)
  values('A0005','ES','No esta autorizado a acceder al modulo.') ;

  insert into app_error(value,lang, message)
  values('A0006','ES','La operacion se realizo correctamente.'); 
  
  insert into app_error(value,lang, message)
   values('A0007','ES','Se borraron @param0 registros.');

  insert into app_error(value,lang, message)
   values('A0008','ES','Se modificaron @param0 registros.'); 

  insert into app_error(value,lang, message)
   values('A0009','ES','Se insertaron @param0 registros.');        

  insert into app_error(value,lang, message)
   values('A0010','ES','No se puede borrar el registro dado que tiene datos relacionados..');

  insert into app_error(value,lang, message)
   values('A0011','ES','Ya se ha inicializado el menu, el parametro nodo no puede ser 0 o NULL.');
 
 