import sys
from  app.data import PerfilModuloData

class PerfilModuloBus():
    perfilmodulo = PerfilModuloData()
    def getAll(self):
        return self.perfilmodulo.getAll()
    def getById(self,id):
        return self.perfilmodulo.getById(id)
    def getByIdPerfil(self,id):
        return self.perfilmodulo.getByIdPerfil(id)    
    def delete(self,id):
        return self.perfilmodulo.delete(id)  
    def insert(self,item):
        return self.perfilmodulo.insert(item)
    def update(self,item):
        return self.perfilmodulo.update(item)    
    def getByModuloUsuario(self,modulo,idUsuario):
        return self.perfilmodulo.getByModuloUsuario(modulo,idUsuario)    