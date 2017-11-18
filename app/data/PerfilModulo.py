import sys
import mysql.connector 
from  app.data import Db

class PerfilModuloData(Db):
    value = ""
    def setValue(self,value):
        self.value = value
    def getAll(self):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilmoduloGetAll')
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def getById(self,value):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilmoduloGetById',[value])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def getByIdPerfil(self,value):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilmoduloGetByIdPerfil',[value])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def getByModuloUsuario(self,modulo,idUsuario):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilmoduloGetByModuloUsuario',[modulo,idUsuario])
            result = self.getDictionary(cursor.stored_results())
            print ("perfilmoduloGetByModuloUsuario",modulo,idUsuario,result)
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result    
        
    def insert(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            print("999999999999999999",a)
            cursor.callproc('perfilmoduloInsert',[a.id_perfil,a.id_modulo,a.enabled,a.creado_por])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            print("222 err.msg",err.msg)
            raise Exception(err.msg)
        except:
            print("222 err.msg",sys.exc_info()[0])
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result[0]["row_count"]    

    def update(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilmoduloUpdate',[a.id_perfil_modulo,a.id_perfil,a.id_modulo,a.modificado_por,a.fecha_modificacion])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result[0]["row_count"]
                        
    def delete(self,value):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilmoduloDelete',[value])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result[0]["row_count"]                    
