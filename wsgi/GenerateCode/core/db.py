import mysql.connector 

class DataBase:
	cnn=None
	environment='development'
	try:
		cnn = mysql.connector.connect(user='root', password='123123',host='127.0.0.1',port='3306',database='basic')
	except mysql.connector.Error as err:
			raise Exception(err.msg)
	except:
		raise Exception(sys.exc_info()[0]) 	

	def getDictionary(self,data):
		result = []
		for recordset in data:
			for x in recordset:
				result.append(dict(zip(recordset.column_names,x)))	
		return result 
