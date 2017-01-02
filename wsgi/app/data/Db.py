import os
import mysql.connector


class Db:
	cnn = mysql.connector.connect(  user= os.environ["OPENSHIFT_MYSQL_DB_USERNAME"], 
								password= os.environ["OPENSHIFT_MYSQL_DB_PASSWORD"],
								    host= os.environ["OPENSHIFT_MYSQL_DB_HOST"],
								    port= os.environ["OPENSHIFT_MYSQL_DB_PORT"],
								database= 'Basic')
	def getDictionary(self,data):
		result = []
		for recordset in data:
			for x in recordset:
				result.append(dict(zip(recordset.column_names,x)))	
		return result 