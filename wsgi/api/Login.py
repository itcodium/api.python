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
from .customException import CustomException
from .support_jsonp import support_jsonp_custom


from cgi import parse_qs, escape        

from flask_restful import Resource,marshal_with,marshal, fields ,request, Api
from flask_json import FlaskJSON, JsonError, json_response, as_json

resource_fields = {
    'uuid':fields.String,
    'expiration':fields.DateTime(dt_format='iso8601'),
    'id_usuario':fields.String,
    'usuario':fields.String,
    'nombre':fields.String,
    'apellido':fields.String,
    'email':fields.String,
   'id_perfil':fields.String
}

from app.bus import ErrorBus
from app.common import SessionKeysItem
from app.bus import SessionKeysBus

import hashlib



sessionkeys=SessionKeysBus()
item=SessionKeysItem()
 
class Login(Resource,CustomException):
    def post(self):
        try:
            lang =request.form['lang']
            password =request.form['password']
            password_md5 = hashlib.md5(password.encode()).hexdigest()
            data= sessionkeys.getSessionKeyByUser(request.form['usuario'],password_md5,lang)

            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)
