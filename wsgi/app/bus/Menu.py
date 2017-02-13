import sys
from  app.data import MenuData

class MenuBus():
    menu = MenuData()
    def getAll(self,vlang):
        return self.menu.getAll(vlang)
    def  getNodesDepth(self,vlang):
        return self.menu.getNodesDepth(vlang)        
    def addNodeSameLevel(self,item):
    	return self.menu.addNodeSameLevel(item)        
    def addNodeChild(self,item):
    	return self.menu.addNodeChild(item)
    def updateNode(self,item):
        return self.menu.updateNode(item)
    def deleteNodeMoveChild(self,id_menu):
    	return self.menu.deleteNodeMoveChild(id_menu)        
    def deleteNode(self,id_menu):
    	return self.menu.deleteNode(id_menu)

