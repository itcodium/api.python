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

resource_fields = {
    'id_perfil_modulo':fields.Integer,
    'id_perfil':fields.Integer,
    'id_modulo':fields.Integer,
    'enabled':fields.Integer,
    'creado_por':fields.String,
    'modificado_por':fields.String,
}

from app.common import PerfilModuloItem
from app.bus import PerfilModuloBus
from app.bus import ErrorBus

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok


perfilmodulo=PerfilModuloBus()
item=PerfilModuloItem()
error=ErrorBus()

class PerfilModuloList(Resource,CustomException):
    def get(self):
        try:
            data= perfilmodulo.getAll()
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)
    def post(self):
        try:
            item.id_perfil=request.form['id_perfil']
            item.id_modulo=request.form['id_modulo']
            item.creado_por='test'
            if request.form['enabled'].upper() == 'TRUE':
                item.enabled=1
            else:
                item.enabled=0
            
            res=perfilmodulo.insert(item)
            message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)


class PerfilModulo(Resource,CustomException):
    def get(self, id):
        try:
            data= perfilmodulo.getById(id)
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)
    def delete(self, id):
        try:
            res=perfilmodulo.delete(id)
            message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
    def put(self,id):
        try:
            item.id_perfil_modulo=id
            item.id_perfil=request.form['id_perfil']
            item.id_modulo=request.form['id_modulo']
            item.modificado_por='test'
            res=perfilmodulo.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)   
        except  Exception as err:
            return self.showCustomException(err,request.args)

class PerfilModuloByPerfil(Resource,CustomException):
    def get(self, id):
        try:
            data= perfilmodulo.getByIdPerfil(id)
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)