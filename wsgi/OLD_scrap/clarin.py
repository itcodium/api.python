import bs4
from bs4 import BeautifulSoup
from bs4 import CData
from bs4 import Comment
from types import *

import sys
import os
import re
import pprint 	
import xml.dom.minidom
import dateparser
from mining.common import  *
from mining.bus import  NoticiasBus
from mining.bus import  LinkBus
from mining.bus import  LogBus

class Clarin():
	vNoti= NoticiasItem()
	dbLink=LinkBus()
	dbLog=LogBus()
	vLog=LogItem()
	notiBus=NoticiasBus()
	ERROR="Error al parsear dato."
	def __init__(self):
		c=0
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
		noticia.idLink=link["idLink"]
		noticia.link_images = []
		noti_date=None
		noti_parrafos=""
		article=None
		
		try:
			article = nota_soup.section.article
		except:
			self.saveLog(link["idLink"],"Parse File","noticia sin articulo","python")
			return

		fotos=article.find_all("img")
		try:
			for f in fotos:
				if f.has_attr('src'):
					noticia.link_images.append(f["src"])
		except:
			#print(" (*) ",str(sys.exc_info()[1]))
			self.saveLog(link["idLink"],"LINK_IMAGES","Except - "+ str(sys.exc_info()[1]),"python")

		try:
			noticia.titulo=article.h1.get_text()
		except:
			self.saveLog(link["idLink"],"Parse File","noticia sin Titulo","python")
			return

		try:
			noticia.volanta=article.p.strong.get_text()
		except:
			noticia.volanta="ERROR"
			#print("Error fecha",sys.exc_info()[1])

		try:
			noti_datetime=nota_soup.find("meta",{"name":"cXenseParse:recs:publishtime"})
			noticia.fecha=dateparser.parse(noti_datetime["content"])
		except:
			noticia.fecha="ERROR"
			#print("Error fecha",sys.exc_info()[1])
		
		try:
			vAutor=article.find_all("div", class_="columnista-datos")
			vAutor_email=article.find_all("div", class_="mail")
			if (len(vAutor)>=1):
				noticia.autor=vAutor[0].ul.li.a.get_text()
				vAutor_mail=vAutor[0].ul.find("a", class_="mail")
				if (vAutor_mail!=None):
					noticia.autor_mail=vAutor_mail.get_text()

			if (len(vAutor)==2):
				noticia.autor=noticia.autor+";"+vAutor[1].ul.li.a.get_text()
				if noticia.autor_mail!="":
					noticia.autor_mail=noticia.autor_mail+";"+vAutor[1].ul.find("a", class_="mail").get_text()
				else:
					noticia.autor_mail=vAutor[1].ul.find("a", class_="mail").get_text()					
		except:
			print("Error Autor",sys.exc_info()[1])	


		for eScSt in article.find_all(['script','style']):
			eScSt.extract()

		article1 = BeautifulSoup(str(article), 'html.parser')
		for e in article1.find_all(["div","p","li","a","span"]):
			if e.get_text().strip()=="":
				e.extract()

		article2 = BeautifulSoup(str(article1), 'html.parser')
		for eText in article2.find_all(string=lambda text:isinstance(text,Comment)):
			eText.extract()

		 
		articleNoTweet = BeautifulSoup(str(article2), 'html.parser')

		for eTweet in articleNoTweet.find_all("blockquote", class_=["twitter-tweet","instagram-media"]):
			eTweet.extract()

		terminosComentarios = BeautifulSoup(str(articleNoTweet), 'html.parser')
		for eTComen in terminosComentarios.find_all("div", class_="terminos-comentarios"):
			eTComen.extract()	

		article3 = BeautifulSoup(str(terminosComentarios), 'html.parser')

		noti_copete=""	
		try:
			cope=False
			for e in article3.find_all("p", class_=""):
				if(e.p!=None):
					print("")
				else:	
					if e.get_text() not in ("RELACIONADAS", "VALORÁ LA OPINIÓN","Para comentar activa tu cuenta desde el mail que te enviamos a tu casilla de correo."): 	
						if cope==False:		
								noti_copete=noti_parrafos+str(e.get_text())
								cope=True
						else:			
								noti_parrafos=noti_parrafos+str(e.get_text())
			
			

		except:
			noticia.seccion=self.ERROR
			#print("Error Seccion",sys.exc_info()[1])
		
		try:
			categoria=article3.find("div", class_="breadcrumb")
			liCategori=categoria.find_all("li")
			if(len(liCategori)>=2):	
				noticia.seccion=liCategori[1].get_text()
		except:
			noticia.seccion=self.ERROR
		
		noticia.copete=noti_copete
		noticia.parrafos=noti_parrafos
		if(len(noti_copete)>1000):
			if(len(noti_parrafos)==0):
				noti_parrafos=noti_copete	
				noticia.copete=""
				noticia.parrafos=noti_parrafos
		
		try:
			self.notiBus.insert(noticia)
		except:
			print("Error Autor",sys.exc_info()[1])	

		
		
		#print("---------  END -----------------")
		

		#print(input("press enter"))
		
 
		
 