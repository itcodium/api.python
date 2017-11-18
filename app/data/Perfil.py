import sys
import mysql.connector 
from  app.data import Db

class PerfilData(Db):
    value = ""
    def setValue(self,value):
        self.value = value
    def getAll(self):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilGetAll')
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
            cursor.callproc('perfilGetById',[value])
            result = self.getDictionary(cursor.stored_results())
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
            cursor.callproc('perfilInsert',[a.perfil,a.vigencia_desde,a.vigencia_hasta,a.creado_por])
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

    def update(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('perfilUpdate',[a.id_perfil,a.perfil,a.vigencia_desde,a.vigencia_hasta,a.modificado_por])
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
            cursor.callproc('perfilDelete',[value])
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
