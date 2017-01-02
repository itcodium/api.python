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

resource_fields = {${Resource}}

from ${Package}.common import ${Name}Item
from ${Package}.bus import ${Name}Bus
from stopwords.bus import ErrorBus

from .customException import CustomException
from .support_jsonp import support_jsonp_custom
from .support_jsonp import support_jsonp_ok


${NameLower}=${Name}Bus()
item=${Name}Item()
error=ErrorBus()

class ${Name}List(Resource,CustomException):
    def get(self):
        try:
            data= ${NameLower}.getAll()
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def post(self):
        try:
            ${Post}
            res=${NameLower}.insert(item)
            message=error.getErrorMessage('','A0009',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

class ${Name}(Resource,CustomException):
    def get(self, id):
        try:
            data=  ${NameLower}.getById(id) 
            return support_jsonp_custom(data,resource_fields)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def delete(self, id):
        try:
            res=${NameLower}.delete(id)
            message=error.getErrorMessage('','A0007',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)

    def put(self,id):
        try:
            ${Put}
            res=${NameLower}.update(item)   
            message=error.getErrorMessage('','A0008',res)[0]["ErrorMessage"]
            return support_jsonp_ok(request.args,message)
        except  Exception as err:
            return self.showCustomException(err,request.args)
