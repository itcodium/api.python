import mysql.connector 
import os
import sys
from string import Template
from core import DB

class ProcessColumns():
	def getItem(self,columns,endline,tab,separator,prefijo,postfijo,processType):	
		res=""
		TTab=""
		if tab==True:
			TTab='\t'
		for c in columns:	
			cname=str(c["COLUMN_NAME"])
			res+=TTab+prefijo+cname+postfijo+separator
			if processType==True:
				if c["DATA_TYPE"]=="int":
					res+='=0'
				if c["DATA_TYPE"]=="varchar":
					res+='=""'
				if c["DATA_TYPE"]=="datetime":	
					res+='=None'
				if c["DATA_TYPE"]=="timestamp":	
					res+='=None'	
				if c["DATA_TYPE"]=="tinyint":
					res+='=0'

			if endline==True:	
				res+='\n'	

		if separator!="":		
			res=res[:-1]

		return res 

	def getSQLTypeParams(self,columns,prefijo,type):	
		res=""
		for c in columns:	
			cname=str(c["COLUMN_NAME"])
			cname_tile=cname.title()
			ctype=c["DATA_TYPE"]
			clength=str(c["CHARACTER_MAXIMUM_LENGTH"])
			
			if ((c["COLUMN_KEY"]!="PRI") & (type=="INSERT")):
				if ((cname!='fecha_creacion') & (cname!='modificado_por')):
					if (clength=='None') | (clength==None):	
						res=res+'\n\t' + prefijo+cname.title() +' '+ctype+' ,'
					else:	
						res=res+'\n\t' + prefijo+cname.title() +' '+ctype+'('+clength +'),'
			
			if type=="UPDATE":
				if ((cname!='fecha_creacion') & (cname!='creado_por')):
					if (clength=='None') | (clength==None):	
						res=res+'\n\t' + prefijo+cname.title() +' '+ctype+','
					else:
						res=res+'\n\t' + prefijo+cname.title() +' '+ctype+'('+clength +'),'
						
		return  res[:-1]
	def getSQLParams(self,columns,prefijo,type):	
		res=""
		for c in columns:	
			cname=str(c["COLUMN_NAME"])
			if ((c["COLUMN_KEY"]!="PRI") & (type=="INSERT")):
				if ((cname!='fecha_creacion') & (cname!='modificado_por')):
					if prefijo=='':
						res=res+cname+','
					else:	
						res=res+prefijo+cname.title()+','

			if type=="UPDATE":
				if ((cname!='fecha_creacion') & (cname!='creado_por')):
					res=res+cname+','
		return  res[:-1]
	def getSQLUpdate(self,columns,prefijo):	
		res=""
		pk=self.getPk(columns)
		for c in columns:	
			cname=str(c["COLUMN_NAME"])
			if c["COLUMN_KEY"]!="PRI":
				if ((cname!='fecha_creacion') & (cname!='creado_por')):
					res=res+'\n\t\t'+cname+'='+prefijo+cname.title()+','

		res=res[:-1]
		res=res+'\n\t'+"WHERE "+pk+"="+prefijo+pk.title()
		return  res

	def getParams(self,columns,type):	
		res=""
		for c in columns:	
			cname=str(c["COLUMN_NAME"])
			if ((c["COLUMN_KEY"]!="PRI") & (type=="INSERT")):
				if ((cname!='fecha_modificacion') & (cname!='modificado_por')):
					res=res+'a.'+cname+','

			if type=="UPDATE":
				if ((cname!='fecha_creacion') & (cname!='creado_por')):
					res=res+'a.'+cname+','

		return  res[:-1]

	def getPk(self,columns):	
		pk=""
		for c in columns:	
			if c["COLUMN_KEY"]=="PRI":
				pk=c["COLUMN_NAME"]
				break
		return pk  

	def getSelectParams(self,columns):	
		res=""
		for c in columns:	
			res=res+c["COLUMN_NAME"]+','
		return  res[:-1]
	

