import sys
from  app.data import ErrorData

class ErrorBus():
    error = ErrorData()
    def getErrorMessage(self,lang,code,param0=None):
        print("+++ ERRO +++",lang,code,param0);
        if param0==None:
            return self.error.getErrorMessage(lang,code)
        else:    
            msg=self.error.getErrorMessage(lang,code)
            msg[0]["ErrorMessage"]=msg[0]["ErrorMessage"].replace("@param0",str(param0))
            return msg

    def getAll(self):
        return self.error.getAll()
    def getById(self,id):
        return self.error.getById(id)
    def delete(self,id):
        return self.error.delete(id)  
    def insert(self,item):
        return self.error.insert(item)
    def update(self,item):
        return self.error.update(item)    
