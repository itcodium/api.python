import os
import sys
import inspect

# Get the current folder, which is the input folder
current_folder = os.path.realpath(
    os.path.abspath(
        os.path.split(
            inspect.getfile(
                inspect.currentframe()
            )
     )[0]
   )
)
folder_parts = current_folder.split(os.sep)
previous_folder = os.sep.join(folder_parts[0:-2])
sys.path.insert(0, current_folder)
sys.path.insert(0, previous_folder)

import json
from flask_restful import Resource,marshal_with, fields ,request, Api
from flask_json import FlaskJSON, JsonError, json_response, as_json
# pip install Flask-JSON

'''
resource_fields = {
   'id_menu':fields.Integer,
    'menu_order':fields.Integer,
    'name':fields.String,    
}
'''


from .CreateMenu import CreateMenu
from app.common import MenuItem
from app.bus import MenuBus
from app.bus import ErrorBus

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok
from .support_jsonp import support_jsonp_data
import hashlib

menuBus=MenuBus()
menuItem=MenuItem()
error=ErrorBus()


class MenuList(Resource,CustomException):
    def get(self):
        try:
            '''
            menuList=[]
            item={ "title":"test",
                    "class":"menu-icon icon-folder",
                    "menu":[]};
            menuList.append(item)
            '''

            #ADD_NODE_SAME_LEVEL
            #ADD_NODE_CHILD
            #DELETE_NODE
            #UPDATE_NODE
            #GET_NODES_DEPTH
            #print("FORM",request.form["OPERATION"])

            nodes=menuBus.getNodesDepth('ES')
            cmenu=CreateMenu()
            cmenu.setData(nodes)
            mnu=cmenu.create(0,None)
            return mnu 
        except  Exception as err:
            return self.showCustomException(err,request.args)
    def post(self):
        try:
            operation=request.form["operation"]
            # OK
            if operation=="ADD_NODE_SAME_LEVEL": 
                menuItem.id_menu=request.form["id_menu"]
                menuItem.node=request.form["node"]
                menuItem.lang=request.form["lang"]
                res=menuBus.addNodeSameLevel(menuItem)        
                message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
                return support_jsonp_ok(request.args,message)

            if operation=="ADD_NODE_CHILD":
                menuItem.id_menu=request.form["id_menu"]
                menuItem.node=request.form["node"]
                menuItem.lang=request.form["lang"]
                res=menuBus.addNodeChild(menuItem)
                message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
                return support_jsonp_ok(request.args,message)

            if operation=="DELETE_NODE":
                id_menu=request.form["id_menu"]
                res=menuBus.deleteNode(id_menu)
                message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
                return support_jsonp_ok(request.args,message)

            if operation=="UPDATE_NODE":
                print(operation);
                menuItem.id_menu=request.form["id_menu"]
                menuItem.node=request.form["node"]
                menuItem.lang=request.form["lang"]
                res=menuBus.updateNode(menuItem)
                message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
                return support_jsonp_ok(request.args,message)
                
            if operation=="GET_NODES_DEPTH":
                nodes=menuBus.getNodesDepth('ES')
                cmenu=CreateMenu()
                cmenu.setData(nodes)
                mnu=cmenu.create(0,None)
                return mnu

        except  Exception as err:
            return self.showCustomException(err,request.args)

'''
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
 '''