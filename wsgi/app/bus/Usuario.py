import sys
from  app.data import UsuarioData

class UsuarioBus():
    usuario = UsuarioData()
    def getAll(self):
        return self.usuario.getAll()
    def getById(self,id):
        return self.usuario.getById(id)
    def delete(self,id):
        return self.usuario.delete(id)  
    def insert(self,item):
        return self.usuario.insert(item)
    def update(self,item):
        return self.usuario.update(item)    
