import os
from flask import Flask
from flask import jsonify 
from flask_restful import Api
from flask_json import FlaskJSON
from flask_cors import CORS, cross_origin


from api import Link
from api import LinkList


 
app = Flask(__name__, static_url_path='')
app.debug = False
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
 
api.add_resource(LinkList, '/api/link')
api.add_resource(Link, '/api/link/<id>')
 

if __name__ == "__main__":
    app.run()