import sys
import re
import pprint 	
#import urllib.request
import xml.dom.minidom
#import nltk
import re
import bs4
from bs4 import BeautifulSoup
from bs4 import CData
import socket
import urllib3
import os
from  urllib3.util import  *
#from requests.packages.urllib3.util import Retry
#from requests.adapters import HTTPAdapter
#from requests import Session, exceptions
import codecs

'''
cp850.py 
0x0100: 0x206a,
\u206a
0x206a: 0x0100
'''


class UrlLinkParser():
	url = ""
	data=""
	links=[]
	response=None
	file=None
	def __init__(self):
		c=0
	def setUrl(self,value):
		self.url = value
	def getUrlData(self):
		http = urllib3.PoolManager()
		self.response = http.request('GET', self.url)
		self.data=self.response.data.decode('utf-8','ignore')
		return self.data
	def getLinks(self,template):
		nota_soup = BeautifulSoup(self.data, 'html.parser')
		articles = nota_soup.find_all(template["template_content"]) #, {template["filterName"]:template["filterValue"]}
		
		if(template["nombre"]=="Infobae"):
			#print("INFOBAE");
			for article in articles:
				try:
					if str(type(article.a))!="<class 'NoneType'>":
						href=article.a["href"]
						if len(href)>12: 
							self.links.append(href)
				except:
					print("Error al leer el archivo idLink: ",sys.exc_info()[1],"python")
		if(template["nombre"]=="Clarin" or template["nombre"]=="La Nacion"):
			for article in articles:
				try:
					href=article.a["href"]
					if len(href)>12:
						self.links.append(href)
							
				except:
					print("Error al leer el archivo idLink: ",sys.exc_info()[1],"python")

				'''
				href=""
				code_str = template["template_link_parser"] 
				code_str +="""\n"""
				code_obj = compile(code_str, '<string>', 'exec')
				exec (code_obj)
				'''
		return self.links	
	def saveToDisk(self,directory,fileName):
		if not os.path.exists(directory) :
			os.makedirs(directory)

		print(directory+fileName)	
		
		orig_stdout = sys.stdout
		f = open(directory+fileName, 'w',encoding='utf8')
		sys.stdout = f
		print (self.data)
		sys.stdout = orig_stdout
		f.close()
		

		#print("Save OK")
	def readFileDisk(self,fileName):
		#print("fileName -> ",fileName)
		self.file = open(fileName, "r",encoding='utf8') 
		self.data=self.file.read()	
		#print("DATA -> ",self.data)
		return self.data





'''

#2015/09/29

#url = 'http://www.infobae.com//2015//07//22//1743347-calo-el-nuevo-salario-minimo-no-alcanza-vivir-dignamente'

url="http://www.infobae.com/2015/08/12/1747966-el-drama-flandria-el-club-que-quedo-el-agua"
# url = 'http://www.infobae.com/2015/08/08/1747011-los-pumas-vencieron-sudafrica-primera-vez-la-historia'
#http://www.infobae.com/2015/08/12/1748003-la-hija-del-ministro-agustin-rossi-es-la-directora-bancos-mas-joven-del-pais
         
# time.sleep(a_few_seconds)          

html=""

# Ejepmlo 1 ok 
# Sa guarda la noticia en un archivo
import urllib3
http = urllib3.PoolManager()
r = http.request('GET', url)

notaStr=r.data.decode("utf-8")
notaSoup = BeautifulSoup(notaStr, 'html.parser')

orig_stdout = sys.stdout
f = open('nota.txt', 'w')
sys.stdout = f
print (notaStr)
sys.stdout = orig_stdout
f.close()



header = notaSoup.article.header
seccion="" 

try:
	seccion=notaSoup.article.p.a.get_text()
except:
	print("No se encontro la seccion!")


fecha=notaSoup.article.time['datetime']
titulo=header.h1.get_text()


copete_autor=""
copetes=header.find_all("p")
if len(copetes)==1 :
	copete=copetes[0]
else : 	
	copete=copetes[1]
	copete_autor=copetes[0]



print("categoria: ",seccion)
print("Fecha: ",fecha)
print("Titulo: ",titulo +"\n")
print("Copete: ",copete.get_text() ,"\n")
autor=""
mail=""

try:
	autor=copete_autor.a.get_text()
	mail=copete_autor.a.find_next("a").get_text()
	print("mail: ",mail,"\n")
	print("Autor: ",autor)
except:
	print("No se encontro autor!")



fotos=notaSoup.section.article.find_all("figure")
for f in fotos:
	print("Foto: ",f.img["src"])

'''


'''
# comentado
social=notaSoup.article.find_all("div",{ "class" : "social-hori" })
social.clear();
print("social",social)
'''


'''
# ok
parrafo_primero=""
parrafo_restantes=""

if(len(fotos)<=1 ) :
	for parrafo1 in notaSoup.article.find_all(style='display:block;'):
		[s.extract() for s in parrafo1(['figure','ul'])]
	
	for a1 in parrafo1:
		if(bs4.element.NavigableString==type(a1)) :
			print(a1.string.strip())
		else :
			temp = BeautifulSoup(str(a1), 'html.parser')		
			for p in temp.find_all("div"):
				parrafo_restantes=parrafo_restantes+"\n"+p.get_text()
	print(parrafo_restantes) 		
else :	
	for parrafo1 in notaSoup.article.find_all(style='display:block;'):
			[s.extract() for s in parrafo1(['div','figure'])]
	for a1 in parrafo1:
		if(bs4.element.NavigableString==type(a1)) :
			parrafo_primero=parrafo_primero+a1.string.strip()
			#print(type(a1),  a1.name)
		else : 		
			if(a1.name=="b") :
				parrafo_primero=parrafo_primero+a1.get_text()
			else : 
				temp = BeautifulSoup(str(a1), 'html.parser')		
				for p in temp.find_all("p"):
					parrafo_restantes=parrafo_restantes+"\n"+p.get_text()


	print(parrafo_primero+"\n"+ parrafo_restantes)


 '''