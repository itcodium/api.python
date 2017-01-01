import os
import sys
import time
import datetime
from mining.common import  *
from mining.bus import  ModuloBus
from mining.bus import  NoticiasBus
from mining.bus import  LogBus
from mining.bus import  UrlBus
from mining.bus import  LinkBus
from mining.bus import  LogBus
from scrap import  UrlLinkParser
from scrap import  InfobaeDos
from scrap import  Clarin
from scrap import  LaNacion
from urllib.parse import urlparse


'''
from urllib.parse import urlparse
cc=urlparse('http://google.com/mail/')
print(cc.scheme, cc.netloc)
'''

class Scrapping():
	modulo=ModuloBus()
	urlbus	=UrlBus()
	linkbus=LinkBus()
	#dbLink=LinkBus()
	item_modulo=ModuloItem()
	item_url=UrlItem()
	item_link=LinkItem()
	itemByCodi=None
	ulp=UrlLinkParser()
	dbLog=LogBus()
	vLog=LogItem()
	def __init__(self):
		c=0
	def setUrl(self,value):
		self.url = value
	def saveLog(self,idLink,codi,descripcion,user):
		self.vLog.id=idLink
		self.vLog.codi=codi
		self.vLog.descripcion="(id: "+str(idLink) +") "+ descripcion
		self.vLog.user="python"
		self.dbLog.insert(self.vLog)	
	def buscarModulo(self,value):
		self.item_modulo.codi=value
		self.itemByCodi=self.modulo.getByCodi(self.item_modulo.codi)  
		if len(self.itemByCodi)==0 :
			return None
		else :	
			return self.itemByCodi[0]["idModulo"]
	def insertarModulo(self,value):	
		self.urlbus.insert(value)
	def __habilitarUrlParaScraping(self,value,enabled):	
		data=self.urlbus.getByNombre(value)
		if len(data)==0 :
			 raise Exception('No se encontro el registro para el valor: '+value)
		else :	
			idUrl=data[0]["idUrl"]
			self.urlbus.enabledUrl(idUrl,enabled)
	def habilitarUrlParaScraping(self,value):
		self.__habilitarUrlParaScraping(value,1)	
	def deshabilitarUrlParaScraping(self,value):
		self.__habilitarUrlParaScraping(value,0)	
	def obtenerLinks(self):	
		urlsEnabled=self.urlbus.getAllEnabled()
		#print(urlsEnabled)
		for u in urlsEnabled:
			self.ulp.setUrl(u["url"]);
			self.ulp.getUrlData()
			links=self.ulp.getLinks(u)
			for link in links:
				res=self.linkbus.getByLink(link)
				if len(res) == 0 :
					self.item_link.idUrl=u["idUrl"]
					self.item_link.link=link
					self.item_link.user="python"
					self.linkbus.insert(self.item_link)
	def guardarLinkEnDisco(self,appRoot,idurl):
	
		now = datetime.datetime.now()
		dirDate=str(now.year)+str(now.month)

		linksToProcess=self.linkbus.getToProcess(idurl)
		for ltp in linksToProcess:
			directory=appRoot+"/"+ltp["nombre"]+"/"+dirDate
			fileName="/"+str(ltp["idLink"])+".html"
			vUlp=UrlLinkParser()
			
			vUrl=""
			position=ltp["link"].find('http://')
			if(position==-1) :
				vUrl=ltp["url"]+ltp["link"]
			else :	
				vUrl=ltp["link"]
			
			pUrl=urlparse(ltp["url"])
			pLink=urlparse(vUrl)
			

			if(pUrl.netloc== pLink.netloc) :
				#print("--- save ---",vUrl)
				try:
					vUlp.setUrl(vUrl);
					vUlp.getUrlData()
					vUlp.saveToDisk(directory,fileName) 	
					self.linkbus.updateFechaProceso(ltp["idLink"],directory+fileName)	
				except:
					print("guardarLinkEnDisco error:", sys.exc_info()[0])

				time.sleep(3)   
			else :
				self.linkbus.updateFechaProceso(ltp["idLink"],directory+fileName)	
				#print("ELSE",pUrl.netloc,pLink.netloc) 

				
	def dataParser(self):	
		
		filesToParse=self.linkbus.getToParse()
		for ftp in filesToParse:
			#print("IdLink",ftp["idLink"])
			if ftp["idLink"]>0 :
				parser=UrlLinkParser()
				if ftp["nombre"].upper()=="INFOBAE" :
					try:	
						lista=["?noredirect","/diarios","www.facebook.com", "www.arcpublishing.com"]
						urlparts=ftp["link"].split('/')
						filter=False
						for part in lista:
							filter= part in urlparts
							if filter:
								break

						#print(filter," - ",urlparts)

						position1=ftp["link"].find('opinion.infobae.com')
						if (position1!=-1 or filter==True):
							self.linkbus.updateFechaParseo(ftp["idLink"])
							self.saveLog(ftp["idLink"],"OTHER_HOST","(idLink: "+str(ftp["idLink"]) +") la url no es www.infobae.com o no es una noticia","python")
						else:
							try: 		
								#print("PASER",ftp["file_path"])
								if(os.path.isfile(ftp["file_path"])):
									print("PATH", ftp["file_path"])
									fileData=parser.readFileDisk(ftp["file_path"])
									info=InfobaeDos()
									info.setData(fileData,ftp)
									
								else:									
									print("Unexpected error:")
									self.linkbus.updateFechaParseo(ftp["idLink"])
									self.saveLog(ftp["idLink"],"FILE_NOT_EXISTS",str(sys.exc_info()[1]),"python")	
							except:
								print("Unexpected error:", sys.exc_info()[1])

								#self.linkbus.updateFechaParseo(ftp["idLink"])
								#self.saveLog(ftp["idLink"],"READ_FILE",sys.exc_info()[1],"python")	
						
					except:
						print("Error al leer el archivo idLink: ",sys.exc_info()[1],"python")
						self.saveLog(ftp["idLink"],"",sys.exc_info()[1],"python")	
				
				if ftp["nombre"].upper()=="CLARIN" :	
					try:
						#print(ftp["link"])
						position2=ftp["link"].find('clarin.com/estilo/')
						if (position2>-1):
							position1=-1
						else:	
							urlClarin=ftp["url"]+ftp["link"]
							position1=urlClarin.find('www.clarin.com')

						#print("Link ",ftp["link"])
						#print(input("press enter"))
						

						if (position1>-1 and position2==-1) : 
							try:
								fileData=parser.readFileDisk(ftp["file_path"])
								v=Clarin() 	
								v.setData(fileData,ftp)	
							except:
								print(str(sys.exc_info()[1]))
								self.linkbus.updateFechaParseo(ftp["idLink"])
								self.saveLog(ftp["idLink"],"READ_FILE",ftp["link"]+" - "+str(sys.exc_info()[1]),"python")	
								
						else:
							self.linkbus.updateFechaParseo(ftp["idLink"])
							self.saveLog(ftp["idLink"],"OTHER_HOST","(idLink: "+str(ftp["link"]) +") la url no es www.clarin.com","python")
							
					except:
						print("Error al leer el archivo idLink:",ftp["idLink"],sys.exc_info()[1])	
						#print(input("press enter"))

				if ftp["nombre"].upper()=="LA NACION" :	
					try:
						urlLaNacion=ftp["url"]+ftp["link"]
						position1=urlLaNacion.find('www.lanacion.com')
						if (position1>-1) : 
							try:
								fileData=parser.readFileDisk(ftp["file_path"])
								v=LaNacion()
								v.setData(fileData,ftp)
							except:
								print(str(sys.exc_info()[1]))
								self.linkbus.updateFechaParseo(ftp["idLink"])
								self.saveLog(ftp["idLink"],"READ_FILE",ftp["link"]+" - \n "+str(sys.exc_info()[1]),"python")	
						else:
							dbLink=LinkBus()
							dbLog=LogBus()
							dbLink.updateFechaParseo(ftp["idLink"])
							self.saveLog(ftp["idLink"],"OTHER_HOST","(idLink: "+str(ftp["link"]) +") la url no es www.lanacion.com -> "+ ftp["link"],"python")
					except:
						print(str(sys.exc_info()[1]))
						print("+++ La Nacion ?? Error al leer el archivo idLink:",ftp["idLink"],sys.exc_info()[1])	
						#print("Error al leer La nacion:",ftp["idLink"])