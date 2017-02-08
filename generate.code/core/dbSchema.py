import mysql.connector 
from core import DataBase

class DB(DataBase):
	schema=None
	table=None
	def setSchema(self,pSchema):
		self.schema=pSchema
	def getSchema(self):
		return self.schema
	def setTable(self,pTable):
		self.table=pTable	
	def getTables(self):
		query='SELECT table_name FROM INFORMATION_SCHEMA.TABLES ' 
		query=query+' where table_type=\'BASE TABLE\' '
		query=query+' and table_schema=\''+self.schema+'\' '
		if self.table!=None:
			query=query+' and table_name=\''+self.table+'\' '  

		self.cnn.connect()
		cursor = self.cnn.cursor(dictionary=True)
		cursor.execute(query)
		result = cursor.fetchall()
		return result
	def getColumns(self):
		query='SELECT b.table_schema,b.table_name,b.COLUMN_NAME,b.IS_NULLABLE,b.DATA_TYPE,b.CHARACTER_MAXIMUM_LENGTH,b.COLUMN_KEY '
		query=query+'FROM INFORMATION_SCHEMA.TABLES a '
		query=query+'inner join INFORMATION_SCHEMA.COLUMNS b '
		query=query+'	on a.table_name=b.table_name '
		query=query+'    and a.table_schema=b.table_schema '
		query=query+'where a.table_type=\'BASE TABLE\' '
		query=query+'and a.table_schema=\''+self.schema+'\' '
		query=query+'and a.table_name=\''+self.table+'\' '  
		self.cnn.connect()
		cursor = self.cnn.cursor(dictionary=True)
		cursor.execute(query)
		result = cursor.fetchall()
		return result