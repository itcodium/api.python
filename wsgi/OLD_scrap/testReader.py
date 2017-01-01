from db.base import Base
from db.base import RssReaderDb
from db.dbData import RssUrls
from db.dbData import  Feeds

from datetime import datetime
from sqlalchemy.orm import sessionmaker
from sqlalchemy import select
import dateparser

session = sessionmaker()

session.configure(bind=RssReaderDb().getEngine())
s = session()


urls=[]
try:
	link1={	"diario":"infobae","seccion":"todas","descripcion":"",
			"url":"http://www.infobae.com/argentina-rss.xml",
			 "habilitado":True,"creado_por":"test"}

	# ---------------------------------------------------------------------

	link2={	"diario":"clarin",
			"seccion":"politica",
			"url":"http://www.clarin.com/rss/politica/",
			 "habilitado":True,"creado_por":"test","descripcion":"",}
	
	link3={	"diario":"clarin",
			"seccion":"sociedad",
			"url":"http://www.clarin.com/rss/sociedad/",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link4={	"diario":"clarin",
			"seccion":"policiales",
			"url":"http://www.clarin.com/rss/policiales/",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link5={	"diario":"clarin",
			"seccion":"economia",
			"url":"http://www.clarin.com/rss/ieco/",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link6={	"diario":"clarin",
			"seccion":"mundo",
			"url":"http://www.clarin.com/rss/mundo/",
			 "habilitado":True,"creado_por":"test","descripcion":""}
	# ---------------------------------------------------------------------
	
	link7={	"diario":"La nacion",
			"seccion":"politica",
			"url":"http://contenidos.lanacion.com.ar/herramientas/rss/categoria_id=30",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link8={	"diario":"La nacion",
			"seccion":"economia",
			"url":"http://contenidos.lanacion.com.ar/herramientas/rss/categoria_id=272",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link9={	"diario":"La nacion",
			"seccion":"mundo",
			"url":"http://contenidos.lanacion.com.ar/herramientas/rss/categoria_id=7",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link10={	"diario":"La nacion",
			"seccion":"sociedad",
			"url":"http://contenidos.lanacion.com.ar/herramientas/rss/categoria_id=7773",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link11={"diario":"La nacion",
			"seccion":"policiales",
			"url":"http://contenidos.lanacion.com.ar/herramientas/rss/categoria_id=7775",
			 "habilitado":True,"creado_por":"test","descripcion":""}

	link11={"diario":"RT",
			"seccion":"todas",
			"url":"https://actualidad.rt.com/feeds/all.rss",
			 "habilitado":True,"creado_por":"test","descripcion":""}





	urls.append(link1)
	urls.append(link2)
	urls.append(link3)
	urls.append(link4)
	urls.append(link5)
	urls.append(link6)
	urls.append(link7)
	urls.append(link8)
	urls.append(link9)
	urls.append(link10)
	urls.append(link11)
	 
	''' 
	for item in urls:
		u = Urls(diario=item["diario"],
				 seccion=item["seccion"],
				 descripcion=item["descripcion"],
				 url=item["url"],
				 habilitado=item["habilitado"],
				 creado_por=item["creado_por"])   
		s.add(u)
		s.commit() 
	'''
	 
except Exception as e:
	print(str(e))



import feedparser

print("INIT")

categorias=[]
politica={"name":"Politica", "value":["Política","politica"]}
economia={"name":"Economia", "value":["iEco","Economía","economia"] }
mundo={"name":"Mundo", "value":["Mundo","El mundo"]}
sociedad={"name":"Sociedad", "value":["Sociedad"]}
policiales={"name":"Policiales", "value":[" Policiales","Seguridad"]}

categorias.append(politica)
categorias.append(economia)
categorias.append(mundo)
categorias.append(sociedad)
categorias.append(policiales)


def findCategory(text):
	strText=text.replace("/", " ")
	urlText=text.split('/')
	for c in categorias:
		for item in c["value"]:
			if item.upper() in strText.upper():
				return c["name"]
	for c in categorias:
		for item in c["value"]:
			if(len(urlText)>=2):
				if item.upper() ==urlText[3]:
					return c["value"]
	return None





urls = s.query(RssUrls).filter_by(habilitado=True).all()
for link in urls:
	data = feedparser.parse(link.url)
	feeds=None
	try:
		feeds=data["items"]
	except Exception as e:
		print("*** 1 *** ",str(e))
		try:
			feeds=data["entry"]
		except Exception as e:
			print("*** 2 *** ",str(e))
	
	category=None	

	for feed in feeds:
		found = s.query(Feeds).filter_by(title=feed["title"]).first()

		if found is None:
			if link.seccion=="todas":
				category=findCategory(feed["link"])
			else:
				category=link.seccion
			print("--- >>",category)	
			if category!=None or link.diario=='RT':
				if "updated" in feed.keys():
					pubDate=dateparser.parse(feed["updated"])
				if "published" in feed.keys():
					pubDate=dateparser.parse(feed["published"])
				
				
				f = Feeds(idRssUrl=link.idRssUrl,
						 title=feed["title"],
						 link=feed["link"],
						 description=feed["description"],
						 pubDate=pubDate,
						 creado_por='backend',
						 category=category)   
				s.add(f)
				s.commit() 
			
	#input("press any key")

	#https://wiki.python.org/moin/RssLibraries


