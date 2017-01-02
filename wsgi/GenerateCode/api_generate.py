import mysql.connector 
import os
import sys
from string import Template
from core import DB

class ProcessColumns():
	def getApiResource(self,columns):	
		res="\n"
		separator=","
		count=len(columns)-1
		for index, c in enumerate(columns):	
			if count==index:	
				separator=""
			if c["DATA_TYPE"]=="int":
				res=res+'    \'' + c["COLUMN_NAME"]+'\':fields.Integer'+separator+'\n' 
			if c["DATA_TYPE"]=="varchar":
				res=res+'    \'' + c["COLUMN_NAME"]+'\':fields.String'+separator+'\n'
			if c["DATA_TYPE"]=="datetime":	
				res=res+'    \'' + c["COLUMN_NAME"]+'\':fields.DateTime(dt_format=\'iso8601\')'+separator+'\n'
			if c["DATA_TYPE"]=="tinyint":
				res=res+'    \'' + c["COLUMN_NAME"]+'\':fields.Integer'+separator+'\n'

		return res
	def getParam(self,name):	
		return '            ' + 'item.'+ name+'=request.form[\''+ name+'\']'+'\n'
	def getApiParams(self,columns,type):	
		res="\n"
		for c in columns:	
			if ((c["COLUMN_KEY"]!="PRI") & (type=="POST")):
				res=res+self.getParam(c["COLUMN_NAME"])

			if type=="PUT":
				res=res+self.getParam(c["COLUMN_NAME"])
		return res
 


class ProcessTemplate():
	template=None	
	schema=""
	ClassName=""
	Package=""
	strTemplate=""
	outPutFolder=""
	processColumns=ProcessColumns()
	def setTemplate(self,file):	
		self.template = open(file)
		self.strTemplate=self.template.read()
	def setOutPutFolder(self,vfolder):	
		self.outPutFolder =vfolder
	def setSchema(self,pSchema):
		self.schema=pSchema
	def getSchema(self):
		return self.schema	
	def setPackage(self,pPackage):
		self.Package=pPackage		
	def setName(self,pName):
		self.ClassName=pName		
	def getTemplate(self,tables,columns):	
		s = Template(self.strTemplate)
		orig_stdout = sys.stdout
		for table in tables:

			if not os.path.exists(self.outPutFolder):
				os.makedirs(self.outPutFolder)
			
			f = open(self.outPutFolder+"\\"+self.ClassName.lower()+'.py', 'w+')	
			sys.stdout = f	
			s = Template(self.strTemplate)
			print(s.substitute( Name=self.ClassName,
								NameLower=self.ClassName.lower(),
								Package=self.Package,
								Resource=self.processColumns.getApiResource(columns),
								Post=self.processColumns.getApiParams(columns,"POST"),
								Put=self.processColumns.getApiParams(columns,"PUT")
				))
			sys.stdout = orig_stdout
			f.close()



test= DB()
test.setSchema("hhrr_profile_matcher")
test.setTable("hr_app_usuario")

tables=test.getTables()
columns=test.getColumns()

template=ProcessTemplate()
template.setName("Usuario")
template.setPackage("stopwords")

template.setOutPutFolder("OutPut\\api")
template.setSchema("stopwords")

template.setTemplate("templates\\api.py")
template.getTemplate(tables,columns)


# C:\Users\MYEQ\rrhh\profilematcher\test\generate
 
 
 