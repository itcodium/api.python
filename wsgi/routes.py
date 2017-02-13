import os
from flask import Flask
from flask import jsonify 
from flask_restful import Api
from flask_json import FlaskJSON
from flask_cors import CORS, cross_origin

from middleware import ApiMiddleWare

from api import Login
from api import MenuList
from api import Modulo
from api import ModuloList
from api import Perfil
from api import PerfilList
from api import PerfilModulo
from api import PerfilModuloList
from api import PerfilModuloByPerfil


from api import Usuario
from api import UsuarioList



 
app = Flask(__name__, static_url_path='')
app.debug = True
app.wsgi_app = ApiMiddleWare(app.wsgi_app)
app.config['PROPAGATE_EXCEPTIONS'] = True
CORS(app)
json = FlaskJSON(app)


# then in your view
@app.route('/test', methods=['GET'])
def test():
    list = [
        {'HOST': os.environ["OPENSHIFT_MYSQL_DB_HOST"], 
        'PORT': os.environ["OPENSHIFT_MYSQL_DB_PORT"],
        'PASSWORD': os.environ["OPENSHIFT_MYSQL_DB_PASSWORD"],
        'USERNAME': os.environ["OPENSHIFT_MYSQL_DB_USERNAME"]
        },
        {'param': 'bar', 'val': 10}
    ]


    return jsonify(results=os.environ)

@app.route('/')
def index():
    return app.send_static_file('index.html')



api = Api(app)
 

api.add_resource(Login,                 '/api/login')
api.add_resource(PerfilList,            '/api/perfil')
api.add_resource(Perfil,                '/api/perfil/<id>')
api.add_resource(ModuloList,            '/api/modulo')
api.add_resource(Modulo,                '/api/modulo/<id>')
api.add_resource(PerfilModuloList,      '/api/perfilModulo')
api.add_resource(PerfilModulo,          '/api/perfilModulo/<id>')
api.add_resource(PerfilModuloByPerfil,  '/api/perfilModulo/ByPerfil/<id>')
api.add_resource(UsuarioList,           '/api/usuario')
api.add_resource(Usuario,               '/api/usuario/<id>')
api.add_resource(MenuList,              '/api/menu')
 

if __name__ == "__main__":
    app.run()