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
import datetime
from flask import jsonify
from time import mktime
from flask_restful import marshal

from functools import wraps
from flask import redirect, request, current_app
 

def support_jsonp(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        callback = request.args.get('callback', False)
        if callback:
            content = str(callback) + '(' + str(f().data) + ')'
            return current_app.response_class(content, mimetype='application/json')
        else:
            return f(*args, **kwargs)
    return decorated_function 

      
def support_jsonp_data(data,rfj):
    res_marshal=marshal(data,rfj)
    json_data=json.dumps(res_marshal, ensure_ascii=False)
    return current_app.response_class( json_data, mimetype='application/json') 

def support_jsonp_custom(data,resource_fields):
    callback = request.args.get('callback', False)
    res_marshal=marshal(data,resource_fields)
    json_data=json.dumps(res_marshal, ensure_ascii=False)
    res=""
    if callback:
        res = str(callback) + '(' + str(json_data) + ')'
    else:
        res = json_data
    return current_app.response_class(json_data, mimetype='application/json') 
    
    

def support_jsonp_error(err,parameters):
    callback =getCallback(parameters)
    res=""

    if callback!=None : 
        json_data=json.dumps(err)
        res =str(callback) + '(' + str(json_data) + ')'
        if str(type(err))=="<Flask 'routes'>":
            return current_app.response_class(res, mimetype='application/json')     
        else:
            if str(type(err))=="<class 'dict'>":
                res =str(callback) + '(' + str(err) + ')'
                return current_app.response_class(res, mimetype='application/json')     
            else:
                res =str(callback) + '(' + err + ')'
            return res 
    else:
        res = json.dumps(err)
        return err


def support_jsonp_ok(parameters,pMessage=None):
    try:
        if pMessage==None:
            message="Error support_jsonp"
        else:
            message=pMessage  
              
        callback =getCallback(parameters)
        res=""
        if callback!=None: 
            res =str(callback) + '(' + '{status:"OK", message:"'+message+'"}'+ ')'
            return current_app.response_class(res, mimetype='application/json')     
        else:
            res ='{"status":"OK", "message":"'+message+'"}'
            return current_app.response_class(res, mimetype='application/json')     
    except  Exception as err:
        return self.showCustomException(err,request.args)    
    

def getCallback(parameters):
    callback=None
    if len(parameters)!=0:
        if str(type(parameters))=="<class 'dict'>":
            callback=parameters.get('callback') 
        else:    
            callback=parameters.getlist('callback', type=None)

        if str(type(callback))=="<class 'list'>" or str(type(callback))=="<type 'list'>":
            if len(callback)==1:
                callback=callback[0]
            else:
                callback=None
    return callback                     

class MyEncoder(json.JSONEncoder):

    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return int(mktime(obj.timetuple()))

        return json.JSONEncoder.default( obj, ensure_ascii=False)



'''
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
import datetime
from flask import jsonify
from time import mktime
from flask_restful import marshal

from functools import wraps
from flask import redirect, request, current_app
 

def support_jsonp(f):
    """Wraps JSONified output for JSONP"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        callback = request.args.get('callback', False)
        if callback:
            content = str(callback) + '(' + str(f().data) + ')'
            return current_app.response_class(content, mimetype='application/json')
        else:
            return f(*args, **kwargs)
    return decorated_function 

      
def support_jsonp_data(data,rfj):
    res_marshal=marshal(data,rfj)
    json_data=json.dumps(res_marshal, ensure_ascii=False)
    return current_app.response_class( json_data, mimetype='application/json') 

def support_jsonp_custom(data,resource_fields):

    callback = request.args.get('callback', False)
    print("***  request.args ***",callback)
    res_marshal=marshal(data,resource_fields)

    json_data=json.dumps(res_marshal, ensure_ascii=False)

    res=""
    if callback:
        res = str(callback) + '(' + str(json_data) + ')'
    else:
        res = json_data
    return current_app.response_class(json_data, mimetype='application/json') 
    
    

def support_jsonp_error(err,parameters):
    callback =getCallback(parameters)
    res=""

    if callback!=None : 
        print("-SJE 1 -")
        json_data=json.dumps(err)
        print("-SJE 2 -")
        res =str(callback) + '(' + str(json_data) + ')'
        print("-SJE 3 -")
        if str(type(err))=="<Flask 'routes'>":
            print("-SJE 4 -")
            return current_app.response_class(res, mimetype='application/json')     
        else:
            print("-SJE 5 -")
            if str(type(err))=="<class 'dict'>":
                print("-SJE 6 -")
                res =str(callback) + '(' + str(err) + ')'
                print("-SJE 7 -")
                return current_app.response_class(res, mimetype='application/json')     
            else:
                print("-SJE 8 -")
                res =str(callback) + '(' + err + ')'
            print("-SJE 9 -")    
            return res 
    else:
        res = json.dumps(err)
        return err


def support_jsonp_ok(parameters,pMessage=None):
    try:
        if pMessage==None:
            message="Error support_jsonp"
        else:
            message=pMessage  
              
        callback =getCallback(parameters)
        res=""
        if callback!=None: 
            res =str(callback) + '(' + '{status:"OK", message:"'+message+'"}'+ ')'
            return current_app.response_class(res, mimetype='application/json')     
        else:
            res ='{"status":"OK", "message":"'+message+'"}'
            return current_app.response_class(res, mimetype='application/json')     
    except  Exception as err:
        return self.showCustomException(err,request.args)    
    

def getCallback(parameters):
    callback=None
    print("#GCALL_0_INIT",parameters.keys()) 
    if len(parameters)!=0:
        print("#GCALL_1",type(parameters)) 
        if str(type(parameters))=="<class 'dict'>":
            callback=parameters.get('callback') 
        else:    
            callback=parameters.getlist('callback', type=None)

        print("#GCALL_1_A") 
        if str(type(callback))=="<class 'list'>" or str(type(callback))=="<type 'list'>":
            print("#GCALL_2") 
            if len(callback)==1:
                print("#GCALL_3") 
                callback=callback[0]
            else:
                print("#GCALL_4") 
                callback=None
    print("#GCALL_5_END - callback->",callback)
    return callback                     

class MyEncoder(json.JSONEncoder):

    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return int(mktime(obj.timetuple()))

        return json.JSONEncoder.default( obj, ensure_ascii=False)

'''