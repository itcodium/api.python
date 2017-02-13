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
    'id_usuario':fields.Integer,
    'usuario':fields.String,
    'nombre':fields.String,
    'apellido':fields.String,
    'email':fields.String,
    'password':fields.String,
    'id_perfil':fields.Integer,
    'creado_por':fields.String,
    'vigencia_desde':fields.DateTime(dt_format='iso8601'),
    'vigencia_hasta':fields.DateTime(dt_format='iso8601'),
    'modificado_por':fields.String,
}

from app.common import UsuarioItem
from app.bus import UsuarioBus
from app.bus import ErrorBus

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok
import hashlib

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
            
            password = request.form['password'] 
            password_md5 = hashlib.md5(password.encode()).hexdigest()

            item.usuario=request.form['usuario']
            item.nombre=request.form['nombre']
            item.apellido=request.form['apellido']
            item.email=request.form['email']
            item.password=password_md5
            item.id_perfil=request.form['id_perfil']
            item.vigencia_desde=request.form['vigencia_desde']
            item.vigencia_hasta=request.form['vigencia_hasta']
            item.creado_por=request.form['creado_por']


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
            password = request.form['password'] 
            password_md5 = hashlib.md5(password.encode()).hexdigest()
            
            item.id_usuario=id
            item.usuario=request.form['usuario']
            item.nombre=request.form['nombre']
            item.apellido=request.form['apellido']
            item.email=request.form['email']
            item.password=password_md5
            item.id_perfil=request.form['id_perfil']
            item.vigencia_desde=request.form['vigencia_desde']
            item.vigencia_hasta=request.form['vigencia_hasta']
            item.modificado_por='test'
            res=usuario.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

