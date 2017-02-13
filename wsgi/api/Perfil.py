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

resource_fields = {
    'id_perfil':fields.Integer,
    'perfil':fields.String,
    'vigencia_desde':fields.DateTime(dt_format='iso8601'),
    'vigencia_hasta':fields.DateTime(dt_format='iso8601'),
    'creado_por':fields.String,
    'modificado_por':fields.String,
}



from app.bus import ErrorBus
from app.common import PerfilItem
from app.bus import PerfilBus


perfil=PerfilBus()
item=PerfilItem()
error=ErrorBus()

 
class PerfilList(Resource,CustomException):
    def get(self):
        try:
            data= perfil.getAll()
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        try:
            
            item.perfil=request.form['perfil']
            item.vigencia_desde=request.form['vigencia_desde']
            item.vigencia_hasta=request.form['vigencia_hasta']
            item.creado_por='test'
            res=perfil.insert(item)
            message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

class Perfil(Resource,CustomException):
    def get(self, id):
        try:
            data= perfil.getById(id)
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)
                
    def delete(self, id):
        try:
            res=perfil.delete(id)
            message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
        
    def put(self,id):
        try:
            print("*** request.form *** ",request.form)
            item.id_perfil=id
            item.perfil=request.form['perfil']
            item.vigencia_desde=request.form['vigencia_desde']
            item.vigencia_hasta=request.form['vigencia_hasta']
            item.modificado_por=request.form['modificado_por']
            
            res=perfil.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)  
        except  Exception as err:
            return self.showCustomException(err,request.args)
        
 
