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

resource_fields = {
    'id':fields.Integer,
    'nombre':fields.String,
    'apellido':fields.String,
    'usuario':fields.String,
    'habilitado':fields.Integer,
    'creado_por':fields.String,
    'modificado_por':fields.String,
}

from app.common import UsuarioItem
from app.bus import UsuarioBus
from app.bus import ErrorBus

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok


usuario=UsuarioBus()
item=UsuarioItem()
error=ErrorBus()

class UsuarioList(Resource,CustomException):
    def get(self):
        try:
            data= usuario.getAll()
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        try:
            
            item.nombre=request.form['nombre']
            item.apellido=request.form['apellido']
            item.usuario=request.form['usuario']
            item.habilitado=request.form['habilitado']
            item.creado_por=request.form['creado_por']
            item.modificado_por=request.form['modificado_por']
            item.fecha_creacion=request.form['fecha_creacion']
            item.fecha_modificacion=request.form['fecha_modificacion']

            res=usuario.insert(item)
            message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

class Usuario(Resource,CustomException):
    def get(self, id):
        try:
            data=  usuario.getById(id) 
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def delete(self, id):
        try:
            res=usuario.delete(id)
            message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def put(self,id):
        try:
            
            item.id=request.form['id']
            item.nombre=request.form['nombre']
            item.apellido=request.form['apellido']
            item.usuario=request.form['usuario']
            item.habilitado=request.form['habilitado']
            item.creado_por=request.form['creado_por']
            item.modificado_por=request.form['modificado_por']
            item.fecha_creacion=request.form['fecha_creacion']
            item.fecha_modificacion=request.form['fecha_modificacion']

            res=usuario.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

