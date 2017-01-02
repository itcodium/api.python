import sys
from  ${Package}.data import ${ClassName}Data

class ${ClassName}Bus():
    ${NameLower} = ${ClassName}Data()
    def __init__(self):
        print('${NameLower}')
    def getAll(self):
        return self.${NameLower}.getAll()
    def getById(self,id):
        return self.${NameLower}.getById(id)
    def delete(self,id):
        return self.${NameLower}.delete(id)  
    def insert(self,item):
        return self.${NameLower}.insert(item)
    def update(self,item):
        return self.${NameLower}.update(item)    