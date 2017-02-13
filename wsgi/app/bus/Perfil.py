import sys
from  app.data import PerfilData

class PerfilBus():
    perfil = PerfilData()
    def getAll(self):
        return self.perfil.getAll()
    def getById(self,id):
        return self.perfil.getById(id)
    def delete(self,id):
        return self.perfil.delete(id)  
    def insert(self,item):
        return self.perfil.insert(item)
    def update(self,item):
        return self.perfil.update(item)    
