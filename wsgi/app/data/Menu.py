import sys
import mysql.connector 
from  app.data import Db

class MenuData(Db):
    value = ""
    def setValue(self):
        self.value = value
    def getAll(self,vlang):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('menu_List',[vlang])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result

    def getNodesDepth(self,vlang):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('menu_getNodesDepth',[vlang])
            result = self.getDictionary(cursor.stored_results())
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result
    def addNodeSameLevel(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('menu_addNodeSameLevel',[a.id_menu,a.lang,a.node])
            result = self.getDictionary(cursor.stored_results()) 
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        print("*** +++ result +++ ***",result)
        return result[0]["row_count"]
    def addNodeChild(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('menu_addNodeChild',[a.id_menu,a.lang,a.node])
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
    def updateNode(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('menu_updateNode',[a.id_menu,a.lang,a.node])
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
    def deleteNodeMoveChild(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('deleteNodeMoveChild',[a])
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
    def deleteNode(self,a):
        self.cnn.connect()
        cursor = self.cnn.cursor()
        try:
            cursor.callproc('menu_deleteNode',[a])
            result = self.getDictionary(cursor.stored_results()) 
            print ("*** result menu_deleteNode ***",result)
            self.cnn.commit()
        except mysql.connector.Error as err:
            raise Exception(err.msg)
        except:
            raise Exception(sys.exc_info()[0]) 
        finally:
            cursor.close()
            self.cnn.close()
        return result[1]["row_count"]
