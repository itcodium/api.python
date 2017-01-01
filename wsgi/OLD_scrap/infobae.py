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
from mining.bus import  LogBus
from mining.bus import  LinkBus


class Infobae():
	vNoti= NoticiasItem()
	dbLog=LogBus()
	vLog=LogItem()
	vLink=LinkBus()
	ERROR=""
	def __init__(self):
		c=0
	def saveLog(self,idLink,codi,descripcion,user):
		self.vLog.id=idLink
		self.vLog.codi=codi
		self.vLog.descripcion="(id: "+str(idLink) +") "+ descripcion
		self.vLog.user="python"
		self.dbLog.insert(self.vLog)		
	def setData(self,value,link):
		self.data = value
		nota_soup = BeautifulSoup(self.data, 'html.parser')
		notiBus=NoticiasBus()
		
		try:
			article0=nota_soup.find("article", class_="hnews")
			

			if(article0==None):
				self.saveLog(link["idLink"],"NO_ARTICLES","La noticia no contiene articulos","python")
				self.vLink.updateFechaParseo(link["idLink"])
				return	
			'''	
			if(len(article0)>1):
				self.saveLog(link["idLink"],"MULTIPLES_ARTICLES","Lista de noticias","python")
				self.vLink.updateFechaParseo(link["idLink"])
				return	
			'''

			for a0 in article0.find_all(['iframe','script','noscript','style','footer']):
				a0.extract()	

			article1 = BeautifulSoup(str(article0), 'html.parser')
			for a1 in article1.find_all('div', class_=["embed_cont","tags","modal","social-hori","video"]):
				a1.extract()

			article2 = BeautifulSoup(str(article1), 'html.parser')
			for e2 in article2.find_all(["div","p","li","a","span","aside"]):
				if e2.get_text().strip()=="":
					e2.extract()
			article3 = BeautifulSoup(str(article2), 'html.parser')
			for e3 in article3.find_all(string=lambda text:isinstance(text,Comment)):
				e3.extract()


			article3 = BeautifulSoup(str(article3), 'html.parser')
			try:
				if article3.p==None :
					article3=article3.div
				if article3.p.a!=None :
					self.vNoti.seccion=article3.p.a.get_text().replace(";","")	
			except:
				self.saveLog(link["idLink"],"PARSE_FILE","seccion - "+ str(sys.exc_info()[1]),"python")

			try:
				# hasta el 2015-11-12 finciono este codigo
				# self.vNoti.fecha=nota_soup.article.time['datetime']
				self.vNoti.fecha= dateparser.parse(article3.p.span.get_text())
			except:
				self.saveLog(link["idLink"],"PARSE_FILE","Fecha - "+ str(sys.exc_info()[1]),"python")
				
			try:
				self.vNoti.titulo=article3.header.h1.get_text()
			except:
				self.saveLog(link["idLink"],"PARSE_FILE","Titulo - "+ str(sys.exc_info()[1]),"python")
 
			try:
				self.vNoti.autor_copete=""
				copetes=article3.header.find_all("p")
				#print(len(copetes),copetes)
				
				if len(copetes)>1 :
					if(copetes[0].get_text().strip()==copetes[1].get_text().strip()):
						self.vNoti.copete=copetes[1].get_text()
					else:
						self.vNoti.copete=copetes[1].get_text()
						try:
							self.vNoti.autor_copete=copetes[0].a.get_text()
						except:
							self.vNoti.autor_copete=""

						try:
							self.vNoti.autor_mail=copetes[0].select(".autor-mail")[0].get_text()
						except:
							self.vNoti.autor_mail=""

				if len(copetes)==1 :	
					try:
						self.vNoti.copete=copetes[0].get_text()
					except:
						self.vNoti.copete=""
			except:
				self.saveLog(link["idLink"],"PARSE_FILE","Autor - "+ str(sys.exc_info()[1]),"python")
			
			article4 = BeautifulSoup(str(article3), 'html.parser')
			#fotos=article4.find_all("figure")
			#for f in fotos:
			#	print("Foto: ",f.img["src"])

			[s.extract() for s in article4(['figure','figcaption'])]	

			for a8 in article4.find_all('div', class_=["single-photo-gallery"]):
				a8.extract()

			article5 = BeautifulSoup(str(article4), 'html.parser')
			try:
				if article5.div!=None:
					self.vNoti.parrafos=article5.div.get_text().strip()
				else:
					self.saveLog(link["idLink"],"NO_PARRAFO","La noticia no contiene parrafos","python")
					self.vLink.updateFechaParseo(link["idLink"])
					return			
			except:
				self.saveLog(link["idLink"],"PARSE_FILE","Parrafos - "+ str(sys.exc_info()[1]),"python")

			self.vNoti.idLink=link["idLink"]	

			#print(article5)		
			#print("--------------- ARTICLE INIT  ---------------------")
			#print(self.vNoti.parrafos)	
			#print("--------------- ARTICLE END  ---------------------")
			
			'''
			print ("idLink(*) ->",self.vNoti.idLink)
			print ("seccion   ->",self.vNoti.seccion)
			print ("Fecha     ->",self.vNoti.fecha)
			print (self.vNoti.titulo)
			print ("self.vNoti.copete       ->",self.vNoti.copete)
			print ("self.vNoti.autor_mail   ->",self.vNoti.autor_mail)
			print ("self.vNoti.autor_copete ->",self.vNoti.autor_copete)
			print("---------------------------------------")
			'''
			#print (self.vNoti.parrafos)
			notiBus.insert(self.vNoti)		
		except:
			self.saveLog(link["idLink"],"Parse File",str(sys.exc_info()[1]),"python")

		