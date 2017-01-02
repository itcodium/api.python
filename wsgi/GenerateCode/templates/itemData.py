import sys
import mysql.connector 
from  ${Package}.data import Db

class ${ClassName}Data(Db):
    value = ""
    def setValue(self,value):
        self.value = value
    def getAll(self):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('${NameLower}GetAll')
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
            cursor.callproc('${NameLower}GetById',[value])
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
            cursor.callproc('${NameLower}Insert',[${InsertParams}])
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
            cursor.callproc('${NameLower}Update',[${UpdateParams}])
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
            cursor.callproc('${NameLower}Delete',[value])
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