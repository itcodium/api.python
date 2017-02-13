import sys
from  app.data import ModuloData

class ModuloBus():
    modulo = ModuloData()
    def getAll(self):
        return self.modulo.getAll()
    def getById(self,id):
        return self.modulo.getById(id)
    def delete(self,id):
        return self.modulo.delete(id)  
    def insert(self,item):
        return self.modulo.insert(item)
    def update(self,item):
        return self.modulo.update(item)    
