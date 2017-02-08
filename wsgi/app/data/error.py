import sys
import mysql.connector 
from  app.data import Db

class ErrorData(Db):
    value = ""
    def setValue(self,value):
        self.value = value
    def getErrorMessage(self,lang,code):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('getErrorMessage',[lang,code])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result    
    def getAll(self):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('errorGetAll')
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
            cursor.callproc('errorGetById',[value])
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
            cursor.callproc('errorInsert',[a.lang,a.value,a.message,a.fecha_creacion])
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()

    def update(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('errorUpdate',[a.id_error,a.lang,a.value,a.message])
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()            
    def delete(self,value):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('errorDelete',[value])
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()                
