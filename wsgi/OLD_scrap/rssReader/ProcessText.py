# FileManager.py
import sys
import nltk
import re
import pprint 	
import time
import urllib.request
from enum import Enum
from nltk import word_tokenize
#from nltk.corpus import stopwords
from os import system
from nltk.tokenize import *

local_stopwords=['de', 'la', 'que', 'el', 'en', 'y', 'a', 'los', 'del', 'se', 'las','por', 'un', 'para', 'con', 'no', 'una', 'su', 'al', 'lo', 'como', 'más', 'pero'
, 'sus', 'le', 'ya', 'o', 'este', 'sí', 'porque', 'esta', 'entre', 'cuando', 'muy', 'sin', 'sobre', 'también', 'me', 'hasta', 'hay', 'donde', 'quien', 'desde',
'todo', 'nos', 'durante', 'todos', 'uno', 'les', 'ni', 'contra', 'otros', 'ese',
 'eso', 'ante', 'ellos', 'e', 'esto', 'mí', 'antes', 'algunos', 'qué', 'unos', 'yo', 'otro', 'otras', 'otra', 'él', 'tanto', 'esa', 'estos', 'mucho', 'quienes',
 'nada', 'muchos', 'cual', 'poco', 'ella', 'estar', 'estas', 'algunas', 'algo',
'nosotros', 'mi', 'mis', 'tú', 'te', 'ti', 'tu', 'tus', 'ellas', 'nosotras', 'vosostros', 'vosostras', 'os', 'mío', 'mía', 'míos', 'mías', 'tuyo', 'tuya', 
'tuyos', 'tuyas', 'suyo', 'suya', 'suyos', 'suyas', 'nuestro', 'nuestra', 'nuestros', 'nuestras', 'vuestro', 'vuestra', 'vuestros', 'vuestras', 'esos', 'esas',
 'estoy', 'estás', 'está', 'estamos', 'estáis', 'están', 'esté', 'estés', 'estemos', 'estéis', 'estén', 'estaré', 'estarás', 'estará', 'estaremos', 'estaréis', 
 'estarán', 'estaría', 'estarías', 'estaríamos', 'estaríais', 'estarían', 'estaba', 
 'estabas', 'estábamos', 'estabais', 'estaban', 'estuve', 'estuviste', 'estuvo', 
 'estuvimos', 'estuvisteis', 'estuvieron', 'estuviera', 'estuvieras', 'estuviéramos','estuvierais',
  'estuvieran', 'estuviese', 'estuvieses', 'estuviésemos', 'estuvieseis', 'estuviesen', 'estando', 'estado',
     'estada', 'estados', 'estadas', 'estad', 'he', 'has', 'ha', 'hemos', 'habéis', 'han', 'haya', 'hayas', 'hayamos', 'hayáis', 'hayan', 'habré', 'habrás', 'habrá', 'habremos', 
     'habréis', 'habrán', 'habría', 'habrías', 'habríamos', 'habríais', 'habrían', 'había', 'habías', 'habíamos', 'habíais', 'habían', 'hube', 'hubiste', 'hubo', 'hubimos', 'hubisteis',
      'hubieron', 'hubiera', 'hubieras', 'hubiéramos', 'hubierais', 'hubieran', 'hubiese', 'hubieses', 'hubiésemos', 'hubieseis', 'hubiesen', 'habiendo', 'habido', 
      'habida', 'habidos', 'habidas', 'soy', 'eres', 'es', 'somos', 'sois', 'son', 'sea','seas', 'seamos', 'seáis', 'sean', 'seré', 'serás', 'será', 'seremos', 'seréis',
 'serán', 'sería', 'serías', 'seríamos', 'seríais', 'serían', 'era', 'eras', 'éramos', 'erais', 'eran', 'fui', 'fuiste', 'fue', 'fuimos', 'fuisteis', 'fueron',
'fuera', 'fueras', 'fuéramos', 'fuerais', 'fueran', 'fuese', 'fueses', 'fuésemos', 'fueseis', 'fuesen', 'sintiendo', 'sentido', 'sentida', 'sentidos', 
'sentidas', 'siente', 'sentid', 'tengo', 'tienes', 'tiene', 'tenemos', 'tenéis', 'tienen', 'tenga', 'tengas', 'tengamos', 'tengáis', 'tengan', 'tendré', 'tendrás', 
'tendrá', 'tendremos', 'tendréis', 'tendrán', 'tendría', 'tendrías', 'tendríamos', 'tendríais', 'tendrían', 'tenía', 'tenías', 'teníamos', 'teníais', 'tenían', 
'tuve', 'tuviste', 'tuvo', 'tuvimos', 'tuvisteis', 'tuvieron', 'tuviera', 'tuvieras', 'tuviéramos', 'tuvierais', 'tuvieran', 'tuviese', 'tuvieses', 'tuviésemos', 
'tuvieseis', 'tuviesen', 'teniendo', 'tenido', 'tenida', 'tenidos', 'tenidas', 'tened']		

class ProcessText:
	tokens=None
	text=None
	stop_words = local_stopwords; #stopwords.words("spanish")
	def __init__(self):
		print ("ProcessText")
	def addStopWord(self,pWord):
		self.stop_words.append(pWord)
	def setText(self,pText):
		self.text=pText;	
	def getText(self):
		return self.text
	def get_word_tokenize(self):
		return nltk.word_tokenize(self.text);
	def get_RegexpTokenizer(self):	
		tokenizer = RegexpTokenizer('\w+|\$[\d\.]+|\S+')
		return tokenizer.tokenize(self.text)
	def getLine_Tokens(self):
		if self.line_tokens  is None:
			self.line_tokens  = LineTokenizer(blanklines='discard').tokenize(self.raw)
		return self.line_tokens		
	def getTokenText(self):
		if self.text is None:
			self.text=nltk.Text(self.getTokens())
		return self.text 
	def getCleanText(self):	
		text=self.get_RegexpTokenizer()
		lower_text = [word.lower () for word in text]
		#print("------------------- lower_text --------------------------")
		#print(lower_text)
		#print("------------------- tmp_text --------------------------")	
		#print(tmp_text)
		

		tmp_text = ["".join(re.split("[(:\".,\´! ')’\¿¡?”“;%&–$-]", word)) for word in lower_text]
		#tmp_text = ["".join(re.split("[(:\".,\´! )\¿?”;“%&-]", word)) for word in lower_text]
		for tmp in tmp_text:
			if(tmp==""):
				tmp_text.remove("")

		self.clean_text = [word for word in tmp_text if word.lower () not in self.stop_words]
		#print("------------------- self.clean_text  --------------------------")	
		#print(self.clean_text )
		return self.clean_text
	def getFdist(self,text):	
		self.fdist=nltk.FreqDist(text)
		return self.fdist




