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

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok

from  app.common import UsuarioItem
from  app.bus import UsuarioBus

resource_fields = {
    'operacion':fields.String,
    'param':fields.String,
    'data':fields.String,
}

 
 
usuario=UsuarioBus()

import threading

def worker():
    print("tets")
    '''
    scrap.obtenerLinks()
    scrap.guardarLinkEnDisco(os.environ["OPENSHIFT_DATA_DIR"],1)
    scrap.guardarLinkEnDisco(os.environ["OPENSHIFT_DATA_DIR"],2)
    scrap.guardarLinkEnDisco(os.environ["OPENSHIFT_DATA_DIR"],3)
    scrap.dataParser()
    '''

def wStopWords():
    print("tets")
    '''
    reader=RssReader() 
    reader.importFeeds();
    reader.stopwordsProcess()
    '''


class LinkList(Resource,CustomException):
    def get(self):
        try:
            
            
            return support_jsonp_custom([
                {"operacion":"OBTENER_LINKS","param":"link/OBTENER_LINKS"},
                {"operacion":"GUARDAR_LINK","param":"link/GUARDAR_LINK?idUrl="},
                {"operacion":"NOTICIAS","param":"link/NOTICIAS"},
                {"operacion":"DATA_PARSER","param":"link/DATA_PARSER"},
                {"operacion":"DOAll","param":"link/DOAll"},
                {"operacion":"RssReader","param":"link/RSS_READER"},
                {"operacion":"CategoryFix","param":"link/CATEGORY_FIX"},
                {"operacion":"Stop words","param":"link/STOPWORDS"},

                
                ]

                ,resource_fields)
            
            #return support_jsonp_custom({"operacion":"test"},resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

  
           

class Link(Resource,CustomException):
    def get(self, id):
        try:
            data= modulo.getAll()
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)    