class ProcessTemplate():
	template=None	
	strTemplate=""
	ClassName=""
	Package=""
	path=""
	processColumns=ProcessColumns()
	schema=""
	def setSchema(self,pSchema):
		self.schema=pSchema
	def getSchema(self):
		return self.schema	
	def setName(self,pName):
		self.ClassName=pName	
	def setPackage(self,pPackage):
		self.Package=pPackage		
	
	def setPath(self,pPath):	
		self.path = pPath
	def setTemplate(self,file):	
		self.template = open(file)
		self.strTemplate=self.template.read()
	def getTemplate(self,tables,columns,postfijo):	
		s = Template(self.strTemplate)
		orig_stdout = sys.stdout
		for table in tables:
			folder=self.path
			if not os.path.exists(folder):
				os.makedirs(folder)
			
			f = open(folder+"\\"+self.ClassName+postfijo+'.py', 'w+')	
			sys.stdout = f	
			s = Template(self.strTemplate)
			print(s.substitute( ClassName=self.ClassName,
								Package=self.Package,
								NameLower=self.ClassName.lower(),
								InsertParams=self.processColumns.getParams(columns,'INSERT'),
								UpdateParams=self.processColumns.getParams(columns,'UPDATE')
				))
			sys.stdout = orig_stdout
			f.close()
	def getItem(self,tables,columns,postfijo):	
		s = Template(self.strTemplate)
		orig_stdout = sys.stdout
		for table in tables:
			folder=self.path
			if not os.path.exists(folder):
				os.makedirs(folder)
			
			f = open(folder+"\\"+self.ClassName+postfijo+'.py', 'w+')	
			sys.stdout = f	
			s = Template(self.strTemplate)
			print(s.substitute( ClassName=self.ClassName,
								Params=self.processColumns.getItem(columns,endline=True,tab=True,separator='',prefijo="",postfijo="",processType=True),
								Columns=self.processColumns.getItem(columns,endline=False,tab=False,separator=',',prefijo='',postfijo=': %s',processType=False),
								ColumnsItems=self.processColumns.getItem(columns,endline=False,tab=False,separator=',',prefijo="self.",postfijo="",processType=False)
				))
			sys.stdout = orig_stdout
			f.close()			
	def getTest(self,tables,columns):	
		s = Template(self.strTemplate)
		orig_stdout = sys.stdout
		for table in tables:
			folder=self.path
			if not os.path.exists(folder):
				os.makedirs(folder)
		 

			f = open(folder+"\\"+self.ClassName.lower()+'.py', 'w+')	
			sys.stdout = f	
			s = Template(self.strTemplate)
			print(s.substitute( Name=table["table_name"].title(),
								ClassName=self.ClassName,
								Package=self.Package,
								Params=self.processColumns.getItem(columns,endline=True,tab=False,separator='',prefijo="item.",postfijo="",processType=True)
				))

			sys.stdout = orig_stdout
			f.close()					
	def getTemplateSQL(self,tables,columns):	
		s = Template(self.strTemplate)
		orig_stdout = sys.stdout
		for table in tables:
			folder=self.path
			if not os.path.exists(folder):
				os.makedirs(folder)
			
			f = open(folder+"\\"+self.ClassName.lower()+'.sql', 'w+')	
			sys.stdout = f	
			s = Template(self.strTemplate)
			print(s.substitute( Schema=self.schema,
								Name=table["table_name"],
								ClassName=self.ClassName,
								NameLower=self.ClassName.lower(),
								SelectColumns=self.processColumns.getSelectParams(columns),
								PK=self.processColumns.getPk(columns),
								InsertParams=self.processColumns.getSQLTypeParams(columns,'p','INSERT'),
								InsertColumns=self.processColumns.getSQLParams(columns,'','INSERT'),
								InsertValues=self.processColumns.getSQLParams(columns,'p','INSERT'),
								UpdateParams=self.processColumns.getSQLTypeParams(columns,'p','UPDATE'),
								UpdateData=self.processColumns.getSQLUpdate(columns,'p'),
				))
			sys.stdout = orig_stdout
			f.close()			

test= DB()
test.setSchema("basic")
test.setTable("usuario")

tables=test.getTables()
columns=test.getColumns()

app_root="C:\\Users\\MYEQ\\Aplicaciones\\api.python\wsgi\\app\\"
test_root="C:\\Users\\MYEQ\\Aplicaciones\\api.python\wsgi\\"

print("Table,Columns",len(tables), len(columns))

template=ProcessTemplate()
template.setPackage("app")
template.setName("Usuario")

template.setPath(app_root+"data")
template.setTemplate("templates\\itemData.py")
template.getTemplate(tables,columns,"Data")



template.setPath(app_root+"bus")
template.setTemplate("templates\\itemBus.py")
template.getTemplate(tables,columns,"Bus")


template.setPath(app_root+"common")
template.setTemplate("templates\\item.py")
template.getItem(tables,columns,"Item")



template.setPath(test_root+"test")
template.setTemplate("templates\\test.py")
template.getTest(tables,columns)



template.setPath(app_root+"scripts")
template.setTemplate("templates\\sql.py")
template.setSchema(test.getSchema())
template.getTemplateSQL(tables,columns)



# C:\Users\MYEQ\rrhh\profilematcher\test\generate
