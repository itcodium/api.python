import sys
from  app.data import UsuarioBusData

class UsuarioBusBus():
    usuariobus = UsuarioBusData()
    def __init__(self):
        print('usuariobus')
    def getAll(self):
        return self.usuariobus.getAll()
    def getById(self,id):
        return self.usuariobus.getById(id)
    def delete(self,id):
        return self.usuariobus.delete(id)  
    def insert(self,item):
        return self.usuariobus.insert(item)
    def update(self,item):
        return self.usuariobus.update(item)    
