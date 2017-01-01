import bs4
from bs4 import BeautifulSoup
from bs4 import CData
from bs4 import Comment
from types import *

import sys
import re
import pprint 	
import xml.dom.minidom
import dateparser
from mining.common import  *
from mining.bus import  NoticiasBus
from mining.bus import  LinkBus
from mining.bus import  LogBus

class LaNacion():
	vNoti= NoticiasItem()
	dbLink=LinkBus()
	dbLog=LogBus()
	vLog=LogItem()
	notiBus=NoticiasBus()
	ERROR="Error al parsear dato."
	def __init__(self):
		c=0
		#print("La Nacion")
	def saveLog(self,idLink,codi,descripcion,user):
		self.dbLink.updateFechaParseo(idLink)
		self.vLog.id=idLink
		self.vLog.codi=codi
		self.vLog.descripcion="(id: "+str(idLink) +") "+ descripcion
		self.vLog.user="python"
		self.dbLog.insert(self.vLog)
	def setData(self,value,link):
		self.data = value
		nota_soup = BeautifulSoup(self.data, 'html.parser')
		noticia=NoticiasItem()
		noticia.link_images = []

		noticia.idLink=link["idLink"]

		noticia.titulo=""	
		noticia.copete=""	
		noticia.seccion=""
		noticia.parrafos=""
		noticia.autor=""
		noticia.fecha=""
		

		noti_date=None
		noti_parrafos=""
		article=None
		
		article=None

		try:
			article=nota_soup.find("article", id="nota")
		except:
			self.saveLog(link["idLink"],"Parse File","noticia sin articulo","python")
			#print("Error fecha",sys.exc_info()[1])
			
		
		for a0 in article.find_all('aside', class_=["mas-sobre-tema"]):
				a0.extract()

			
		try:
			fotos=article.find_all("figure")
			for f in fotos:
				noticia.link_images.append(f.img["src"])
			#print(noticia.link_images)
		except:
			self.saveLog(link["idLink"],"LINK_IMAGES","Except - "+ str(sys.exc_info()[1]),"python")

		try:
			noticia.titulo=article.h1.get_text()
		except:
			self.saveLog(link["idLink"],"Parse File","noticia sin Titulo","python")
			
		
		try:
			bajada=article.find("p", class_="bajada")
			if bajada!=None:
				noticia.copete =bajada.get_text()
		except:
			self.saveLog(link["idLink"],"Parse File","noticia sin Copete","python")
			#print("Error Copete",sys.exc_info()[1])
		

		try:
			noti_datetime=nota_soup.find("meta",{"itemprop":"datePublished"})
			noticia.fecha=dateparser.parse(noti_datetime["content"])
		except:
			self.saveLog(link["idLink"],"Parse File","noticia sin Fecha","python")
			#print("Error fecha",sys.exc_info()[1])

		try:
			for p in article.section.find_all("p"):
				if(p.get_text()!=None):
					noticia.parrafos+=p.get_text()
			
			if noticia.parrafos=="":		
				bsParrafos=article.find_all("section",{"id":"cuerpo"})

				vParrafos = BeautifulSoup(str(bsParrafos), 'html.parser')
				for p2 in vParrafos.find_all("p"):
					noticia.parrafos+=p2.get_text()

		except:
			self.saveLog(link["idLink"],"Parse File","noticia parrafo","python")
			#print("Error parrafos",sys.exc_info()[1])
	
		try:
			pSeccion=article.find("div", itemprop="child")
			if pSeccion!=None:
				noticia.seccion=pSeccion.a.span.get_text()
			else:
				pSeccion2=article.find_all("ul", class_="breadcrumb")

				ulElements = BeautifulSoup(str(pSeccion2), 'html.parser')
				eLis=ulElements.find_all("li")
				if(len(eLis)>=1):
					noticia.seccion=eLis[1].a.span.get_text()
				#print("-* seccion *-",noticia.seccion)
			
		except:
			self.saveLog(link["idLink"],"Parse File","noticia seccion","python")
			#print("Error seccion",sys.exc_info()[1])	

		try:
			autor=""
			for col in article.find_all("div", class_="columnista"):
				autor=autor+col.div.a.get_text()+";"
			
			for col2 in article.find_all("div", class_="encabezado-columnista"):
				autor=autor+col2.div.div.a.get_text()+";"
			noticia.autor=autor	
		except:
			self.saveLog(link["idLink"],"Parse File","noticia autor","python")
			#print("Error Autor",sys.exc_info()[1])	
		
		try:
			self.notiBus.insert(noticia)
		except:
			print("Error Autor",sys.exc_info()[1])	
