
import os
import sys
import mysql.connector

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine

Base = declarative_base()

strCnn='mysql+mysqlconnector://'+os.environ["OPENSHIFT_MYSQL_DB_USERNAME"]+':'+os.environ["OPENSHIFT_MYSQL_DB_PASSWORD"]+'@'+os.environ["OPENSHIFT_MYSQL_DB_HOST"]+':'+os.environ["OPENSHIFT_MYSQL_DB_PORT"]+'/'+'data_mining_go'

class RssReaderDb():
	engine = create_engine(strCnn)
	def getEngine(self):
		return self.engine



class StopwordsDataBase:
	cnn = mysql.connector.connect(  user= os.environ["OPENSHIFT_MYSQL_DB_USERNAME"], 
							password= os.environ["OPENSHIFT_MYSQL_DB_PASSWORD"],
							    host= os.environ["OPENSHIFT_MYSQL_DB_HOST"],
							    port= os.environ["OPENSHIFT_MYSQL_DB_PORT"],
							database= 'data_mining_go')
	def getDictionary(self,data):
		result = []
		for recordset in data:
			for x in recordset:
				result.append(dict(zip(recordset.column_names,x)))	
		return result 