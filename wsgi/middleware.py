 
import json
import datetime
import types
from cgi import parse_qs, escape
from flask import Flask, session,request,redirect,current_app


from flask_restful import Api
from flask_json import FlaskJSON, JsonError, json_response, as_json


from app.bus import ErrorBus
from app.bus import SessionKeysBus
from app.bus import PerfilModuloBus
from app.common import CipherData
from api import support_jsonp_error


class ApiMiddleWare(object):
	authorized=0	
	body=""
	message=""
	isApiLogin=False
	error=ErrorBus()
	def __init__(self, app):
		self.app = app
	def setError(self,value):
		self.message=self.error.getErrorMessage('',value)[0]["ErrorMessage"]
		self.body = '{"message": "'+self.message+'","error_code": "'+value+'","status": "ERROR"}'
		self.authorized=0	
		print("++++ self.message",self.message)
	def setCustomError(self,value):
		print ('* 14 *')		
		self.message=value;
		self.body = '{"message": "'+self.message+'","error_code": "NONE","status": "ERROR"}'
		self.authorized=0		
	def checkSession(self,parameters,environ):
		print ('* 0 *')		
		if len(parameters)==0:
			print ('* 1 *')		
			self.setError('A0002')
		else:
			print ('* 2 *')			
			if parameters.get('uuid')==None or parameters.get('uuid')=="":
				print ('* 3 *')		
				self.setError('A0002')
			else:
				try:
					print ('* 4 *',parameters.get('uuid')[0])		
					luuid=parameters.get('uuid')[0]
					cipher_data=CipherData()
					uuid=cipher_data.decrypt(luuid.encode())
					skey=SessionKeysBus()
					res=skey.getSessionkeysByUUID(uuid) 	
					
					print("#00001")
					if len(res)==0:
						self.setError('A0004')
						return;
 
					print("#00002",res[0]["id_usuario"])

					if len(res)==1:
						if(datetime.datetime.now()>res[0]["expiration"]):
							self.setError('A0003')
							return;

					modulo=environ['PATH_INFO'].upper().replace("/API/","").split("/")
					
					print("#00003",modulo[0])
					'''
					#obtener usuario
						validar perfil-usuario para el modulo llamado	
					'''	
					print("*** Obtener Datos del usuario ***",modulo[0],res[0]["id_usuario"], environ['REQUEST_METHOD'])			
					pm=PerfilModuloBus()
					vModuloUsuario=pm.getByModuloUsuario(modulo[0],res[0]["id_usuario"]);	

					print("Modulo usuario: ",vModuloUsuario);
					if len(vModuloUsuario)==0:
						self.setError('A0005')
						return;
					else:
						if vModuloUsuario[0]["enabled"]==0:
							self.setError('A0005')
							return;

					print("#00004")		
					
				except  Exception as err:
					print(type(err),err) 	
					if str(type(err))=="<class 'TypeError'>":
						self.setCustomError(str(err))
					else:
						try:
							self.setCustomError(err.msg)	
						except  Exception as err:
							self.setCustomError(str(err))
							

				#print ("** Token Expirado", datetime.datetime.now(),res[0]["expiration"])
				#print ("** getSessionkeysByUUID ** LEN",res[0]["id_usuario"], res[0]["expiration"])		

	def __call__(self, environ, start_response):
		parameters = parse_qs(environ.get('QUERY_STRING', ''))
		self.authorized=1
		if ("API" not in environ['PATH_INFO'].upper().split("/") or environ['PATH_INFO'].upper()=='/API/LOGIN'):
			self.authorized=1
			self.body=''
			if environ['PATH_INFO'].upper()=='/API/LOGIN':
				self.isApiLogin=True
		else:
			self.checkSession(parameters,environ)

		if self.authorized==1:
			if self.isApiLogin==True:
				response_headers = [('Access-Control-Allow-Origin' , '*'),('Access-Control-Allow-Methods','POST')]
			
			return self.app(environ, start_response)
			#response_body = response_body.encode('utf-8')
			#response_headers = [('Content-Type', 'application/json'),('Content-Length', str(len(response_body))),('Access-Control-Allow-Origin' , '*'),('Access-Control-Allow-Methods','POST')]
			#start_response('200 OK', response_headers)	    	
			#return [response_body]
		else:
			ee=support_jsonp_error(self.body,parameters)
			print ('* 9 *',ee)		
			response_body =ee
			response_body = response_body.encode('utf-8')
			response_headers = [('Content-Type', 'application/json'),('Content-Length', str(len(response_body))),
			('Access-Control-Allow-Origin' , '*'),
			('Access-Control-Allow-Methods','PUT'),
			('Access-Control-Allow-Methods','DELETE')
			]
			start_response('200 OK', response_headers)	    	
			return [response_body]

			


'''
------------------------------------------
environ
------------------------------------------
{
'SERVER_SOFTWARE': 'Werkzeug/0.11.10', 
'SCRIPT_NAME': '', 
'REQUEST_METHOD': 'GET', 
'PATH_INFO': '/api/cliente', 
'SERVER_PROTOCOL': 'HTTP/1.1', 
'QUERY_STRING': '', 
'CONTENT_LENGTH': '',
'HTTP_USER_AGENT': 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/538.1 (KHTML, likeGecko) PhantomJS/2.1.1 Safari/538.1', 
'HTTP_CONNECTION': 'Keep-Alive', 
'SERVER_NAME': '127.0.0.1', 
'REMOTE_PORT': 4079, 'wsgi.url_scheme': 'http', 
'SERVER_PORT': '5000', 
'HTTP_HOST': '127.0.0.1:5000', 
'HTTP_ACCEPT': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 
'REMOTE_ADDR': '127.0.0.1', 
'HTTP_ACCEPT_LANGUAGE': 'es-ES,en,*', 
'CONTENT_TYPE': '',
'HTTP_ACCEPT_ENCODING': 'gzip, deflate'
'wsgi.multiprocess': False, 
'wsgi.input': <socket._fileobject object at 0x03024D30>, 
'wsgi.multithread': False, 
'wsgi.version': (1, 0), 
'wsgi.run_once': False, 
'wsgi.errors': <open file '<stderr>', mode 'w' at 0x004BD0D0>,
'werkzeug.request': <BaseRequest 'http://127.0.0.1:5000/api/cliente' [GET]>  
'werkzeug.server.shutdown': <function shutdown_server at 0x03024DB0>, 
}

'''