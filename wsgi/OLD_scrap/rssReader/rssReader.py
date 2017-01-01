
from scrap.db import Base
from scrap.db import RssReaderDb
from scrap.db import RssUrls
from scrap.db import  Feeds
from scrap.db import  Texto
from scrap.db import  Cliente

from datetime import datetime
from sqlalchemy.orm import sessionmaker
from sqlalchemy import select
import dateparser
import feedparser
from .ProcessText import ProcessText
from .textoPalabrasData import TextoPalabrasData
from .textoPalabrasData import TextoData


from datetime import date
from time import mktime



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



class RssReader():
	def __init__(self):
		c=0
	def categoryFix	(self):
		session = sessionmaker()
		session.configure(bind=RssReaderDb().getEngine())
		s = session()
		qFeeds = s.query(Feeds)
		feeds  = qFeeds.filter(Feeds.category ==None).all()

		for feed in feeds:
			category=None
			if feed.rssUrls.diario!='RT':
				if feed.rssUrls.seccion=="todas":
					category=findCategory(feed.link)
				else:
					category=feed.rssUrls.seccion
				feed.category=category	
				#print(category," - ",feed.link)

		s.commit() 
		s.close() 			
	def pubDateFix	(self):
		session = sessionmaker()
		session.configure(bind=RssReaderDb().getEngine())
		s = session()
		qFeeds = s.query(Feeds)
		feeds  = qFeeds.filter(Feeds.pubDate ==None).all()
		flist=[]
		for feed in feeds:
			flist.append(feed)
			datefeed=feed.link.split('/')
			if (len(datefeed)>=6):
				aux=datefeed[5]+'-'+datefeed[6]+'-'+datefeed[7]
				feed.pubDate=dateparser.parse(aux)

		s.commit() 
		s.close()
		return flist 

	def read(self):
		session = sessionmaker()
		session.configure(bind=RssReaderDb().getEngine())
		s = session()
		qFeeds = s.query(Feeds)


		result=""
		urls = s.query(RssUrls).filter_by(habilitado=True).all()
		feedList=[]
		for link in urls:
			print(link.url)
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
			
			for feed in feeds:
				try:
					pubDate=None
					if "updated" in feed.keys():
						pubDate=dateparser.parse(feed["updated"])

					if ("published" in feed.keys()) and (pubDate==None):
						pubDate=dateparser.parse(feed["published"])
			        
					if pubDate==None:
						pubDate=datetime.fromtimestamp(mktime(feed["published_parsed"]))
						print(feed["published_parsed"],feed["title"])
					
					found  = qFeeds.filter(Feeds.link == feed["link"], Feeds.idRssUrl == link.idRssUrl).first()
					if found is None:
						if link.seccion=="todas":
							category=findCategory(feed["link"])
						else:
							category=link.seccion
							
						if category!=None or link.diario=='RT':
							try:
								f = Feeds(idRssUrl=link.idRssUrl,
										 title=feed["title"],
										 link=feed["link"],
										 description=feed["description"],
										 pubDate=pubDate,
										 category=category,
										 creado_por='backend')   
								s.add(f)
								s.commit() 
							except Exception as e:
								print("Exception -> ",str(e))
								s.rollback() 
				except Exception as e:
							print("*** 2 *** ",str(e))
		s.close() 			
	def importFeeds(self):
		session = sessionmaker()
		session.configure(bind=RssReaderDb().getEngine())
		s = session()
		FIELD_SELECTED="title"
		cliente = s.query(Cliente).filter_by(codigo='RSS').first()
		feeds = s.query(Feeds).filter_by(fecha_parseo=None).all()
		for feed in feeds:
			try:
				#print("***",feed.rssUrls.diario,feed.category)
				if feed.pubDate!=None:
					vTexto = Texto(cliente=cliente, 
									source_id=str(feed.idRssFeed),
									source_category=feed.rssUrls.diario,
									source_category_sub=feed.category,
									source_field_name=FIELD_SELECTED,
									source_date=feed.pubDate,
									texto=feed.title,
									creado_por="test")
					s.add(vTexto)
					feed.fecha_parseo=date.today()
					s.commit() 
			except Exception as e:
				print(str(e))
		s.close()
	def stopwordsProcess(self):
		vProcessText = ProcessText()
		vTextopalabra=TextoPalabrasData()
		vTexto=TextoData()

		session = sessionmaker()
		session.configure(bind=RssReaderDb().getEngine())
		s = session()
		dbTextos = s.query(Texto).filter_by(fecha_proceso=None).limit(200)  
		
		TiempoInicio=datetime.now()
		
		for dbText in dbTextos:
			#print(dbText.texto)
			vProcessText.setText(dbText.texto);
			text_clean=vProcessText.getCleanText()
			fdist=vProcessText.getFdist(text_clean)
			common= fdist.most_common()
			dict_common=dict(common) 
			orden=0
			for cText in text_clean:
				vTextopalabra.insert(dbText.id,cText,dict_common[cText],orden,"test")
				orden=orden+1
			vTexto.SetFechaProceso(dbText.id)
			
		s.close()
		TiempoFinal=datetime.now()
		difference = TiempoFinal-TiempoInicio
		print("Fin")
		print (TiempoInicio,"\t",TiempoFinal,"\t",difference)

		

# find in a list
#itemExists=[item for item in feedList if item.title== c]

