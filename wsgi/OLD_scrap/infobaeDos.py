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


class InfobaeDos():
	vNoti= NoticiasItem()
	dbLog=LogBus()
	vLog=LogItem()
	vLink=LinkBus()
	notiBus=NoticiasBus()
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
		nota_soup_header=nota_soup
		
		noticia=NoticiasItem()
		noticia.link_images = []
		#print("link",self.data)
		
		try:
			header=nota_soup_header.find("header", class_="article-header")
			author=nota_soup_header.find("div", class_="byline-author")
			article0=nota_soup.find("div", id="article-body")

			if(article0==None):
				self.saveLog(link["idLink"],"NO_ARTICLES","La noticia no contiene articulos","python")
				self.vLink.updateFechaParseo(link["idLink"])
				return

			try:
				noticia.titulo=header.h1.get_text()
				noticia.copete=header.span.get_text()

				vSeccion= header.div.a["href"].replace("/","")
				if (vSeccion=="deportes-2"):
					noticia.seccion="deportes"
				else:
					noticia.seccion=vSeccion
			except:
				print(str(sys.exc_info()[1]))
				self.saveLog(link["idLink"],"TITULO_COPETE_SECCION"," - "+ str(sys.exc_info()[1]),"python")
			
			try:
				article_content=nota_soup.find("div", id="article-content")
				for item in article_content.find_all(['figure']):			
					noticia.link_images.append(item.img["data-original"])
				#print(noticia.link_images)
			except:
				print(str(sys.exc_info()[1]))
				self.saveLog(link["idLink"],"LINK_IMAGES","Except - "+ str(sys.exc_info()[1]),"python")
				
			
			
			vAuthor=author.parent
			#print(vAuthor)
			#person = input('Enter your ')
			try:
				if vAuthor.div.a!=None:
					noticia.autor=vAuthor.div.a.get_text()
					noticia.autor_mail=vAuthor.find("div", class_="byline-bio").get_text()
				else:
					self.saveLog(link["idLink"],"AUTHOR_NO","Noticia sin autor","python")	
			except:
				print(str(sys.exc_info()[1]))
				self.saveLog(link["idLink"],"AUTHOR","Except - "+ str(sys.exc_info()[1]),"python")

			

			try:
				vFecha=vAuthor.find("span", class_="byline-date").get_text()
				noticia.fecha=dateparser.parse(vFecha)
			except:
				print(str(sys.exc_info()[1]))
				self.saveLog(link["idLink"],"FECHA","Except - "+ str(sys.exc_info()[1]),"python")


			#print(noticia.link_images)
			#print("*********************************************************") 
 			
			
			
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

			#print("3",str(article3))	
			
			article4 = BeautifulSoup(str(article3), 'html.parser')

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
				print (str(sys.exc_info()[1]))
				self.saveLog(link["idLink"],"PARSE_FILE","Parrafos - "+ str(sys.exc_info()[1]),"python")

			noticia.idLink=link["idLink"]	

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
			self.notiBus.insert(noticia)		
		except:
			self.saveLog(link["idLink"],"Parse File",str(sys.exc_info()[1]),"python")
			

		