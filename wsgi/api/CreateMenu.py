

class CreateMenu():
    data=None
    lstNode=[]
    length=0
    position=-1
    node=None
    node_equal=None
    ant_depth=None
    list_index=0
    def  setData(self,value):
        self.lstNode=[]
        self.data=value
        self.length=len(self.data)
    def  getNode(self,value):
        return { "title":   value["menu_text"],
                 "depth":   value["depth"],
                 "id_menu": value["id_menu"], 
                 "class":"menu-icon icon-folder",
                 "menu":[]}    
    def create(self,index,pnode):
        if(index<self.length):
            node= self.getNode(self.data[index]) 
            if self.data[index]["depth"]==0:
                self.lstNode.append(node)
                self.node=node
                self.node_equal=None
                return self.create(index+1,node)
            else:
                if(self.data[index]["depth"]>pnode["depth"] ):
                    pnode["menu"].append(node) 
                    print("  A) -> ",node["depth"],node["title"]) # 
                
                if(self.data[index]["depth"]<pnode["depth"] ):
                    self.node["menu"].append(node) 
                    self.node=node #1
                    print("B) -> ",node["depth"],node["title"],self.node["title"]) # 
                
                if(self.data[index]["depth"]==pnode["depth"] ):
                    if(self.node_equal==None):
                        self.node_equal=self.node
                    self.node["menu"].append(node) 
                    print("C) -> SAVE", self.node["title"])
                
                
                return self.create(index+1,node)
        print("000000000000000000000000")
        return self.lstNode
 